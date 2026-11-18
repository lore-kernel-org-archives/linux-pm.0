Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.211.166.241
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039367;
	b=GfPBcyxDbMrc8ibbyhkL3CKF1wdOWer6aGlFwoMIV7nKIjIzNzHFDjM/Rn9hyjUmUxSU
	 nSVTe18E988KD2bmDPs3pYM+JdpBnM5nx+f8dPZB40QVuB8XPtSOTTsYRA+OB0vzazD+g
	 lEVVftzp1ZxaSQ2WPLhnWziOpqnY6lBLhjgHONctf/TFaQzlXfjHZXNfHDmZcvwEvXmdy
	 YCD+YYmjbcBLt+hTcO4TfbOeOS3mX4ACHVOews9GNyDClfy0coCI5g1lsoOjuvM9GDLZo
	 bt3QoltLwR7NurXbuuOAi5EkJ+xYWcpAhOoNaNMhwRkLVdKkq32tiVjU/F1MsBwUADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039367;
	h=DMARC-Filter:DKIM-Signature:Received:Subject:From:To:
	 Mail-followup-to:Forward-to:Reply-to:Message-Id:Date;
	bh=kr0PipGp7yXca/w7m2D5TH1UM2D+DidDSv9RdMc83RA=;
	b=mEI/+aWES0ImX041jrhsjSEJBqs/59f7p9l7v8ehDzO1DmhmByzd3MtyT9c+PYhaKh1E
	 CoFxjeuBMYb42b7Kfrk69D/6fzo37I5OxTnkA1i8SQ9C+WhhfrRJ9FRYb9hCFQSD4EY/d
	 jHwxa7nACEvytLpIULUkvWg/cSJoIds/j1kemkOARG9VzfeeL+dlGPG2207MAYMAAFPJA
	 igh1xWx9ohJTvDX4Ua5UoTqO6hRYZ/Cc99rdDk2JRIw9FIwp3oxwwRc+gstxsf8z5pYnh
	 LWHh+eWjGyoqnUlZxauRm3vS77x8SfOzpKIiKIH23NWaD84uds+OB9Z/auVcwvQ2L/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxtv.org;
	spf=pass smtp.mailfrom=linuxtv.org;
	dkim=pass header.d=linuxtv.org header.i=@linuxtv.org header.a=rsa-sha256 header.s=s1 header.b="peoX/Rzv";
	arc=none smtp.remote-ip=140.211.166.241
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF177606A336
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 22:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF177606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxtv.org header.i=@linuxtv.org header.a=rsa-sha256 header.s=s1 header.b=peoX/Rzv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linuxtv.org
	; s=s1; h=Date:Message-Id:Reply-to:To:From:Subject:Sender:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kr0PipGp7yXca/w7m2D5TH1UM2D+DidDSv9RdMc83RA=; b=peoX/RzvMLH7OhiGhEL6Fi/iRh
	G+4o9CmhFiouZieHXfOEo5cUtdnCIX6fMmM8yRQViuFYNKzmVu48oZ+5NOC6nnWocogGAKktAdqYg
	EBbiNDTUxvEnd7ZraF4Kdl/tu9DFl64VzxOLwP6YZeBNypne1HKFtK6INW5XJbnNGn3Bd2hcqG1Ah
	zw33xjUagWtO8YcQpTysqsJDDfiFPcNSNf6A0bJDWpadzkVmrcr/Y++k6hGIy/x0DgGHnE01IXhSD
	YqBQAy792weZ9Tt4GQ6C9X47wRcoul+ussLdHGcY5MNpG+4ugzf+gkcaXQPWOO39SWFCuToFDoNV/
	ZBw7jIfQ==;
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1xTnce-0008TD-2q;
	Wed, 18 Nov 2026 21:55:20 +0000
Subject: [media.git/next] media: ipu6: Keep psys out of direct-complete on system suspend
From: media-ci@linuxtv.org
To: Chris Simpson <chris@nilk.net>, linux-pm@vger.kernel.org, linuxtv-commits@linuxtv.org, Rafael J. Wysocki <rafael@kernel.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1xTnce-0008TD-2q@linuxtv.org>
Date: Wed, 18 Nov 2026 21:55:20 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list

On Sat Oct 17 16:13:38 2026 -0600, Chris Simpson wrote:
> Since commit a1fa010b3c9f ("driver core: auxiliary bus: Drop
> auxiliary_dev_pm_ops"), the auxiliary bus has no dev_pm_ops. The psys
> auxiliary device has no driver in mainline, and its PM domain,
> ipu6_bus_pm_domain, has only runtime PM callbacks. So
> device_pm_check_callbacks() now sets power.no_pm_callbacks for psys,
> and device_prepare() puts it in direct-complete.
> 
> A runtime-suspended psys in direct-complete gets its runtime PM
> disabled in device_suspend(). Runtime PM is enabled again only in
> psys's own device_resume(), which in practice runs after the PCI
> device's. Before, it came back in device_resume_early(). ipu6_resume(),
> the system resume callback of the PCI device, runtime-resumes psys
> before the firmware authentication. That now fails with -EACCES on
> every resume:
> 
>   auxiliary intel_ipu6.psys.40: Failed to get runtime PM
> 
> and ipu6_resume() returns early, skipping ipu6_buttress_authenticate().
> In secure mode the firmware is then not re-authenticated after resume,
> which matters whenever the IPU has lost power. On s2idle on a Surface
> Pro 9 the cameras still work, and the error is logged on every resume.
> 
> Add suspend and resume callbacks to ipu6_bus_pm_domain that forward to
> the driver. That is what the PM core does without them, so isys is
> unaffected, but psys has PM callbacks again and is not left in
> direct-complete. This restores the behaviour from before the auxiliary
> bus change.
> 
> The fix is kept local rather than in the auxiliary bus or the PM core:
> it is this driver that runtime-resumes a driverless child from its
> parent's ->resume().
> 
> Fixes: a1fa010b3c9f ("driver core: auxiliary bus: Drop auxiliary_dev_pm_ops")
> Cc: stable@vger.kernel.org # v7.1+
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Chris Simpson <chris@nilk.net>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Patch committed.

Thanks,
Sakari Ailus

 drivers/media/pci/intel/ipu6/ipu6-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

---

diff --git a/drivers/media/pci/intel/ipu6/ipu6-bus.c b/drivers/media/pci/intel/ipu6/ipu6-bus.c
index 173616381f62..1b06e581edbd 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-bus.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-bus.c
@@ -63,8 +63,16 @@ out_err:
 	return -EBUSY;
 }
 
+/*
+ * The driverless psys device needs system sleep callbacks, or it is put in
+ * direct-complete and its runtime PM is normally still disabled when
+ * ipu6_resume() tries to runtime-resume it. These only forward to the driver,
+ * as the PM core would do without them.
+ */
 static struct dev_pm_domain ipu6_bus_pm_domain = {
 	.ops = {
+		.suspend = pm_generic_suspend,
+		.resume = pm_generic_resume,
 		.runtime_suspend = bus_pm_runtime_suspend,
 		.runtime_resume = bus_pm_runtime_resume,
 	},
