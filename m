Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286E3ABD98
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578601; cv=none; b=BtoDKxSGnxiPMxIDP8Cv8M5T0xFimsu9dKzgoX9KyLvB4Z60er2XaVxbE/HgULKaNKiKCDgG23XXf2vA0hf3MVV3Xohs4+R0moc7ixBLdbxOsMtFrFu3A8R2F9j7OQuCjaJN2wDuyXJgHAVXQsao5n9FVOEZy2TI9iZbAmAe9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578601; c=relaxed/simple;
	bh=dRdbHwD0Hrrdp0c4gtwcp4PWR0mHfX7lHE/RwCL+5wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrNz3et61LOzdCkA4ZMdD0/jFxlcqM2eeTh50c6GfNPbEnZg0NbB1wp1UnfhcIUYW4AUtv+G5aJye1pgd1Co6J64DLecchKfY503kG9QYMZh3aiKFjE2N3bS0lNflVS9o1cK5xQ4sG9w6XKpRmrlvnXtNK91wL0vd8v7QEIvzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sr7hlphR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dOWb57FO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sr7hlphR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOWb57FO"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xg6U1746053
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 02:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vl5jutfVhvm
	E1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=; b=Sr7hlphRNJftrgiZGYM+USTj2AE
	Cpb9P0G7H66y3b9SUptmFIhkrnVFig63u6kq14kQEy12mhS+ONXE6BEvzBVgGc0W
	/1dMGJLL0984Kk2jj+tKtJov2rKVdYD+cwls5laUSyBNP3fDEvjx79VWkfyFaKC7
	BQ3aFfEyAUXBbiNGhuljVoKg+plcXPhITJyQ3qEjk+5/m3LXGS3QDQfjO8NIWizB
	bgdjNL2Z1ZimIjzTPe37MHORu2jze44R5rn1T0X8UGiteGhLQD2jjvHYvS7Vph/5
	lYLlt8dXIs1iTJZh1YUugXkjFMGGmDPNTiWM/Fg1angWoUizxFINcuHfgLw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter049w7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 02:56:39 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30b7fe4d3f8so307045eec.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781578599; x=1782183399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vl5jutfVhvmE1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=;
        b=dOWb57FOGIul+gpT7pd3rYiPWFsgt1JkWsjRb8GklHg3iNNC/jnlH2nBFQSp4PRSWk
         /U/lGNUwDtxHUuuqrTWBm74Fds32P8vtSwz3hP7+CABNYDZF5gdQytxHy+YRM8NpFPNn
         zaGVt284DwIK0lTJcsLKGHdP/gyVZZIKcFF9mt2U8fE9RXTGpsvfZ6WVgC1as9XEEnK+
         f83d3K8NhXRtyMo1vil77WK6U991brmVf3exQjWbEisJ/XFOAsc7dqG1yv0Lmg123Zgk
         reFMeSJBrTaBfxw0Y/QViRw5rqvt3cM4fgwX7RYw90fqRZlcHvq9x4RcsAakqNXA/HjD
         4Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781578599; x=1782183399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vl5jutfVhvmE1lQtUR6YUJHSF2kbL7j9memnIYnr3u4=;
        b=r4DR7fHW8gqEWdbGKexK/6zodhVoJEESrUo0/pOQgEaSQ/u7zxQG3jMuDZmkuWGqCC
         l2u681KVboqGWJvJ11zMuGMNKJMGrvVWe5lD2tlbRp9X35MWnXlc+qrcJb+JmU+G+qDD
         RnSR33uM3/RQ3HosxeAyn1+KAuyxcXhXvteAO8lAPRLtLI/xFGIYEOB3HbmCZUbPEYUS
         A7tFToe7SDh2X058YuwQ98B+1nNWThoQAOEQgCPuHU5YPC8shUhzwHQ1jcObk0rUhJtk
         rPNd1ij1aq1tVAYZgVwdM4LaUJjfh5IzQiCLx0qkyrc6/Gkw6J3QpF08jqjLU+XapBop
         hIUw==
X-Forwarded-Encrypted: i=1; AFNElJ/sTdxEkpy1wpMOL0HR78XSe/frSG205q9bmCOab81qjN+wLlC6yAHkyM9xMzY95xlc0wPgN4BVTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1Kn7LT+T8ckNu6h8qUSEoslHzhBs4ZfdZckeq692K9fdKn8f
	qAu9Rst+SHvd6ZzubxnPvNqWwpOA6ks5aBIEDmv/DKuXpJqFeevrhj5VT7D7xvlL+II2VsSxL9p
	RSnJec+aVTt+R0SC57bXV4ltuhArj0saMK3tvdSYa4lYCaL7bf2rVVhDy1wKCfA==
X-Gm-Gg: Acq92OHupgusR9yhWonGgyQNeDwygx2a27iafixUe6Bq7Anpf+A1Jwj2kUGXl6FpHpc
	qsE2nj2Qf1iOmYAeQP4zP4udB01YeubmMmkB+uR24iTiWAFxNSISAk/FBEXh2AKyace3HWZ6/ef
	9T5r8FaLGKMb3ct2kqqQ6O35enVabUP1OEsF1UOAFSmBdW2+0hCvgcJq2OHG0LXjfmD7fQNuVT/
	Nq810Jb7Ap/QWlydF9jUv8Ny/0y458DfXMOZX4UIQ4qRRT98W/MesJAlzd+AHJJ1+Rx0On4Cshp
	m2TpQb3pZz67BmEOShmf9hqVFNS73/MJLBi7PaOcXn5CwFZQyaJeFo2G7u6z1VtGoleWFGOdZYz
	c0+aIrKi3tT+0bN9qOLxv9mjb+LC5EncjPntj4mkM+rlbTYXHPvhuEoTxe2dCRKuC+RJ63MLa
X-Received: by 2002:a05:693c:63c2:b0:30b:ab02:9e5d with SMTP id 5a478bee46e88-30bab02bea3mr164644eec.6.1781578598820;
        Mon, 15 Jun 2026 19:56:38 -0700 (PDT)
X-Received: by 2002:a05:693c:63c2:b0:30b:ab02:9e5d with SMTP id 5a478bee46e88-30bab02bea3mr164640eec.6.1781578598278;
        Mon, 15 Jun 2026 19:56:38 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm19050507eec.7.2026.06.15.19.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 19:56:37 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Tue, 16 Jun 2026 08:26:32 +0530
Message-Id: <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aTw6cKKdN55-nubDLT4StdFrwHgQUgMB
X-Proofpoint-GUID: aTw6cKKdN55-nubDLT4StdFrwHgQUgMB
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a30bb67 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=EF50nfIsKRdRTP-bws8A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfX4/OpeF8Nk/cd
 7S6ZukhBncr5UypamqmeTDZms08Pl4PM4NDtt58XeC5DJvvEAmGP9/DjKlglw7uNvWkaUZUusPb
 AkIGrIBbM3u3Osr7hg+UPjZt90eywYtiLjCjuu0bKCX1rJ/V/gJ+aHZLCoJAaM+GbNNrZ5fsicm
 jvJUlS4iofZaqTfyQyAJAmQaP03CNmxxqasUszOqvmW0IHXMzmUqNHAH7APou8WrezfTJN8geVR
 UNXn2dHu7KfiqO2B+iP98Bt1r6IwVBYUgZpUE9drlkECe0i9kYJZLKWPXV0xlBbX9kFjGsQpy/n
 7JKHBiBVmIRerxkLRoOYJuBRWzuvP2iVyskHPBmHRv8yzv8vinXwCrjVvwa/gSrNXpx4zddo9KC
 aRxEn2ZEAVm8+QNWsXjgCGEi4DPOAR1r9bvJtqzMhIYmK4NXGvuAFqicY9pb6yOo4mz9tV6rofg
 Q2xrPTKjHVkmjX+Id8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyNiBTYWx0ZWRfXzLQ/e5ijiG/4
 35VuIypGlEN3vNG1URJeQIRC6r5dlQgGHZ0gxaQpydO4bfCnGkVTHZYZhwSz5O0ClYPwuSw2nk0
 fbIX+WoM1UNsN1CqZXZ1WUMI5Ef1AIU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160026

Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
0x1103 (WCN6855) before 0x1107 (WCN7850).

Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth")
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 94c3f4b7ee36..b5ed80d03953 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,10 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

