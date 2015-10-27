From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 62/70] cpufreq: interactive: turn boost_pulse off on boost off
Date: Tue, 27 Oct 2015 18:30:50 +0100
Message-ID: <1445967059-6897-62-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34961 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964931AbbJ0RmI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:42:08 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ruchi Kandoi <kandoiruchi@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Ruchi Kandoi <kandoiruchi@google.com>

Change-Id: I36fe217fa047d68ea90e78b12c7db4537ea8010b
Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 0e3e45e..3daca21 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -908,6 +908,7 @@ static ssize_t store_boost(struct cpufreq_interacti=
ve_tunables *tunables,
 		trace_cpufreq_interactive_boost("on");
 		cpufreq_interactive_boost();
 	} else {
+		boostpulse_endtime =3D ktime_to_us(ktime_get());
 		trace_cpufreq_interactive_unboost("off");
 	}
=20
--=20
1.7.9.5

