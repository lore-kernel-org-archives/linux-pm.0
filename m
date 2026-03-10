Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A2372B40
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773137917; cv=none; b=Ob8f72+TUlIv+csd9g3MDILaEwDOYKAIErxlHUdV8853zzkTsLltb0xyKPgaSW6N6J5F1QcCTclInksQ+fQ7agTe+ZQbo7GQipndXUL5CdkqoLLajOxWxoq2mjVkCQpvVpDZXSjx6FnLGBkZd6KiJwq8h16ah6BS628ytuuyVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773137917; c=relaxed/simple;
	bh=6/6KqpSz/HPJSSYX3xQ5DweaUSrzMkS14FO8kxhhbiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LG+pL3FOnW++DWYJrHwGAuByQLsmv8SpqGK+F2DM/wfWLpqmrB8cKpROMcmEXzjBT9/H9Ozw8AgKux5r0wYprJLD47jlYAL7zrRXiQk5iXGbGLTPTpdYZkpR4UPhNEqA/qwof6r16kQECPnITzuG2HMMltYDt/NHPyDo1o5yDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iemtuUzu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4xxtbvg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iemtuUzu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4xxtbvg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A6VPO02021616
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Oj0duUChrG3r/OIty/mgtnt0E7BOjdKdZWc+huinXSM=; b=iemtuUzu28+V4meN
	OagKFqMOwtcrQLCNT545TOWw6HT00wq1QzgYCT4+kCEehenA3i48hN9Ngb7N1rmH
	jecuTJCzdjsHHoxS0SmvCImdKgYcW6K7i0UQosEOao9/9PyUBF2h7mHvCMpgPmB6
	OHvJKepa8GTGPbL0yLU5peRGwVbafBNGqDGEvPJ1QL/OHt8Fak92QVYaw4KUfmT8
	FMIO3tmPtjc/COxrOXu0yi8BSYPgTuC2GnLBYF8AGmCUf/Iy/v4qGjbtCJ/jcKKZ
	1b1sEsecawZZLKQ/uMWZziuojzPF5YdEbV0HKmGv8osFBG8+OGn8FfapBPFe8DDD
	vpWe5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cte3w8trr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 10:18:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so1895198085a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773137914; x=1773742714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oj0duUChrG3r/OIty/mgtnt0E7BOjdKdZWc+huinXSM=;
        b=P4xxtbvgfaIp3WNXFsHkxuiq2462m18Lh25NxqPPdGMAXcqII4rGs82Rd9GikcCmTy
         ZSBI/L9iPImHe/sJYOBLft8AFWt7hQ12UBsIv5qYvBWyyhqzVVIha5IgL/1ITbQDL9jL
         8YWM4JgCfCQbKpmYKcpg9gd/TGs+HdTWn/u8xPJgntxKcNLWPnDbKe9JYHEKBzaHMzck
         jGXQItCtTx4g5NlbcefCEonDNB6Wn/j6HteQ69IbO/RvVfRlEN1nUZzvsB9ydmZ9dkQs
         s1MlO8T+n3Jb4iwnL8GC/2vHeZQdykKvbd8dlvtcC2r0kiNsM6kHBJmrgfvJE1JlZICu
         pfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773137914; x=1773742714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oj0duUChrG3r/OIty/mgtnt0E7BOjdKdZWc+huinXSM=;
        b=kJMhjsDpHIDzqASXpwjmbNkqG5n4U8edM5C/ldHvsBA7wVXduMf00vO8IiYhaYq7xn
         hyetBKNA+9SHg4DWepX1b46t500GArTMaCkTriPuQcU7FSAHPifzKTrWSN4fyU+zZJHJ
         ettnLNb5SrgRzSqMkhfGoZk0RnCuc88a+wydl5lEf9vxbYpAiBoKkwLQMHg6tmRxGARR
         YAZyrNWiSAAhQwA4blom3uyfxJU9jZJ/yzdXAbbR5Gz7FG5xeHvo5PGwHPn42/QlnQff
         BXNLA+f1wjCj6tkK1vuo1eZ9BkIRvRWylt5Eq5ICVwTiv6W72e01GSy+1EhKtSo0CbGh
         FGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSLZFK/rJsZWMZmMl3LywFQ72Dj8Mgypa5SeSNxgXKi+bBlBZUB3eJldIaTj4I0+M1zDmHrLRNrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEazjr28qWjoS5xt7gsgG5btzQPJ9ei4Bof20XZi+Q/7p6tSh
	Taf1AA6n8hGB7DOROxblxomqwSPAK2bfFTT27VikN5JlZtke8Ov0Z7K6zeGfdkzqv0MMZ1yAm13
	aStgcSrqTJ6dasfLzC2pjcp6JDX9vraaLn6BgUtlMaEwuEuyt6bR8hDKE6KeNFw==
X-Gm-Gg: ATEYQzzV+hqQue11Rf8MSni4D7RZ24N5SkRn42n4yowxT7DoEFjbHni2MvytZBcKejc
	ucdHDNjqagaTS4m1u13rwEIn0nuuOnz0xdanCPEm4TlECk31Df2CNLKwY1+Zvdy0sfYrh/LJMPV
	ngfs4Wkd0Q0Yvnw+iMQzaTVWnMj1AVEHzjj8jiXCdtJvHEah9DltiUItQo6bqH3/klkK34taX9Z
	NIOgNgisprU+muS/P6Phaf0655AiK6JuwzKkpuaoi0BRvMK9MxIbap8jKNv5VY+malQRLm9FcxL
	P6WZzHHZYSWFbYiSIbDq8F6ayzcRJakeiup9DmOXyc/Q2SjFIrIMW/aULKrRNuXT7ARuh2/ZBLo
	jsVz+g+bVarQcLLGnU3uoLqMvvOthZhe7BBA7joYLav9eZzryQTqxP9qsOF3O9GmuTPRO4LU2o7
	Y/oIr8mdL6
X-Received: by 2002:a05:620a:288e:b0:8c0:cec4:b6fa with SMTP id af79cd13be357-8cd6d47d005mr1813031585a.65.1773137914416;
        Tue, 10 Mar 2026 03:18:34 -0700 (PDT)
X-Received: by 2002:a05:620a:288e:b0:8c0:cec4:b6fa with SMTP id af79cd13be357-8cd6d47d005mr1813028585a.65.1773137913981;
        Tue, 10 Mar 2026 03:18:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aba60esm66574275e9.5.2026.03.10.03.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:18:33 -0700 (PDT)
Message-ID: <fb4c5d65-52c6-4a25-8c97-6c2e1df1e3ec@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] SDM670 Basic SoC thermal zones
To: Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260310002037.1863-1-mailingradian@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260310002037.1863-1-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4OCBTYWx0ZWRfX2HOXQRU2t7b0
 4JJ/MJbaPvAnz5ruGenVCAT++er7DBQItpCpTUkmNRGhSg8VjiNYBgcVN32E4wl5RE7idbrZKgs
 oPrT90jVStpXcsisfm/RxKtg/uviE8BRupZgPCEX2J3UDdUur76xsc6r+zLhWpn8i9ni4RDiLp5
 EyRDKigzwPynFSi2rcezLHR83NTGZZn7U0Dktk2xeUbLHyKzoI2BVPTWG3I2xi5IPIO3Xk0GRoc
 IL/j4B/thOilgBaHbTMip0qVV2IT2F2R2p5wbmVOQ4Phi+f5/qRzj9Ez714vYv4ImqKyrM/TLce
 hNciM/worCiAcllorYlNP26PR9fSFNSwPv5Zy48m4wI1hkxOvbrzvPpTI1Yzk61VZQ/xkWeRtTU
 yUyaBm0GVIrc+sSIS9XF0jvRjzchRIgt/yXKDV1EPh62iEp2xpKDf0h4HCaq/7uas2qKX6x0R+o
 bLl1o65Fp3rtaUoOlow==
X-Authority-Analysis: v=2.4 cv=GtFPO01C c=1 sm=1 tr=0 ts=69afeffb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=ubao2W7AewvDnVcLIXgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: WqFVIXN6h7rh5XEDqhtO0qgeAjZUHBYZ
X-Proofpoint-GUID: WqFVIXN6h7rh5XEDqhtO0qgeAjZUHBYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100088

On 3/10/26 01:20, Richard Acayan wrote:
> This adds support for the thermal sensor, for thermal-based CPU
> throttling via LMh, and for thermal zones.
> 
> Changes since v2 (https://lore.kernel.org/r/20260304014530.27775-1-mailingradian@gmail.com):
> - remove cooling from memory thermal zone (3/3)
> 
> Changes since v1 (https://lore.kernel.org/r/20260210021607.12576-1-mailingradian@gmail.com):
> - add review tag from Krzysztof (1/3)
> - replace CPU thermal zones with lmh (2/3, 3/3)
> 

Applied patches 1 and 2

Thanks !

