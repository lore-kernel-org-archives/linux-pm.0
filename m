Received: from outbound.ci.icloud.com (ci-2003b-snip4-7.eps.apple.com [57.103.91.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2031AABC
	for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.91.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520964; cv=none; b=STpfeTgI1wo7cUl4DDDqsfC7YzjtcLdFXTfRUV2FBgBGcRkQxfuxMv+8nkiEIoRR4ohmDhOMzm77HXpnpFQGYCBqaZJgTzsAVLuauMinqFwB2MtZ8EXj2knjGiBfSfZMUGP9qD3tpgrvry2x8qHvAXoIRiCvIMU3mNT9dG5FOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520964; c=relaxed/simple;
	bh=UUoWXCxDvO6r2JlFkyfmeUmr7VyR9UD0H568ShKZ+00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrFbbtMByA/cyRwCdvsiwoanXJly+/f8eGboJJUCQGl8ye1usoaRJ7CGBHOsevYNzsK1jK1RtWmNNXXk8boPlcLBysGEG1tnj5gckSN7XEvaQnlwJPCWR0Lw/PkWi3UL3N+lu/B2m/NFoXL0sdOwfhUB64YEGmo0xbpV/kzPYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ANv1yiAP; arc=none smtp.client-ip=57.103.91.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ANv1yiAP"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPS id 9E5051801066;
	Sun, 27 Sep 2026 14:55:58 +0000 (UTC)
X-ICL-RepId: 01a0e35d-9e64-7ed5-8134-ce24affd0e72
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMGXAVeC1YBXwFLVxQEDloDVA5cBBcbXwJCH1sVSzhaDlsERxQXG1wAFw1WTVAbXwJCDxwTVhUTH1RWA0gZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1QG18CQg8cE1YVEwBeDw9MC0gBWwdSAEcITAZYBFMcQgpLBlkPRgBdTxFdDlIFRl5aFFwYQwJXAnkRUAFYHlZeWhdeUxcfSwBcRVoOWwRHFA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1790520961; x=1793112961; bh=vOLbn1jnQFiFSgxpC+eYo1Hv38mbuS419e9eJih/QEU=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=ANv1yiAPeBPJCfaYHO92hiOt4pJAClDbm2J9q6ZvfnPYS3V8ACJfa8WtIlCnTuLrXzNuc1TaCGeuF3aGXBrbsfQ8suLyAo3f4DBuOdYMAh5q9s2dZT2z4BWy4sbGQF708SgCQ7+0LtlJFHp2VG3SivYPDnG1z74emQMimaJy9mo4gARtpThYc4AFHe0JNtwG7i2SFKYeZcDAudMYsMz4ZeauasIEsUN55KObLvl48SO3s+q0sUUAeD3p/a+CAAoge3GUOTyWMK0X5XmBc4K1hxLeZYI/O6QV6TMfap3RjOhczvxwPPqUfL9XidWbjtYsNSV1wjrJo2rYHZr6STb8jQ==
Received: from bigre.tail98293.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-7 (Postfix) with ESMTPSA id 4449418002E0;
	Sun, 27 Sep 2026 14:55:57 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	daniel.baluta@nxp.com,
	shawnguo@kernel.org,
	agx@sigxcpu.org,
	angus@akkea.ca,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 1/4] arm64: dts: imx8mq-librem5: Remove invalid monitored-battery
Date: Sun, 27 Sep 2026 10:55:35 -0400
Message-ID: <20260927145538.233548-2-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927145538.233548-1-vincent.cloutier@icloud.com>
References: <20260927145538.233548-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=6ab92e80
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=_-FhWcXjAAAA:8
 a=nrsuy9JVKKtfWTm6JsgA:9 a=c3Bybt16QQbktBXcOhN1:22
X-Proofpoint-GUID: 2g6l57dVJmbFiv48J3yGrRr-y6I4hDgv
X-Proofpoint-ORIG-GUID: 2g6l57dVJmbFiv48J3yGrRr-y6I4hDgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX0XdBR5pTvSU4
 3V2cXCLpxYY3sZ/iyBYKNPn5HdV2yQ/8rwlOv5kF+eDKSu+N0dnk/CfJms4vLYQzkeArLVwwtqd
 5qB40xtJwpIeqHrhPwRhBIzO59tFrV8VU6YY0JCWf/ZjDngWoaKJfd9NAcbO9ndi+rMXZN6Hfx+
 Kp5Ba5+n/3IDDhlZKG+IjzVXnxmM6leh9asmn5zlighSc/CpS6LBVSCTjpyJ8PqjDQJGNK63x7m
 dpA8PkGB27qXiHZQ4R8Bi2pfkMyRpMQX+eNYTGGuNSdQz7m5p/sn3XuU0KzcJiWswD88sG18BWv
 UWtaSwvHFR+wtO/GKgoyQLc9D/Ks5MvlWOCdTK4b+jLUTlJpQm7vSEE/GCkg+w=
X-JNJ: AAAAAAAByTRhRa0g/bAY4J12S4Su1Mvxp/farNAGbYVWFrzD9qnnEsDcpE4fik2cnApSp53QMElBBnUROAQxaO/U2airQj538zYcly7/jWcdzaZLT385KuKqy8dGEwedjsCgadEeAVv0xMibm5vKbMDICKMrVIz9gyIZPGdjiWJCDQ/AaOSFNy+PTh0dViT8MjxJAYyd7czZVMIF6qtLl1Ur+OdAFK1Hj8JMEdmtODDtFeNbgbTTGpTjQkXeOSKVPs+v6bOsxiiJJwZIvdMiyC6YmPY7RKeFZOi1B4ggz0e6T9OlfeM218qaxwAwhNfCaYAcjQV4hEe0mdINbv2hkDIPDGNKZja8vrhSrjwSTtZVb9mL4QKZK+SwhwAY+D/Szta4z2Zz8vNvQnQV6pjXNpC5ZLA67rDUlCu0wD2N6QT2li3c3Ye5F2AFkHhaaggK+U842qzM/pKdWUkCY5nKIxDFp3ubF5oyliVhUBeAG6ezkJuMTijRs5jB2HGVl2ldw61J0B5W/kkx9BI+zT4dgau49UOAHjRCWIioKfji20kPEdEWXweNkJmzQgMYR/cBWR8JqlUTPZ/xu6edTFlSkzXtg+GvWdCa/ymE+h3b21IDJOBI3V/4kgph3z85iacTEChNiygY2m6wyMxEWvxtlcebZKP+I5cwUGAlIcZUcT3jvv/OZFCPegtn/Cc+EkR9pAUgPryld4jpFF/ZJpfqB0OVOPvKh/JhVn25VoNDwUrTN01CqWWrTEynCn1D1eia3+KydbZrkJl7GpqsnMQRZOKFIcOjaFLrxKKi7Foi4zQ8PIU6qEv1javcA3ArrYttgd6QHGnTKTIKy46QYoUYT2huH0LfSDPbEoirKWW19WzZ59D6h5F/KKc5kUHkTXcRUOxnXIp7VyGKFZ7eVx6KVvgQXtMWeU0QM9wsLy47V60nvY8Yw42XAM/vuepQubQjwDg=

From: "Angus Ainslie (Purism)" <angus@akkea.ca>

The BQ25895 charger node points monitored-battery at the MAX17055 fuel
gauge. The property requires a phandle to a simple-battery node, and the
upstream BQ25890 driver does not consume battery information.

Remove the invalid relationship.

Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f5d529c5baf3..099195279e84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1201,7 +1201,6 @@ bq25895: charger@6a {
 		ti,minimum-sys-voltage = <3700000>; /* uV */
 		ti,boost-voltage = <5000000>; /* uV */
 		ti,boost-max-current = <1500000>; /* uA */
-		monitored-battery = <&bat>;
 		power-supplies = <&typec_pd>;
 	};
 };
-- 
2.55.0

