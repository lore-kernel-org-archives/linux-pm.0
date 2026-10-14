Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452D47D47A
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009172; cv=none; b=rkSgNWUGPSqTjXwn+EtIxZjEMsCEyNPeVJcFGFYwXzMSwDWJ6EWWGYIM6TkpYN1Yu7qEBY1B2jJvtIFOX8+yx8iOudyG+cb6D21QkTnypLcIyPgDXe462F/0WgcD6UrQDaZRRP331RfFR5kBQB7+8sw3sIELR9GIAd9Y2gMCNrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009172; c=relaxed/simple;
	bh=X0mEEhygK0MLHthM3WIi/83jtbol6g35/nqCm65nqrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i8+D6K1tGIofRcpSgs4eMtpAaF118ex7qVOSJr7Xnp8BOHFQpX1I1+ZmS15jn1aRuPzuDhmFD5D79WF/7aytYg5318LXPrks0C7H3K9PEpZjs8dDscMFD2pBn7xWAS3REQ1lW83oV36N+FBpdWDoxY1UFKcSPZLwvJwod3oAgYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5AOhYLw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fsnZQAbn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5AOhYLw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fsnZQAbn"
Date: Wed, 14 Oct 2026 20:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o46f6KWtzr0lCxk65DsOqlXbdylytDabtYJnrEGmFCA=;
	b=O5AOhYLwFToFbcU/8c233sdIMnN9DMNEyaHd+aIphyEuFN/uZ0Jk8Plx+cZ/Jj/JkuCTPl
	YuPOhYqdxOWLwJCFfwWZUYyHZkTcfMWL4MWEUc4geZhQ1+tGkW+TtPB6ISxPjo+yCf6WPd
	eEZXoK7tXEL6Uy+RO84/4OUpX5FTfX8xrz3uO14ULC8fBx/ZjKNkmErXGjagdPgW1pB0mQ
	p0anKMqXz1LIcePEfJn/61Z+pNlmrTAC0jNLfUK2Lr9j+HbEFBC5zn1CDc9V7DAR16HTfv
	T9fhqptxNqvbfYh8on5NtVS4ZuNQoyrWiiUHKxNPwBPf5KXsJzyECB6iEf4jXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o46f6KWtzr0lCxk65DsOqlXbdylytDabtYJnrEGmFCA=;
	b=fsnZQAbniMTE+nxYIXIUa5AZce85zPTVJ3TA2M/C3aztBWhvDrQk3p2QYql0SvxYDNnpxL
	WKIbdUObN/kUEdAQ==
From: "thermal-bot for Aryan Sinha" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/linux-next] thermal/fw: Fix kernel-doc parameter names
Cc: Aryan Sinha <sinha.aryan03@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20261012152037.33461-1-sinha.aryan03@gmail.com>
References: <20261012152037.33461-1-sinha.aryan03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200916727.2666337.4855679415933911644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     379ae6766d1a7a1f78f1d97b6c72a262f14960e8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//379ae6766d1a7a1f78f1d97b6c72a262f14960e8
Author:        Aryan Sinha <sinha.aryan03@gmail.com>
AuthorDate:    Mon, 12 Oct 2026 20:50:32 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

thermal/fw: Fix kernel-doc parameter names

The kernel-doc for thermal_fwnode_cooling_device_register() still names the
old device tree arguments np and of_index, and
devm_thermal_fwnode_cooling_device_register() documents fw_index rather
than fwn_index. Rename them to match the code and reword the device tree
reference as a firmware node one.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
Link: https://patch.msgid.link/20261012152037.33461-1-sinha.aryan03@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/thermal_fw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_fw.c b/drivers/thermal/thermal_fw.c
index e8bd204..7c28bfa 100644
--- a/drivers/thermal/thermal_fw.c
+++ b/drivers/thermal/thermal_fw.c
@@ -11,13 +11,13 @@
=20
 /**
  * thermal_fwnode_cooling_device_register() - register an thermal cooling de=
vice
- * @np:		a pointer to a device tree node.
- * @of_index:	a cooling device index in the cooling controller
+ * @fwnode:	a pointer to a firmware node.
+ * @fwn_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
  *
- * This function will register a cooling device with device tree node refere=
nce.
+ * This function will register a cooling device with a firmware node referen=
ce.
  * This interface function adds a new thermal cooling device (fan/processor/=
...)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind it=
self
  * to all the thermal zone devices registered at the same time.
@@ -71,7 +71,7 @@ __devm_thermal_fwnode_cooling_device_register(struct device=
 *dev, struct fwnode_
 /**
  * devm_thermal_fwnode_cooling_device_register() - register a thermal coolin=
g device
  * @dev:	a valid struct device pointer of a sensor device.
- * @fw_index:	a cooling device index in the cooling controller
+ * @fwn_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
