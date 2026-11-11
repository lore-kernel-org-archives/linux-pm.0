Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395725;
	b=jyUu6J1v9STXmH8KJhP8IDKQelWtSKfN3qchcsa7JVIUskJQvjn6gkRUvoUN94LK3Rdq
	 2g/Ua5jaG2rdus6lexPD23+DAIYSOt3OXaCefdU0CSYiVBD3CC1dPJhTMMoxX0lXzWF+K
	 MNZqTO8seCb4a7+zkWiljQMch/tZRrHacGUqN1NeApPLDe8ehqAxhPbzMkdaNg96d7Uzn
	 VzGnZgHnirwFfdhT5oNBxJU3mKsW3yBIT5h8q0KW3WL++7wSkdupVaa5tmzL3Ivt6ipOv
	 Cv0CTgAOTAx5TSzDXMzo5Qpt85HiocdA/T7sMP5xavhq9ord2f6Ri/kFaS8Hc/uyxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:X-Mailer:
	 MIME-Version:From:To:Cc:Date:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=lbUKZdEyRLlv3O/aIgaEEkBaoJXsJfgjB065TzawuKc=;
	b=law95WWFoVUFDc44LVIvTMNr18V+0TmjszWtH/b6XaajWVUPe2oNvu15/iT2hVVUdPw0
	 GtW5CuZ9deT0BPzfgAuiAbzWDvzIUHMcNdHNppI65A4P/x2lPhWsBG8HvkSxyT3Dza+tt
	 vIl6lncUiSo1Cw9lHkx8i1ja1TGPrB8QK92SE5hImEfZABhdxQlK7LrtBibO+ROGPqMCP
	 oE03dIFzvqMFP1bfQ6mb+hmi89udpD5N499BENfM5EShPqpUyQsvKuQH7ZGeMM7YI/alV
	 ZGce1CMEIdXJUhLDKQpmQMPXJOCMfNeDs4f530AyHBWhsfj1L3ny2yuFlC2Yw2hIjvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bE85bbU6;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B87606A321
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 11:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B87606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bE85bbU6
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso6289749eec.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395724; x=1795000524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbUKZdEyRLlv3O/aIgaEEkBaoJXsJfgjB065TzawuKc=;
        b=bE85bbU68xj/3eAUAW6ouagIHBXVoLbzfpQHIsteqgWl/ShOQJ73xaJE4beefIH/SB
         uqvgEORq9sFGFcMS6ndj8mC2gvSJZSDwEbkR5BrAvcMGU6H6zIHxXRZ8yzCOSl80tkjh
         krUOU8xkPtckSmqsg+8lGb5XeBS9c8fCxFwpLEFq2q21vWbKCNqJlYdHE3+tBzpIYEWj
         qZQCflxwALCqVqMRYZ+xgEI5g86/L/YP6Z4JJdFl5jbUtGMsM8RLbYpQHUPPwEsK1lqm
         RvAo5MRvQSvK/Y/CZIhkddSzmRYFShm/KObvzO4LeTwV8Ag4oyntxOa0ZPscuK443T9A
         ZTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395724; x=1795000524;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lbUKZdEyRLlv3O/aIgaEEkBaoJXsJfgjB065TzawuKc=;
        b=qxoWoObPNgi+nuOVRmENWPag59JI5IMph8Y1SJM3CPS271Q6UVpl2o8n0J/tKGPai/
         3W1ZySxjxv9eQOS0LFRdEYuDEogH3k7ciUPBuNb7bDHH0oKLUUd4oXURGMXupxBxtMUC
         m/W1tgeF3XloEnmz1tag/xuDz74UkK3eSj2uSrCHVVOsTICLDVq6bm8iCrTp893OdEkq
         Y1+vKhHvbWxwh0ZI88STDP6tiFQQbx/IkqItC2SXQXgXEkoNeG2SIugnj083YhcumxUh
         O4eUBwNaqf1CxYT7OPOMRGkLKxUGz0Z+6aOgvebkJEovqeQvtZFXhChadsgxDTkth5Fw
         9VoQ==
X-Gm-Message-State: APuU4Z9eScrxPKSIztCCiKmNCwGLX/XBSli3TKgR5xhnBzi5haakPVrg
	+iwRHwy+T0V28wp85G8LzsbkvNnfZK2ivdI6XpcVbUsyum8YfAWe0KEbl8fY6JyRDC4=
X-Gm-Gg: AYBFou1HMcHwkPYIUgZr1oyoE5LdArlAKgqkFgJwYY3FmDudPBy8dlquHaMrrbxqUmb
	YAOqi71dtlXtB4RjQC6JunyAsklspBzKpnPFa/Eh/xRF3w4/TcL8RIhZesd8q39s6MVUsLwNqHH
	+LGE5vvBafyAsCui8mc0Rm3tZzF/yEG0QKu20XKij6uQL72iWP9YClJntZpnjr+0zJ+ih6q2jJK
	RdhSs9gDevQK0ntzAJXkHjntwvUsq4TB+Zov7nzyBFQoO7wvXvpcUfGsGUqmQANF6hmR9Kp3OuQ
	777xoiSfMYCzIpo/H+CyEjCsJ+V/OQA0kcw5dKtgA5gwKoOrmBPWNYh24hhZfuLkjkcr6+/igf6
	tmc8rZB71uEascPkyWPgy5qg0908M7OKApy8/VgJ/wm2SPj7T5JBT3mMC/yL6+MfOglkiHHGwA9
	IPpqLy/kU3/hqEI2tru2frSKj8L9nSexaj77YRL+TTTTNqMOABOIP/c9Lzid6pElUlpmeYvY/GD
	6hF4BC6pQfQ4WrrgdTYwtGjeMG+Zy+3mJp9IWB/LNbsMiEJVWkQOpPfWEbVLpmSMtHlYjNQi8C0
	XcMlIfu6Nuky+XxI1eSvi8w9jkQ1HFOsO/yNx8Ow07aXhaSqf+jygs39oGIA1WpNkoy2d3EpAjG
	cUUPyxgxPo0Bw4gw=
X-Received: by 2002:a05:7300:2324:b0:36f:350b:3838 with SMTP id 5a478bee46e88-37686278c55mr3634182eec.31.1794395723659;
        Wed, 11 Nov 2026 03:15:23 -0800 (PST)
Received: from manush ([2406:7400:94:5368:19d0:c01f:d33b:214b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9d78sm16577508eec.25.2026.11.11.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:15:23 -0800 (PST)
Message-ID: <6af44e4b.4b6e150d.9a2df.361b@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: sre@kernel.org, jay-hx@posteo.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: 11 Nov 2026 16:45:21 +0530
Subject: [PATCH] power: supply: rt5033_charger: fix extcon DT parsing and
 deferral handling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In rt5033_charger_probe(), the driver attempts to parse the optio=
nal=0D=0A"richtek,usb-connector" phandle:=0D=0A=0D=0A1. When "ric=
htek,usb-connector" is absent from DT, of_parse_phandle()=0D=0A  =
 returns NULL. Currently, the driver unconditionally passes np_co=
nn=0D=0A   to of_get_parent(NULL), which returns NULL, and then c=
alls=0D=0A   extcon_find_edev_by_node(NULL). In extcon_find_edev_=
by_node(), passing=0D=0A   a NULL node can erroneously match any =
extcon device without a DT node=0D=0A   or return -EPROBE_DEFER, =
which is then masked as a DT warning while=0D=0A   leaving probe =
to succeed with an invalid/unintended configuration.=0D=0A2. If "=
richtek,usb-connector" is present in DT but the extcon provider=0D=0A=
   has not probed yet, extcon_find_edev_by_node() returns -EPROBE=
_DEFER.=0D=0A   The driver treats all errors identically with dev=
_warn() and returns 0,=0D=0A   silently abandoning extcon initial=
ization instead of deferring probe.=0D=0A   Consequently, cable d=
etection and OTG supply functionality remain=0D=0A   permanently =
disabled.=0D=0A=0D=0AFix this by:=0D=0A- Checking if np_conn is N=
ULL and skipping extcon setup cleanly if the=0D=0A  property is o=
mitted from DT.=0D=0A- Checking that np_edev is valid before call=
ing extcon_find_edev_by_node().=0D=0A- Propagating -EPROBE_DEFER =
via dev_err_probe() when the extcon device=0D=0A  is deferred.=0D=0A=
- Using dev_err_probe() for work and notifier registration failur=
es.=0D=0A=0D=0AFixes: 8242336dc8a8 ("power: supply: rt5033_charge=
r: Add cable detection and USB OTG supply")=0D=0ASigned-off-by: M=
anush Prajwal <manushprajwal555@gmail.com>=0D=0A---=0D=0A drivers=
/power/supply/rt5033_charger.c | 30 +++++++++++++++++++++------=0D=0A=
 1 file changed, 24 insertions(+), 6 deletions(-)=0D=0A=0D=0Adiff=
 --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/su=
pply/rt5033_charger.c=0D=0Aindex e545a6e7f..5a149640a 100644=0D=0A=
--- a/drivers/power/supply/rt5033_charger.c=0D=0A+++ b/drivers/po=
wer/supply/rt5033_charger.c=0D=0A@@ -698,29 +698,41 @@ static int=
 rt5033_charger_probe(struct platform_device *pdev)=0D=0A 	 * is =
available, just emit a warning and leave the probe function.=0D=0A=
 	 */=0D=0A 	np_conn =3D of_parse_phandle(pdev->dev.of_node, "ric=
htek,usb-connector", 0);=0D=0A+	if (!np_conn) {=0D=0A+		dev_warn(=
charger->dev, "no extcon device found in device-tree\n");=0D=0A+	=
	goto out;=0D=0A+	}=0D=0A+=0D=0A 	np_edev =3D of_get_parent(np_co=
nn);=0D=0A+	of_node_put(np_conn);=0D=0A+	if (!np_edev) {=0D=0A+		=
dev_warn(charger->dev, "no extcon parent found in device-tree\n")=
;=0D=0A+		goto out;=0D=0A+	}=0D=0A+=0D=0A 	charger->edev =3D extc=
on_find_edev_by_node(np_edev);=0D=0A 	of_node_put(np_edev);=0D=0A=
-	of_node_put(np_conn);=0D=0A 	if (IS_ERR(charger->edev)) {=0D=0A=
+		ret =3D PTR_ERR(charger->edev);=0D=0A+		if (ret =3D=3D -EPROBE=
_DEFER)=0D=0A+			return dev_err_probe(charger->dev, ret,=0D=0A+		=
			     "failed to find extcon device\n");=0D=0A 		dev_warn(charg=
er->dev, "no extcon device found in device-tree\n");=0D=0A 		goto=
 out;=0D=0A 	}=0D=0A=0D=0A 	ret =3D devm_work_autocancel(charger-=
>dev, &charger->extcon_work,=0D=0A 				   rt5033_charger_extcon_w=
ork);=0D=0A-	if (ret) {=0D=0A-		dev_err(charger->dev, "failed to =
initialize extcon work\n");=0D=0A-		return ret;=0D=0A-	}=0D=0A+	i=
f (ret)=0D=0A+		return dev_err_probe(charger->dev, ret,=0D=0A+			=
	     "failed to initialize extcon work\n");=0D=0A=0D=0A 	charger=
->extcon_nb.notifier_call =3D rt5033_charger_extcon_notifier;=0D=0A=
 	ret =3D devm_extcon_register_notifier_all(charger->dev, charger=
->edev,=0D=0A 						&charger->extcon_nb);=0D=0A-	if (ret) {=0D=0A=
-		dev_err(charger->dev, "failed to register extcon notifier\n");=
=0D=0A-		return ret;=0D=0A-	}=0D=0A+	if (ret)=0D=0A+		return dev_=
err_probe(charger->dev, ret,=0D=0A+				     "failed to register e=
xtcon notifier\n");=0D=0A out:=0D=0A 	return 0;=0D=0A }=0D=0A-- =0D=0A=
2.46.2.windows.1

