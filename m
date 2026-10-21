Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590708;
	b=PUUrC9uSxvx19rHlN3c/VpDr1wyGng2SaoOoNrKTM3/Em1QgBDjNAbt+tAs8gKIcS6ec
	 9OKJ69AUKb1lx+Hiy6VGni5cc2X/35x0PqKKFs14neZicAMvPh+o5NezVDka/jSErjI+0
	 C9Vao9QyTv5sqjpzSP5dgmnosBf4twvSs2r6fHL53mKro05uLMO3SOTMhVbjVqd7C1qdp
	 z7nkvZglQeokTumI//5WIxkFEWB9IDkn94GTRq+la25SLJUtCbo5q5CSFo+OhVjF/QJ50
	 kEVYSKaflK55kSlaplpyZ+dNzNefBJ9CHFRHYT7VfXmjZJeCnHewpXgIhkQnwm7n8jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590708;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
	b=o5ZqSQHN8RPCx7oxtMIJBuPiVeRQDKz/kaZ+x1S3Hsc1bcpq0MXt4UsE9Qsb1v8RAlUW
	 Ot0IAwgtJkyKgxEGgPkjQmLhkSkdj8bLgqNAa0UAZLiA3yo8OJbJihYWFyDMvVmu2P5NI
	 D+XbK6A/oIcSIDF23EDHmHNJmzEzMqvaaL9MmVRjtJ4cW8qyEbM/P4TywU+vQcY39Gr+o
	 xX1dOCrp33wrzEoD27ziqglCiOLjMSEGxubssDqmpNWxkaZNjVNzg/oqIUn7TT9UG5gKU
	 4Xhw663txS3hTUpBPDWdYNBQmrvuaz7pU1Bm7JbWokRpmPPY0pbaD4RACpukMMY/2kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRpM+auj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6Ak0N8X;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3260A2602
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C3260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XRpM+auj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6Ak0N8X
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBg0bg3224769
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=; b=XRpM+aujYckvOMNn
	5+yu0Juc7EZshslGjkOahJVUO3kw+BGJJapxZTP4nzSvjnpdR2CqwSBaCJkjiJzY
	LhN6m2vUwjdUMpCnIS7Aj59CtnYdIAxyfiXAOgyl0o99la7byAKe/Tg6z7D/MTqt
	Pc8G+pcgwp+za4Zdt0moTyIoD3pa9uUG9jopZx18l6E+uCBILuECexSkucw0QDaU
	fvjBNP9ebEOflRjZuVA0bzlwIaWNUvkA2i1QPFBAHyAkhhHiAhZkLan92YgMXpKY
	y8WAdunXzmyd+DodUh1xg1lg4BH0Fku2s55XVePcCwKxxtCgdXnt5PhNWy5Mtbyi
	jLww0w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79by2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:51:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35a04491c56so819199eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590707; x=1793195507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
        b=N6Ak0N8X/KfFSyA9/PFHAryf3Rltd/07WSOoVG/lbuu6WM2NuiX/sSkZgBRV0aKvj9
         /p4MLYqELiZmER9HN/ftkyMJiWehdJjLmiQsWfNJAWkUCB9g6Z4fh7390bGGsbUxyg8N
         TG9MpRKzeeJGqBHRiugjTgQ222rygcxb6ujXEa05kzMmtVwmXPiLegLPaXJBnciX7JvT
         ximpuTFK6j/yi3VEgKbEhQi+0FBUY+ttCXXyYBklPrcdoLgdJiraJtYPgaSvat6grwTr
         9Ulvfxb4MtjgHBxWtpiDpC+hinesN3DUKob1AvMYuKKLY7zdFjqMNG8gk6si2c6oFDMQ
         tRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590707; x=1793195507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dVWsWBCRMZYjSHMs8vlsyzTh7G+H8wKUyi8fgvNpbTw=;
        b=tN3kQvGFqM/W8hC8TD/UfiqNUvzszLv1pGBH2U54c5iEOrLbAX7p2wn5lrrQI7OzeH
         3X/jO6iMg81CTsy2h9ejlI0AyrPKiMCK19QaXHIogGRl9XFPzxsJV8QzOggwFpsMsA/4
         /J1Jnva6XHyrJKpTBnIaZUpLHhPbHNFTpRo/UDFgF4GRg5N345MxRMm2mv19PAQqR6UR
         WJXBVI5DE8y4HDcEYShLdxU8hB6nX2odW8coGsTRgxA+i0bqHv21Ug2BlRIAYGn+R2RM
         Q186TI4uTCWzzI8TcgUBkycM4KXbD8cokR7WlVzDe0+bESGrKtXXunwpm1zZwWFWlAy9
         n5CQ==
X-Forwarded-Encrypted: i=1; AKwUvBw86K/oHLx0Y5FYFtlk+ybSjbv8m/XCR8f/xcrob/9CN8Y68+rqmPXiqcfLzilDvDiT9GmAj+nMoA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI6Ke7G0jxsr2PJtLIYu+GXHqzCGXkxClNZqDqXdSeJqKmtG2Lu
	i4wVe3Z3h1BkLkKrFQZmMQ3gjp/+KVwg1G34BHH+r5fc77Ls3jM6IW1kl+avZGrSFJauB7tZ/Ni
	L+bZTVk00wE3vZo2msWEC2rfycvDi1xdU7vI6hCbmwBnx5O9gSGvo+jgcYvztzQ==
X-Gm-Gg: AYBFou1FINjRySciIwJ/CO6DZcq7PWLVFcEoV3ZpjIr/xF8B2gJMWF5brNOPP7OZ2h7
	RsmsT6hhjv+ruYJJSzO+EnfKfvM4QZjY2RmFmsb4xFpf7t7qs8kQTrxc6iW7/J8ajO1Dng3sfje
	DS7u+05rQbobzK0OkpTmTrCc2hkXhkE2nhSsd8de6bZPQdBCOhepeU+I+t1ZqPOgquz9V3niNow
	gaafjIgGXOdTTKXMIFqHR0en0tJCG3nDbr1IVeulAMFZDyXLPX2khHM+aoAO8cR9JrFN3rVkMyj
	d4IQpr8i2eawzU2eEm616axMKdITj77ikXpkNHpcE2kBMYP4YtOEzWNKNyBGDKrj2+WJ07v1m9X
	1BBBZu+UCA/Saato4D/XOV+90ap8jv2PE2w==
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id 5a478bee46e88-365fb187594mr6216831eec.17.1792590706924;
        Wed, 21 Oct 2026 06:51:46 -0700 (PDT)
X-Received: by 2002:a05:693c:8801:10b0:353:7f47:8168 with SMTP id 5a478bee46e88-365fb187594mr6216804eec.17.1792590706367;
        Wed, 21 Oct 2026 06:51:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:45 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 19:21:24 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: glymur-crd: Describe the PCIe M.2
 Key B connector
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
Message-Id: <20261021-pcie6_fix-v1-3-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
In-Reply-To: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=2234;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=N4sUA81o0uvR6JdRpINVUf4MY/Mr1oj/T6BQ1Wygh9o=;
 b=Mdyqv8Zf06NuraQphLE0x8nVr/anXhWSoGzD68/+GdqDV3SEHuXyw0N0AGK6CGE3tJDTk5X/X
 0f1Bi/Acn5JCklLc75L4R3KL1umI5ACEtsxpwIhEWvgWEfm5OeQcGnm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: t23l5hj73tVrixW1PYj6_QwqLpFrJ-EI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfXx2tiHx/ULLb+
 Xd7GR+RWpqkL1sHI0ehSqWlHlx/9iNEL8atjzAfxppU4n4rYEVIyekHyABrVBvhlhkZrzbxDqdY
 GcZ+D719TaEc2CUh7IsEpa2a9OpFTgHig2Encfov4WCztLeLqLa+JteOHtTaWGFqSohRblAnDYO
 tRitv0GbFiteEY7Z7ybm2+e3hJZmHmLF/iOIP4hBptcgvpAczhM6kaWZs83i3psKfROm6RtV8co
 HcApfxCKtaj14MJmogLF6jzWDJ8BnkogoFzikqYqFCbrxjbiUc0aDZbKmpi36r6o3qfn2m1bGnX
 Qcd9eIc1xNfCnQsHGWovJLBSPcAkhP0xmMrijc5SSSlkrgOIBa1ZX75dAeewePgg1exa3giRlRr
 2MJnJKczspTLJeaUI3x0jtCC+Iv390hbihQkLWkSTwFfgYPxiQsXjtAHlz/aPCL8e/FqGckweh3
 71csobjI3tFBJIYoq/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfXwG2p3lquqqnp
 NeLKinn2YCmWRwl2XV0DCF/xBl/Hb8Y0GPo9b8z5ZiPdMyuIlIgTb1NQpXK4FSXvRl9P+ra606d
 9K5cZASJvXq50O9KzqiB+L82W5jS830=
X-Proofpoint-ORIG-GUID: t23l5hj73tVrixW1PYj6_QwqLpFrJ-EI
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8c373 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

The Glymur CRD has a WWAN M.2 slot connected to PCIe6. Currently the
vreg_wwan supply is described directly on the PCIe6 host bridge. As a
result, the supply follows the PCIe controller power state and is turned
off when the controller is powered down, regardless of the requirements
of the device connected to the slot.

Move control of the WWAN supply to the generic
pci-pwrctrl-slot/pwrseq-pcie-m2 framework. This allows slot power to be
coordinated with PCI device power-management requirements and keeps the
supply enabled when required by the PCI device, such as for PME-based
wake-up.

Describe the slot as a PCIe M.2 Mechanical Key B connector and link it
to the PCIe6 Root Port using a graph port/endpoint pair, as required by
the pcie-m2-b-connector binding.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index e27c697e3170..73de60b0d0e5 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -237,6 +237,27 @@ vreg_wwan: regulator-wwan {
 		pinctrl-names = "default";
 	};
 
+	wwan-connector {
+		compatible = "pcie-m2-b-connector";
+		vpcie3v3-supply = <&vreg_wwan>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				wwan_m2_pcie_ep: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&pcie6_port0_ep>;
+				};
+			};
+		};
+	};
+
 	sound {
 		compatible = "qcom,glymur-sndcard";
 		model = "GLYMUR-CRD";
@@ -810,8 +831,6 @@ &pcie5_port0 {
 };
 
 &pcie6 {
-	vddpe-3v3-supply = <&vreg_wwan>;
-
 	pinctrl-0 = <&pcie6_default>;
 	pinctrl-names = "default";
 
@@ -828,6 +847,12 @@ &pcie6_phy {
 &pcie6_port0 {
 	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+
+	port {
+		pcie6_port0_ep: endpoint {
+			remote-endpoint = <&wwan_m2_pcie_ep>;
+		};
+	};
 };
 
 &pmh0110_f_e1_gpios {

-- 
2.34.1

