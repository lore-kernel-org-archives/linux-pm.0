From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 07/70] cpufreq: interactive: adjust code and documentation to match
Date: Tue, 27 Oct 2015 18:29:55 +0100
Message-ID: <1445967059-6897-7-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

Change-Id: If59c668d514a29febe5c35404fd9d01df8548eb1
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt  |   16 +++++++++++++---
 drivers/cpufreq/cpufreq_interactive.c |    6 +++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index b262c53..40894da 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -249,11 +249,21 @@ frequency before ramping down. This is to ensure =
that the governor has
 seen enough historic cpu load data to determine the appropriate
 workload.  Default is 80000 uS.
=20
-go_maxspeed_load: The CPU load at which to ramp to max speed.  Default
-is 85.
+hispeed_freq: An intermediate "hi speed" at which to initially ramp
+when CPU load hits the value specified in go_hispeed_load.  If load
+stays high for the amount of time specified in above_hispeed_delay,
+then speed may be bumped higher.  Default is maximum speed.
+
+go_hispeed_load: The CPU load at which to ramp to the intermediate "hi
+speed".  Default is 85%.
+
+above_hispeed_delay: Once speed is set to hispeed_freq, wait for this
+long before bumping speed higher in response to continued high load.
+Default is 20000 uS.
=20
 timer_rate: Sample rate for reevaluating cpu load when the system is
-not idle.  Default is 30000 uS.
+not idle.  Default is 20000 uS.
+
=20
 3. The Governor Interface in the CPUfreq Core
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 154f7bd..bf8d772 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -68,19 +68,19 @@ static struct mutex set_speed_lock;
 static u64 hispeed_freq;
=20
 /* Go to hi speed when CPU load at or above this value. */
-#define DEFAULT_GO_HISPEED_LOAD 95
+#define DEFAULT_GO_HISPEED_LOAD 85
 static unsigned long go_hispeed_load;
=20
 /*
  * The minimum amount of time to spend at a frequency before we can ra=
mp down.
  */
-#define DEFAULT_MIN_SAMPLE_TIME 20 * USEC_PER_MSEC
+#define DEFAULT_MIN_SAMPLE_TIME (80 * USEC_PER_MSEC)
 static unsigned long min_sample_time;
=20
 /*
  * The sample rate of the timer used to increase frequency
  */
-#define DEFAULT_TIMER_RATE 20 * USEC_PER_MSEC
+#define DEFAULT_TIMER_RATE (20 * USEC_PER_MSEC)
 static unsigned long timer_rate;
=20
 /*
--=20
1.7.9.5
