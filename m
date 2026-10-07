Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783BD413230
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380065; cv=none; b=VEFd+GP6E+/WID+pi7JvlPpB6Nonixw4UubAmLLIDcfzAbnFqr8PGnxmzj58b6GKjgerGBsaiaqp6zVeCQYDP3VzD49JdjZnrcVp8xdggcQqm8DUwAn8YrrYs6PBdVazlkJDugxrs6WZ/+T6ABvYymL4AMthwuxV941x2Ijz/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380065; c=relaxed/simple;
	bh=J+Ry4cwzeCUVHqt0PFF643jrxb991egaVN/95KRrhGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKnw+OogugS7RWJkPVPzfYp9xjxxfulXK+jcAiNTFINcWxJlZ6zzg/kszzLT0LD+fdv9HhcmCK0e2y2Wt0ppUS2V3ci5rQAfqPt1G0HzpvBKS81Op4UY/PqlWmU5CWqjkRcEt1rtdJDYEnMu9ld4mdMXf/Bciwts6uus2/xRhEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VRIIwtD6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dfYB6Ui0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VRIIwtD6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dfYB6Ui0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BVN4u2364110
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 13:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lF50zyxySUMbpLVqNm3u6N8Uxl/mwFSB/O+gwZMjDSI=; b=VRIIwtD6+oDhGMUf
	sNIZltXXA1EXTqKxH8xFZvfvxYKGZ2aWM9C/Z6/6JDWyjTw8aQYARM5cFrCm58lB
	xVAweVG1Dvwu8bQ40WenwtoLru9chgdhOL5jU5XuKp6mIUXhe1BP21Uu/IA4Z74g
	bLTsJPQ0EU9JN3UtHF6CX33GoCZSNR34LaEPdU6MmXKo5+XYABLLYOCeP4aHlKuR
	UYFGj0LL5PmwezFwy198Lc+Ybei4asqtX9Z3460ebjlkgqRnxoSUC35KfkChS9mD
	va7NjMteIBMgnRP+EhX5WHoqYfm+ByAac41wjyQCh1FHrk9tQms3O8AI8A7/XVS2
	yLiPFg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8smb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 13:34:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e82060977so569185a.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791380051; x=1791984851; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lF50zyxySUMbpLVqNm3u6N8Uxl/mwFSB/O+gwZMjDSI=;
        b=dfYB6Ui0VlWqaqSQqYtb103zA+K3YPFEUHwN7XAVeA70q+P6iD5xezu3Y+hsb0U4tE
         3KbSPI365Ka11jnGWzE+SNr1vEVPvYa4K+47CA+X/uFreRthUgabru+ei6S4kAZvIipS
         tG42+NWSC84Vm93kcmAqtgTm+hkfVR9KUlBgvV0ujXFRNuEngmiMk/wW+Jt0SJzSsS83
         89eznDPUEbD38UVkS3hbEyLO8d6MroiR79j49l49EGZcPphdNjrgRLHh04LepTgD9oXj
         XjUtNMdJFsh0ihpJFpkcIb3omb6kfkw2nWiOfMjEQ/d2dDK6KBFWkNonDkhvuHZDvMvq
         r2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791380051; x=1791984851;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lF50zyxySUMbpLVqNm3u6N8Uxl/mwFSB/O+gwZMjDSI=;
        b=NhOCwYW5AI39PWEUXRbtaso70Hz3DJlRiliIuQdVNhTyiCIexxN5c+w3RypgYcKLiH
         SZHM9CkNknRhb73ZPoHRmjoBtbLsk7UVjBbt1eSU3WaibV1yjiv8wS2xCLrctwGT04X+
         zKxgpacnmwl8n5tT0hrCARkAoMAKD6EntTQntfbxacbgKmDzZrwQ4KeyuF6QU9Kt6oyf
         6Rh4IczV1XG6ZSGIJcUqqG4vFEu1ota3LBUqY6yB2Q1hCdCZSwbNHFYWND//fwfp/OZ0
         l+VQ9CVOL5/URrmuOHVygPrvRN0IOymmuSDlCW17+ggLcoUJ0rwvQMbL1cI1sQ/UHcyJ
         07yA==
X-Forwarded-Encrypted: i=1; AKwUvBwKu/EZ57DZ0eJgZbSBsC6o26XN6VvEdbqt7FZmJaYI0bnR68mV9KHgDdqH1UZV/OyJTHTXauADEg==@vger.kernel.org
X-Gm-Message-State: AFuF++lrrvaN5TkW+FUBHIGXu2l9VVrhmRWHtyKUHb3b32QbXwdvswI1
	mfMFQqXAZMB9lTWaccPfOVkaomNFp5AnEDSNBomA05iwPrEflHhcfl3BkiN1092JrdGl1oPGZUR
	QhL0WADHchx9TDqvGa1LLf7vVZLWd8g9hf5ehGoLkPhNOhydHfVDn2JtSgbF6Pw==
X-Gm-Gg: AYBFou3klakg0nucXd8vdv/0WjEiN+yBFVlvSUDvk9Mnda8fpr0XUyOxqtVKDSYMgai
	XVBRi7hnVjvNhRtCR1IaUEEt/c+UH42B9bZp+YO7JCyZs6r/zRi3mhbF3Ne07G4e4TzqCY8gOoU
	T1P80Nh9VjCBkRUa16EFmS3Vsql5cOyGbZVGYYLBGRViYiI4nmdaW5K8IS8M9LboNAoIJmvtLPl
	nLeDNnkJGzNvSf2jgYTUT4+y4T/CYAG/U0uzCRmPCfwiD8ylfXrvCII7NYVFpoSjmhJVDlJIneh
	XgROGgMjl8as7nRreBQNQqwxDWyCt1Aur99/BVxD41+3eWSJGm0oFYz0SaumtsEMa2uyEXw/6EO
	B5/nWiz7PvVZq5UK2dRu/X9/b7/35qqyH/XERCjN0ErST
X-Received: by 2002:a05:620a:4808:b0:939:fe55:402a with SMTP id af79cd13be357-93e860dc342mr1130814385a.31.1791380050644;
        Wed, 07 Oct 2026 06:34:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4808:b0:939:fe55:402a with SMTP id af79cd13be357-93e860dc342mr1130806585a.31.1791380049939;
        Wed, 07 Oct 2026 06:34:09 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f486b6fsm52614375e9.1.2026.10.07.06.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 06:34:08 -0700 (PDT)
Message-ID: <6e73ffc6-41ee-4ea0-a9e3-3286d6c72cb8@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] tools/thermal/tmon: Fix string truncation warning in
 optarg copy
To: Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
        "open list:THERMAL"
 <linux-pm@vger.kernel.org>
References: <20260929201951.408456-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260929201951.408456-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfX8RhPlBO3Kq3D
 CK9+dT8dl7g8rldn1OiGnusRlymzu+OWsEt9BHbL06Agj2o2ws4AYs1OinArtHwCJxlsWIheijH
 XwAUGb5LcA/w/cZppA4TfGadpQASRqg=
X-Proofpoint-ORIG-GUID: Cp1Mu_A4POoI09Sy7y3B4TTByZOIQ_Z_
X-Proofpoint-GUID: Cp1Mu_A4POoI09Sy7y3B4TTByZOIQ_Z_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1MyBTYWx0ZWRfX2vWAjuv0yzks
 fcWAwr1kr1nwyw+Snt+g/SrF6KkSdVRoduFfixyqsJjA4Uuk2CzxGdsTIoa/spFHmRQjNiJo0AR
 cSucwE2x6J1DqT0wzGAnQxk1Vt1MtrR3nIs+xVSt2srQctGqiPhS3wxeKtmTcsmBMmzEvFqyWij
 7gWn6RtKUVHYT8rLZfXTfKIcg1X5bEgL5mpqGuhIFz6Q8+s6uJxvMtMiD6uUAhmyoRuEA1GiSic
 2iiwwQGmMvGCg84TjAzWpZeL4raZob/s6URQzfVzHgIgifs/gqDWkJmyNutplu44Wlns2HA+SJh
 QyU+RGksCENlb1N+4FIzruFrSX8y3ucA3JYGF4POapPkAmseyARMMI5dFSv9jftAU+FXZF8xXPo
 qPPf1jSAIK/k7SZ+Byq59FWF+uPz4m+WWoGFjYptxOURGt3RIEuAxFOXLQPSqz9fl03Lr5L/m/z
 43xnQXFueYXVz1JLLFQ==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac64a53 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Q-fNiiVtAAAA:8 a=s7NgktmowLUAvCqQ5TwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070053

On 9/29/26 22:19, Florian Fainelli wrote:
> GCC warns about possible string truncation with -Wstringop-truncation:
> 
>    tmon.c: In function ‘main’:
>    tmon.c:233:25: warning: ‘__builtin_strncpy’ specified bound 20 equals
> destination size [-Wstringop-truncation]
>      233 |                         strncpy(ctrl_cdev, optarg,
> 	CDEV_NAME_SIZE);
>          |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Replace strncpy() with snprintf() to guarantee NUL-termination and
> silence the compiler warning.
> 
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
Applied, thanks
