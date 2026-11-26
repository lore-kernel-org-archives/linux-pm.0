Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795652413;
	b=IpVXrarsSNbyOtRvvF2o9dGDq7SGCYeHbaTGIi5SCRdhjNK+Bow1ZpC4J9AfRpBCASRh
	 7EAjefyT3VknZHTzDG6S2lyM2Ja0+JlP3Z19zW1EBmkNfq1NwBA7RVNLoDyH1jVVYH9ai
	 QH3AQMOgK4Pkmd2d0JD2R3uTu/5k9QE8BQnDhE8/OgGDMbupQO7lqUI2EIO39ddnWpAah
	 SYG71qjFRQPNiaXt4PLI5ysTwRd0NKb7rZWiffFcsEysXjFgU/wOAYv0HM0Awd9zHRDZV
	 ZMdNFxiLFs/rt4OykrN9L+YUIBPx+TL3/9VtTK8m5FrnEEzPdfhkr//ETIcm08c8gog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795652413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=67RnFo9t94m6kVPT2M6dT+gKsUjvLfhYxs4nIkL8V4Y=;
	b=pyb1zwblleD4NAsiJKe14YkC/wUnoMoOdUoo5cS4Mv10Tbza/chJOy3Y5iNYeM2wc4b3
	 /fU4jDEYpp9ZB+C+/YfIXYPUdnvsyAhcQ6BUzJA09HfLKSvl8pPzlQLWohHQrsRL5oBQB
	 3pj7X5PS92vtCHTo84bFZ8ddjcwwfK3bTiVSGgUv8JPpMywuyimZ+ZxU54wWLGqpLtmSB
	 W6dV3if9oTNT7hV+iI9Pjs+4m+O83v1IeVOtr/XFPuDqZ0N/5/xzTpYpD8F3kCNmwjGpF
	 uP8ptfjHOjIzud088naLAojtQCq8QRTKfMcl28hgFxH5eLJL1QYtlgftdMt8W/qA4Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stB+5PBX;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C243606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 00:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C243606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stB+5PBX
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae58d17cd9so7070834c88.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795652412; x=1796257212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67RnFo9t94m6kVPT2M6dT+gKsUjvLfhYxs4nIkL8V4Y=;
        b=stB+5PBXW/avFEos/qFibZqG4ycUMnCS1eSSsFgmU36+3Y0TKFH/tXe07+2Fwi1IyN
         ROC47M/MSdbYyW3z4iAsvRco7wfgKg11ngXKoWF9vRc8kyCrHWxEUee5X03Sd1wU8eCG
         Kcz9mPZz2k52z71Kfyud969RsW1AwM4Qw03iEsjB1u02NTT9lDYNc9om9SPWWclxpVM3
         5wvEBpzJ+CwHgOi6BO7jjP2AGwPvjF86z0oRvBMvk1I42ZaeME58zN/1Li18UTXMWuhz
         qc7g1IFW3yrGxw/XB8uG1dha1wRjmdqfhmHYvGG7ErnUE+z7DElh+S669I1dHzOFfAjO
         oFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795652412; x=1796257212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=67RnFo9t94m6kVPT2M6dT+gKsUjvLfhYxs4nIkL8V4Y=;
        b=hlr8FFG60kcju5h+nqc4o/zIqrBDItmOO8PsaheYyPoIM4I8kni1E3xmAJPrippIOW
         K7dwr/KkdmIatHSiogCgxBu09i7GdvfrhN0WQ7F8Le6LihCSc63NYfNhSRnOLRaZFcdv
         +UKtsz+jq0yHz+w1xgohVa9mWn3Sx+4pBl6y9Pnj7uYICRZ3r4PD5YBLhmBrl07Bd/Gv
         svXGZzC/eNtuVMsBkj2aHVNTEfg6+z0VtDvuz7BqXc/d0tVxm50ZZPtgNoUEE+HgL+WC
         u59bVCZlgKJCwIyQpkkbuuGOX3lKQCYoDlclpyULLrwQ9bQZMPTSDTdqhBoSDFB60T6C
         bc0A==
X-Forwarded-Encrypted: i=1; AL+hErHEQVR7SVu9aoUuRHRvahJ8rZJQDKq+ndN585oyLwedaMgh5oZTDb7Jex9AjGcXlbgTPIuicPzF4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9uqXRcQ/V2gv7p0D6gXIEQGixoCkIAU4HoG5IpdTr+zd6gB78V
	IrQ2885RDcUzGvWO3Vj/4CN4PHw9vc+/MHwgSlKKzrw9ZiyqgMqypFMy
X-Gm-Gg: AZFdTZc1+HlWj+MEiKvi6KyDjMg620QBhKZvnaxAnMWj6+AhFgZAekt6uITMwonQBka
	iCW3XRczNUCikbWktsC3nOP3+aK6xtINaab+4rbxwMhqH4mY1XUj1HyQKTZJfAYjdiBFtDUZvab
	yohwmUt93bte8UOCQYReyJDx4AbtsVNLhIw4hB8W34r5epNH4opK5is/vBaG3p9IHpJCBlDCGX5
	ADwkh3bEhcJaO0L+fT0qAVfWUZnSmTUe7igVR+gWy5S13KhslJc/dkpz7djWsweuG4991eCE0Ou
	dH/lKybim07qTNuKGoh3wE/wwGbk5Prnxf4MPWUT9aOEK23q2qWCGGEgjR1mq+VTlYNMrjRxsUf
	TOuMybHCaX2A4ORIDA8jvyxWmJZUrazIyzlYUFuesDEyQ2hiTb1yNMqX8yn6oBJj57yM9sD5aHG
	BEgI6dIt+qwEzoYoDmzW15PVqtcA1kGboAA16rYLhjH9eQ0ZnIxO6lJq4dZlDX+Bp5HqEUPksrj
	Di0oteSH0OFSkLLcUR64KxBKzd0UvZYSbrcpHXR6xFETnESox9z+cCFoRnjWJpLWxjvX+a6K+Aw
	vvdv4io4oSWdjkItEYZWSuU1r9BlpeTDlzk3/zE63lTxRmOfjznh8Ernpr//Bk7E4Wvwj8lVmW5
	pvaPs7g==
X-Received: by 2002:a05:7022:28b:20b0:1ac:f84d:4036 with SMTP id a92af1059eb24-1b55686f9bamr17189301c88.9.1795652411529;
        Wed, 25 Nov 2026 16:20:11 -0800 (PST)
Received: from dboxtp14.fish-porgy.ts.net ([211.63.184.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556829d31sm72708969c88.9.2026.11.25.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 16:20:10 -0800 (PST)
From: Jason Kim <dialogbox@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Kim <dialogbox@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	regressions@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Xi Pardee <xi.pardee@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Subject: [RFC PATCH] usb: xhci-pci: resume Lunar Lake xHC before system suspend
Date: Thu, 26 Nov 2026 09:20:06 +0900
Message-ID: <20261126002006.25823-1-dialogbox@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANb8v8EGmQf90hRvr8cE3vTKOOY8b6LTxki1uORW_TJ9HadrZw@mail.gmail.com>
References: <CANb8v8EGmQf90hRvr8cE3vTKOOY8b6LTxki1uORW_TJ9HadrZw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a ThinkPad T14s Gen 6 (Lunar Lake), suspend-to-idle often fails to
reach S0ix when the PCH xHC (8086:a87d) is runtime-suspended when the
system suspend starts. The Intel PMT counters show the PCH blocking
package C6 (PREVENT_PKGC6_CHIPSET_1/2) for the whole sleep period, and
the package stays in PC2. No LPS0 constraint is reported as unmet.

A runtime-suspended PCI host controller is runtime-resumed by
pci_pm_suspend() and then suspended again, so it goes through a
D3hot -> D0 -> D3hot cycle in the middle of the system suspend
transition. If the controller is kept active until the transition
starts (power/control set to "on"), S0ix is reached reliably.

Add an HCD flag that makes hcd_pci_prepare() runtime-resume the
controller before any device is suspended, and set it for the Lunar
Lake xHC through a new quirk. The PM core holds a runtime PM reference
from ->prepare() to ->complete(), so the controller stays active until
the system suspend proper and goes from D0 to D3hot once.

Results on v7.4-rc4, battery, 8 s rtcwake cycles, counted as S0ix
entered when last_hw_sleep > 0:

  runtime-suspended xHC (unpatched)       0/30, 4/30
  power/control=on right before suspend  97/100
  with this patch                        28/30

The analysis, the patch and this changelog were prepared with the help
of an AI coding assistant (Claude Code). I reviewed the change and ran
the tests above on my machine.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222281
Link: https://lore.kernel.org/linux-usb/CANb8v8EGmQf90hRvr8cE3vTKOOY8b6LTxki1uORW_TJ9HadrZw@mail.gmail.com/
Signed-off-by: Jason Kim <dialogbox@gmail.com>
---
This follows up on my report in the thread this mail replies to.

Sent as RFC because I have seen this on only one machine, a ThinkPad
T14s Gen 6 (BIOS N4IET31W 1.17), and I cannot tell whether it is a
Lunar Lake issue or specific to this platform and its firmware. The
ACPI power resource of the xHC here is \_SB.PC00.LPCB.EC.PUBS, which
is defined under the EC device, so firmware may well be involved.
Could someone at Intel check whether other Lunar Lake systems show
the same behaviour? Depending on the answer, the quirk could stay on
the PCI ID as in this patch, be limited by DMI, or be dropped in
favour of a firmware fix. I would appreciate advice on which way to
go.

Notes:

- Tested only on v7.4-rc4, on this one machine. The Thunderbolt xHC at
  00:0d.0 (8086:a831) is not touched by this change.

- No Fixes: tag. On Ubuntu 7.0 the same failure happens about 14% of
  the time and on 7.4-rc4 most of the time, but I have not found the
  commit that made it worse, so this works around the trigger rather
  than reverting a specific change.

- Resuming 00:14.0 alone in ->prepare() is enough. A debug variant that
  resumed both xHCs in ->prepare() gave the same result (29/30), and so
  did taking a runtime PM reference from a PM_SUSPEND_PREPARE notifier
  (29/30).

- Separate issue, mentioned only because I left it out of the numbers
  above: in two boots (one of them with this patch applied) S0ix failed
  in every cycle no matter what the xHC did, including with
  power/control=on (0/30). In those boots the display DMC
  "DC5 -> DC6 allowed count" never increased during sleep, while it
  goes up by 15-20 per cycle in every other boot. It does not seem
  related to USB, and I will report it separately once I can
  reproduce it.

- If a more generic fix is preferred, for example avoiding the runtime
  resume in the system suspend path for this device in USB or PCI core,
  I am happy to test it.

 drivers/usb/core/hcd-pci.c  | 21 +++++++++++++++++++++
 drivers/usb/host/xhci-pci.c | 14 ++++++++++++++
 drivers/usb/host/xhci.h     |  1 +
 include/linux/usb/hcd.h     |  2 ++
 4 files changed, 38 insertions(+)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index cd223475917e..85df50237e4c 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -521,6 +522,24 @@ static int resume_common(struct device *dev, pm_message_t msg)
 
 #ifdef	CONFIG_PM_SLEEP
 
+static int hcd_pci_prepare(struct device *dev)
+{
+	struct usb_hcd		*hcd = dev_get_drvdata(dev);
+
+	/*
+	 * Some host controllers misbehave if they are runtime-resumed and
+	 * suspended again in the middle of a system suspend transition, which
+	 * is what happens to a runtime-suspended controller in
+	 * pci_pm_suspend().  Resume them here instead, before any device is
+	 * suspended.  The PM core holds a runtime PM reference from now until
+	 * ->complete(), so they stay active until the system suspend proper.
+	 */
+	if (hcd && hcd->resume_before_system_suspend)
+		pm_runtime_resume(dev);
+
+	return 0;
+}
+
 static int hcd_pci_suspend(struct device *dev)
 {
 	return suspend_common(dev, PMSG_SUSPEND);
@@ -599,6 +618,7 @@ static int hcd_pci_restore(struct device *dev)
 
 #else
 
+#define hcd_pci_prepare		NULL
 #define hcd_pci_suspend		NULL
 #define hcd_pci_freeze			NULL
 #define hcd_pci_suspend_noirq	NULL
@@ -631,6 +651,7 @@ static int hcd_pci_runtime_resume(struct device *dev)
 }
 
 const struct dev_pm_ops usb_hcd_pci_pm_ops = {
+	.prepare	= hcd_pci_prepare,
 	.suspend	= hcd_pci_suspend,
 	.suspend_noirq	= hcd_pci_suspend_noirq,
 	.resume_noirq	= hcd_pci_resume_noirq,
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index e278db940a58..261c77ba794c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -60,6 +60,7 @@
 #define PCI_DEVICE_ID_INTEL_COMET_LAKE_XHCI		0xa3af
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI		0x51ed
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
+#define PCI_DEVICE_ID_INTEL_LUNAR_LAKE_XHCI		0xa87d
 
 #define PCI_VENDOR_ID_PHYTIUM		0x1db7
 #define PCI_DEVICE_ID_PHYTIUM_XHCI			0xdc27
@@ -419,6 +420,16 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_MAPLE_RIDGE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
+	/*
+	 * If the Lunar Lake xHC goes through a D3hot -> D0 -> D3hot cycle
+	 * during system suspend (it is runtime-suspended when the transition
+	 * starts), the platform often fails to reach S0ix: the PCH keeps
+	 * blocking package C6 for the whole suspend-to-idle period.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    pdev->device == PCI_DEVICE_ID_INTEL_LUNAR_LAKE_XHCI)
+		xhci->quirks |= XHCI_RESUME_BEFORE_SYSTEM_SUSPEND;
+
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
 	    (pdev->device == PCI_DEVICE_ID_ETRON_EJ168 ||
 	     pdev->device == PCI_DEVICE_ID_ETRON_EJ188)) {
@@ -679,6 +690,9 @@ int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
+	if (xhci->quirks & XHCI_RESUME_BEFORE_SYSTEM_SUSPEND)
+		hcd->resume_before_system_suspend = 1;
+
 	dma_set_max_seg_size(&dev->dev, UINT_MAX);
 
 	if (device_property_read_bool(&dev->dev, "ti,pwron-active-high"))
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ec4bfeb4887c..d3f202cde46b 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1652,6 +1652,7 @@ struct xhci_hcd {
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
 #define XHCI_ETRON_HOST	BIT_ULL(49)
 #define XHCI_LIMIT_ENDPOINT_INTERVAL_9 BIT_ULL(50)
+#define XHCI_RESUME_BEFORE_SYSTEM_SUSPEND	BIT_ULL(51)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 181db044c4d2..616d334436a1 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -160,6 +160,8 @@ struct usb_hcd {
 	unsigned		tpl_support:1; /* OTG & EH TPL support */
 	unsigned		cant_recv_wakeups:1;
 			/* wakeup requests from downstream aren't received */
+	unsigned		resume_before_system_suspend:1;
+			/* leave runtime suspend in ->prepare of system suspend */
 
 	unsigned int		irq;		/* irq allocated */
 	void __iomem		*regs;		/* device memory/io */
-- 
2.53.0

