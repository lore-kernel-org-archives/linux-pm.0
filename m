Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4605592E8
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958517; cv=none; b=BQb4RDprXA4zBObgqU+rM8YS6/GD7BMnACBRf7CpXrgvs28xxIFPkF6rkCBB0pFRnWf5IVkAsJymLP0mabFo6TKL/qgUavkvax5odTYfvdGfBS1Lv+ZlRD65cZdKQm4HjJQ7w/1S5MfBjVFXj6dRyhpj7z9i4Z7eDUD/8P0LZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958517; c=relaxed/simple;
	bh=7TBSuHy5oRrJQVVuqdv6lsELHPKVcaY4yxj5xAtDUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acHaGq3tXaDcYFjWD73LZf9ET4Yp+vzun3Ja7lMhpjCV8lYDi+X1PYdKy0VhdfkNC7suoi/nc0B0kK73F8NYx1JtLDVDljDujqdMSc0wgEKq0fjf8qQLpFxj/5mkn2p/bluBnZjP4D1TW4/hClyK6g0G0SEPM4a0EAF1Tm4SKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWF2Q6pF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XXU3gHTV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWF2Q6pF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXU3gHTV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU4ns1183704
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 12:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=; b=XWF2Q6pFiI8nVG/b
	zSHzCWhm2p7A0JOkmKiYSs/ozFkb2G8Y3EWVn3DbKxhL57A+J/QLKXTZ0qWwsaD1
	PFZa7b1p8Iqo9agHznTq3UzrGIuDMFGRtdtCB8JPeVCgqhahWJ+ZknLGguAU4lOD
	cTrbgXHj57W8BuT2hMhyO6gHaEBsdKcjcnzQTv+8OxJ1ba9fBYLqEaBwGiQL6W5v
	Oai3mhzJDli9cV9nyAxepgEkEZDY+m9bpOxOxtd3v/XSnyt7I5yUwBSdcFZNhdz7
	i6yUJaHvvyYpM0RiyVEeUCiH7Ag8FqRFNbRLrV4ID0cTfpf47s6mGzU5iBAcO1Bn
	1QS2nw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559rnpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:55:13 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-980a896f53eso3231672241.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788958513; x=1789563313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=;
        b=XXU3gHTVicE2VP1Qv6AeXzbayoN9zca3/X3TZoqLWzV1eq6rVYvRLzjAGfpDE46AyU
         YfYlFY+gLEyd4Qbq99UXozK6es6o9MketAgt2ZQtbRKyKlK4qIyquvayV6QpG1ZfZwWP
         imrvUFd7dAHO0s3EfmoBL8FoVkT+d3YoxnuQ1Gaqfy0M2QkWNXXHbkXZSC60FLB6P2Yf
         7FjCx4GvziuuyNXbAvWn+Of4th5DMwg5lohEeCNUdJJ7a28TOsrdWNBn91jqUkZD3wG3
         WZfN0Up6O3Z5j3AOb51qOGCXVOcHynVM5xEhklQJU0K7CDHIUP6DMWElSIcxtAJEwFws
         1fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788958513; x=1789563313;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xp0l+FccINUxiHaMdx+4yzVfFMtmM60z+5A5uiSZ3jM=;
        b=EYLCIOTGe7HIckPd4wPZG4h59y5lCA0gIWTk67E6XSk+HlSFrGzENCOPeyGYG45vcf
         26Oa1ld0mBYtwkKGyUDmEeMpyjY2scQ19DUYzjwgCVc0FmSbLuA8djeHoqlrv2E7ewYS
         WW8xP99BDFKJnXfTgdGw4VBvCNmnTWPnvSBCJ7F2bo9x7625WAHrf2UlRaG0mGNqW3yw
         I3AGVZS+MLruzFHSFrwVFM9AfdVXL5kVEkeJs+jHq2zEIonDXgxgHGzKVf+b2cu3w0Wd
         CNsDvjqXFSPfER6439wvvOgE8MLQW51R2Fow0QWbvkPv9aUBsXNQr6IaDoiDJB5GQGK1
         PN4g==
X-Forwarded-Encrypted: i=1; AKwUvBxGFB6lNIjBCcekr5tXay8bRSpUx8EwB+/7wM1k1Kxc7ieUqSC0FyO5NSz/XA5grXwaylKvnyoBMg==@vger.kernel.org
X-Gm-Message-State: AFuF++kr3kMAdzaLPt9cGX8fbmzWpv1+zQ49R9MCr+pGP9rwqO9efrqt
	sQWitTxeLfJg1ChHBOvHmzkl1o82jwF0/Zmpp2AXjLes18RbDrNBHvbIKGWZnwh/Q2sYGmjytwo
	0v5eDCnz6wZcZSwb4s4VemqqpyKkAIasu5n5IAI/44cJcsQkGqD+47BqhQaBWd5MtJBnkxw==
X-Gm-Gg: AYBFou0G+5gfWzUDjaYrejczJAUWMcHBsaFc1GWg7X/xfq6M040K45owT+Dv5PDO46w
	viZvtJel+d8TwEIn23HO56aPHJ03+9WIPg1n80Y9WsyUzsAaq8sRFeaG3URIQ0Z3zp4KHaKS0gK
	GrvA2KMOCxZ3cZPTgglVZAtx/X2eI2EVmjcLUzed9idEt/sO8YC/86y/guzCYIbUyhcfLi0H9RC
	Xy400WIf3MGrSgy2DEesl73/IS9HDT86jwtQ7X7Xg4uukaayEQaM2BmTSrz33WHGY1JmvAFNHNH
	HjlypbmPXLtKpXK5DLFTQB66D4ycaPxsBfv+2xdStP1PRjFQdL7hIoY8Er9rhSM5IuGakIUr21a
	68pi8cs8+pkGH6W5pYmwu2z0hxBY=
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr17098742137.6.1788958513374;
        Wed, 09 Sep 2026 05:55:13 -0700 (PDT)
X-Received: by 2002:a05:6102:5e91:b0:784:b882:9567 with SMTP id ada2fe7eead31-78a4a9d9306mr17098714137.6.1788958512927;
        Wed, 09 Sep 2026 05:55:12 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm43616140f8f.14.2026.09.09.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:55:12 -0700 (PDT)
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
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Support PCIe switch topologies
Date: Wed,  9 Sep 2026 14:55:09 +0200
Message-ID: <178895850666.30743.6753366946500476857.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
References: <20260907122129.1577279-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa15732 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iDry_tSsOD4vq6Ch1OYA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: 1Guun1gzOgxdMkCcXU7-WEKXRytZ69Jz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0NCBTYWx0ZWRfX13l24eSNzhNq
 sC6I9ou6HeduyjIA5U5/SUbftPyHx4WF3NTuRbtbYSFwI3uL39atMHQ1/sOSQsIGJ2rYPm46hVg
 bS03NoM8Cj+P6IWFPncfU87C0n9bGzI=
X-Proofpoint-GUID: 1Guun1gzOgxdMkCcXU7-WEKXRytZ69Jz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0NCBTYWx0ZWRfX0qYYD1fYJH8K
 uzCT+SWb5+SnCPY3/pHqKwo+TNM/z8LyM3F8EKdGVUxz6HVBujz0IbU7+LKdkfQ9duq8LbTqJKl
 1eVF+kkQuIci1gl0K9aZlnzUzFe6XewUA8ZaP1INOCEEVtCfJ5JEcal5uYQIYWVAvqn5o2aBYGF
 DL6EFOfLk5+7WYUXDthJt6g/IhMF22//G9hL2HA+FKTQIPoeISPRhQZg67Wm/VTfLBJ+rLOgiXv
 aRQTfwAT/JFjQcfoLsjM6iPLuBM3NgMQZA/Jpi8TXt7C6nzskvQJEtC19vLR+No4J5ea1wNraqq
 gJTpbIMV7F99ZR4aCXDBKO50CDLeLVt4p7pPoYCk8cGwb2WEAJJUOAcYyae1YxX0A6Dx0kPCHcH
 PvxgZNp5rQj5m2TElby7CNf1RsB4D/r3mwaxP1A+rfINBcdTA5RBBWC2Y4O9ABbELrPLURBO1y1
 /gfGd1YDy4AN5o3gA8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090144


On Mon, 07 Sep 2026 17:51:29 +0530, Wei Deng wrote:
> The PCI parent OF node check in pwrseq_pcie_m2_notify() and
> pwrseq_pcie_m2_create_serdev() only looks at the immediate parent of the
> PCI endpoint device. This fails when a PCIe switch inserts one or more
> intermediate bridges between the root port and the endpoint.
> 
> For example, on lemans-evk with IFP Mezzanine board, the Toshiba TC9562
> PCIe switch creates two bridge devices (upstream and downstream ports)
> without OF nodes, so the WCN6855 BT device appears at depth 3 and its
> immediate parent has of_node=NULL.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pwrseq-pcie-m2: Support PCIe switch topologies
      https://git.kernel.org/brgl/c/935ecc5c86c5ae2693b2fbff83fc1bd086a9c915

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
