Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627662;
	b=I77Ft2xy4mV+5YkTxhDUYPRSL5izxnpzSoJgkOmT6q0iNped3SidtIRbFGpNn8rKf1B5
	 10B7uXtcQAtNkT2nIBHGJ6WfvsW+KhN5R5VKxKbYSntq/OwK5IsMeHKYMfAhZC5YD1rOX
	 JVaAVoYCVfxhRkzP1pXfvlnSMZmuYfNUnmzxEDxjMC2tKPRIrC+WhOnXtGh0SSCBomxS+
	 vzoPfXQrhgzMHviclGZeGtXQtIpT4DcLZaUf/ikWJ8RD1adPmaAmgMqJ0KesNTRkcuC1d
	 Fb6vnSD8O7vXONtLI841uaaBkIhcykbETHubyzqVk5CDWz97qqgMVU7rK8qf2aXnEDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627662;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=ik6VFiFfPJe255GVKRzpIR8r7xYA8hWdqcOzEhsK5iM=;
	b=RKmZtagyCL1D8WanMRsXFNLbhskyTE8qfo8SmFEVvgjtE3JIXRi8UeQV8KUajRRQRi6k
	 nVBXNnlJb7P6/W5KpFIPDkyXeLarWviUwsHtHe/rDAU5ktKOtg53M40OFShdkz3mBxuGZ
	 Frn5VAjV0+TUVBoGIiNab9efUfuD2ApgfZ2GisDkd7EbiRCV4xUcIItev82uNmjC6R9iT
	 XSh74mT8B5boW0fG5WQJVmEmJSmWtirgQEFvhOWO1x1a0neKVjShIJwAd5eWraafvf/ln
	 5+azqPtMNz/nCUjY6NBflyGT0rf2u4w3ZKFwPR/86BjOFo966kZdfn3a9R/Dv/jJtZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyK9fahL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB7606A336;
	Mon,  2 Nov 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HyK9fahL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C811F00A18;
	Mon,  2 Nov 2026 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627661;
	bh=ik6VFiFfPJe255GVKRzpIR8r7xYA8hWdqcOzEhsK5iM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HyK9fahL3mEyAFHzDo3wWnmF9nJ9B+SCg/3LQHhwltqBBb1+Q/YKYdECY4Dcqvr78
	 zSE60H7288DSylqiDUzQL5/Dq7OitRRqhVoVr/IweuX/lqZWiGKnw7a6NlTh2wLD+Z
	 92R6R823/G+ZtIN0H3KHi3YScKGIFRsEU/u/+b43Qpxlc0B4dV7wxlOwIrPq2VVC4x
	 t2ZWW4lTm/kBq+Fiav9UgUgubNlKuD9I+AmDtHCSVxD+cqNKxxaR7esfasqIypwfkv
	 +n1j7XCektl1X6rH1ARjBjh/SqZ2rKJVVQhAfj8T0APOI6isux0Zg0I+ms3wxKQyPT
	 zRYax/JwnFu8w==
From: Mario Limonciello <superm1@kernel.org>
Date: Mon, 02 Nov 2026 07:54:09 -0600
Subject: [PATCH 1/2] PM: Use hibernation callbacks for system power off
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261102-superm1-s4-at-s5-v1-1-313e0012dd39@kernel.org>
References: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
In-Reply-To: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, 
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Eric Naim <dnaim@cachyos.org>, Bartu Alev <bartualev@gmail.com>
X-Mailer: b4 0.16.0

During system power-off, device_shutdown() invokes the PCI bus shutdown
callback for each PCI device. pci_device_shutdown() first calls
pm_runtime_resume(), which may return a runtime-suspended device to D0
before invoking its driver's ->shutdown() callback. Consequently, devices
may remain in D0, consuming power or causing spurious wakeups.

Devices should instead remain in a low-power state until power is removed.
ACPI 6.5 section 7.4.2.5 states that all devices are in D3 in S4. Section
7.4.2.6 defines S5 as similar to S4 except that OSPM saves no context, so
reusing the device hibernation power-off callbacks for S5 is appropriate.

For SYSTEM_POWER_OFF, run the device PM core's suspend sequence with
PMSG_POWEROFF. When CONFIG_HIBERNATE_CALLBACKS is enabled, this invokes the
hibernation ->poweroff*() callbacks. Skip device_shutdown() after a
successful sequence so the PCI shutdown callback does not resume devices to
D0 and undo the transition. If callback support is unavailable or either
phase fails, fall back to device_shutdown() so power-off can continue.

Tested-by: Eric Naim <dnaim@cachyos.org>
Tested-by: Denis Benato <benato.denis96@gmail.com>
Tested-by: Bartu Alev <bartualev@gmail.com>
Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-pci/20250506041934.1409302-1-superm1@kernel.org/
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 kernel/reboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 9a84401adde5a..1ad8629fde4d9 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -14,6 +14,7 @@
 #include <linux/kexec.h>
 #include <linux/kmsg_dump.h>
 #include <linux/rcupdate.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/sched/signal.h>
 #include <linux/suspend.h>
@@ -315,6 +316,13 @@ static void kernel_shutdown_prepare(enum system_states state)
 		(state == SYSTEM_HALT) ? SYS_HALT : SYS_POWER_OFF, NULL);
 	system_state = state;
 	usermodehelper_disable();
+#ifdef CONFIG_HIBERNATE_CALLBACKS
+	if (state == SYSTEM_POWER_OFF) {
+		if (!dpm_suspend_start(PMSG_POWEROFF) && !dpm_suspend_end(PMSG_POWEROFF))
+			return;
+		pr_emerg("Failed to power off devices, using shutdown instead.\n");
+	}
+#endif
 	device_shutdown();
 }
 /**

-- 
2.53.0

