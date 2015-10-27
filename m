From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 66/70] cpufreq: interactive: Fix compile errors in accordance with changes from 3.14 to 3.18
Date: Tue, 27 Oct 2015 18:30:54 +0100
Message-ID: <1445967059-6897-66-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>, Ruchi Kandoi <kandoiruchi@google.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Ruchi Kandoi<kandoiruchi@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index a0a7c3a..9faa189 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -805,7 +805,7 @@ static ssize_t store_hispeed_freq(struct cpufreq_in=
teractive_tunables *tunables,
 	int ret;
 	long unsigned int val;
=20
-	ret =3D strict_strtoul(buf, 0, &val);
+	ret =3D kstrtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 	tunables->hispeed_freq =3D val;
@@ -824,7 +824,7 @@ static ssize_t store_go_hispeed_load(struct cpufreq=
_interactive_tunables
 	int ret;
 	unsigned long val;
=20
-	ret =3D strict_strtoul(buf, 0, &val);
+	ret =3D kstrtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 	tunables->go_hispeed_load =3D val;
@@ -843,7 +843,7 @@ static ssize_t store_min_sample_time(struct cpufreq=
_interactive_tunables
 	int ret;
 	unsigned long val;
=20
-	ret =3D strict_strtoul(buf, 0, &val);
+	ret =3D kstrtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 	tunables->min_sample_time =3D val;
@@ -862,7 +862,7 @@ static ssize_t store_timer_rate(struct cpufreq_inte=
ractive_tunables *tunables,
 	int ret;
 	unsigned long val;
=20
-	ret =3D strict_strtoul(buf, 0, &val);
+	ret =3D kstrtoul(buf, 0, &val);
 	if (ret < 0)
 		return ret;
 	tunables->timer_rate =3D val;
--=20
1.7.9.5
