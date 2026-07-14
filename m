Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAC3148B4
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035790; cv=none; b=kt+mucsB/02NZ0iWStaupX00ZxBCYUC5f2cCa6rKTwedQ5EI8AV86VYvoDcsM8xwhDG1HgKcWFBpk/iXKxYcgyq4jlhCm4e8dAppFztHRvv0GVHVtrNVJhWjJmFxuKmo6YdrEp0Ka+meDWLwB39mPDCIL05s/NMPAih3KtH4MLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035790; c=relaxed/simple;
	bh=ddXIwzcq69bke5xNa9ihXe5S9Fqz3ubWOFlTMrMw3WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCtdt9RHIVpQ1ZkNm9APAmGaZKwZUONt1d5BTOOJaNiHqPx3SiZtnoHPqpf51OUpIDsJWmdkCsje46s/ONdU4vKgJsMscuVu0K/D0Z5M1rhRlRt6QLJkHeGrksCIl0lB/VmdQTYa8L62vgS1IdSHbxyB9zpaV9J7u2OIFFT/rvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K1gx0cTZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Va97bLam; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K1gx0cTZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Va97bLam"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBOAXC108385
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00Q7YH6eDQ6ptYXmSdMzfh3T8Q4kbHubaB7GwVpuRik=; b=K1gx0cTZoZ4ghvyq
	xdu1uKleqnvXartFRKkAxxsjNdTJy3e1tUpfdArTxn6GRzoQzk3hm4Ro2znKexll
	Dcz80Pos7mjoQvbjyRhf+qJZagMKJV/8uQx1B2Rd2TRGh98/jkzyEUrXqc7SVp8L
	QO+9xRqvyhv5MJSjTjDqw1zINRz/PdYkHId8T1UlVmsiO6E4FOCGgszMhwFkGCcj
	Qs1UqQsZSpVgNTzF3B7/2vHvBPu9OUB+U7aOi9e694LHlhzazuKPa3v1JgvbEmWJ
	z1jtgEZDUPLXkjjXdtbMFAA/8kMTy2/hZudsBD7rNVQiLcdNEklG0UAJu4KBCNf7
	dcjorw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa9uyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:29:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92efd2ca21aso543898585a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784035787; x=1784640587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=00Q7YH6eDQ6ptYXmSdMzfh3T8Q4kbHubaB7GwVpuRik=;
        b=Va97bLamo9Rogk5kH57trTukVF+MFV+MKnmGmqzgiymV5H0266+pBOeAvOmL5BPlsD
         cSuyUhXbbafmghy+yW0qn2AgajRHQR10lFjWzQqMhIUaWryHPRF2vdj3nS/lbdV01H0i
         eSs1gI7vuFeabY0kNavzCX8Pt1tcKUAGnFE9ItGkrujAJ8A37v9NrFQXJmkhNd/XHymX
         R9KjSYPKu3bfOTGBPCCjKI2lKHGsS2j9gHu32KpMNIofkLCxPOlfgOhcG4GomFkqhWQ8
         wlXNeOA4ApAz5LXL7KXxO0WNEOSFgUIKFa6HGURT65tVNMBmUWoXgWoG3unpsKopCgiw
         b9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035787; x=1784640587;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00Q7YH6eDQ6ptYXmSdMzfh3T8Q4kbHubaB7GwVpuRik=;
        b=i92Xvc1wfJNr1vQsLL1FmyXKt1pV7iiLdK5n+BOmP2vt+h/YXJCVvIhPuuiG6/m4m3
         Zx1mDR0PvxHX0J+GKN8Ltp/Ya/HHuIZfZ470IgIXp7JPvFpIslFqOEwJXNgeGFN2t7w8
         hbTydMPWkDLyEZdIZ3xxAf1jbvRub4y5SoNLOeE5jFO8M8hqZIN0Uepd8GCR/0Gjb7XJ
         +0OozMcDL5OjZjcaNkvGiGjq31NYafDDaqdIil8W+QVeK1RcLK9BP6PT+DoTbacQ+Vum
         8Zb0mPTdNJGvYnm8QyCUKC2VefdxSdX6rvBTi9CzcKSahjZcn30ZjY+ZlSyomnSnaq9P
         I55Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqzrs16rzUzKZpJILpnHqBHGFlgUarfa8eK5PpioGPy8VNxTzX+aqyoSh90q6j8oqBTAWmeGATU7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BC/ZViBzzEDdfhrdYcnwdFb+RVw2RbEEhAOne4RqHbt07XN8
	0uwbP6wEbmEMloCKF2RCtwjGax6aZLxanHHVZw2daXQHWDTXAHm669HX9LCKExOqxkphO3q4/AG
	n7uXoFZq7Qv2XNJr6yeQvf5uDj81osROu57HxAWPG3rGAi0bDDB9JGxOWx3Kigw==
X-Gm-Gg: AfdE7clWuCXI/dQZEvPWROZt1gScMKIpCJhEwuIIslzlBLtxAXfcjdxFHOU/nvibIz2
	7KBsL4bc8K7ULhWVfhxyVQ9pARUEIOdJKNFw7LuRqVUIZCHKHx2zMJ5cCLA4LfdrswsjZ9QNpSe
	h41rbRh+6XcOVqqb6gsc7FDxC0t57kLKKIG5KpNVqbp80wShTwE+30j9myR3Uy6Q6GuXlp4x6YC
	HaGzZ/lr9LH26tc4phcEwWn93tO19hLzDqxO4CzTWLpdpPY7aNXay8zdM33qq+mpdTQN2pVk8EP
	o9wbIHfCAiqhBLxjxaYzBVPlLhFdO3C5brS0UVFtIWHlZu7aFTmE+x4chG1Z1lPqeFzJmoCRM7c
	tz01doJdBp1HOdj0BXyqKVJ5pizXdNXmQlFpr7Ev/
X-Received: by 2002:a05:620a:469e:b0:92e:c117:9ea9 with SMTP id af79cd13be357-92ef2e303aamr1315626385a.87.1784035787644;
        Tue, 14 Jul 2026 06:29:47 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:92e:c117:9ea9 with SMTP id af79cd13be357-92ef2e303aamr1315621985a.87.1784035787277;
        Tue, 14 Jul 2026 06:29:47 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1503753785a.46.2026.07.14.06.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:29:46 -0700 (PDT)
Message-ID: <e83dffd9-e54f-45a8-b997-e84b5beead71@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:59:40 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
 <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
 <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX6kNW0jYDNJQ0
 bLNGlayj0TvZn/hNVoSa1ja2zM2vDHc7WR73vnTyow2apSyLgpLy8SlBcTH+QLc7fhtIb6lz5vX
 J76DIMT9NqZDQLNZeQNwqo08PLYgOM4=
X-Proofpoint-GUID: avW7XwtXuBobQxBOlbpu4FiUF11FDdMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfXyKcIXf2R9s8a
 wj5N9KKz+yqtywq7Zsha3UlrzhWysvbPuyOJPquTeNJyh7RP2Fxtfxr03M0F5/Y/R3OsuHp3Jsy
 qNJAkxzG1pVKuCQMRPAGgglEA6kc7Z3kckuD3Gxa407UqRfp/L2yL0v9P8K2vNDOaL3fTCxSr8Q
 RmuyErvSDDWKEm90bYrTQcxsNB6OlvQTjWRYibghUgFPV0JCVewuR5lMnC44nG5zRb7MXkf1HJJ
 ihbKAkOJ3owylGYpKJJ0dqsrOrsATbZmVOFj675U4dLRhDxnQsUq/7xl5oOQGFuoebmzgAOCdnL
 kV3RigI6KscXgFjbDepq0xnZsOhyH+rqQ0Kl7B5Pvak0X55X+K99KKg19NE5Ul9lci247x3zfGT
 tNWY1lFsdHEOKLnDfhDayhWpposqeZzFupJ3+erhQ1v+lTJ8K0FikLPo4sMf6cVi1TZu8c79NTz
 Fs7O7p+FQzYVcipQxCA==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a5639cc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hD80L64hAAAA:8 a=LIVxzhUnV8PAbWL9GmcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: avW7XwtXuBobQxBOlbpu4FiUF11FDdMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140139



On 7/14/2026 6:34 PM, Ulf Hansson wrote:
> On Thu, Jul 9, 2026 at 1:41 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:

[...]

> Without detailed HW expertise (still learning about the UnoQ), it
> looks to me that the HW may have been modelled upside down.
> 
> The power-domain-cpu-cluster should probably *not* be the consumer of
> the mpm, but rather the opposite. This is how qcom,rpmh-rsc works, for
> example.

Agree, There is a series [1] sent out to fix modeling similar to how rpmh-rsc works.

[1] https://lore.kernel.org/lkml/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/

Thanks,
Maulik
