From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 53/70] cpufreq: interactive: Remove unnecessary cpu_online() check
Date: Tue, 27 Oct 2015 18:30:41 +0100
Message-ID: <1445967059-6897-53-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35079 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965544AbbJ0RdW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:33:22 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Viresh Kumar <viresh.kumar@linaro.org>

Cpufreq no longer calls governor callback for offlined cpus. i.e. All
policy->cpus are guaranteed to be online. Hence we don't need explicit =
check to
see if cpu is online or not.

Change-Id: I9ad85ea4addd5b4a40952e59ed730dd15e328690
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index a66748e..378835b 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1073,9 +1073,6 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
=20
 	switch (event) {
 	case CPUFREQ_GOV_START:
-		if (!cpu_online(policy->cpu))
-			return -EINVAL;
-
 		mutex_lock(&gov_lock);
=20
 		freq_table =3D
--=20
1.7.9.5

