Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B53DA5C3
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274915; cv=none; b=OuQVmLY4dEjxa69GCGTMGiYREgMnxawbUZDO7jnpPMlTDP4wyyQJAr3nDT3+w8nYtimeRgTv/v3XSNZz1z3BP5yxDxyD819rTrigDuqTbpf18K1/K99RBhAPXd2KtF+4D08DKtDMjO4xDcZxN+CIo5i5XOD+jkJei2JRmRRfEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274915; c=relaxed/simple;
	bh=rZymK6zMzN6GZk8l3iT4DzVoSNYOOdaK8F6aD8UoJlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daNhMoCeQ0BslfSUYbf1v4hGFZCROhIkZJEWecRaWpLCuUuBGPTPsTY+XH9NFWm+ZjyPPZHECAD7/kvUopl95iC8gECTgqj8Vxu4xxq7P5x2SPF7tfIb0VgUTQGNy1WKN757AUAOqiYzgpkB8ZAbhmCtzQ0vKHvfHoFGYnZH8pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ic0TwDnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NQ158O1G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ic0TwDnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQ158O1G"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6svII1237939
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LKHvX6tqS/qImne6H2K8InjGHU4hq+riBpBr5o2VuU4=; b=ic0TwDnKzGanOxm5
	RbcpsQH0HAe5ZyWQRw7sqVkw05bJ+keqYSJF2LZDUc6SQrd5Pwb/CEneMHcEIr+J
	x1bq4G9NB/clpxvTodj59FWElxGKva/PgvoPuCCZ9DsXE02i4Sf+SA7O9NLWN+R6
	GG/UQv7IWNLQb8mroFMNB+Bu7e8r5tfGM6EhMRSm5CgR2cb+NRXtN1LmJatz5le2
	f7S44CYXaxYFRoH03VQHlHeGtqfPhvlkAqybNlcn99kTYkGbwlW+h18qxNj59yq7
	INlLVB/6UNBRmv2LJn3uUR6ADnKv0ED4YOEeQRcoxICLOz/Og6sJ6aW8bnZyaobG
	EjEC/Q==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3svfgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:53 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e3f58830cfso6559956a34.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274913; x=1779879713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKHvX6tqS/qImne6H2K8InjGHU4hq+riBpBr5o2VuU4=;
        b=NQ158O1GLbsm+1ILC7kZ4nTfwcE9JY6TqcmEOjjTDPuu60ZibZfWAIg/7DzVyPu/lg
         KeXweem6vmnqQmMkr/9qJtecbYYy9EnQTSjD1uMAK/d5DtxuFmtB1U+UR1NUBqBJrAAE
         8wyLbLjjCSWcSxKLHU1X7JGXBXkLIHg2CrEccQjxeDR1KNNxh4uBuWj8wq80UplF+I8L
         JDW4v6VKHOuzDl0La6Hr+78skH8/Jc0hgx4jR//1AcrLm/gfohx2c30Z/y8Ggl6hhj04
         GMEFk7vPSi4B5wLGgQQmLYbsVL4cJFXELKPdDjtxKJUx3nv2bKAk14703Y2eAcX74S8B
         iWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274913; x=1779879713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LKHvX6tqS/qImne6H2K8InjGHU4hq+riBpBr5o2VuU4=;
        b=r++8XT9gpJDkPRRFD0jtXHM6MXigIIhPggI/UiaxyZHUlFoNQR1DyLc5GqlxKvecqb
         RdLgUS0f2vOcWpKo7YK/Eg964pswLad51tghlH+D7A82RK2QbZmh8I7UJKfr0laQp2Bv
         4wTsvtPrbkoVv7u/QLThnHegMtmXzW1McIFmmLoqD2KQJHa2D9YQ5rEl37U/c3Br/p4k
         jHr+Q7iPg9rVcMYDacU9W3SLG3NrDLvBBObRnmeoZFObsYP6Sylj2ylwAmFkSriEdp59
         aSz8L/XON/omw4XAbL20xqNkbqgHNrtkxnK2A2zBgl1CPJmrLEUPrOLNv3zpuAHl3Z6m
         pJfA==
X-Forwarded-Encrypted: i=1; AFNElJ8wUTr1uZM3O8V93iSdla0VoILyqnP5NhCMZUoCQhVMLgo5lDULpycbU7hF2d919JRj71jn4b0NTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDINClVHkvb6/Wjo6Qdt7pGx3WQXR+p2fmosKxKvAmsD+IZDX
	r2zWvxJ3muhjPTmbz2XvI1bFP/CmcOYvWadUQcPb33iL9ire8Q4bZYNHqj5EqFgJPAl8QTXD4uF
	SkMwHfmegxi6JyQLtRluQtechKYRYPuOaPKR9dq9VzVyFqzxmP5Fx3R5c0lsCRA==
X-Gm-Gg: Acq92OGfx/x5ZwpPZLddbYF6sjF/TueX+4iBw5RPJRG9os56BTkvNR8x58rv3e9uYT0
	G7cWG9Avv1Mg3E1omyEoUYboVDxjEKZJrAKMk8E9ln5IvpwHTuom1Az63xlWJRyWN2VXL1Edp56
	foZeB5DGa8avKG6kxROxKNie3lfWurIzuC1cCzOSWVVA8sc/CkQF/zKXo0ahvlQ9FFH8Q9Ph0az
	dfpZ5otwKgo22+yRdiHF3qNBpVn+0CYYU2sLTcfd745jvEuY1cPKmlMfpi/4bqnh3GW9s88hrzM
	qKvX8sm8YTTJc5yQly/jlPHM9J6E/o3xxdHDGPq0DFVAlwkTElPgDyTS6Vs0FiwBAcnxw5YI1sS
	ObNc+ACAAKZemxY/s//efszUIidRMSlo+XA3j4aM9cBvF72xLE1XPH/Mr54yIvq3/8iG7U1MghR
	kwNvvpjejqDR1+ixV3
X-Received: by 2002:a05:6820:1606:b0:69b:b52c:c9b7 with SMTP id 006d021491bc7-69c9c01d0a7mr13771705eaf.41.1779274912644;
        Wed, 20 May 2026 04:01:52 -0700 (PDT)
X-Received: by 2002:a05:6820:1606:b0:69b:b52c:c9b7 with SMTP id 006d021491bc7-69c9c01d0a7mr13771646eaf.41.1779274912186;
        Wed, 20 May 2026 04:01:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:01:42 +0200
Subject: [PATCH 1/3] power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT
 serdev ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-monza-wireless-v1-1-9f6942310653@oss.qualcomm.com>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: fNPTQh5-Ecah-kbjaH03a7Uiu_3pfruX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNiBTYWx0ZWRfX5rlfTL4S9pxo
 SspDctg9ah5FcS0UFR+vfLDmeaY7aA+2bsqLbMMMMwCpqOz/yrIIYKVW/1UTeDASqMsKXIjGISp
 OGL3aGPVL4YCT9u2dkRUhHwJwH/MJvtLwG1FEhPRrhV+HZuRVgpIx5rv/fv7ntswa/oRomRMWL3
 svGu9JHIicw9GBo/8hfwCB8+f2slvxT1PkdiwAtejMuyiD5L1M8j5OwuKU+9J+wIyRMKI2GmTfI
 Fm4k9dhgUfe6FGjbGkgM+RGbCV3rmRtqK6WVe+T8nYFq1V/ncPHJIQY8J6ZNLv6KD8a32GO+ZyO
 e4nSoDpG4UAg0K4OXgCUQskbjhx4vQUihPBkFPMjo2xWJHJugXCM9b1/IPbwS1Gk+7ci9/Xgt/q
 kv+pcHPGrpOX57Lbgz9sOYEgbob3HUDXSY+y2lRqE2C6AGbElsrw26Q/BiGvXWti1bz0XjKMukK
 SiXerIXe0Eui7uQR5tw==
X-Proofpoint-ORIG-GUID: fNPTQh5-Ecah-kbjaH03a7Uiu_3pfruX
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d94a1 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=nYxCwpw-O1B6azs0dq8A:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200106

Add PCI device ID 17cb:1103 (Qualcomm QCA2066/QCNFA765) to the M.2
serdev ID table, mapping it to the qcom,qca2066-bt compatible string.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index efeb25ba9c79e20fc8bc8354def8ae423d0f2f2e..f90df88c663985c7702c19911f0c147e3b68984b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
 	{ } /* Sentinel */
 };
 

-- 
2.34.1

