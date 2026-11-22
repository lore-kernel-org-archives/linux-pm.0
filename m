Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795329973;
	b=BXblqnwOZDCDC2DKoSNmKa1hC3PlYfpxhOmKm9D2L72dJONXGZVNV7+ost1x53acBQhX
	 RI3ZA9hb7NKDtzb2UOlSap69W3qbLJIuck327DukMFU7q5SXeLQ4q1LVIX586cZI7il0i
	 3KsneXNR804AB88E9NZABrpJAJhoD5tErVaYimfH4NWafuxzALz/Tk7f29iKqBQTOdpQg
	 fcoY8yYZWsPlBV1ny7eJTfFHjOXNIU6UH6OGsMC0EapOMdaX21rEGmp5ZErEaxBrxjvrS
	 DqTwWsibWMM3W/crjZL92lkbl1Dm9XR8Q3wi2cR8fg89JjX86+5nrKrDzzOtrDFA2Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795329973;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
	b=FTUUrJecbK3bVYLHYAHFTfbz7WMfzmUkUuxf+qG7cZBOOr6EABTcjKpE09SD56tnnf1X
	 AZrU2Yx1xfYKUtWKv/VCzhRQxKELdo9WTXu/51wHjjECYnZob4EtIjc9ezwCOFXo9Zbab
	 zj8zXoCRlX5YpmyKUYc9fVP3HHv14pWTsutAT9Es3uxqRRPhMe67Sgpa4hzaOufIiOvrb
	 W9NmPmxnhIQ1NHTEIUL4ba2OuIrMog5HAz6zd103bkZZCc8oaDjR4HPtRvlCxyaVO/mX/
	 T//9M0TL+fENQW3txqxwE2b6ZwyUf66N5tV9+LEUzf2I8p6sSxGZJ2VrpLU2CnWE06A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd4Iy+tU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iS5zRebj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BB606A334
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 078BB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd4Iy+tU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iS5zRebj
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3kc2K4034990
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=; b=cd4Iy+tU+oopdkBT
	NqLPb6HhNInALg/+FgEC+4luWYkoQFWvXQoTGQrGLYK6deAKCNU3w0+seictRbbX
	Du53AixtxwckMWyS+cfpZvvvoX4GIToFZa2ZE76g21SBS3gT8yYcWiwxVdCuGerq
	HoN/ruNE1aM3n+uIeCiuzGBlPYCF/BmITjICv+cQz3HmH/KY+3Cll4ry4UV47P5B
	+jzSmLkNJ4J4T08VsZaIARtccUS+VnVByrGshKaw28LrUfXtezh5QbbWcyrzBlvV
	fkwnos13o9t8guFnv4Y5QjC3bCAQCajs+LGVhP0udIXYuCFgUbwLowJNbEmN5LRR
	O0e7ag==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32w02w8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 06:46:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3846d5f54c1so2974808eec.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 22:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795329971; x=1795934771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
        b=iS5zRebjQnEWcTaiTvzf033ZczVAen+bnqsKObIP4uEOLInDc1PWczQT5XBpEr+m+v
         26byVcKgBvraDEK9WSFxbUB2fZx99T/iQBrtU57bZAgFPyfWGGXykIFAw0+mtmm0BX3K
         taP//dC5re3EMECbv3XCZUw/aO4YLb/NY9068T9nIWmTBbso0ulbM2kl0Ra/6B+Xu8z/
         lsg58THY7d0TSAnFtKKnKwjUMHGlCvzU0tu8mov2rsuoolxW2CkNDe7ka0T/Nwos072N
         R3l3gKZQu8iWyBQshacl4MMissbXgmENvxi3/UeqL9Gi+Lf5XbYwEBc0z767yrAuFlQu
         vX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795329971; x=1795934771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/HxRaZR7J9ru1hz+OIfLQCN5TXx4eWOdESZp+/f6pr4=;
        b=gAtm5RyCdYHdbpX9Q3Fs1Jalq50QDkVXAa7Lvkowu/nGXPJ4HU0xDS2UAyuYp22Ovo
         oHlBNceODGtOgjcb4IgLISgtIQs05hMav3rSH76vMryJzGxZWzkNI1rDHBgiqBxDfth6
         5FN1AasXp1XvtV0gU2yGJQp1wKzB5T1HefdpRdZxf0Lj7nYJfeAdrkbKlr37y5yFhw6H
         Pk62HR5cVEWP+9vKTpVF77NzPV42lg0nmhRQxQWd5GJj4pQP99uHQMoNuqCISew/0ozR
         8k0haeUgbLkNqpbfppDq/08bexVkNfX6nuPo+ypvDml8bZWgi9oZ1vsqZhu8EWYBQZtr
         iT5A==
X-Forwarded-Encrypted: i=1; AL+hErHFoHspiVDkgGLtA+AeXaQtUPKgfv8RLy7D5AD0J0IGCFzkCv2TCdOmjAwRjjI32zDBTtQgDj4cVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NO3aKUwoQs2Ya67NKUtKGp2Kt8BGS2hDTNVdJ/zkggjTyxc88
	yQHrlMCmsbM8ONegH2UfRJ58i4fU+JxRDTaSV/Wtq6Rd+4jNAsCi2naTOZl03b5n9ZHt9dkGlF/
	VqFGi5SWDn0wTjBdfWc85VD2VEVL4aLEOJ+csoDRVenLRcIntG2EhjD6z9JP65A==
X-Gm-Gg: AZFdTZd+dTiXpQ+/QVAy9mCmJu82REmmk0MkMesYhiS9HbAWXryf3zSJC3cT0I1CKJ6
	W8TN62Y1QDd6Kt0/o6F5iMPfkV1AG5qNyCgZ4gHkRNw1GtUydu4kn1RA9wzv1WKeA7pnvpRhICA
	kizx0zk0rJOhuGH+Nj64KjRDVWIUOx32eWosvOEtg14qO0QJTWBomkGo+ep484qSmTnHRlk9pvl
	AH/vaACFBqa7nrmwLPOY+W9va/zsFiuTJX1ZsG7JC0iYJUqM00WVQBzRBs30Q8cvoR9DOMVTHDo
	wgmqrAFnN88SrBLNaQnZSdh9/GaOF7eAp4chchfXUjJzFEX6ZAWkVfOistwslseLN2HWVYhKq0S
	Srbi7kyey6FIMCcrXw/ny3jKHzWd4S+9uyqqDlYas6KJTI/zJrL8sAFXAWlCqYD352dsMkwkmVG
	8/PDogRWei
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id 5a478bee46e88-3856fd5cceamr9129715eec.17.1795329970898;
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
X-Received: by 2002:a05:7301:85cb:b0:381:edba:caba with SMTP id 5a478bee46e88-3856fd5cceamr9129689eec.17.1795329970317;
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm27598615eec.10.2026.11.21.22.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 22:46:10 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 12:15:52 +0530
Subject: [PATCH v2 2/4] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
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
Message-Id: <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, alchark@flipper.net,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795329955; l=4982;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=GERyXG9kT+rvE2z4g19ttsfCKGC8K9XHB/CHtubzrro=;
 b=EZVbgnjTMa6pM0iZgLGu7RxcsQSbI+fK1plh3pLB9BzCaNYo7+zdadU8O+5so2n6TyGSe3gIS
 kE/RMafil4/BqLXxL5kBq+LUwAiN/df4ANGXn1ZNKOOq/rs9O91bBdt
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfXwyrN8m50T98a
 RQCB9BlOIg2f+Qb40BWhvKpvjggYDnrUZOHTpoaQcLtYJnEhxISJz2aSv8BZH/X0EdyhjXbbkJZ
 O46B0O1/bEivT4FzeOf4YqC9xmYYva1TMNS9mtDZsFZaabh1d0l+Yj+DVCIV/SCEO/hiwBimKoe
 P7f0XEuxoOcdxnyUyvjZS+NPK2guvVT682sxxAKxOUuTeBGAVv10jOoMyDkRqD/DAuZqiyVTD6j
 mWZzhRAo0FPr6t7nRVOO9oirNp5U5u4C188oiWj3Q+7u5IYO5b4BgscfYoqJ90De/bT00/F3aaP
 NoRz5VkTBphrJhptgvHEeMcNgGEZDA+xywhrlWFMCgk8OMpLk3njSntpvbQF6mTpqmhokxMoOIV
 dtPl0wvZlW0M0qRGAwm8F68QkkoKYyCd0KoKglPcymbQN1bFNYkV2YMK4DpPiVgHHh5XR8EwOl7
 TjJ2nQzelUUtMGLWg9w==
X-Proofpoint-ORIG-GUID: hC6n_JLzE-B0B_KQ4-grHuy9VIw_j_RF
X-Proofpoint-GUID: hC6n_JLzE-B0B_KQ4-grHuy9VIw_j_RF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAyNiBTYWx0ZWRfX2gYBrzVXZP/F
 xnoQTmiB9I3vPJoNxKvEt3da4Pft0KCeshUymjYJJelg2NXG4vs9aPXMZ3R1/zfP7hUVBhcJnpG
 AOuqzgrjZLND5qnVoL8l5R6AEz28Kvc=
X-Authority-Analysis: v=2.4 cv=S+dMU4sP c=1 sm=1 tr=0 ts=6b028fb3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1YR4yFrG3nAziPXzX-cA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220026

Add support for handling the power sequence of the PCIe M.2 Key B
connectors. These connectors are used to attach WWAN Adapters to the
host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
2.0.

Currently, this driver only supports driving the 3.3V/VBAT power
supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#
GPIOs as a single "pcie" target, since Key B Adapters expose only a
discoverable PCIe/USB interface and no non-discoverable bus (unlike
Key E's UART-attached Bluetooth device), so no serdev creation is
needed. The other signals described in the binding are not supported
yet.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c1..8af4a059b596 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -39,6 +39,8 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct gpio_desc *full_card_power_off_gpio;
+	struct gpio_desc *reset_gpio;
 	struct device *dev;
 	struct list_head pci_devices;
 	struct mutex list_lock;
@@ -135,6 +137,45 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
 	.disable = pwrseq_pci_m2_e_pcie_disable,
 };
 
+static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
+}
+
+static int pwrseq_pci_m2_b_pcie_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
+	if (ret)
+		return ret;
+
+	ret = gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	return gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_b_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_b_pcie_enable,
+	.disable = pwrseq_pci_m2_b_pcie_disable,
+};
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
 	.name = "pcie-enable",
 	.deps = pwrseq_pcie_m2_unit_deps,
@@ -166,6 +207,11 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
 	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
 };
 
+static const struct pwrseq_target_data pwrseq_pcie_m2_b_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_b_pcie_unit_data,
+};
+
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 	.name = "pcie",
 	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
@@ -177,6 +223,11 @@ static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
 	NULL
 };
 
+static const struct pwrseq_target_data *pwrseq_pcie_m2_b_targets[] = {
+	&pwrseq_pcie_m2_b_pcie_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
 	&pwrseq_pcie_m2_m_pcie_target_data,
 	NULL
@@ -186,6 +237,10 @@ static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
 	.targets = pwrseq_pcie_m2_e_targets,
 };
 
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_b_of_data = {
+	.targets = pwrseq_pcie_m2_b_targets,
+};
+
 static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 	.targets = pwrseq_pcie_m2_m_targets,
 };
@@ -577,6 +632,17 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		goto err_free_regulators;
 	}
 
+	ctx->full_card_power_off_gpio = devm_gpiod_get_optional(dev, "full-card-power-off",
+								 GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->full_card_power_off_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->full_card_power_off_gpio),
+				     "Failed to get the FULL_CARD_POWER_OFF# GPIO\n");
+
+	ctx->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get the RESET# GPIO\n");
+
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;
@@ -641,6 +707,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
 		.compatible = "pcie-m2-e-connector",
 		.data = &pwrseq_pcie_m2_e_of_data,
 	},
+	{
+		.compatible = "pcie-m2-b-connector",
+		.data = &pwrseq_pcie_m2_b_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);

-- 
2.34.1

