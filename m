Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607978;
	b=M4HCYe0Eqj9j77e5UIR3IVDJHfRIE8G5i9RrSSDa2qnissWGkiBRePezT8hwerIkGmrd
	 wCYN0Rkz9YXw8PoO4A5LT4bxUAOoMxOwkg51R0YsO/QR13U2tbt/wifyQ5DjDtl/87e58
	 WUUW9AW5hLIDGPicmIuOuo/4hZkW6fzaX92rO3gXcZABqKBbrU2zzePLpKoemzzA81slp
	 qm/nnzlvMwLtCgEKLlrpqI2NOrtvp9buLXSI2mJeR6SiPzlwAg3gQmYVVFNvaOgTBNcq/
	 7e0DPTp6tN0TkzRfXkhFks3ng8Jv7C/r5Jk5r+uOhRSSxoOp9BG9BdzBMHyRkSJiCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607978;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=SU647vzmqaGSjCNDS1nEI1C5jnO7I+EOQmdf1iKE6SE=;
	b=Lj6DgQ8B5kggWYCvtOTNI+OF/dJrotxzmlyDGaRk5PCd6KVO1J4vRoIaixZWNTArjPdw
	 uCogJK4wIkW3my9SFDzU/6kond9ERRrlZs2kn30dMvEuZBQ5pkiFVjco1hkmgszMR5nWy
	 nAPDZsnxrM0CA3AxMNiucUKY4iv0xZm+DX2CncIgTZX0PxFbi7W4+weAGqB9gLXpO7brj
	 /YprL2ifbVKx9Zry4yDbpQJ9nKi44FQKpO8HlPONO7Ck9IxzJSO8HNLYZkUVOwpaoOvnV
	 XIix2UNoX0fD5hks1rquuhQdA4c5iNZ4t1Mv0WU7m3EXHH3BA7EpKafBNUkgo/RjJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fhf1zar+;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dNECNCzR;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3E606A321
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D3E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fhf1zar+;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dNECNCzR
Date: Wed, 25 Nov 2026 11:59:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795607974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU647vzmqaGSjCNDS1nEI1C5jnO7I+EOQmdf1iKE6SE=;
	b=fhf1zar+0qui0ZQRtEjnO/wGCXq17rW04NZQjoh4C4bL3OKjk0IeKvV2JotLhcP0g8Pr2D
	znvb0f+o0itk3AvTIBGw7ShUSVUiZlnvETkkhjTuhtO4ygUuhm/rFJDF6NQulwKPf7u1HH
	KzQ2DnRowp9lJrMUr7n4FTDOSGd/AASHg7Y4ff6TlOFp6mFyNlvGis+NtjpsPGnAEW5ydL
	9f+RVGxQmKlXrzZapNcrGn6/O2/CpOnn6a4E0g98nkaZCaxWXZecOJpbdhFuQ+fRQcVQCS
	lhG4T/VYheA6ELHiJNBOqHFVLxaBCtRL1M/AE+z9OLGmXao/qTa8iyb3x0TRUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795607974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SU647vzmqaGSjCNDS1nEI1C5jnO7I+EOQmdf1iKE6SE=;
	b=dNECNCzRy7ddaTnsuz/phq44aWs2rKAx/u4QNLnJwRpjvJKAJ1Lqc5NmlbSV4OUF+UCQp3
	FSDNb6tg2BprOdCg==
From: "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/qcom/tsens: Release
 parent resources on probe failure
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
References: <20261021085749.3786101-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179560797322.92412.3717508418736846230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     58e10a518985fddf367a9f1c97941f5f6601d36f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//58e10a518985fddf367a9f1c97941f5f6601d36f
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 25 Nov 2026 12:53:14 +01:00

thermal/drivers/qcom/tsens: Release parent resources on probe failure

On legacy MSM8960/APQ8064 device trees without a separate TSENS child
node, the Global Clock Controller (GCC) driver creates a qcom-tsens
platform device without an OF node. TSENS consequently uses the parent
device for firmware lookups and managed resource allocations.

If probing fails, including calibration returning -EPROBE_DEFER, the
driver core releases only the child device's managed resources.
Allocations attached to the parent remain, accumulating across repeated
probe attempts.

Wrap the parent-bound allocations in a devres group and register a
cleanup action on the TSENS child. This releases the resources on probe
failure and unbind while preserving legacy firmware lookups. Keep the
group handling in a probe wrapper so the existing initialization path
remains self-contained.

Fixes: 9066073c6c27 ("thermal: qcom: tsens: Add a skeletal TSENS drivers")
Closes: https://sashiko.dev/#/bug/linux-7dc6dad0-c471-47ca-b493-8402752cf13a
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261021085749.3786101-1-daniel.lezcano@oss.qu=
alcomm.com
---
 drivers/thermal/qcom/tsens.c | 37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 4d7013f..997a0db 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1377,7 +1377,7 @@ static int tsens_register(struct tsens_priv *priv)
 	return ret;
 }
=20
-static int tsens_probe(struct platform_device *pdev)
+static int tsens_probe_common(struct platform_device *pdev)
 {
 	int ret, i;
 	struct device *dev;
@@ -1455,6 +1455,41 @@ static int tsens_probe(struct platform_device *pdev)
 	return ret;
 }
=20
+static void tsens_release_resources(void *data)
+{
+	struct device *dev =3D data;
+
+	devres_release_group(dev->parent, dev);
+}
+
+static int tsens_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int ret;
+
+	/*
+	 * DT-backed devices own their managed resources directly. Legacy devices
+	 * created by the Global Clock Controller (GCC) driver have no OF node and
+	 * use the parent's firmware data and managed resources instead. Group
+	 * those resources so the child releases them on probe failure or unbind.
+	 */
+	if (dev->of_node)
+		return tsens_probe_common(pdev);
+
+	/* Tie resources allocated on the parent to the TSENS lifetime. */
+	if (!devres_open_group(dev->parent, dev, GFP_KERNEL))
+		return -ENOMEM;
+
+	ret =3D devm_add_action_or_reset(dev, tsens_release_resources, dev);
+	if (ret)
+		return ret;
+
+	ret =3D tsens_probe_common(pdev);
+	devres_close_group(dev->parent, dev);
+
+	return ret;
+}
+
 static void tsens_remove(struct platform_device *pdev)
 {
 	struct tsens_priv *priv =3D platform_get_drvdata(pdev);
