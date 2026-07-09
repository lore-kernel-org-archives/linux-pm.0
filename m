Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D73DFC8F
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582197; cv=none; b=a6kF+9MVoZ9CLAHgr7B5MIhbtGaV/mTrgPyOt7NkBWIlaiuDmquu8cFrY8/LDIJWWyjnBwrSuxjjhe4TXnvq/nCXW2NFNVkdeZm2IoP8DaCSwhoL/4HF6JrYLdULUNhfYZlOshqnmADDkfqp76UUX9gZFzSsJw2xQEf8/8tO45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582197; c=relaxed/simple;
	bh=OyZcDfisQ7Y03Tga3N3GCuQdIV0fLv/dNHzOc2IqdHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddcReXDTNSzJH0wf8BSux3dtP/xVnZVvBhWW6XIlcpAN+EO0oqbgG43iydWdrwUmDgOYHQRXMOTG23zqv6hDjGPA0GZDjwrPcy4huAUZge9y2tNaQRwzGRbiUsoNe38G4H2iTnTVx0lg8PMFSWg7/g64rAkxryPZief7tncmwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PM6OnJot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFb68wOu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PM6OnJot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFb68wOu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960bOl837507
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SAIWzkhO1FLpQ+i7r/tKtt/ZcJ0vBvJSb0SWQVnfJ8=; b=PM6OnJot10VdgJ6L
	E5QcPHu1V0QlIzMIHYiKkbhLh2YD5CAdBlZZaf835fckTm4pQIzNR3rzEgKNWxz7
	putFCodKHEF1VeuQKP717iVxflN/xT+5lYPoUMUY0Y3KJQ478osl3L0V8BJL6Idm
	CuqlGNv1viLA08sqjM8gg3HgA5agNG9qEfZTzE8I+NvbbEfJIiV9Sv+6OGLSPfu9
	HRSqsCUhW0kVUuuSqSz5EguB4vkIJ9vYg/71xTAjK9JvJF2srGv4lz0exkQE10YU
	zWf9fmWlFaqrTVMdoFBoSiLJfQRPoQD/OSrNlEwZX77CbZniAoCtlDECqv/9VMuM
	+wvcCA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwax35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:29:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84832baac02so424225b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582194; x=1784186994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SAIWzkhO1FLpQ+i7r/tKtt/ZcJ0vBvJSb0SWQVnfJ8=;
        b=QFb68wOunuamu1vfWF1gzTLC+G8XAlOby8jYccB0U36S+QQAPwT4a33495+0utO07K
         hyc/RhbSC0mSpjTqqwgGA98dhA2pK6wdB9Gw/JFRMvETkEE70sj4EXUT0axbjx2ye6kF
         M3O7NQMEhQ6EBcxRxUbSh9Xy1lIOU5Yj2iWInrJo3Bml0IM+1ZENWYWIWDI8HMBvR72r
         LWfBfAAP5rV1BzBAXJJAoUEacJ9rTNPMikuPkHsLImNlmOSXXwOM5pHs7xTI1gF1ed6+
         1cKW6iXjkOHiU3K6SPpXV12rJ9xFrqYWly/Lcp5I8DiZzwBClwIgSpR8EcECvwZAd22c
         /5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582194; x=1784186994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SAIWzkhO1FLpQ+i7r/tKtt/ZcJ0vBvJSb0SWQVnfJ8=;
        b=QFrqjo7AjUc0nNMz8WiBLQPqkq/IR/gOpsTEiTEWjzuG1J0CcIpqovoykAeCuITbv0
         eNewsVxgD9YRY0zEJgDDPUhtFH2OS/c/SQcJQGFcxkIEH2kzd4N96d8cUz34piWFScNH
         dF9spS5QecbJ6lQtFFJ9DsuLnd00ztiXp2Jc/wl7kbcdvcaZ6BQJd1tVhtAEqqAgplw2
         Gb9/qvnofsR3gQP2vnqSb5RNVmgMRIIOIYV+v2nbwPjgE5odE0wg7Pig1a3bbWDUou/M
         L/IfI/ulWaxry3H9ZZ8w82Nhh11wzVh/ydCodTx4nElFsRdHbFiXd/pKrHKIT7N6Ccun
         a6dQ==
X-Forwarded-Encrypted: i=1; AHgh+RpiNnZIJrJ4U7bbJD2LV1o1zZw9+kkAk63a/MexwNLAZ2OR9xhVCNQVjEeBEqqVMLAJNSwQnNGfOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPRfVUfkObkQm9boVHAbDhIOU5MX7Bgu+lWZ5ZBhM7h/7zHv+
	wGpbFSDipvusdhXwx59ZZELBbWMnuL017SVngegkhTJlSE471KOQPZrCzyB2qABUgVB1/9ayCsk
	dBCMB+NK9OCTNztW0dP+PUPCRR2EAZddCHHw7sowA4ejD7s62+sdKTHiX8kiQ0Q==
X-Gm-Gg: AfdE7cmevijnAcPwGVTKnc47mf4WRSIIuOuqj10WOwPfigyXauGTFa3cqPiLNslj0aC
	93GZb0bKvyHcWmv8iiE1zSrlnkIOE6Qr6BPa9lmL8UV8ve8y0yXpxGotw1UdetG8W+7OCBPeTRa
	DBBHPwx/MOjQYVEU73cS5uzE+XHT/pMcCYSDpI5MBFmfCI/Tp8vKhGhLXclZ6eHLi3b+86Ong3j
	Wvw/QGzfR7ujSEd/rgWi1GnPdT5hnhoM8Gl7ojir1WfU+VRWVytLCEyHm/WdkcDdGOHS4Vbh3Rm
	bRi5Y+himmOo/LtqdrZo2Vb1cNKLS/JPFtPvSVmYzHBZ7A5iea47oD0gn3wJaVuCFblwhhWkSwX
	HYUg431blYerdeFTg1CfIpnAj844f3hzwS/dZUl2ngKhOSwUXtOdK0cNCTOVTXA==
X-Received: by 2002:a05:6a00:17a0:b0:845:e40b:dd58 with SMTP id d2e1a72fcca58-84856048ed2mr1603265b3a.7.1783582193873;
        Thu, 09 Jul 2026 00:29:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a0:b0:845:e40b:dd58 with SMTP id d2e1a72fcca58-84856048ed2mr1603245b3a.7.1783582193462;
        Thu, 09 Jul 2026 00:29:53 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8167222b3a.38.2026.07.09.00.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:29:53 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 12:59:41 +0530
Subject: [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        mengshi.wu@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfX1JolpULy/bIU
 8ff4slkCnUfq/nTzl6S4ZnM4tsmQXMxK2ith0vHwCmjMrd+es46hCNTtJMznKmKR+7tr9Eg4Ey/
 pCXOWJM8OFreEpNzuTnU3gtrCRQ8fCNkvX1NTnrIQy/4rJgCHvr+LuDCFFv70H1o36lumJeLo/U
 GIUG7pQ5rD16h43nM+MjtjmiXsP7zvFunwRcli45lFkEKUVSOAzJj2oVjuUMH5a9c0sa/p7R+Uv
 mWxz/Ff7/uDZiJb13hQhSCssYp4WR+s7nWEco41qpBSyR4feFi+8LpYgNNNRsPiQ5aBGV21Jm8w
 eR6rCOEe8RLbBHRv8AIpb0FOAVVHYY+s/6JQcFeMHi/Wc/ZNFyQJYBUQhwwSgap7yospFHt0Jfs
 bxsiBYmOO+iDKA/r4A+pOjnZZdKp7uU6pHq4yURczbKbq3H7qp4Rmi040AexKWLFkLN8UkGUub1
 3LZdjDVgKNT87q6ShxA==
X-Proofpoint-GUID: 0QAXGovjwN68DAIdPCV6UzxqREfXdTgl
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f4df2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=718rDa6z-us7KMpumiEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 0QAXGovjwN68DAIdPCV6UzxqREfXdTgl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfXxzXD8XIi0Vdv
 SSfdRZqYF1ZEedbEG25HLsFZTENrElXOhQBY7KP4rpleoHp9C8PdOVvYyoMhJwaBvYV4feF4JVe
 A9N6cuRAJlHklkKTFkt6EPDXIPGf/UI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090069

The WCN6855 and WCN7851 combo chips are available in M.2 card variants
that differ by their BT interface: some expose BT over UART while others
expose BT over USB. Both variants use the same PCIe device ID for the
WiFi interface, distinguished only by their sub-system device ID.

The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
USB variants hit the same table entry and trigger UART serdev creation.
For USB variants this is wrong — there is no UART BT interface on such
a card, and the serdev probe will fail.

Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
their respective sub-system IDs. USB variants no longer match the table
and will be handled separately to deassert W_DISABLE2# for USB BT
enumeration.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..cf51122d54fd 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -191,9 +191,11 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
 	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
 	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },

-- 
2.34.1

