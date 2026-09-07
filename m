Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931B41C302
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767141; cv=none; b=qPNtYT2fWfOz9TeYF/knWuLcHQC4wm17r14nRztLdYeXFmYSEc+aw3lnaj+06SqLxd8Z2LQKKZIHfQpflROjivd5R5LsAfjpWBUL9Fm6sM9N2YOSJCxxhe583h17e2UweBc6Vnb5Bjzi6h3FPJo9SWyki6LU0XXI10SOZAny7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767141; c=relaxed/simple;
	bh=5yWZl1jwei4RGUJo4VVTHvQQ/qhIpImbHnCijWHhCSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KyJDTDorCvpOHOhy+JbOPkU1A+h0oUqr3GuyrfndF+gxP1D6n/ZL3jWO20ObRigQV35qgHm3SdMhDGf5viRgI8iZMTMo9XnQ5ss1BQA0WcSheLPTrCHDnM6sdeQNDEBANcJiHeQSJasmBHDPhKaZVYt7PYvomXQSQ6ET7xFSfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UO8szE6e; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UO8szE6e"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so24730585e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 00:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767137; x=1789371937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rD5WySJ1L49NgFFXB+bGCoZxLI27TU6b4IffLKrGf+c=;
        b=UO8szE6eGPuPo5N2zez2anOdtuwbNZ4BohHeE/8jcYB1Ha0QT0dOgNFExzNx2N+uNF
         g3OB6knIIOcX6ymZxcvPw+ccC6pkiXmjwxYZWB7ZyqqKkLZcu29zConw95XTJYm7xNk4
         IY5MvJoQdOjoxo4QtiXY4tgbmueQsoEk6Ik5EZXBdJKa0uANCgV0U53o6aM33ne3ZVY+
         0CAywYtDZk3x/wGRHAvqnSHWrnwVukPOqCP/PbI3qevfieaPjNb0Pu4G/29swqn0sUyB
         Mry96Mi/5/Xcl6JELEHkMOll3WZJUAdNcQSS1dAG+Lr0wPbzTolJordkSiMvXj8KNjrZ
         2yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767137; x=1789371937;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rD5WySJ1L49NgFFXB+bGCoZxLI27TU6b4IffLKrGf+c=;
        b=D8nNj0boCbwHQZrxwJXMadYdroGJsLVsLMu463I0w740/3TBdrNkD4DF3zjAym67GS
         fgeKoDPnU8mP7/pDZnTTM+7ZHAf14PuT/rCa6FNgSqONbMs9DauDUsXXUvQ5rrV4c+dz
         dWaL+CWuKZPz8ffylZwarl/m9FXnYj1n7KXy6pwoZeBccOkd8Fwd4pFt3aghYwUs6m51
         cLwecWcA6/0qpH37A9tOJyOR2K4E5pLTMazBUmlYnwxOGAXEMHB4N/nLbzoLJKqOdqc/
         yjtzaBoeZAj+t81omCLmYLCgqhx4YzQXVLpHcNm0uYvv/nW+JiKBhmUtlsyIuPLQncLO
         APww==
X-Forwarded-Encrypted: i=1; AKwUvBw9p9j441QQQ0xrwQEUJZXAoCSYHMCWHkcmyrciZuvfjVUazj/pm+6FRRJfW900hdPFkKHFPgdp7g==@vger.kernel.org
X-Gm-Message-State: AFuF++mGluwnxAaPFJf9q/vyy6awQIVEprOToZdWKoTRMDa2UzA4cYmZ
	c4ZR1zEHP3je/LJtkUmRut9MKkVQPI1/oed20MvqlmAuHdTxMMbzH7H+
X-Gm-Gg: AYBFou3zs2sGkmLxKqsbr0bufYRi9dCM/ZKRDwKrxxTeEw1YeKS+5hQNK7/ITBVK/8W
	rPtzQeGIacw6Ni7e1nSXTMpPby/o+b4zjmyG6CLe5egeaRR7yQdZn46qD73WLBusdfzgBJ0KRn+
	0A9UaNGHtnatxlz2u5WLbNKDE9sukHQ32PIID/7NHrOVajIc5LSA8Ho2yC4YfYTn3lBCqjBREFT
	9yb3qhnGnpjEfTBSSs+BUJdGL5rhSzmBG54VT63b6j0pReYWkc9DJyTAfhcAJSS6vzJAzzm7Ny/
	EaUbR2vK4VGFHj7+dgLyN37poo62T8Hr/sbWifoViu9gVFGXaBad+xrQN3znYoSIiYZR2ZcmHXp
	d7PJ+elbPRO6IJc+++YR/NBSD1QXFb6bxzyN2JDOk0V6JEcusnT76pEjv6L6Z8XThJcgrsMywZG
	5or+x33+Uj+i9HRsB9VhyV/W3AO06ghE/a/FRY3nQlLFXcXe3d5Hf5+6nKJjrOTz9nD9lY+Q==
X-Received: by 2002:a05:600c:3588:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49cfc6ea7d5mr184672115e9.22.1788767136986;
        Mon, 07 Sep 2026 00:45:36 -0700 (PDT)
Received: from foxbook (bfg95.neoplus.adsl.tpnet.pl. [83.28.44.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d08144037sm191147985e9.7.2026.09.07.00.45.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Sep 2026 00:45:36 -0700 (PDT)
Date: Mon, 7 Sep 2026 09:45:32 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: "Gordon Chen" <chengordon326@gmail.com>
Cc: "Mathias Nyman" <mathias.nyman@linux.intel.com>, "Mario Limonciello"
 <mario.limonciello@amd.com>, "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 <linux-usb@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Mathias Nyman"
 <mathias.nyman@intel.com>, Ingo Haenlein <ingo.haenlein@gmx.de>
Subject: Re: USB-audio isochronous Missed Service Errors on AMD Zen5 client
 (Fire  Range) -- Data Fabric idle C-state? No OS-level knob found
Message-ID: <20260907094532.4ffeddd5.michal.pecio@gmail.com>
In-Reply-To: <18b4f8f0c2ce37be.8d4c4c4ee804b95a.4c2042ec04b99872@GordonMsi>
References: <18b4f7b23ba6392f.e25301f473da0264.54f7bc72d1817dd4@GordonMsi>
	<18b4f8f0c2ce37be.8d4c4c4ee804b95a.4c2042ec04b99872@GordonMsi>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 13:44:25 +0000, Gordon Chen wrote:
> Hi all,
> 
> A quick correction and a sharper question after probing the PCIe side.
> 
> I checked the controller's PCIe config (lspci -vvv): the xHC function
> (0000:6b:00.3) has no Latency Tolerance Reporting extended capability
> at all and reports DevCap2 LTR-. Its upstream root port (00:08.1) is
> LTR- as well. So the PCIe-layer variant I floated in my last mail is
> a dead end -- there is no LTR register to write, and neither the
> endpoint nor the root port advertises the mechanism.
> 
> That leaves an apparent contradiction I'd appreciate help squaring:
> 
>   - USB/xHCI layer: HCCPARAMS1 LTC = 1 (the controller advertises
>     Latency Tolerance Messaging Capability).
>   - PCIe layer: the same function is LTR- (no LTR capability at all).
> 
> So if I issue a Set LTV command (the driver-injected path you
> mentioned), where does the xHC actually forward that aggregated
> tolerance value to the fabric, given it has no PCIe LTR egress? Is
> there an internal sideband path to the DF on these integrated AMD
> controllers, or does LTC only affect USB link power states on this
> silicon -- in which case Set LTV would never reach the Data Fabric?
> 
> If it's an internal/sideband path (Mario / Shyam?), a Set LTV PoC is
> still worth trying. If LTC is purely USB-link-scoped here, it won't
> touch the DF idle problem and I should look elsewhere. That
> distinction decides whether I write the PoC at all.

Hi,

I wrote a small debugfs interface for people to play with, it just
issues the Set LTV command with given BELT parameter. You know it
worked when you see "INFO unknown command type 20" in dmesg.

See USB 3.2 spec 8.5.6.2 for details of the BELT value. TL;DR:

1024 + latency_us, must be given in decimal and latency_us <= 1023

The spec says this only matters for non-isoc endpoints, so I guess HW
is expected to be smart enough to manage it itself when isoc is active.
Ergo, it will probably make jack all difference and we can comfortably
go back to blaming AMD.

Please also try 7.3-rc2, just in case you are actually running into
known (hopefully fixed) problems with isoc URB scheduling.

Regards,
Michal

---

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 0f6f97cfe0b0..5f370e5e57ff 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -670,6 +670,70 @@ static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
 	}
 }
 
+static int belt_show(struct seq_file *s, void *unused)
+{
+	return 0;
+}
+
+static ssize_t belt_write(struct file *file,  const char __user *ubuf,
+			       size_t count, loff_t *ppos)
+{
+	struct seq_file         *s = file->private_data;
+	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
+	struct xhci_command	*cmd;
+	u16			belt;
+	int			ret;
+
+	/* Decimal number */
+	ret = kstrtou16_from_user(ubuf, count, 10, &belt);
+	if (ret)
+		return ret;
+
+	cmd = xhci_alloc_command(xhci, true, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	spin_lock_irq(&xhci->lock);
+	ret = xhci_queue_vendor_command(xhci, cmd, 0, 0, 0, TRB_TYPE(TRB_SET_LT) | belt << 16);
+	if (!ret)
+		xhci_ring_cmd_db(xhci);
+	spin_unlock_irq(&xhci->lock);
+	if (ret)
+		goto free;
+
+	wait_for_completion(cmd->completion);
+
+	switch (cmd->status) {
+	case COMP_SUCCESS:
+		ret = count;
+		break;
+	case COMP_TRB_ERROR:
+		ret = -EBADR;
+		break;
+	case COMP_PARAMETER_ERROR:
+		ret = -EBADRQC;
+		break;
+	default:
+		ret = -EIO;
+	}
+free:
+	xhci_free_command(xhci, cmd);
+	return ret;
+}
+
+static int belt_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, belt_show, inode->i_private);
+}
+
+static const struct file_operations belt_fops = {
+	.open			= belt_open,
+	.read			= seq_read,
+	.write			= belt_write,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
 static int xhci_port_bw_show(struct xhci_hcd *xhci, u8 dev_speed,
 				struct seq_file *s)
 {
@@ -901,6 +965,8 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
 
 	xhci->debugfs_slots = debugfs_create_dir("devices", xhci->debugfs_root);
 
+	debugfs_create_file("belt", 0666, xhci->debugfs_root, xhci, &belt_fops);
+
 	xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
 
 	xhci_debugfs_create_bandwidth(xhci, xhci->debugfs_root);
