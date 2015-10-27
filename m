From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 15/70] cpufreq-interactive: Compile fixup
Date: Tue, 27 Oct 2015 18:30:03 +0100
Message-ID: <1445967059-6897-15-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, John Stultz <john.stultz@linaro.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: John Stultz <john.stultz@linaro.org>

Looks like AOSP has a compile bug. Fix it up.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index fcf0f21..7cb2e64 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -233,7 +233,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	 * floor frequency for the minimum sample time since last validated.
 	 */
 	if (new_freq < pcpu->floor_freq) {
-		if (pcpu->timer_run_time - pcpu->target_validate_time
+		if (pcpu->timer_run_time - pcpu->floor_validate_time
 		    < min_sample_time) {
 			trace_cpufreq_interactive_notyet(data, cpu_load,
 					 pcpu->target_freq, new_freq);
--=20
1.7.9.5
