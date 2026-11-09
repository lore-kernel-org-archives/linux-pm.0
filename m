Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231298;
	b=E1D7pn0/HiBQhhSAFtc687GR4r37fVWClEXkP9gGi134uVFjllNRbvCCg6XlIptJVNnQ
	 GY2t/bdNq1uBlutEbYKQ4vI+ZXhkh83vLAQhU6lJfsIJTIY0jZ41fIqmxgKo/vlA3m4Rr
	 nA0A+zvrJ1rVAQ1/S4syJ2VdPfrGuakgyd6TZmC2igi1HF7cV35n1BC36+d13b4Z/1IP+
	 I9T2a7aLFHIDMt0EEkCnfoRRQxscbl6cHE4eRqXUntC3upZqNHA0B5jFnDl7ZK7o0sQkz
	 zUg71hWNTl9n5FiZJPNCmrTomw3jmWT3/zBvBlDu8PGCbDcjbLHZ2iDsBlZ2PYn2s5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231298;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=N41VeEczq+k91sixjK0ew/bCkvhEnxkVOkdqKilv/a8=;
	b=MxaGKIZmFtmZ5r1Jg34iYfs9SV0kCNFHL8tXVo3OASMbsEdIKMl9CAyaKTlRr6nR3G2C
	 V+MJiCJA8/0dImzHMfODfpQ+i9WMN0gIivU747JFROhvEhY1Y4IJchK07Ve+VMIEOJ6T+
	 ifmnC4SsPI4033db3APXfr6Ncdj977YW65qfMNmRtWpGPUCbCF/FqJuMpfBSNPssDIyDB
	 e2JJkhMnoMXrVf9SpQHIVlWfZ9CiQkHmeXPb7WH92p4kg6esrvbI65Unun1uOajys29FE
	 c2PSLpSRYCzrhFLKV5FEZmLjA1cpwGOT2TRU/9EEDi1tgiy9C1ef2BjwWffOaUQU7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iane5xqY;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAA606A332;
	Mon,  9 Nov 2026 13:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AAA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=iane5xqY
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B2E66DDE;
	Mon,  9 Nov 2026 14:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231154;
	bh=YH57mBQ4iFnOtigQAwHV0/PJKXGYO94Q91SH4+ynjtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iane5xqYwryIvN3LPTwHt50JZEfJaAJ6DsHvQd3DpKMFr+R+C6fGz1LQwPYo00LXg
	 y0/SnGlzft9vAcLADxMFEHDQtOuGSekGiufFURv6Iez6mebvvohgOSFomHukdD9ybP
	 cmdioRi2D/dgV3CSh8NRXKnRpPHy8X6n0GapjEKA=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:23 +0900
Subject: [PATCH v4 02/13] pmdomain: renesas: r8a78000: Add SCMI maps for
 VIO
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-2-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add SCMI maps for the VIO domain to map the VSP and FCPV power domains
and module controls.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v2:
- add VSPD and FCPVD
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 02699952f5c2d83f6f750025c37f951af3bab471..37869a666d458b801bc5e19daabab4d34d3b66f0 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -696,6 +696,57 @@ static const struct mod_map_in r8a78000_mdlc_scp_mod_fw[] = {
 	{ -1 }
 };
 
+static const struct power_map_in r8a78000_mdlc_vio_power_fw[] = {
+	{ 0, 4 },		/* PD_VIO0 */
+	{ 1, 5 },		/* PD_VIO1 */
+	{ 2, 6 },		/* PD_VIO2 */
+	{ 3, 7 },		/* PD_VIO3 */
+	{ 7, 11 },		/* PD_VIO4 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_vio_mod_fw[] = {
+	{ 0x70, 26, -1 },	/* VSPD0 */
+	{ 0x71, 27, -1 },	/* VSPD1 */
+	{ 0x72, 28, -1 },	/* VSPD2 */
+	{ 0x73, 29, -1 },	/* VSPD3 */
+	{ 0x74, 30, -1 },	/* VSPD4 */
+	{ 0x75, 31, -1 },	/* VSPDB0 */
+	{ 0x76, 32, -1 },	/* VSPDB1 */
+	{ 0x77, 33, -1 },	/* VSPDB2 */
+	{ 0x78, 34, -1 },	/* VSPDB3 */
+	{ 0x79, 35, -1 },	/* VSPDB4 */
+	{ 0x7e, 40, -1 },	/* FCPVD0 */
+	{ 0x7f, 41, -1 },	/* FCPVD1 */
+	{ 0x80, 42, -1 },	/* FCPVD2 */
+	{ 0x81, 43, -1 },	/* FCPVD3 */
+	{ 0x82, 44, -1 },	/* FCPVD4 */
+	{ 0x83, 45, -1 },	/* FCPVD5 */
+	{ 0x84, 46, -1 },	/* FCPVD6 */
+	{ 0x85, 47, -1 },	/* FCPVD7 */
+	{ 0x86, 48, -1 },	/* FCPVD8 */
+	{ 0x87, 49, -1 },	/* FCPVD9 */
+	{ 0xf9, 163, -1 },	/* VSPB0 */
+	{ 0xfa, 164, -1 },	/* VSPB1 */
+	{ 0xfb, 165, -1 },	/* VSPB2 */
+	{ 0xfc, 166, -1 },	/* VSPB3 */
+	{ 0xfd, 167, -1 },	/* VSPB4 */
+	{ 0xfe, 168, -1 },	/* VSPI0 */
+	{ 0xff, 169, -1 },	/* VSPI1 */
+	{ 0x100, 170, -1 },	/* VSPI2 */
+	{ 0x101, 171, -1 },	/* VSPI3 */
+	{ 0x102, 172, -1 },	/* FCPVB0 */
+	{ 0x103, 173, -1 },	/* FCPVB1 */
+	{ 0x104, 174, -1 },	/* FCPVB2 */
+	{ 0x105, 175, -1 },	/* FCPVB3 */
+	{ 0x106, 176, -1 },	/* FCPVB4 */
+	{ 0x107, 177, -1 },	/* FCPVI0 */
+	{ 0x108, 178, -1 },	/* FCPVI1 */
+	{ 0x109, 179, -1 },	/* FCPVI2 */
+	{ 0x10a, 180, -1 },	/* FCPVI3 */
+	{ -1 }
+};
+
 static const struct mdlc_info r8a78000_mdlc_fw[] = {
 	{
 		.base = 0xc1338000 /* mdlc_aon */,
@@ -712,6 +763,10 @@ static const struct mdlc_info r8a78000_mdlc_fw[] = {
 	}, {
 		.base = 0xc1330000 /* mdlc_scp */,
 		.mod_map = r8a78000_mdlc_scp_mod_fw,
+	}, {
+		.base = 0xc5000000 /* mdlc_vio */,
+		.power_map = r8a78000_mdlc_vio_power_fw,
+		.mod_map = r8a78000_mdlc_vio_mod_fw,
 	},
 	{ /* sentinel */ }
 };

-- 
2.47.3

