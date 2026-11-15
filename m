Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794773949;
	b=L/slSwm0ASpy9gAjdpBS14t9cj5n7d6UGOO9QiYiMGnzHlOyFkZ2AAtgN2zuf+iNhEKN
	 FyRm27rkdgLzL87AgFHrri3m6isVz8KeU1EK+RoE7/ZEfYTGYluzgpMRljxJJ+eIRbFRQ
	 C8GKkY3z7IzKBuecrEXHhQ9Hjr6pYqbmi0bgw0omfFlxUXkv8Tx9A2mVd0WS7D4MJHqVJ
	 59exZKR3D9tZmoW0345LRjGwpqRVOI+Y0PYQNIJxnxayoBWPNpy2dQm4KO1NLZrQWu5BP
	 F1fM83rX/WTKEDzfapDR8ttFEev3VrmhisSEaXubHptU7gGErICTRlkFK+nwSAUF5Qg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773949;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HU8PHT+KWiAuKaUIww1F97vp7QjMjvhw/XJ/x3hxNAk=;
	b=nYz7+GA6kQOY1m8a1qVp8WZL+nKtsREBYzuVTVg6XQBvKY4TYuriqxRJ/1Ia4lbBg64j
	 K3F/gpy34/duE1VQF8X5CyVyyyebTDUAMr27j4VeS+9a136pypUp4J/IUyWgJmjlZieXO
	 LeKucNkV3BYD/O3DIkKLc3sHTo7YddO5HOTW0hs3319VFlMxFTzEwb/F1iq9sD/UDuUNS
	 GkEuhVoJDJUgd2ZuGKzVfzoNYqiEodw/D+tS1MOtPbxR9gmk52MIrdzXnlbBx/IJRvVVj
	 /F27AXJeyCaAd0ol2zSD7BaNAugjxnI6zXkY6ewZ6Xsf7ZF++K/Ner9KCs7WNBPpdYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shy8U1IK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA1606A31F;
	Sun, 15 Nov 2026 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Shy8U1IK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794773948;
	b=D+zoLc/Xp7nRFp1JDAa8JdPz8LE/uRhnK321QAlmr8JSsLIyE9nIgevakQ+SnZEfKfR1
	 VMnJbksaEcUXJp4AYWwG3lcqsTTDr6qTf9DdQ3ZQ/7Az8Aa692w90MspT4od8afzQERZd
	 zTsQ+HP07PF0ELMJpks0F53OOjRBJPaHnovJkU2Wd/pk1VKDBRh8OwlV4OSZ2zjtSU9n1
	 jV5iSY9+WBNVY5aRPoIEUAEwrzE8J2sxkpOhg7sqwvE6MCmV1Kz/ffyMDb0a3T4AYMd4T
	 tmjXv9LdsGxFD4WxkWuDCuymtg8tUt5qoHfSiNMgWaXn+cxx8FHmz7574wdpw3HgSkQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794773948;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HU8PHT+KWiAuKaUIww1F97vp7QjMjvhw/XJ/x3hxNAk=;
	b=1uaZocYtDg+eL6oUt54AU19kZiswZcJPTr4JP//NIn2kcVxnT5UZZAhwj1aia2xiPG70
	 2rRdq3re+lKnSZNBuNWLmxpQEDQCYP2PheUcqLnAx/BCTxFBJuJIesFkZoSAuVg8gj+WG
	 s0vYpJnjUVrliiM7O9AXklL29dT5Obuyn3j/qnnDOAaNy3KNLls6x1kjpO5F8sfbmclq9
	 /YkeAQRR9y4xRpB+xnDwHktT15gG1FCN5ZqhOjXOGG75w9uvPGwE/TOXfK5kQqVOLFMNy
	 oilLJ5+HODvcwXwMBJGQGHyC4dhm+vt5O77SUAJ39LhuA47KRXpc4a+B533JldM2EHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 15F311F000C4;
	Sun, 15 Nov 2026 20:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794773948;
	bh=HU8PHT+KWiAuKaUIww1F97vp7QjMjvhw/XJ/x3hxNAk=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Shy8U1IKyVrgulCeEfKhtb3f7pjoLsuYgCB7JADiafGhL5yBKGcKFD8+xUBx3037K
	 F/UX9+N8eIoO/aTFz2ENACFWIpRAT2gmasl60kuMLQbbkayLmXrvby6GW6NRVLHKSX
	 c64JK7EMBiGiEKwuJiXiw3I63mSQibBQhOCHReYgMnha8hpPI/ywsv1OTKEGmUXpE4
	 Rkre4lW4TjBFq8APXMrAyWbTSFGPPIKzDeV7m1NfYiWlnnXhcgYDcaplsxiRck2AyO
	 QM+EhAHpKzhUelUg2RfAwgXuw24X72Ap+nxcP48vCvDZGGv+FjrsUFkpv0xcrBXknV
	 HS9EqUeqzaI3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6A3FF4A17F;
	Sun, 15 Nov 2026 20:19:07 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:49:07 +0530
Subject: [PATCH] interconnect: qcom: Don't read back BCMs without an RPMh
 address
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
Message-Id: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqEMAxA4atI1gasgky9irhIY3Qygz+0MyJI7
 27V5bd474AgXiVAkx3gZdOgy5xg8gz4TfMoqH0ylEVZG2NqVGZ0PKEX6h3xF6mq7PBiEldYSNn
 qZdD9Xrbd4/B3H+Hf9YEYT99r6FR0AAAA
X-Change-ID: 20261116-icc-bcm-readback-a339f8caeb09
To: Georgi Djakov <djakov@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794773946; l=2496;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=C3HdaNqcX4ObzTQ9prlCAnRjAzf7IUOLq2nd2OSs7GY=;
 b=Qiueej8877pUz/J1S9Rgz3OvEXsJuv5wma0AJPNZTorbginMlTr2yBXREAZUyfp56P9CLW6od
 aDMl2imzY5VCDcLJp+YsiJDyBggNMS/e6e6BwW1qoUV8eQ8R29iwDNd
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
Assisted-by: LLM
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


