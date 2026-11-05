Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893611;
	b=Lk+RQv+tpOPrfyGP/RXg2FbKBNES2MMf0vPQZeXgXZSGwU1ApX+SEsoc2VTDHtq7Fa0z
	 5vK0eXwIV9A9szxLLRf8HNeFOQ44327ETW850C+CAMi9nUND/LWjQLR4wl8wlP0bumXeD
	 /2YtJ+imsmS0n8V7mvDUAPEKWO3JNuR7ixlFmGRV3FXuR11ALEn856nGGRynMveuFrcNS
	 mk4Hh6WQpT12kJ2Ga5nfg1+uzONHMR10ryCxa6Jt0yV/K+gg7L0cKde/W/PK7zPNaoIhT
	 JtBqP06i3/hyW/9mcsuxs95gddzijX9DiKEhZqmiLwOa0j5xO4c3ZYfX5Gpk4GxAx0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893611;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
	b=dY6kRnyW+BSWZrvR+YFee9idapgpqSa2WHBsAcxhtR20H8IK6ABWfkb9e5dKcV4tw5tH
	 7hPybv70/Ji/MGe27E45myd9yLdIUOcTSWZfl1p5o9lQIVNF1TN8qPut7BL2cUvxhlvxu
	 l7JxVkahU9266AY/eS5TQVHDX3Hw5puCG1RJypqNygbMfn/EYMi/vIz3rBuPRO4kRPNXH
	 HpPiTYmHnuEC5P0gvWyS5XSAwJ4l9EdDYx5AehObDcbZZu5/7Rq/hJN9Lcjuv7tLX+AlB
	 OBngkCkS9rIVuzxd8fCTnhYi8i8LWTQzA6fqObav1KJmB9PiB8pvvDMPvnAcD+7Dgew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A26606D807
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A26606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UbgLQfmH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeiuGTIc
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQ7Qn4134032
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RN+WEUPp4KINOTOtwDMjWG
	bdxhennDprUx1GDkbGW6I=; b=UbgLQfmHay1X+yLkye7NquJWqU5e0T0xMorbpE
	74Ttkk3IcQCJZwuOfogWU5uXpQKh/oTjnd9cYKbq0bW3rj7XRJDB1tZ3CpwtycAn
	BeZOC//LnRvrAnZ7u7FlUyDLOuQE25ubJNXpbEIEMIOuxl9/M6/W2+Bnm4XSIBze
	oKceZdEID2DXR+k+W5EFVf+Hvo37clM7+TRhEM17pGLdFGC7JxfxvzrXcijSkJVf
	8N9YDYYc5R92tCaQ3JJPnfznxFcQ46sztjBN6p/+92aE6IAAnFuQSQK35wbGUo5c
	hqnW/zSD2V0yeutOmQorrudVCg5uwEG31yCLMWNzjGuuCVHw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksqafmk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:46:49 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-9907539aff7so1406292241.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793893608; x=1794498408; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=NeiuGTIcDa0UFX5v82P4oZ0WJu5KVbWMNDs3GR2L8p1fx7zZcZyrjB6VxrX5NUCB6N
         eHdIDgVXXkiHUpu6/FHKgtE9FvhR1ig7GAEei4+MFiIheIGXYrapXFX15FlVWRgUG008
         2JtuIba77h77V4H2b045mwUGoFGTyholICVyAuLpku78CVH/5uzpOSWqUxixZjXm1aqV
         ud5eIyCvvoXAf0VVQ7jcyQCeBiFkBfIZepROugkZ1Akwv7wapLoXaNuxQrFLGqLra3Zt
         caoI1dEF1whJDIBvf8nDVFBbw7CZPUdJdtoHxPakiSdkasof596lWyN2l4HiqYj0sYe9
         h5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893608; x=1794498408;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RN+WEUPp4KINOTOtwDMjWGbdxhennDprUx1GDkbGW6I=;
        b=o5ize9gc14swSFB4smTUKx2A+g4c5+PCFXjKqDhrEfyE82R9aJWXJ9x4kw526KyOsS
         /Ix8GAA5XqnklgORJk6AycUFpMUNIS/0U8qbtaqiLKnyADnafDMvu6ky/fHwNps0Eqws
         114DE5gcyn21qyjHE+qpfNKxOb1BEXqDRav9d9LfhdgLS0mtpEGsqhC1Vv5+OGvdC4I7
         elEtI96Z85E7MWdHqGL346bxAPbw+RhybwQTELTv6sZ7YvMqzH5/jR5juU1/fHC8+eSu
         lp8L+sKt+EGmLT5eaQObGafbKqV4ROTDYI4QC6hPTPb3mKKrJMTyiaiTsWFCPc2i38b5
         eP4Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8eIA2r+Ccms8Pj1Av0eadGhdiMYwMaomi7cDuP+KtHw7cjQaIpS0+U9cJohHDuqRVjdnrvuiOTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+QRB5bbovGhEJHjyDFs+h5NsjT6m77pRSzJB36gQGFqCOYyg2Y
	sikFcGHKaPRfJzc3F5L+x1i4hZ5NfjamEApoV2OfU2Wk1xnjnU/QU9drZZzIa7Z9UWyIpn6rbxV
	hWvozuCekS44ZkZVVcZh6zw/zS6cTUB92pwb/BNSdKLAUG2FfksS8zXnOnYnkJinBAwXlcQ==
X-Gm-Gg: AYBFou2l432/73ElwKoxehTE4g4mzVhnNRI0GpoCEQb4Fw+U5LYHS+R3SNcyCj3+2l7
	sRahGwxuC/50IgmfdsHI3MMkzPMywrwGX4rEpltml96Xyr2WAOJ9hcsraWhdefupt6+3pDdDaK2
	NQ1rblSlqMky9xQqc3R/qqnHVx29n2l8pYH2kMfGuFX3fj0mp7eBkq1se3GSOs3M9HEAHlLdIWh
	/VSi3y8E7/kowHbAjOhvuU/aSDPlombAArUQw1E+HhTF1dpkouzN41Q8EN+pLqHLkFts41HrAW+
	MZJVhGurJv1HUKoOl11XeRP0U9pyuyG5uhnYckjha9dqosiWBymkAQBDG3YVHTRoxSrEIz3VFEf
	2KIifwdIpHqbJSKC1Dp7f+1sqE2k85/GFIR1X/O1PqlEr6DZHkiH8N72vtVykx7z8Wk4uG562S8
	r1uw==
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324557137.33.1793893608468;
        Thu, 05 Nov 2026 07:46:48 -0800 (PST)
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr9324517137.33.1793893607880;
        Thu, 05 Nov 2026 07:46:47 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm10717936f8f.49.2026.11.05.07.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:46:46 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:46:45 +0100
Subject: [PATCH] power: sequencing: fix serdev controller reference leak
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
Message-Id: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOSk7GoC/x2N0QqDMBAEf0XuuQdJICH4K6UPYjZ6aG2agBbEf
 +/h47DMzkkNVdCo706q2KXJZ1Owj47GedgmsCRlcsYFa43nctSGL5dRwG/HqifsXJF5xbBw9s7
 CxJB8jqQnRRf53YHn67r+lZkypXAAAAA=
X-Change-ID: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=blvW7P+vdcHikV9wkNkqbWJ4eKvSI0rN+D6MuijpqgY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7KTmd1rI0vmNN85k0PZmqXGbQ8qWCS5DLVv9q
 J9gq1Xa1vCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyk5gAKCRAFnS7L/zaE
 w94KEACA5RwVkTCGlBgYEPF7sW4hDzlNdX/Mkg8SksT9dCIa2v3O3WNBupuy8rIxu3W5/cuYUw1
 c1dzdVJMZYqcH4Mb6pCinkkd5z5+lduqTNLSXtIHVjpiGFL2Ex5lTF1aloa+9FWz1RoHIquisyY
 R/BFEBZ9cyUP39Yx00fnQqnNcgtZwhvcx80PhXqQusGEr2Y9KwzPc3L9GO3OFE7U4WBR3nrB8G+
 4p/ooTTMIJl0yif8KQXors2F0zY/vrLHA4yQyAYiLxoKFck2iSdhu/v75WkX/Li0HMWwx1TjvrJ
 I53v/UQiSfMbWyXATm81qIG8BE188YjxHnlbpowxF1Imif2MuAUUnQUKJb31t7sAhfVdzF3lNet
 meCGbN2bamOhRr+2qtOAmf1QgX9GhUFbLWvP9olvER/nL7JsvrdQrvVFUVMUp28UoWyye98u+CH
 7oqg5T0ge65lwSLsI3DHbMwXLXDwBehf3ypoQ9lq3j+BqJskzc+yi1SHP+J4olgkQxJ9xW9xG2k
 CV5X3Je2nLPFedDOGnIddzjBXP5Dk8D7WBuwVO6Bf9pRH0q4vUjdIbHGD60Gdss5imJnno85qJG
 r12NIf1dbaegpiWbhdb0YRvV46DzaLJdG3iXkZjH0ReHkXBKAhn2Tgukz7k20QTiilC/vRh/vbG
 qzC+9B+9xzd1EwQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX59kjJtQCHo4B
 n3u9VFZBgQ9edcn+MkPsLxZA8nWb7JiG/jBkFLDXS0I4WhoGZJIv6hAYGdk9ClrGQ+LzL185AR3
 DWhNme4g4F6hg6N3f2HE+iTTIS0eWGNARr0xPXTWfSavcYWNbFwCJhayOvKvj9LLCJX1Ko+cWkm
 VNnjhG7lfMlEK54Fur56R/9GmnEC5IFiPRiOGwllV67ZkZVEku1mVjgivJ1oovf0beyUO/2tijx
 VgqPB0ufxv0FevT2cttEt5YQl2UqU/3FpSgQWtGnz40iwjYFJAov53CFvsMYEnaRF6XUSojbW9u
 WYvejUMgIMdosNCwA+lRLl6mDJJ4SiUmFYRgi9LOkqBiJWVQko8z8y7lLOGdXQXyjWDJyMp0mm/
 GaqD8Fyrvu4BvVw3m/ubHU16hGa7T+gO4dei+7f+kjHvse5uVhUuBLEtuElrTJ0USeOPIRO93dc
 orxK9wMUHJKjw9x+sPA==
X-Proofpoint-ORIG-GUID: 6Pa0Hd4h_-vkQvAJrrwPct3_mxvSmjeZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MiBTYWx0ZWRfX3dNHu19wqCCg
 2KszN4fC96x/Yz/hc+DXz2HMHWDKCZkLEbNlQlFJ5XuRK6HxPxSAB9GeAgP5ytMrq3m3itRYlOi
 vXVtxUgbhEoVjf4pkPxac0X1PUCIk28=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aeca4e9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vvZYVk8vaF1dF-lsgB0A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 6Pa0Hd4h_-vkQvAJrrwPct3_mxvSmjeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050062

In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
pdev is already tracked in ctx->pci_devices, we return early from the
loop and skip the serdev_controller_put(), leaking the reference.

Initialize ret to 0 and jump directly to the label that ensures the
reference is released.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/bug/linux-07754192-a8ad-42d6-ab1b-cd6f16bec846
Fixes: c4be520907a4 ("power: sequencing: pcie-m2: Create serdev for PCI devices present before probe")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..e3bc5ebb1e56666d135c04b23f6d462a0a166df3 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -296,7 +296,7 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 	struct serdev_controller *serdev_ctrl;
 	struct device *dev = ctx->dev;
 	struct pwrseq_pci_dev *pci_dev;
-	int ret;
+	int ret = 0;
 
 	struct device_node *serdev_parent __free(device_node) =
 		of_graph_get_remote_node(dev_of_node(ctx->dev), 3, 0);
@@ -308,16 +308,14 @@ static int pwrseq_pcie_m2_create_serdev_one(struct pwrseq_pcie_m2_ctx *ctx,
 		return 0;
 
 	/* Bail out if the device was already attached to this controller */
-	if (serdev_ctrl->serdev) {
-		serdev_controller_put(serdev_ctrl);
-		return 0;
-	}
+	if (serdev_ctrl->serdev)
+		goto err_put_ctrl;
 
 	/* Bail out if the serdev device was already created for the PCI dev */
 	scoped_guard(mutex, &ctx->list_lock) {
 		list_for_each_entry(pci_dev, &ctx->pci_devices, list) {
 			if (pci_dev->pdev == pdev)
-				return 0;
+				goto err_put_ctrl;
 		}
 	}
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-pwrseq-pcie-m2-serdev-ref-leak-f521e086d5f8

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

