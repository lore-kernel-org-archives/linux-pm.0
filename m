Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AA51AECE;
	Fri, 18 Sep 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751258; cv=none; b=KjfdDqN5BxSsJVwYXA5DoGCDMQJcBKbpPJeFGvnEHwuoeo82v2uDnRr/MRh6o8et+9Tjthy3iRyK4lRseH/4OC7AlT3QzuN8GbiyJtVmaCw6ge3KHSUpkvdA9fNYXxUfS91deS9WzIhTSFLZEXkkvMrgy2CthF2U4NhQyDI6Tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751258; c=relaxed/simple;
	bh=2QdsesoHAlMy96I5aiAFuYZ4M8Z0sKDlGzOlZi5kva8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0bBnBgLb2Mb1X7vOUDSdu88txtv0Q/hUiUPf1WRzVVQRs3zR8DtecVCh8HjT0cp5Ja08V0Nj+Yy2VqkDYnLU4ITeNEaH9/Tgn92TbLeHrU+JJUALs7V0F8HE6rXJVcAUlutsw9LXWGHzTr26mS0wyEcVwbWFrXnOoYY2MAnuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pQ/9JShr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pQ/9JShr"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3B9F4FC4;
	Fri, 18 Sep 2026 19:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751151;
	bh=2QdsesoHAlMy96I5aiAFuYZ4M8Z0sKDlGzOlZi5kva8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pQ/9JShrjGBx/i4L0OLQ7oLCKasOVPvR1anTDZoiLbRN6hUj/iDtEnSCp+kUfa2S8
	 bSUWnDM+W3YSYFqkuMvquY6fM/ylBLEfdrxkdbt4+8mrT44dMpXbIV8xnvf05lGz6s
	 tR1LLkEPwq6ZcBv05dOmkPopGcVi1ye6ELwlA3fo=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:00 +0900
Subject: [PATCH v2 03/11] pmdomain: renesas: r8a78000: Add maps for VIO for
 SCP FW SDKv4.36
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-3-dbe9236bfd22@ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
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

