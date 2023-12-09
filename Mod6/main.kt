import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {

    private lateinit var kickButton: Button
    private lateinit var kickCountTextView: TextView
    private lateinit var kickTimesTextView: TextView

    private var kickCount = 0
    private val kickTimes = mutableListOf<String>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        kickButton = findViewById(R.id.kickButton)
        kickCountTextView = findViewById(R.id.kickCountTextView)
        kickTimesTextView = findViewById(R.id.kickTimesTextView)

        kickButton.setOnClickListener {
            kickCount++
            val currentTime = getCurrentTime()f
            kickTimes.add(currentTime)

            kickCountTextView.text = "Kicks: $kickCount"
            kickTimesTextView.text = kickTimes.joinToString("\n")
        }
    }

    private fun getCurrentTime(): String {
        val sdf = SimpleDateFormat("HH:mm:ss", Locale.getDefault())
        return sdf.format(Date())
    }
}
