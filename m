From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] cpufreq: exynos: Initialise return variable
Date: Mon, 21 Jan 2013 15:59:53 +0530
Message-ID: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:40341 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3AUKir (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jan 2013 05:38:47 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so1886083pbb.30
        for <linux-pm@vger.kernel.org>; Mon, 21 Jan 2013 02:38:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@sisk.pl, jhbird.choi@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

'ret' is undefined when the function returns from the first
error condition. Without this patch we get the following warning:

drivers/cpufreq/exynos-cpufreq.c: In function =E2=80=98exynos_target=E2=
=80=99:
drivers/cpufreq/exynos-cpufreq.c:182:2: warning:
=E2=80=98ret=E2=80=99 may be used uninitialized in this function [-Wuni=
nitialized]

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-=
cpufreq.c
index 218b3ce..38c6158 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -159,7 +159,7 @@ static int exynos_target(struct cpufreq_policy *pol=
icy,
 {
 	struct cpufreq_frequency_table *freq_table =3D exynos_info->freq_tabl=
e;
 	unsigned int index;
-	int ret;
+	int ret =3D -EINVAL;
=20
 	mutex_lock(&cpufreq_lock);
=20
@@ -167,10 +167,8 @@ static int exynos_target(struct cpufreq_policy *po=
licy,
 		goto out;
=20
 	if (cpufreq_frequency_table_target(policy, freq_table,
-					   target_freq, relation, &index)) {
-		ret =3D -EINVAL;
+					   target_freq, relation, &index))
 		goto out;
-	}
=20
 	freqs.new =3D freq_table[index].frequency;
=20
--=20
1.7.4.1

