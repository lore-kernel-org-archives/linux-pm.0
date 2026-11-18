Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999147;
	b=zGiUmCfLalJBBJD86gDBo3SlRJAbhO2HBJnN5eIUxNUeFc78V6CQTjUiVsPeOZ3O5pAi
	 HW5bFVEQ84qiKlwchxF8PaDkuTYm+l7XQhbohTSryPXoTdh80abBt/pxU7iwLabzNCicl
	 OlPnMO9V1lTa1NPcF5uIzYgzCRSJGxk5S/7JKz9Mt4ojzAB4RcayicdR6Knz8dret0w27
	 1SX592JKt5wxMymo4NT+/qNHYYDmLCQCHiF3GZRqxn09DpnVygU9j+b2SUXjgcUDS6Tm2
	 De3fhOWy2pHEVCTpVy/yTlq8iqs37gSKVUcloz1AvckLVtxDGALX0ncn7PMY+JdpSmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999147;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E3osvfmeF/jQrh3Wedc0Un28ejx+8cAJcxtwjUsQUnc=;
	b=bZS9RZ4b6iUcMO6nlDQ7frDrX9L8vdR2mHJOpg622CPECOSZWgDtkWsOOd74aMRSwIPb
	 RG+H/C0SN5VP4INz5iPBtc2+Qic2w48N6NsCI+wEDtQGdg0t+Z+7S1akb9SEQZERQKRgt
	 gB16bV6c1X5X9Iz0QdHtKlviLGKad1RiOxf+UIbaucC5wCdZ8qQsMXydqTcugDD1cvcdj
	 gUX9TEpzs9tLD4jduAleE1BhsHpsqkm/o8T43xT5Ph35J5MWyYhQXMj2ELvvNcV09gJRz
	 q4gQ9uk4mIO3BD69nn0K3NHlRDKqaVTNZdwEOYOgHpDf5t8TGPoGsICLZ2v+198uhPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KGNY2nH/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E6606A33A;
	Wed, 18 Nov 2026 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGNY2nH/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999147;
	b=KyeEJLZug1bVLrzp9ukOsnDz4NJ3WBQmD9LaDUdlvfUcxErdnInchGVpeDSKK+sm5TtN
	 iq1gUzXazwGLBazJxDGZhjcolnYlqHjAfc3GEqIk3beFCSJr/xMPFEBYulxNXcuEGWG+E
	 5IPiTCUeY16sCII/K/12BKmSkYTVS9Xn+3GoNcmcWkOMrB+7C9JR9X8V4uRhbwwcX+U0v
	 lyzfkfd0lzqvLeSAwPPwmRK5NefQbfr48xipra/g3MRl9Wj9EYW4z/cOrCPYjyY6N2tcT
	 f0P5W5mdB/iD0dbiPluUERtjWlBL/pJf7tdXqy1r/uyx06jDre5KWvM8oJ5xEpXPgjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999147;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=E3osvfmeF/jQrh3Wedc0Un28ejx+8cAJcxtwjUsQUnc=;
	b=Sipv9VaGTkINXx0fAzF/iyO9Dh2wtOybLo7pJ7PLqmoCEBBGwjM9krvaUMChoBIngtqw
	 6tdelS/C0l2+fycgMHvCdGKxcB8/HiMz7hvWgrgqAreM9U8r3svqiCWlnA0fxHEY61eL3
	 5DY/RUhlLyG7+IOnhzDsYEyY0pAh5xhgFPTQ6rvrTA2LRQI0BGy2561dKeB2uSZS0T8YF
	 iXZfZC9+zvjpyK1TszaR7UphvKVpwmG0xDkSndb5ANcJ8xKCGv+3qv2jSGc6I6qo6QS6B
	 J0E6yarlUd/J3TMP7g6OWl+Ca4ppoJfWvcwyLv25OKJtKa8B7+c4tBDsgBHlW+VE+Tw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBFF61F000C6;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999147;
	bh=E3osvfmeF/jQrh3Wedc0Un28ejx+8cAJcxtwjUsQUnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KGNY2nH/wdEXd9FAhwn/Cf88a0tEcwXRE9VSnO2cqeHhgAUZ6Zy1k2JFi+ZR66mbk
	 wK85vOHBY2K8czhTBOq9qNgiVXyOk51B28jX2dbka4YTo9ZvqhUFRNZJp3/ih4geoH
	 VIA1wnzmrX2JyZfccwJ6wLgaDWOpF7rFARri3IpyBvFSruqAD20MjxkCmwzRLv1Pti
	 4J5iJNEMl5YYajHx3oHrIrMaZ4xjiENV8wmuFHQsIEifKOMq+RdrGrCdZ0a1JWtCGR
	 xf3CzRIauydj6wJuENzos1GKB8r3j+gYFodoxPZqaguN4R6jE+QUQAbLMGOKgeq0+q
	 UZ3fkCCqYaecQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 78CCE4AD14;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 04:52:25 -0600
Subject: [PATCH v2 2/6] cpufreq: sun50i: Move nvmem cell reading into a
 helper
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
Message-Id: <20261118-a133-series-v2-2-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
In-Reply-To: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alexander Sverdlin <alex@sverdlin.org>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <paulk@sys-base.io>, kernel test robot <lkp@intel.com>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999144; l=3315;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=vQMAtGZJDRtx69UU5Evyhp22Ohka9g8vqRSa6Av0uww=;
 b=/iR630XagWCGKfxs4w50SDK7/FVOhyuA5FzDZPxddcU6aWe/8piODyfVMs7rA3b/D4urOCi82
 64oUMcsnWoBAn6Jv6brrnV5NomY/KceOQyiYDxirESf4l6e+iIJd57/
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

The A133 speed grade needs several efuse cells, but the cell reading
is open coded in sun50i_cpufreq_get_efuse() for a single cell. Move it
into sun50i_cpufreq_read_cell(), which takes the cell name, so the next
patch can read the A133 cells by name.

No functional change: the existing users read the first cell, as
before, with the same length check, byte order and error message. The
raw bytes are now held in a __le32, the type le32_to_cpu() expects,
which also removes the sparse warning "cast to restricted __le32" that
the kernel test robot reported.

Claude Code (Anthropic) drafted this refactor and its message; I
reviewed and tested it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603021703.aBD0w99y-lkp@intel.com/
Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 55 ++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 9261d148a16..34c0897c22c 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -31,6 +31,34 @@ struct sunxi_cpufreq_data {
 	u32 (*efuse_xlate)(u32 speedbin);
 };
 
+static int sun50i_cpufreq_read_cell(struct device *cpu_dev,
+				    struct device_node *np, const char *id,
+				    u32 *value)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+	__le32 tmp = 0;
+
+	cell = of_nvmem_cell_get(np, id);
+	if (IS_ERR(cell))
+		return dev_err_probe(cpu_dev, PTR_ERR(cell),
+				     "Could not get nvmem cell\n");
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	if (len <= 4)
+		memcpy(&tmp, buf, len);
+	*value = le32_to_cpu(tmp);
+
+	kfree(buf);
+
+	return 0;
+}
+
 static u32 sun50i_h6_efuse_xlate(u32 speedbin)
 {
 	u32 efuse_value;
@@ -191,12 +219,9 @@ static bool dt_has_supported_hw(void)
 static int sun50i_cpufreq_get_efuse(void)
 {
 	const struct sunxi_cpufreq_data *opp_data;
-	struct nvmem_cell *speedbin_nvmem;
 	const struct of_device_id *match;
 	struct device *cpu_dev;
-	void *speedbin_ptr;
-	u32 speedbin = 0;
-	size_t len;
+	u32 speedbin;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -214,25 +239,11 @@ static int sun50i_cpufreq_get_efuse(void)
 
 	opp_data = match->data;
 
-	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-	if (IS_ERR(speedbin_nvmem))
-		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
-				     "Could not get nvmem cell\n");
-
-	speedbin_ptr = nvmem_cell_read(speedbin_nvmem, &len);
-	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin_ptr))
-		return PTR_ERR(speedbin_ptr);
-
-	if (len <= 4)
-		memcpy(&speedbin, speedbin_ptr, len);
-	speedbin = le32_to_cpu(speedbin);
-
-	ret = opp_data->efuse_xlate(speedbin);
-
-	kfree(speedbin_ptr);
+	ret = sun50i_cpufreq_read_cell(cpu_dev, np, NULL, &speedbin);
+	if (ret)
+		return ret;
 
-	return ret;
+	return opp_data->efuse_xlate(speedbin);
 };
 
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)

-- 
2.34.1


