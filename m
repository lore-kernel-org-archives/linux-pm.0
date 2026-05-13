Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDBD3EDE72;
	Wed, 13 May 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638535; cv=none; b=XBDIB0gB9b5jrkPZDX+tUysp9fGqHUYYSBrjJCR5dalq6WdNGh5N81J8E1EFJtdAo2qkZxtiO+OyrDiwrX2WstavinTHMcP6ZBf+pcmwfJdi22zVTTFLELuJ7oC6eFVUx/q0X91lJqjWBiUNRQQYDggDuExmiTK4XyVR0npTDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638535; c=relaxed/simple;
	bh=cyBGQYu3cnltr0KpzFHVMko97pZy3Otlu/birjlNyqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9XoX5QD7wncwJPuYUbegYG5h808TWHLcQQOUszQ5+rGGHf2QKjtA0ryFmiPW6QjZNwBeKIHlEk8zqXxVUaaIwQD/KC1CyOc4MLesCeXZ9HhsbE1x+GqohHndTXfKdbjwINGsqmmcPqkjbTJ2rNsoOKHM046XPj6e2nKT7xjgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACHFwu03gNq5iMdEA--.8577S2;
	Wed, 13 May 2026 10:15:16 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Colin Cross <ccross@android.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH v2] PM: sleep: Use complete() in device_pm_sleep_init() and skip no_pm devices in dpm_wait()
Date: Wed, 13 May 2026 02:15:09 +0000
Message-Id: <20260513021509.483108-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHFwu03gNq5iMdEA--.8577S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW8XF45tFyUWr15Gw4xXrb_yoW5Gr15p3
	4v9ayFkw4UXr4vyF1jq3W8GF15X397Cry7CrWFkw1UCwn8Wr98tFWrtFW5XFs8A39xta47
	trWUJa1rCFnF9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUQvtAUUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

Replace complete_all() with complete() in device_pm_sleep_init() to avoid
a false-positive WARNING from lockdep_assert_RT_in_threaded_ctx() when
CONFIG_PROVE_RAW_LOCK_NESTING is enabled. The WARNING triggers because
complete_all() may be called in atomic context (e.g., from
device_pm_remove() during network namespace cleanup which holds a
raw_spinlock).

complete_all() sets the completion count to UINT_MAX/2 (permanently
signaled), while complete() sets it to 1. Since no threads can be waiting
during device initialization, both are equivalent at that point. The
completion is always reinitialized via reinit_completion() in
dpm_clear_async_state() before each suspend/resume phase.

However, changing to complete() introduces a potential deadlock for
devices with no PM support (dev->power.no_pm = true). Such devices are
never added to the dpm_list and do not go through dpm_clear_async_state(),
so their completion is never reinitialized. A parent device waiting on a
no_pm child across multiple suspend phases would consume the single-use
token in the first phase and block forever in the second.

Fix this by adding an early return in dpm_wait() when dev->power.no_pm is
set, since no_pm devices do not participate in system suspend/resume.

Fixes: 152e1d592071 ("PM: Prevent waiting forever on asynchronous resume after failing suspend")
Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
---
V1 -> V2:
- Updated dpm_wait() to skip devices with no PM support,
  as suggested by Rafael J. Wysocki.
---
 drivers/base/power/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e1b550664bab..ed48c292f575 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -115,7 +115,7 @@ void device_pm_sleep_init(struct device *dev)
 	dev->power.is_noirq_suspended = false;
 	dev->power.is_late_suspended = false;
 	init_completion(&dev->power.completion);
-	complete_all(&dev->power.completion);
+	complete(&dev->power.completion);
 	dev->power.wakeup = NULL;
 	INIT_LIST_HEAD(&dev->power.entry);
 }
@@ -252,6 +252,10 @@ static void dpm_wait(struct device *dev, bool async)
 	if (!dev)
 		return;
 
+	/* Devices with no PM support don't use the completion. */
+	if (dev->power.no_pm)
+		return;
+
 	if (async || (pm_async_enabled && dev->power.async_suspend))
 		wait_for_completion(&dev->power.completion);
 }
-- 
2.34.1

