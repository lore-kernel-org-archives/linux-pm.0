Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58B7445ACE;
	Thu, 15 Oct 2026 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050740; cv=none; b=NzP45ybqg9n9VZ0aOB+krvzTha9iQ7fSwwbJNMi0AGFLUJHR1k/JRhCiazRG6+AacEofF/HyujH78cMH3i4uHFMKtLMj9sR2qCw9I29o5AqR/9ry+5fIcAPsdKEbiwIwd+MKk42L/0ZI3Y/LIZMK7emmSkmVTI8x77TvsEPMdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050740; c=relaxed/simple;
	bh=2QdsesoHAlMy96I5aiAFuYZ4M8Z0sKDlGzOlZi5kva8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B29fNMaV046Lt7COiqeUb67ZEerp/4hFGaNaBfuJK7XbTTQNoyY+srzrIUJyl+xsdu/pNaTPtdc6SWvXFT4fCvqIh1I8Qsx3lLQ7dxGfSTJKoSg52hfH23MFHxiQbqf/yvAtEC+3L8mURsakALZCZ+eN2Yup75/vf14nFfOZb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cf+O7y6h; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cf+O7y6h"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61A6BDAB;
	Thu, 15 Oct 2026 09:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050608;
	bh=2QdsesoHAlMy96I5aiAFuYZ4M8Z0sKDlGzOlZi5kva8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cf+O7y6hOHtiLKokf/n4E1cGRoOffrNvZPykKlTrODKi8le1AVl04SPMg9rmKRzc+
	 Z8W3dTrUlGCuNCLtymFwVARDvo2iYlZn44cK2vijTzRV1YLXtyz+6+l+C3JCEF4slP
	 uRPFrcfrufGbQuu5Bhb8L9uByfJR2ummwI974mHc=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:43 +0900
Subject: [PATCH DNI v3 03/15] pmdomain: renesas: r8a78000: Add maps for VIO
 for SCP FW SDKv4.36
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-3-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add maps for VIO for the VSP and FCP power domains and reset domains.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

---
Changes in v2:
- add VSPD and FCPVD
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 54 ++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index a0d83f27735e7deacb060e4102e510726b34e62e..cabe6435ecd791e358fd6987ce9394898d8c87f8 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -861,6 +861,56 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_28_0[] = {
 	{ /* sentinel */ }
 };
 
+static const struct power_map_in r8a78000_mdlc_vio_power_fw_4_31_0[] = {
+	{ 0, 4 },	/* PD_VIO0 */
+	{ 1, 5 },	/* PD_VIO1 */
+	{ 2, 6 },	/* PD_VIO2 */
+	{ 3, 7 },	/* PD_VIO3 */
+	{ 7, 11 },	/* PD_VIO4 */
+	{ -1 }
+};
+static const struct mod_map_in r8a78000_mdlc_vio_mod_fw_4_31_0[] = {
+	{ 0x70, 26 },	/* VSPD0 */
+	{ 0x71, 27 },	/* VSPD1 */
+	{ 0x72, 28 },	/* VSPD2 */
+	{ 0x73, 29 },	/* VSPD3 */
+	{ 0x74, 30 },	/* VSPD4 */
+	{ 0x75, 31 },	/* VSPDB0 */
+	{ 0x76, 32 },	/* VSPDB1 */
+	{ 0x77, 33 },	/* VSPDB2 */
+	{ 0x78, 34 },	/* VSPDB3 */
+	{ 0x79, 35 },	/* VSPDB4 */
+	{ 0x7e, 40 },	/* FCPVD0 */
+	{ 0x7f, 41 },	/* FCPVD1 */
+	{ 0x80, 42 },	/* FCPVD2 */
+	{ 0x81, 43 },	/* FCPVD3 */
+	{ 0x82, 44 },	/* FCPVD4 */
+	{ 0x83, 45 },	/* FCPVD5 */
+	{ 0x84, 46 },	/* FCPVD6 */
+	{ 0x85, 47 },	/* FCPVD7 */
+	{ 0x86, 48 },	/* FCPVD8 */
+	{ 0x87, 49 },	/* FCPVD9 */
+	{ 0xf9, 163 },	/* VSPB0 */
+	{ 0xfa, 164 },	/* VSPB1 */
+	{ 0xfb, 165 },	/* VSPB2 */
+	{ 0xfc, 166 },	/* VSPB3 */
+	{ 0xfd, 167 },	/* VSPB4 */
+	{ 0xfe, 168 },	/* VSPI0 */
+	{ 0xff, 169 },	/* VSPI1 */
+	{ 0x100, 170 },	/* VSPI2 */
+	{ 0x101, 171 },	/* VSPI3 */
+	{ 0x102, 172 },	/* FCPVB0 */
+	{ 0x103, 173 },	/* FCPVB1 */
+	{ 0x104, 174 },	/* FCPVB2 */
+	{ 0x105, 175 },	/* FCPVB3 */
+	{ 0x106, 176 },	/* FCPVB4 */
+	{ 0x107, 177 },	/* FCPVI0 */
+	{ 0x108, 178 },	/* FCPVI1 */
+	{ 0x109, 179 },	/* FCPVI2 */
+	{ 0x10a, 180 },	/* FCPVI3 */
+	{ -1 }
+};
+
 static const struct mod_map_in r8a78000_mdlc_pere_mod_fw_4_31_0[] = {
 	{ 0x30, 193 },	/* PERE_GPIODM0 */
 	// No CLOCK_ATTRIBUTES { 0x31, 194 },	/* PERE_GPIODM1 */
@@ -997,8 +1047,8 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_31_0[] = {
 		/* FIXME .mod_map = r8a78000_mdlc_vips_mod_fw_4_31_0, */
 	}, {
 		.base = 0xc5000000 /* mdlc_vio */,
-		/* FIXME .power_map = r8a78000_mdlc_vio_power_fw_4_28_0, */
-		/* FIXME .mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0, */
+		.power_map = r8a78000_mdlc_vio_power_fw_4_31_0,
+		.mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0,
 	}, {
 		.base = 0xc08f0000 /* mdlc_pere */,
 		.power_map = r8a78000_mdlc_pere_power_fw_4_28_0,

-- 
2.47.3

