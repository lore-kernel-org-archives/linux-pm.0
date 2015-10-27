From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 38/70] cpufreq: interactive: init default values at compile time
Date: Tue, 27 Oct 2015 18:30:26 +0100
Message-ID: <1445967059-6897-38-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35595 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441AbbJ0Rcu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:32:50 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Todd Poynor <toddpoynor@google.com>

Change-Id: Ia4966e949a6c24c34fdbd4a6e522cd7c37e4108e
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index fdc2a47..c8358a3 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -67,7 +67,7 @@ static unsigned int hispeed_freq;
=20
 /* Go to hi speed when CPU load at or above this value. */
 #define DEFAULT_GO_HISPEED_LOAD 99
-static unsigned long go_hispeed_load;
+static unsigned long go_hispeed_load =3D DEFAULT_GO_HISPEED_LOAD;
=20
 /* Target load.  Lower values result in higher CPU speeds. */
 #define DEFAULT_TARGET_LOAD 90
@@ -80,20 +80,20 @@ static int ntarget_loads =3D ARRAY_SIZE(default_tar=
get_loads);
  * The minimum amount of time to spend at a frequency before we can ra=
mp down.
  */
 #define DEFAULT_MIN_SAMPLE_TIME (80 * USEC_PER_MSEC)
-static unsigned long min_sample_time;
+static unsigned long min_sample_time =3D DEFAULT_MIN_SAMPLE_TIME;
=20
 /*
  * The sample rate of the timer used to increase frequency
  */
 #define DEFAULT_TIMER_RATE (20 * USEC_PER_MSEC)
-static unsigned long timer_rate;
+static unsigned long timer_rate =3D DEFAULT_TIMER_RATE;
=20
 /*
  * Wait this long before raising speed above hispeed, by default a sin=
gle
  * timer interval.
  */
 #define DEFAULT_ABOVE_HISPEED_DELAY DEFAULT_TIMER_RATE
-static unsigned long above_hispeed_delay_val;
+static unsigned long above_hispeed_delay_val =3D DEFAULT_ABOVE_HISPEED=
_DELAY;
=20
 /* Non-zero means indefinite speed boost active */
 static int boost_val;
@@ -992,11 +992,6 @@ static int __init cpufreq_interactive_init(void)
 	struct cpufreq_interactive_cpuinfo *pcpu;
 	struct sched_param param =3D { .sched_priority =3D MAX_RT_PRIO-1 };
=20
-	go_hispeed_load =3D DEFAULT_GO_HISPEED_LOAD;
-	min_sample_time =3D DEFAULT_MIN_SAMPLE_TIME;
-	above_hispeed_delay_val =3D DEFAULT_ABOVE_HISPEED_DELAY;
-	timer_rate =3D DEFAULT_TIMER_RATE;
-
 	/* Initalize per-cpu timers */
 	for_each_possible_cpu(i) {
 		pcpu =3D &per_cpu(cpuinfo, i);
--=20
1.7.9.5

