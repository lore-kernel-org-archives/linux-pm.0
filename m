Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B75390222
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115561; cv=none; b=npyfv/UwjPPmqfy9hCWrJXE53E1wU0oLQHk0yDi+7Ax3ts+TxQBr8EyAp6CPhwLzzH07TKRVTcbkZHcGlbDVI0s9Y5zDLNF5O4PaTL+43l5NAPZsGwsysmwPkR0GFv5xs2zTjrgOewbDWl+wpfj8EuMV9UHEz+LSo0NwS9S6f2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115561; c=relaxed/simple;
	bh=3DJMMCrgCSKDouR5F/hK4CUhTjXeO5GrMSVZMpdPbvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCx6gBGc31V/hfyecy3yUNLbdqHPmUgd9GwGjidODEErOjUYBRSgSCjMq6f+LWsJbVSPrReNfgpVoI61rRULAScjAEST54UUOwgThc5ydusJjB+7zN5NeASWodo5Xn21+KYLBoTS7nfYc6sAM0da3bW4X5DHiniaPe6gTDUGOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CPWwrI8c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BjsjBw7X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPWwrI8c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BjsjBw7X"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59FWY2427856
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=; b=CPWwrI8cHcSZdT0s
	GuGLYjQnrYOShZXZL5uj+aZ8PPNsiN3R7Wm2tQuEhuWBbrIIgNjNABkMCSP7VUm9
	kQj0UGMQnvJse3rUQs8K9a9MtQYkFvFddGkHsk/fCkdrrM2Nmvgd80poTTloEoBZ
	5pIuFn/RlLxBMagIOL9kHFDBKbO76FjkpkiipEN2FToQVIVZ6OPjtgYyyJemMgDL
	s+H0TYZlFIblsim7RHfCNF3cyXhnpaO8MCgT/C6IkQKlSMzP01+6jJ6tvbNUBk6v
	t17GqYpOBTyR4qS1t3bC1GGgjWIhT5c5O8oKfcN+j1oN6XLJVmgmZrLY9oFpXXli
	5b3nOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhtsdg75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:59 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157db42dd8so873341385a.2
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782115558; x=1782720358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=;
        b=BjsjBw7XDSSyoHtX+fDP8DAoE5TTk8pNvVPnsLR90e8b/NvohwEjweJrQUZjWqvRxf
         9ev90YOzToJWyKMI7BWCabP3wX77jaXHVwJPZnutcJombCzqWwrtTGSj9SR7MZcIEmod
         746+sHq3Ct2mmxNwIT4qHRj8ZUidT/ZuLMZSp6Fr9wCk+RwdFUoiz1/MgtWhSPTZ13rh
         QGOx6zWhmdYt9bC55sd33UmaZe9egDt9CTOCrnlIYv+NmTjVcUBE9Ci+K8ORldolMxDp
         0NuWvSKnzFQ/Nar+ahLwZ395t9RqF0/sQ30iGm3Rph1yjJFsrqO2aSILF1YH8xzYsbMH
         B/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115558; x=1782720358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9y8LDW4Y35Y8sO3NwaOEa7mBH+iPx+dPxyNYY5yZOPQ=;
        b=hfJTt6huCHjisPkJmiVwXq6mKsC0vnxqtn3mwT1d3WXAJsIUByqj1X5LxSsSNTaruo
         vAEOW0hfyq/tdST47jfxnVEc+H5RmI1HMv489yFqkpE6QCBS4vmEgORzvdPURdJXEozm
         7+K+paBJOOuWDdqLcgTF44Oif/9CltN4S00yYfhGfWJJDnNi/HQexEi+roW8jqmWPqdP
         fcdTSTgXYJ93wi5SWgc565lRfg16aI369+5lcECV3EntvXT95GTFXALFaky61IkcDGbB
         6Calz8f4ueOhHTtYiGMsatE/e5VQjSZS2I02BN/pCRgb/OiOZ0PSvOl3syQzgaHf1fqP
         nVSw==
X-Forwarded-Encrypted: i=1; AFNElJ99/XBdFyJo7OktaqcdFw+B6rlyCWqJKedaSMlmIXVeWwAptsmqoSW5LocwJ6LQBuknDxbik9MEOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNN8wAzTZ5X770CegGpU5yVn+pCiNRXnyzEVu0xC7tP3gBN1U
	i74UV8KNOk8OKV6Df1qH2ZoV6joLu1gFHOdCv69/V8Jvi0VNnMnRvfMg6Px56psD5cuSBrFRyfc
	cnPcRx6vXxsJH9scjhPSeQLgjLz0ouNb3PL1MpsqEvDi5EBVKflcQEsop7J5Z1A==
X-Gm-Gg: AfdE7ckM1Ysb/D7Gr7Yk0tzxqdw0Iyc9/kFAXW1J1eSVeB6ns1+6sny3RHXcQoh88mU
	LYtarg/jDgyhzTWM4E4LsmZwOqHwCSQLvnIrBY/XileNgzwbOJ6f0KygOxwT8Naj+3FKMLM45uL
	5JQvCuBprA78zRi3OYU7hcutCNykeUKBqwRN75h5feYt8cI5/WtfwRRimSydtplZYxU6c+FfgEZ
	O+Lu4FVa0mmPrm+uOFlGPM31UvLM8kftmAghihqH2qpQQK5fWZadXc456GTXBdkZknWEz6+BX+N
	cZX/R6TYUoSrqO7Jb84brsHy7y6vr3oFxBnJD9Jgje7sZAAlB2kTVhvA4ObQKpAWQM5VvlqCMGH
	UuCqJd/n1Yo+6jIgJjEikiP8i2UF5wtLBCwf/x3I=
X-Received: by 2002:a05:620a:6842:b0:8cf:c513:349c with SMTP id af79cd13be357-9208f16113fmr2075603685a.9.1782115558148;
        Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
X-Received: by 2002:a05:620a:6842:b0:8cf:c513:349c with SMTP id af79cd13be357-9208f16113fmr2075601085a.9.1782115557737;
        Mon, 22 Jun 2026 01:05:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24040371f8f.23.2026.06.22.01.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:05:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: brgl@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
Date: Mon, 22 Jun 2026 10:05:50 +0200
Message-ID: <178211554547.11059.13980488492227504298.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616151049.1705503-1-vulab@iscas.ac.cn>
References: <20260616151049.1705503-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8sRzo4vLAIS_n5Pll_8eOrLtGoq6hwK8
X-Proofpoint-ORIG-GUID: 8sRzo4vLAIS_n5Pll_8eOrLtGoq6hwK8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX4UXw1mO5515F
 zkioX//3EnPu7Ssw+87q2TaEuzJ3g/NvCddd3j1c7FvDHBUn2u+gVK+tCqbPdoqr9yejzIoij0x
 KZ123HBuuw2xglAktMyDvhY15cd2DMPUbToE0jww4neJgnzCHVjtjXJ/IY4vkSzLZDjJlIpeYNo
 Jvrh8xUh0yOVZt1R2cRkFh/SJBDwiCxLqnlgQh8vWi1A1PSj7g4T3Bjg04LJ5+AB1U1G85QuWAu
 /Ok++AVZtBSRrvAHKygaSd/h/368+59JdaDcPgRq3Wgyoxp07YW6CWnCkHhiXBW7+I2rKWSG2oL
 kflhFHkOWrV/E7MTn9KXuKX08MfUyO8wsAxCJiMjW2iDO/SK/3Wd0nk80h4zBfSZ/NMf+Qv2LDz
 pagreI3ey4Q+5e1z8Y/IAT0ERRPBGVsrx5opebu9BpjFsf1Pff9shpkJcKX0Q1MxA6q+cRciOBr
 +kXAmOqsaioEsa5zm4w==
X-Authority-Analysis: v=2.4 cv=bcRbluPB c=1 sm=1 tr=0 ts=6a38ece7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_NzQ_ZF5m_U5icpug6UA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX6N7fgBobNU4/
 a91H73nWBNAFpkoHOkD5Bul2pIyASG/Plc0HLfJX4/PnEV5W39R7Z7za0CPvhOlAH0PLTEI8CEY
 0hHRwSyXjacpGKpC7WXLHGrVQeN3jjk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078


On Tue, 16 Jun 2026 15:10:49 +0000, Wentao Liang wrote:
> pwrseq_debugfs_seq_next() declares 'next' with __free(put_device),
> which causes put_device() to be called on the returned pointer when
> the variable goes out of scope.  This results in a use-after-free
> since the seq_file framework receives a pointer whose reference has
> already been dropped.
> 
> Simply removing __free(put_device) would fix the UAF but would leak
> the reference acquired by bus_find_next_device(), as stop() only
> calls up_read(&pwrseq_sem) and never releases the device reference.
> 
> [...]

Applied, thanks!

[1/1] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
      https://git.kernel.org/brgl/c/257595adf9dac15ae1edd9d07753fbc576a7583d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
