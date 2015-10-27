From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 57/70] cpufreq: interactive: fix compiling warnings
Date: Tue, 27 Oct 2015 18:30:45 +0100
Message-ID: <1445967059-6897-57-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chih-Wei Huang <cwhuang@linux.org.tw>, Chih-Wei Huang <cwhuang@android-x86.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Chih-Wei Huang <cwhuang@linux.org.tw>

The gcc warns like:

  cpufreq_interactive.c:745:6: warning: operation on 'ret' may be undef=
ined [-Wsequence-point]

It was introduced by commit cf0fad49d17cb8273ce555dd5b7afab67d7923bf.

Since sprintf(...) just return 1 (one character) in this case, ret shou=
ld not changed.
Just discarding the result of sprintf(...) leads to the result that
the committer of cf0fad49d17cb8273ce555dd5b7afab67d7923bf wants.

Change-Id: Ifed1cef6d6a31c3ed23dad03a567b3b9eddf3a57
Signed-off-by: Chih-Wei Huang <cwhuang@android-x86.org>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index d72e8c4..9f63bd1 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -752,7 +752,7 @@ static ssize_t show_target_loads(
 		ret +=3D sprintf(buf + ret, "%u%s", tunables->target_loads[i],
 			       i & 0x1 ? ":" : " ");
=20
-	ret +=3D sprintf(buf + --ret, "\n");
+	sprintf(buf + ret - 1, "\n");
 	spin_unlock_irqrestore(&tunables->target_loads_lock, flags);
 	return ret;
 }
@@ -792,7 +792,7 @@ static ssize_t show_above_hispeed_delay(
 			       tunables->above_hispeed_delay[i],
 			       i & 0x1 ? ":" : " ");
=20
-	ret +=3D sprintf(buf + --ret, "\n");
+	sprintf(buf + ret - 1, "\n");
 	spin_unlock_irqrestore(&tunables->above_hispeed_delay_lock, flags);
 	return ret;
 }
--=20
1.7.9.5
