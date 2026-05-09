Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DD382365;
	Sat,  9 May 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778318852; cv=none; b=mwcDxoPoN2Xm66YUJkVnjbVCwPXGBlY9eDAAJjBHx2WURj5nNb2ayaWqnK0UDKp7a9kYBVNEWFkUbCm96+zkEsvvlo5JEF+B+m/5dpGqsQ62e2qHGX0U36n+F9Y4QgLu7ZXhISXEeCPv1DgWOidC85ivv9T+ZCvINDmGmiWrvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778318852; c=relaxed/simple;
	bh=8tfSMCNSxrzmA7fK4BAtFJcw4hhOwP0+zl00SMQFpCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y2fM2ux2LZSxv7lF9NcoXpElhJPAWv+D9rem3SNAzWOkhFqnu0J6umvVXokh+rPiF6truBR7fgYYDDfJCPEZqNAgjDeraqzlClZa+OOMySRYrO5bPnNnI03gTZQFg89OZjY3MH5e1MiClw9/RuljtyobsOXCHgU0tr7k3iOp9uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAnC+Lt_f5pX4x7EA--.10838S2;
	Sat, 09 May 2026 17:27:09 +0800 (CST)
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
Subject: [PATCH] PM: sleep: Use complete() instead of complete_all() in device_pm_sleep_init()
Date: Sat,  9 May 2026 09:27:07 +0000
Message-Id: <20260509092707.3426533-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnC+Lt_f5pX4x7EA--.10838S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4kGry5JrW3XrW5Ary5Arb_yoW8WryUp3
	4xK3yFgw1j9r4vy3Wqq3W8XF15Was3Cr97CryrCw15CwsxWrZ0yFy5tFZ8Jr4DZ3yDtasa
	qF15Ja1rGrnF9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

device_pm_sleep_init() is called during device initialization via
device_initialize(), where no threads can be waiting on
dev->power.completion. Using complete_all() here triggers a false-positive
WARNING from lockdep_assert_RT_in_threaded_ctx() when
CONFIG_PROVE_RAW_LOCK_NESTING is enabled, because holding a raw_spinlock
elsewhere in the call chain makes lockdep_hardirq_context() appear non-zero.

Replace complete_all() with complete(), which is semantically equivalent
when no waiters exist (sets done to 1 instead of UINT_MAX). The completion
is always reinitialized via reinit_completion() in dpm_clear_async_state()
before each suspend/resume phase, so this initialization value has no
effect on later suspend operations.

Signed-off-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Fixes: 152e1d592071c ("PM: Prevent waiting forever on asynchronous resume after failing suspend")
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e1b550664bab..7a948dd134df 100644
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
-- 
2.34.1

