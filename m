Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795375207;
	b=hbaemG3XPH4vhi0S+48PcjGcgyP7pVb8mgaPi660o+d1ROUQ18+oBgAabZXba1thSGA+
	 h/NAjLkJcC0hbNDeVq9Uz5xrsppX+BqqqFRG1jEgtrqmUd78gySzYzIfz2D3SGzY3jt2R
	 DqhmgzRUaWjoGrEYTqBrWN8j+rUoapT50R92zzI+f1Xuvrr2L4FrZ6EtVR/RuDbbqoIur
	 SqazzfqiZ0cYU8hbPaCYXe12U43WeMcnVORHVpjpfmzJNBoRo7FpKyU2XD2vseIdqap/j
	 f/iejkVFnIqAhqHmFvhgMz+0tpMXmQMse+FXqPNxosIfFa4sH/IB9qfRXYVPuL/Gl9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375207;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2TafYp3QH2t2vVMZyE9e/qn6OjzCUeGCeg2thvKX9Ks=;
	b=l+9g4QOCxJ8Sp8W5+0ellbajq8v3cLZ0TWzsmULmD020mluvR9SwxyeY5HfwOXNEfOFF
	 x6dik2m4ah1aenbGBBKzDvAwtBcUvkE8SBz7K5Lb2BOJv7f0QRtY63N+oZJPjPbJFRef8
	 xeQEjLVGrtzizAxXUV+KNiNkp/bmE+pV+FvwU/Rd9AM2/YFvMxBTdyIO3x28FyN1+OZMk
	 HrwPxzH+0w5krsCbIjyflQnH2oFOtdZw+5o2vs1KxmK/hI8TFmzRjiy8SFLMOL3hTRFUr
	 qCLBXz4kIYQogrflZPPgV7RKYUuDB4K1OMxfJrHPV6xGPQEC8ymxkLMJk2fG8Ik2C6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehoLgTmA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52C606A31A;
	Sun, 22 Nov 2026 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehoLgTmA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795375207;
	b=VnqvGzeVB4/puNLBK1WC3oZOFm0fnQXs02PW3it2cYdWqquDbk5TA3b4aHigYXEsDRyS
	 T3Cs1asfivldky135RB0sVO1huUyhdNzwFD8LgzsZAn7Y3SO/otb4QjJBeLQnWyW91XFl
	 qtkoLDQrLa/AGxWCHNGrRFbJuGTAiD0ZIQP8eGa8+ujwafMeguUFzbsMBOKm5jgVSJg9N
	 oEaX5O2ofNudJvEl+lHXum+F22/daA1JGR1fFq/T8VUbd238+xnFOEyRgBDyM29KoQzva
	 58lX8S/XO0SH31Lr9No9oekVCuWpGHZFrsOuBHwofHOCvnhzkHHjrCLXOFR3aPqUOaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795375207;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2TafYp3QH2t2vVMZyE9e/qn6OjzCUeGCeg2thvKX9Ks=;
	b=i4hTzh8icnSKg2rx9CcnH8CAlC1BuFMluGxx+oErvnJ4Ismqzb9vYHy7phImYljTPcS9
	 27cxuz5kJ0LZPdJpES8SErSDzoay0nspoHR+na7+X4j3FUDR20K/Z+AgypIk4wM/qvehw
	 IGE9ORfQM5Tm/ZyC73nQ8kSz+OATkff0ejSjyVQPEX6AaQBtezb7oijr8rC4KtDNvUrzs
	 u8cKKkr0GQySiDkt+LyhuAkeMfjmWD7g7cPSd1LPmFmQvioTOL9oBmeSuF++cMgJNbKOq
	 p1yZesh3W8CPk0TeG2Cfs+h+Q8cPtafnRg43cnoj8tEyWmPkkavpRP6STEaRQNsv85w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D856C1F000D0;
	Sun, 22 Nov 2026 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375207;
	bh=2TafYp3QH2t2vVMZyE9e/qn6OjzCUeGCeg2thvKX9Ks=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ehoLgTmAAgLAZgjYQu0+T1+9/WOzbEMUgztXPYAYMGez+FNg1nbie19ZW52vzWCMG
	 gqDKMvpnX9xT6NSuBohcTUfYA3tlTUvPjJZpijMgCz8SGfUctj78HwSoEdpd1nzrfe
	 J1tQcyGymlhK0HSK7/1+dxRsHJfUhrBfpim99OCJTPPAM3lU6ip0cErT54gVscCHas
	 QDL1n3tWB5C5URHP/l+/8G8qrOsRaeKZab29SBo1jxjJhXhsp8RxhIQizH2VOxsPWM
	 Zuo95PQZqJ5qVoIBwLZIkLF5oEJg83R5l1ClnoOIyZg/IOroBBO7I52DuCgmBaV+7J
	 RnJINQNaRmbmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3C80B4C1C1;
	Sun, 22 Nov 2026 19:20:03 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 23 Nov 2026 00:50:03 +0530
Subject: [PATCH v2] interconnect: qcom: Don't read back BCMs without an
 RPMh address
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
Message-Id: <20261123-icc-bcm-readback-v2-1-b470ed2bb7f4@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RhKYyOuvIdhMR0GGQ3UtEgkh
 LsLuHf5kvffnyFJVElwyWaIMmrS0K9QHDLglvq7oNYrQ5EXzhjjUJnRc4dRqPbETyRry+bMJD4
 vYZ29ojT62ZO36sfp7R/Cw9bZjFbTEOK0f45m8/7kR4MGrfMna2vnyJXXidoQjhw6qJZl+QLht
 Z8swgAAAA==
X-Change-ID: 20261116-icc-bcm-readback-a339f8caeb09
To: Georgi Djakov <djakov@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795375202; l=2810;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=+1XaK5OK8j/KqvYoTiFyF9kYItUTNV/Y3VVPDk052A4=;
 b=n0m9CWqAcfG/LxNDiu+/+IqZPLT28lKYhcwsmXO2JDyFy5obl3FLAoT5Fjg+ildCVVHuEDDOh
 LcofgTwovyJARTpLU6boX2FS9vmvuCApH4CYdazVSaIe0w651N9iJnu
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

qcom_icc_rpmh_probe() ignores the return value of qcom_icc_bcm_init()
and reads the initial vote of every BCM back with rpmh_read(). When the
command DB has no entry for a BCM, qcom_icc_bcm_init() fails before
setting the address, so the read goes to RPMh address 0. On Molokai
(SM8845), whose command DB lacks the QPC0 BCM of the Kaanapali gem_noc,
that read never completes and every later RPMh request times out, so the
regulators fail to probe and the boot stalls:

  qnoc-kaanapali 31100000.interconnect: QPC0 could not find RPMh address
  qcom-rpmh-regulator 18900000.rsc:regulators-2: failed to read ENABLE status ret = -110
  Error sending AMC RPMH requests (-110)

Skip the read back for a BCM that failed to initialize, like before the
read back was added, when such a BCM was simply never voted.

Fixes: 11a44c6087c6 ("interconnect: qcom: implement get_bw with rpmh_read")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
Found while bringing up the Motorola Signature (Qualcomm Molokai, SM8845)
on next-20261113: the boot stalled in the regulator probe and every RPMh
request timed out after the first one. The Molokai command DB has no QPC0
entry, so qcom_icc_bcm_init() fails for it, and the read back added in
commit 11a44c6087c6 then reads RPMh address 0, which never completes.

Tested on the Motorola Signature: no RPMh timeouts, the regulators and
the interconnect providers probe, and the rest of the boot is unchanged.

I used an LLM (Claude) to help write this patch and its commit message.
I reviewed it and tested the result on the device.
---
Changes in v2:
- Drop the Assisted-by trailers and the LLM notes from the commit
  messages, the LLM use is stated in this cover letter.
- Pick up the Reviewed-by of Neil.
- Link to v1: https://patch.msgid.link/20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com
---
 drivers/interconnect/qcom/icc-rpmh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 4a2a746a4e59..1fbf4c960e1e 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -332,7 +332,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		return PTR_ERR(qp->voter);
 
 	for (i = 0; i < qp->num_bcms; i++) {
-		qcom_icc_bcm_init(qp->bcms[i], dev);
+		/* Don't read back a BCM without an RPMh address */
+		if (qcom_icc_bcm_init(qp->bcms[i], dev))
+			continue;
 		qcom_icc_bcm_get_bw(qp->voter, qp->bcms[i]);
 	}
 

---
base-commit: 3fd56a2833c22f62eb84297d0dbd47739632f1a0
change-id: 20261116-icc-bcm-readback-a339f8caeb09

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


