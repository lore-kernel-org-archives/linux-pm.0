Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604244;
	b=mg/H/x4zNFiN1UdVA2bJO4hs/k7Ysg8T5bQ24zjgVRCH0AgQ7dezuWKFEY8nMhQmNzw1
	 fs0kGQo3IMpZMo4BUyz+Jgo1USdmCBTd1MPPrzkijMF/oTnsVRz8SCxeUFueOcuXSxeN0
	 z1AVcEni2u0JaFAUe7HdSzYEOI9NnSI/hqc3A3Tz9aaEeZG9fvHF3oq59HdfjBiiCZoyJ
	 H32ZNG28sTBuRh/53Sp58bhF7e0D7Wz/W4S9Vv+nUNufvd6oVJGjDsoZ5v0iQ2l8EVq5p
	 FpGyAm4n7DnsFpk+GcasYBCeHqfkH+oLeFTbcGiorRn/z0NKZA0LcehRU8RlEqfzsyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604244;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=E1wMT+/ccKcF5sYLZnsI1jaWTQsigD5t+XChwFqJkLg=;
	b=sAq55l/UCJxjqJGv9jpRU1E8yV/c71nav3+kAvWgrh6cGzdf3lKcuBIFTRojRPj2KusB
	 m7Gv0CjMTeXf38lczD9ZpWhXa8SYgnDkietBNNXAr2dxjWhWC4QcnGXP+7Y7e4TIZBWET
	 KZWaLpJw2uE1P7XIuXRaM0LQeHIlwLenAemXW7atojBRrLQbEMpO+JYEWjtNm1JdndQD1
	 xpI3y1ARipTEpL9acCXR297N0+5FH40DrVTWfYfz9vYYj9nA4xP1IKxwU8InYU6H+31cc
	 dSUQZuRnC9bXgcyCjsFNZHALdGdt4QgmBcR8f7xUukT62wfZFOUdWNCys8Ky4pJhQTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nnKj8gyD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVy1qdG3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E085C606A327
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 07:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E085C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nnKj8gyD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iVy1qdG3
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A23vsIc2717039
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 07:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E1wMT+/ccKcF5sYLZnsI1jaWTQsigD5t+XChwFqJkLg=; b=nnKj8gyDjIMqMZhg
	Zps7qYWTR0bBKOMv6zZJo0Eu396pDcc9Bu08rQNbvKXfShVl08suoOu2ZHNxTyvg
	oDyczpkUwDGPm0rEjTk+QhcCsg9uoOlmEZ6zRu+oAGyKyF4uUeJakt5ExPSbzink
	DR7My4eZjIkfXjkfPh1gLWHJgIqJs17ZG/zrqKwI5z7hlVckbqGkXPnkNFrz2tmG
	7lOThCFqboVfbVZEndjz/xh5RhVIJ3+sd4auujgbJgIuNXLqPwMKQkKda36FuvIj
	EyFRv0vqSumHR8WnnRcPWIWMv2h8QHPZQAKkPcaj+7s3Ae1MTYEvH3z+3HMjf8oC
	/8eTHg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2wpeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 07:24:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so6080585a91.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 23:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793604242; x=1794209042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1wMT+/ccKcF5sYLZnsI1jaWTQsigD5t+XChwFqJkLg=;
        b=iVy1qdG3hBQXMFSEdCjUXwwNL2pep8OtxPQOzV60l7gJ2pfyhdI93BR8gkOCGFXLcK
         B8JyXuzCyAYjBctYp48j7Q4/+k0o792wrjdhUcIwJ/BZ4BK09DYrUI2+zkXgOBCsAqef
         7XrjVpCIufqZi+gjYacRD3LGOLEW6DpmUdILgQ6TxzMsdmbbmDO1Rjn+b+w7vEPdu/n6
         3SKFdhdh0EWvYCAVws5cm+rXLRFC3yx399vtjHWy3UUZPPl/kOmtKANAF44ljF10+1UD
         ZZEO2ngx27bHsgv9lYEXAayp4ilYxE9cZFe8U+sRc0UaACfkrsoKJpnmMG20+NoBv8bO
         j6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604242; x=1794209042;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1wMT+/ccKcF5sYLZnsI1jaWTQsigD5t+XChwFqJkLg=;
        b=g9o1QNcFKntKrEAEW2T0lucR6qZqBIfixggVIS7f9g5b/je0JO/KnsmJtrFBgKM1Te
         Vf+7mM7wQMfKO6KR2VsMeG1s3LuQ25UoOusZ/x4ULCep/+u95MPigiK4jdfGDPc7WApx
         MPKYRjTVU0Dk1l5AI4oWEhgKA3DXHr7HbUmVzaMEUd3L4tc/M05/3eqFGasz3NrSaFGi
         dTvCBQp7GnweoGqGb0ltK9SKCJJ4q6KpkbLXfxQKYORUBMYD9ubisqpkcIEbeiy1juS9
         pd6Mlxeke5CLBYeWcUY1IdY8Yzwydk3N7bEeXiU8JeIvV3g/uzo2XvNRNeHYo4DY6nql
         YMxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgxr9/54lpUc/p8HUlN7BZjZaNKM5a9w6BkT1Y3Z4ThaGwPLMC9SwqVkQNnhP1eBiUoNF5W4RJ9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/su5617zvfL9ZZrPc6+woUNmXW3Kv8w2Jupm6DuY0rDQlsp3OW
	JZ2R/KIi469ypLjWZQwMAe5r+M+1BbqDWvYsOmWVtldwJwvS2ifFR+t/g1eOQayTN5ewIP3dbXl
	bv5tJDMC1cLTfc6n66cKXrspffWjMRMOtGRaD8S38x6Nl9csrvlWt0oF0dXAh
X-Gm-Gg: AYBFou3bYd2++hxuawk8fonQTzpBkfzUbwnEBx4D8kwZzYtpdSk8GwipvjhXo278eN0
	TSmCN8qbKNsua/7CxEHXSJEl7LfvQFGSQGboJ865d7RUptFs5y6EqH5gnGfNE4VRzF4Elco1WAE
	AZw5WXV5EIyA3Mxb7c8S9g7JF1XTAk2SCfqfDF2H0tRYWj1MNAZyxmp4L84RoYHP6od2cVDNHBG
	8WHKj2n4rV+cOODTafqc8xP3s3DPtKxAqT7CNOoOsNtodT6zehLZGcHZ9z/TkjJk8BG9FIRneTf
	a72kC6vudI4EliaVXla2ls2KlDKggMp2wFj7iwoePcJP95frNEwz47fMWP4pl823lpZrWbrtAPG
	P4JFbCNY9QyqWpXyqb8FbyI9rfjCEhmoGokZbJUt7Qh00GlZLQFeoFwg2mUXsLFu2Q5nZbYwWaE
	EsAg==
X-Received: by 2002:a17:90b:1f92:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae897c8014mr7947710a91.16.1793604242181;
        Sun, 01 Nov 2026 23:24:02 -0800 (PST)
X-Received: by 2002:a17:90b:1f92:b0:3ad:6090:a183 with SMTP id 98e67ed59e1d1-3ae897c8014mr7947678a91.16.1793604241625;
        Sun, 01 Nov 2026 23:24:01 -0800 (PST)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3aebc8942e0sm4048361a91.7.2026.11.01.23.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 23:24:01 -0800 (PST)
Message-ID: <310fd443-4cbc-4dcc-884f-6cd23d5f9c10@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 12:53:52 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 0/6] power: reset: Introduce the Power State Change
 Reasons Recording (PSCRR) framework
To: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Bradley Morgan <brads@mainlining.org>,
        kernel test robot <lkp@intel.com>,
        Francesco Valla <francesco@valla.it>
References: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <20261019-pscrr-framework-v17-0-69ea6cdf4731@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cQ2ATnJ6G5VQA6xxEVHKHrifNHKjo_Nz
X-Proofpoint-ORIG-GUID: cQ2ATnJ6G5VQA6xxEVHKHrifNHKjo_Nz
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae83a92 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ftlb9jb6QNwlQdeFhJ8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyOSBTYWx0ZWRfXwyrL/SN7FelH
 WJs1rI43W7bsThps4WzBIG4lJV2i/mWmdH0rO8C+BqR1Q/J8qQ+FX7jUL0w4EaYSM5xIKZVhZN0
 ugPvWb1k/pBwjAOej/wnw1+JAqjNsB0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyOSBTYWx0ZWRfX4IAE8sNI93en
 iJjqqy9tnzXLzFb33YpB+Ua3IX2Cau2wTkegi+7JXqIkcAJo4vdQS8CkHJhu2iZLqIsGfl7YRJL
 /8HVAQ5RApD8X7jXjGM6BnWW0zvlkup4DsTrBJ9UmjUd5xyjA3HnpgCGgLsMKkfRKHMjKWPCNP7
 HcpMiPJwhTDtYau5bJvobwV/IVuDSzCWYEY5NQv9o+hloZLIUmBVchRGnE3nI26+S7mzFhztX9Z
 ktsvumiMsZAIMoRMVsbdrX9pgi6vwbqgxpcOpX5f2VacwVkIVRSUhsyBOyIuOPflYfAKih8YrVS
 OoraUSfar68CLMy4jQq7GDx+4CytcQzMvRQUV2v4pLdC1e7sdHxSxPnwLh30o/rS/sw5hCd6ijC
 9CFYYSUh+NrONXC3h//196CHxiWvHmYcTezrc8mrFH8/6LWdl5/o/UnLHQkOQGdVMD1fwMeva7D
 lj6lGPjhuJRZ9jG8i3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020029

Hi Sebastian,

Gentle ping on this series. I've addressed all the comments 
raised till v16, and there are no outstanding concerns on v17 
from any maintainer --Matti, Daniel, and Bradley have reviewed 
with Reviewed-by tags, and you already gave one on patch 1.

Please let me know your thoughts, or if there's anything you'd 
like me to revise.

Thanks,
Faruque Ansari
