Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627663;
	b=NfQRZ6tlWoc3AQHJVyfeVhfT7ku2wHV1d41yNtMFDV4p2DapEdbb2ApE4nbXJlRnu9zh
	 rgJPaTvXN4pWKGoVQCWowgvSbJc3QzmZv15q7I2Yn+xTRoUP53Cbocug369WU3F3tMfzW
	 hScoL3cwc2WiRXKCSq9+dzDQijpd/BcTUPutuniN1ukgpWPgDWhFBqKM2GHPPJPEWUPoy
	 2FMlnVbVLfSQxZjq76nYS4OlFHC2tMJqSH1PIY8uLh94AMEYMVpFHEeHHzWRYQ9ZyPVJJ
	 oLVHAdS9FUCgudb93qLeVEnFAQ/Ul58avyeE/uH3XXqdnEvnCOk4jJMbMNqmPDy6V1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627663;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=mFtjTfjF96h3Bv9TOaPN4aONAIjO6u2dFzKJuI6D/kM=;
	b=veulf2mwEWHDqY/VFDeizZvFflmBXNu8huRlEXPPhZgEmq/jkZyepC7BkR/XHHox9KD4
	 WYR+3AsXsWEo5dtkBP4d/Mmf7pxL9oa/F9X6x799LmzkiNBYrwvkwrVUiiqTsLCwD9iqL
	 OEwOlgL3m9nXYqmzS7ApKj/DtyU7fMl0H4qvuL3MkVgZaA/LTZfkyAuia6BK/ohqm9Z+8
	 NnVaBrNpUQHi13WmA7iyxru2IsEvl5/yoKe7+krQ+y7TMoE0UkJQadQo3f9bNMacP+hUd
	 M4rhH19KgX16sgA5x07Ohibf/3x5TzozIVjc91IfFDO53/EW/ziaxuiyeThX1Nd+nwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCnVpNCR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0E60A2606;
	Mon,  2 Nov 2026 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCnVpNCR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DAB1F00A16;
	Mon,  2 Nov 2026 13:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627663;
	bh=mFtjTfjF96h3Bv9TOaPN4aONAIjO6u2dFzKJuI6D/kM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DCnVpNCRgJUE7VaBJ0XVsv2S78YcT8dtN0tPStJwegyCcoP5u/riLvIREEb9Tiszn
	 bjNuux5gUsKNOelW5FYDwfmPt7IiWdStEDtPTmALUzlFLW3JePPAf4khsZGDTmg4U2
	 hxYB4vLgXi5KMFbRWyw8RbkIN3N+Wlr95PQGiy+FIIl7fBrvhOJxEFQujx/yuRg0Vl
	 9eG7gA+EMdlb3Aou5nkaOLIaRRogFqDxahlyrRxCZxc1nCZc7tuhhCcyN9hxY03mxw
	 efdPyB1rqoJMhus+gtiX9w1XejiZQXA5EyvrNCzRzL3MWhQmW0fRn/m/S5OrqyPrd3
	 dWs3Kh2QgzZIA==
From: Mario Limonciello <superm1@kernel.org>
Date: Mon, 02 Nov 2026 07:54:10 -0600
Subject: [PATCH 2/2] PM: Add shutdown=legacy command line option
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
Message-Id: <20261102-superm1-s4-at-s5-v1-2-313e0012dd39@kernel.org>
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
 Bartu Alev <bartualev@gmail.com>
X-Mailer: b4 0.16.0

Powering off now uses the hibernation callback flow when it is available.
Add an escape valve for systems that fail with this flow.

The shutdown=legacy option restores the device_shutdown() path. Document
it in the kernel parameter reference and the shutdown debugging guide.

Tested-by: Bartu Alev <bartualev@gmail.com>
Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Bartu specifically tested his ASUS FA507 with this series.  His laptop
got really hot in S5 before the series.  He also intentionally used
this debug knob to verify the problem comes back.

Merthan tested on his ASUS laptop and it fixed system getting hot at
S5.
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 Documentation/power/shutdown-debugging.rst      |  7 ++++++-
 kernel/reboot.c                                 | 10 +++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..16d584bdbb73d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6981,6 +6981,10 @@ Kernel parameters
 	shapers=	[NET]
 			Maximal number of shapers.
 
+	shutdown=legacy [KNL]
+			Use the legacy device shutdown callbacks when powering off
+			the system instead of the hibernation power-off callbacks.
+
 	show_lapic=	[APIC,X86] Advanced Programmable Interrupt Controller
 			Limit apic dumping. The parameter defines the maximal
 			number of local apics being dumped. Also it is possible
diff --git a/Documentation/power/shutdown-debugging.rst b/Documentation/power/shutdown-debugging.rst
index c510122e0bbc2..254cd3e0b5907 100644
--- a/Documentation/power/shutdown-debugging.rst
+++ b/Documentation/power/shutdown-debugging.rst
@@ -33,7 +33,7 @@ some potential options include:
 
 Kernel Command-line Parameters
 ==============================
-Add these parameters to your kernel command line:
+Add these parameters to your kernel command line to capture shutdown logs:
 
 * ``printk.always_kmsg_dump=Y``
 	* Forces the kernel to dump the entire message buffer to pstore during
@@ -41,6 +41,11 @@ Add these parameters to your kernel command line:
 * ``efi_pstore.pstore_disable=N``
 	* For EFI-based systems, ensures the EFI backend is active
 
+If the system fails while running the hibernation power-off callbacks, add
+``shutdown=legacy`` to use the legacy device shutdown callbacks instead. This
+can be used to work around the failure and confirm which callback flow caused
+it.
+
 Userspace Interaction and Log Retrieval
 =======================================
 On the next boot after a hang, pstore logs will be available in the pstore
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 1ad8629fde4d9..6c80356b9a85f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -70,6 +70,7 @@ struct sys_off_handler {
  * of that.
  */
 static bool poweroff_fallback_to_halt;
+static bool shutdown_legacy;
 
 /*
  * Temporary stub that prevents linkage failure while we're in process
@@ -317,7 +318,7 @@ static void kernel_shutdown_prepare(enum system_states state)
 	system_state = state;
 	usermodehelper_disable();
 #ifdef CONFIG_HIBERNATE_CALLBACKS
-	if (state == SYSTEM_POWER_OFF) {
+	if (state == SYSTEM_POWER_OFF && !shutdown_legacy) {
 		if (!dpm_suspend_start(PMSG_POWEROFF) && !dpm_suspend_end(PMSG_POWEROFF))
 			return;
 		pr_emerg("Failed to power off devices, using shutdown instead.\n");
@@ -1112,6 +1113,13 @@ static ssize_t hw_protection_store(struct kobject *kobj,
 static struct kobj_attribute hw_protection_attr = __ATTR_RW(hw_protection);
 #endif
 
+static int __init shutdown_setup(char *str)
+{
+	shutdown_legacy = true;
+	return 1;
+}
+__setup("shutdown=legacy", shutdown_setup);
+
 static int __init reboot_setup(char *str)
 {
 	for (;;) {

-- 
2.53.0

