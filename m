Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893784;
	b=JMRTwj1vOSWn8ufHK2n5pF39Gi1a6dahNzbYPKg7hbAbdIIck8k5QNn60/+gpVPGO7Gp
	 ZHqS7Kic1XuybTuLepxT0ClzK7//D7coep4856f5WELt7qRu56U7PbA8U9g+0b+Jk+QMe
	 S91j4BN5rd4UIaThjU+sUq+5ofkF/9KEFWt4W5Dk4neaClmKy2MO6WMHwbTGaM/yHOiM7
	 Mn32GwbqPTqSBCQdm/2XkB+LS5UccmHHhitZf3jxO7/WDqRp0xw0bn2IbA7Yo7zKc1y9e
	 pQH9Ifw2NTua1KaJMv6mgQJSC8Yox53sXdOOq350N0+XbN16a3wRn+NF7DnZ9+VoJYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893784;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=9GWugEMzVkHzBAwk2r5M5fmKjRFcrZqffM7hiI9obCA=;
	b=B+C+eKh1zPT16MTUlNI4neYvJlWnx3Jz6GlAeTB3smQejYf5mGfRwnqKJv7sN8XTJkFs
	 hQamZRM1wePaWiaU/CGvj30ZMo1h9KNWUhpG08+1LTCdWwOG/2lLi+L7oLnvmfZpCjlP8
	 OEEFXzBRqAChSKAgg9WktkyrTPYrVHrRNDwWAaBnaTCJXmyczJ4lg508nyc5g3EWaxmjN
	 qQTUzyqbba5AlskXydsLWF5lSLIP34NSPqwM4IlbrYB4wdR32U8t/7bqCDxOYbgrjHCYP
	 2Vf4fkKsfB6wT38WLWclHP1L32uCTTyTcU3cdX6y1F1CY/nTpa6OPITRFWhX7M/UFrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCsjyNtg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="Q0OyHdE/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA26606D836
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA26606D836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rCsjyNtg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Q0OyHdE/
Date: Thu, 05 Nov 2026 15:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GWugEMzVkHzBAwk2r5M5fmKjRFcrZqffM7hiI9obCA=;
	b=rCsjyNtgabECldcBSsI1w5OOMNSB/KoONe9f1s93781U9a4sRKubMry96Td5alkdjAIOh8
	GjulSaT6ZTuzcAqFqzICGp7cOQEmUkr4zxuUXWX3+5vr1H8stws8jeV/oZahQQipAxvfTT
	OInxUNOMXW0ixQoDa30579kfi7l7m+4amxPE1C7XftZbpVA6iZd1wuFtbsbdu01n7qsIDm
	3QJzaExAjM26pO2iOcpItQ4YrRyEGyefgQnpw2NH1cIv3i92Zle+l6n2J3SF08mLnbiJO6
	lr5J4Zd/Ep9RZuJ5MOq7T470Yftn0jmbYVXSt66oB+g7bGKyMkApqbpw43SB8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GWugEMzVkHzBAwk2r5M5fmKjRFcrZqffM7hiI9obCA=;
	b=Q0OyHdE/bZQ2A3pzaP9rVddPASfebtwvc9NydF0CUCz0IKFz/Xx+dFwPhk5zSJ8Xuxj/oP
	5LjRyTzFueJ0cABg==
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
Message-ID: <179389378067.1009794.8409083392063800648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     2fef2bb0ca32c937b848ba946d07662b1e08d036
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2fef2bb0ca32c937b848ba946d07662b1e08d036
Author:        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
AuthorDate:    Wed, 21 Oct 2026 10:57:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:47:27 +01:00

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
