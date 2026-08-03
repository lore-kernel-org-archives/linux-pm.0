Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39D39D6F6;
	Mon,  3 Aug 2026 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780676; cv=none; b=flyJnRFZhR/EGTWEP5TmIotaTGL+i7r4gcwZIPHSUwfcRGoJtbnJWmQqb5jww090O3G4cHgw6Avu0uKkSjqULw471KmVT0AOKRaIIebNfGZ9n2+0Fk5gxmeK200v3f4QOJtKGKxZSUfYLNqqAgnzMdlKBkkGHIbQ6FLgPiK+hLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780676; c=relaxed/simple;
	bh=VlB8ik3K/w+Mz9YdhToh8/rEVvPcaGHd7IqacymkKt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pzzfKzk5OoWuCqq6hasyH8T0vOkefTJdsuWUHVP8H9FnCC8+ZT9/oCmuOSVAeaG6mKZ9RKtXzSoMvEHQp9vzqNC8vk4002WXfdBb6hJLb6dF8YZQy+lYVlGX1edyctZXwTHwnhsFjiUHqINc9ZUI8oFG8hX+n/sbPsxIt1gCskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu04ZLaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu04ZLaD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1251C1F00A3F;
	Mon,  3 Aug 2026 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780674;
	bh=ADmuhGyPnsQrVI3q0l1mWHXbtYHb6HXx7eCGIqiSASU=;
	h=From:To:Cc:Subject:Date;
	b=Xu04ZLaD9z00p21u8EFlaDnNxHYGOQ7X2gwqpY/wxUy8hHvuPB+OH0AUxI7YTvq4L
	 GVkIYu8E4u4j6ySoNlPnmNtQC8Bkv9ZmxszJ3G7kRq6NEF6xeuLsRKaBMU5vnXwVSy
	 uHCRUMqAZLeKaIxGQDSI4yTNceFxk0XXnRSJhAvij6qWyonWQfYbgXtAA5nItnEz65
	 HlS723qRwygvDhWETsQ/iu/E7G2+CK7AA+dDhxlirT9zC+B7rfhgZRHVjYucL85JvP
	 hQTqs7+LyH4SnLuTlPLsDPxW4LTmHS1RXykOohJ6ufXuQY2brqiHbM/q7wjKomjPJt
	 o/1PRgnBP7FuQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>,
 Julian Silver <mendaxca@gmail.com>
Subject:
 [PATCH v1] intel_idle: Avoid using deep idle states during initialization
Date: Mon, 03 Aug 2026 20:11:10 +0200
Message-ID: <5120454.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit c0f691388992 ("intel_idle: Use subsys_initcall_sync() for
initialization") effectively made intel_idle initialize earlier which
turns out to interfere with USB EHCI probing on some platforms [1].
Investigation led to the conclusion that this was related to allowing
package idle states to be used earlier than before.

Work around that issue by making intel_idle set a CPU latency QoS
request to prevent package idle states from being used on all platforms
supported by it for the duration of the device_initcall() initialization
phase.

Fixes: c0f691388992 ("intel_idle: Use subsys_initcall_sync() for initialization")
Reported-by: Julian Silver <mendaxca@gmail.com>
Closes: https://lore.kernel.org/linux-acpi/3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -53,6 +53,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/moduleparam.h>
+#include <linux/pm_qos.h>
 #include <linux/sysfs.h>
 #include <asm/cpuid/api.h>
 #include <asm/cpu_device_id.h>
@@ -2822,6 +2823,9 @@ error:
 	pr_info("Failed to adjust C-states with data from 'intel_idle.table'\n");
 }
 
+#define INTEL_IDLE_INIT_QOS	20
+static struct pm_qos_request qos_req __initdata;
+
 static int __init intel_idle_init(void)
 {
 	const struct x86_cpu_id *id;
@@ -2891,6 +2895,13 @@ static int __init intel_idle_init(void)
 	if (retval)
 		pr_warn("failed to initialized sysfs");
 
+	/*
+	 * Some platforms, in particular the Intel S1200BTL motherboard, have a
+	 * problem with using package idle states too early, so prevent that
+	 * from taking place until the device_initcall() phase is over.
+	 */
+	cpu_latency_qos_add_request(&qos_req, INTEL_IDLE_INIT_QOS);
+
 	retval = cpuidle_register_driver(&intel_idle_driver);
 	if (retval) {
 		struct cpuidle_driver *drv = cpuidle_get_driver();
@@ -2915,6 +2926,9 @@ hp_setup_fail:
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 init_driver_fail:
+	if (cpu_latency_qos_request_active((&qos_req)))
+		cpu_latency_qos_remove_request(&qos_req);
+
 	intel_idle_sysfs_uninit();
 	free_percpu(intel_idle_cpuidle_devices);
 	return retval;
@@ -2922,6 +2934,15 @@ init_driver_fail:
 }
 subsys_initcall_sync(intel_idle_init);
 
+static int __init intel_idle_init_complete(void)
+{
+	if (cpu_latency_qos_request_active((&qos_req)))
+		cpu_latency_qos_remove_request(&qos_req);
+
+	return 0;
+}
+device_initcall_sync(intel_idle_init_complete);
+
 /*
  * We are not really modular, but we used to support that.  Meaning we also
  * support "intel_idle.max_cstate=..." at boot and also a read-only export of



