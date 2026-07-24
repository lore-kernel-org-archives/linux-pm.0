Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B26427FB8
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896612; cv=none; b=XMV0/2XQdQE00oXpJx2Elw8ayZlF7bIbNX2TOOBGbD0lsVCiXPFlPS3kykyyhE8REUfNL2octzeSrWqw8V7rUO29Mz6N6vLC5nBRYJDXGPkjwDfJUtKRPiyyzuuE8mrZXfFGK+dyzKnMcZilCyTRC25qG2zPQMvv9bLrK7dzCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896612; c=relaxed/simple;
	bh=On+U5sZtQGZNC7xrtx/ie3LGSZMOmGdCwE+QOb/ojPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj1+f3KMZmOmZLseLrEEKX4d4HOlmRVWfhaDZo9i1LwqX/FFnSCyzKE1wC4qT000nQL/RyyW/BIekGleLGACQppUjP5F9fHEpPzqj37Ya177D1pqWauAasK+Jcjy07o9OfumHW2q7Iwa7Llhx5o2RR3q7MrRr8DYCqoKSyMgU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gXFf62Ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaBb9PF/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gXFf62Ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaBb9PF/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OADXwH2478948
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 12:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=; b=gXFf62RihZMqBFZY
	k4N/Dwyqh9EkAXu2BiRRyysuQ95dvtSl8Vssl+btmtCc0X28nmUc/9lnxZVFxx/r
	vOL2R2+xTakZjyHij+Dx1Jo1K3qWE8TkBZhjdTfwCHGR5K4naZa8lx1UcvL5kcKB
	j5GLbe5nRSDw/E6lZqh5TxzeoLQfy/mucQvS3qxIkDulfXM01l1pVD8YNEE/g2Ez
	X6VgsBepnXFmcvw38Mqn+IhVfsv7Ryn2mCHkc3To2G6LYuCUcBntfqBvGve4ma2S
	y2nCZrz4VWM3FzbMViXq3oHoDbI1RB/YLPlQ8KCbJAuhbCpyJ0+JQCTgSG/uzCRr
	gmXy3Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm2cx9ewk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 12:36:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52827090cc5so7017081cf.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 05:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784896608; x=1785501408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=;
        b=RaBb9PF/CrWsa+nYNvYffzmRdVkY1BunTJh0SR0K0eQj4QZX4XCtbDSF2lx/avai9s
         gYx2/g5HPM0UjyMVE1OXeQRHrLCDqSSbWRX/HGj+rqNOAQmQtGkC81kXQ8EoBHXQ8dMj
         xnPIL00hcgndNeCTdG1qBVSRpJwMzO8eNRa1En5Fz5ahC3TQ/mqcVBthzvxKrjPBGJyQ
         lNDK2xWzQZ3lexObmObLz42XRa3emp7xmLboFjGV7ivYbHyi3hnP+I/Gu2yU0psaAS2I
         +3TmKaaJL125ZB9w8buOOpIZC63d3vSKtb4JS4drjlacg8D+F/EYgouLjr3pk/LrxM5A
         P40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896608; x=1785501408;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ef+wpAo9/ud8vszxpOpil4lSBTQBiQbjcVY9DMcRtk=;
        b=aRucere+QQ5et3F9eWri7AILg4fkPg+zhD5Y/Xakfcn3TQh6BG3PfOk5VHI6zHMNUp
         ZbrJ2jK2d71EcJTE23wF8cKgF3pgbNzHYigPCsg514Oaf7ToIfcwE+L4IltHedwibwXC
         KABtbedjsxllERsPIAZM4Z/0yXWFN9xBXf/AC7CiLbw4ir4ztif/JQn6Vv5FvbgtQzOh
         GQ4tmsobc8NIr3e5hFjAJy09pgtcFH+fOigZldST9U2kYxMAhx3p0TQBV8Jb+TBK1tX4
         zEsP+qpHSIxH4PWQyOmGvNwJRpXNgTSHSvweXdXlP5LoHl9I3hs3VP7PAmZFoaP1Rs28
         zi7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqTWkZidDb326X0U7G9wwxn1AM7REMikCx5dHc39/ec7o15QF997g6BdVqpCsyNMTQ4RDlcsAWIjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkXNW5EEmwM1RewQPlUofDnSYLOvrJg7rVhLMKKwnzEMn4luK
	gMQc4FhKWc3VvkOlR5xjJXdDltAS2/gAklzkjmPHL8GNKJCuXN9eSOAMRoTUxBwdzI8sHG1Z27x
	2D6vbeY0UG8UmoiVmr3gR+Tx33DFYZqAApNuuCPT84z9oabfgYRUemJXQQAXNAw==
X-Gm-Gg: AR+sD10TOzViigLyRb1poTsZ5xOmRXxyFqNtkW6/nIT2oandSkN3zI7eNexW1nOY8b1
	H1pki2ZeVaomagn8mTQsj73YWPzkEpGaOLwWA+Q/IyeQCpiRL5kryi7U090SAQe/TNLEEU2FFiy
	pGf3Tx6gt+ujGgP/SbF4rIu9/0NEW6zZ4G5/rEBHXD+mAq9HOA5kCIUU0dFuWJOyTQBnMNv3my4
	vS2W2p6I0lXuxnoW1VyMx67+GuYDSaDpDaOxwJrp+0d9MwfdGhEVKnr2eDizY+EACZ1k0APyvoO
	5ZotcyBQuBSEDtimQSNs7N9g68X01hlPrWtIZVG+bG9GBaORtoYvGyxymzWiB88nZq7Fv8wH+Kr
	VAoI0li3P3jvRI+J0qbN3irM4rLE=
X-Received: by 2002:ac8:7d16:0:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-5295d2d9bc2mr4467571cf.13.1784896608224;
        Fri, 24 Jul 2026 05:36:48 -0700 (PDT)
X-Received: by 2002:ac8:7d16:0:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-5295d2d9bc2mr4467221cf.13.1784896607776;
        Fri, 24 Jul 2026 05:36:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4034:92c:3896:182c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bffc501sm38898115e9.4.2026.07.24.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:36:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
Date: Fri, 24 Jul 2026 14:36:44 +0200
Message-ID: <178489660241.15691.2530971556020227133.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
References: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pttlX7XovfT0MK9ShSOEmMzLlT1RfjmW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNCBTYWx0ZWRfX0xkHWaUNrSqw
 koDiDf5EFpk50s21JKdoJkfMy4ICM7qcBbCXR+c1pSGhsH0MdJozabw/TY1DZmjFCBN89gFWXXZ
 9iOndE6vn/sTAmjobf1TqSfTZTSXQQh1s0b9JI+aJRHHKqER5zTjSNw32ctjGV6gNIvqXvp9mcU
 a+uotgWEudWtiyy47Mw9hnuhZyDqj2Yk/JPkr3YIxMaoB4D14WNm2jVIfEwM94pzzCWMC2V5+oW
 ovu8FfvW1O4l6gJWh9ExeOZXBvsqh2VfW8NCHK9nJ/agfs+/toCJ60Jn9jBJ0xwwhj8P1V4b47W
 ft54ucYUGE75/pFXwc2gt8yehzueP1xAH+qJIar1Y+XpD+QFzJm11ksxVNQmzU1ZRvHOphwA9Qn
 20GbMgd17n/78AWrNk0Jsq7quXzuZVdj0acttFXS9Zfnqwt/EX8HBvLyZ62OyScA9aTAmtCeuwg
 9yVRTrQneFAC6gKZj+w==
X-Authority-Analysis: v=2.4 cv=X51i7mTe c=1 sm=1 tr=0 ts=6a635c61 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sM1ioMSF0laoeU0cyGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zgiPjhLxNE0A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: pttlX7XovfT0MK9ShSOEmMzLlT1RfjmW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNCBTYWx0ZWRfX9VDycd6q2/lM
 bfVFmR1c+JIHBXymKER2WUbgIM6uJunXZc75dQ/WeCm9kqJUO8aOVsbl29SXyMhDmdPGYP0tb0f
 O5oM3weE1vKP+wfAoiMCFpKRH7IScyM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240114


On Fri, 24 Jul 2026 13:51:56 +0530, Wei Deng wrote:
> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
> 
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong — there is no UART BT interface on such
> a card, and the serdev probe will fail.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
      https://git.kernel.org/brgl/c/a39ac4651e3b9d2ca78b6d3dc2a81a6bd25fa616

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
