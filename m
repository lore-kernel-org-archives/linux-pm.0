From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 69/70] cpufreq: interactive: Don't set floor_validate_time during boost
Date: Tue, 27 Oct 2015 18:30:57 +0100
Message-ID: <1445967059-6897-69-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Junjie Wu <junjiew@codeaurora.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Junjie Wu <junjiew@codeaurora.org>

=46requency selection algorithm guarantees its chosen frequency
is not lower than hispeed_freq as long as boost is enabled.

Setting floor_freq and floor_validate_time during boost could block
CPU frequency from going below hispeed_freq even after
boostpulse_duration expires, if min_sample_time is higher than
boostpulse_duration. This conflicts with the intention of commit
de091367ead15b6e95dd1d0743a18f0da5a07ee5
(cpufreq: interactive: specify duration of CPU speed boost pulse)
to allow CPU to ramp down immediately after boost expires. It also
makes boost behavior inconsistent since it depends on min_sample_time.

Avoid setting floor_freq and floor_validate_time when boost starts.

Change-Id: I12852998af46cfbfaf8661eb5e8d5301b6f631e7
Signed-off-by: Junjie Wu <junjiew@codeaurora.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 064ab56..95525b3 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -606,14 +606,6 @@ static void cpufreq_interactive_boost(void)
 				ktime_to_us(ktime_get());
 			anyboost =3D 1;
 		}
-
-		/*
-		 * Set floor freq and (re)start timer for when last
-		 * validated.
-		 */
-
-		pcpu->floor_freq =3D tunables->hispeed_freq;
-		pcpu->floor_validate_time =3D ktime_to_us(ktime_get());
 		spin_unlock_irqrestore(&pcpu->target_freq_lock, flags[1]);
 	}
=20
--=20
1.7.9.5
