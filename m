From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 45/70] cpufreq: interactive: base above_hispeed_delay on target freq, not current
Date: Tue, 27 Oct 2015 18:30:33 +0100
Message-ID: <1445967059-6897-45-git-send-email-czoborbalint@gmail.com>
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

Time to wait should be based on the intended target speed, not the
actual speed (which may be held high by another CPU).

Change-Id: Ifc5bb55d06adddb9a02af90af05398a78f282272
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 3dc067e..9dd4d38 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -377,7 +377,7 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	if (pcpu->target_freq >=3D hispeed_freq &&
 	    new_freq > pcpu->target_freq &&
 	    now - pcpu->hispeed_validate_time <
-	    freq_to_above_hispeed_delay(pcpu->policy->cur)) {
+	    freq_to_above_hispeed_delay(pcpu->target_freq)) {
 		trace_cpufreq_interactive_notyet(
 			data, cpu_load, pcpu->target_freq,
 			pcpu->policy->cur, new_freq);
--=20
1.7.9.5
