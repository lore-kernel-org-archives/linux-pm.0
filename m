Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578907;
	b=hyC8YHeZ9dPuyxX3t7zS+4Uvaqsh86N7qjTQ6EJObT8T21y1gNefrEMk2jgg+7QAqQ2D
	 JC3btQQ0x4k2NzfFUBc9UlyW6qHI+Md69CamA1RmBZ0jnACiGq5KNep4Kf2vuWfjVbYET
	 Bbo/Dr31Qh8pbxII1Cljgc7dNw7zaHskf+JbmuWA6rDJbS5AsaGP6dC+LmRR2D5Ppxoqn
	 tZiMCYkWOsBrjz8n3QE9QOMnq7gC1zXMv3pHmw/O+4tUDpOQDYALXkd1yQK+zQqzdZa/R
	 eEt6olWMgZA7roSb3+7HVMkb3dtiJOwhFj/Mx4wGSgmGjustpWHJ9oeehxWPJrzv3KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578907;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qGuu7mdTe48tzVj5UIBCGFenVGFbZZDVeQNujQoibIk=;
	b=EjsFw2Zai73X1Uzwq7xkB0mZCrVws9Czko5RiLf4rpXIdaf0zeDJqzc1//tp1jAGeUJT
	 8zKB7CC+Wfx3Pbx6pXzrRGgdBwkUxoGy+fdeS6lZxZ7MC61Jb7dDKnlrF4obeiTfgvr8N
	 TAOv/wYVig8jfmAblqxcQQZZcllZ7R+I/Q3n/XGNWVR+yHap94pP8ww3TqIeGzRKSEK7B
	 ZpWB1rcg5GMP2QqZG5QAX6RdOHKHFi0gQ42kdYu+zfTKZ/l7+/b6qHcBK7fD4bac1BBhI
	 nOd/+mKWRDqwDBLxp9PHUFbmAO5Pi+cZiKAAl0JVOrtXCrG/MOttGlahB6VESs0UMZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bL6ph9CU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SRnMKTp2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551A606A31E
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2551A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bL6ph9CU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SRnMKTp2
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5eAa1356945
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qGuu7mdTe48tzVj5UIBCGFenVGFbZZDVeQNujQoibIk=; b=bL6ph9CUm1kadnCo
	jss1z55EW/pdqxJcTXajq0aPpwZRRyDUXw5TLiBJ+MzWUHSYayJsQC9aTtwrERBm
	84hylA/dv04uC//3FPxvauvVZjxTP66amQSgvQjlrvYZklzF4xWprryYwEHxG2L6
	4AxjqxOtg74iUSBvOS9lTNWT+Bjz/wV3cwpuETXKKE6JiZEJ28sYxQhshstao5DT
	ZcSMz+8MJXMfDLdm+hIno27dvphFjfEvMxBW9khvGLK+jOTVb+bHdWt2jwkibax/
	bNTEQ6j8Gqm87UD+FLsGnAisQ7BS9GHd5Y/pTGZI7lh+EOoNQnu+yrBlc9pgqOhB
	pvuBuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda4ufed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:35:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92eebb130dcso8859185a.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792578905; x=1793183705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qGuu7mdTe48tzVj5UIBCGFenVGFbZZDVeQNujQoibIk=;
        b=SRnMKTp2kLJje4tGPbhU6d8rjST87RlIqCRx6DKkgc0krtYOrPq+gKGRt8zuI3D1e5
         cfqDLnbs7xiiZdNaY5pdtXXxvZQt1+AuHHJz1qSTgpmZcGKwlYP+WJ8ukR8HeMqUKMqB
         MNVX4WYucxPGX7EPAfLxywgKJn1UZ45UJD19mlIeGkgjWZ9S7iGrJYEkEh4t8EALmm0t
         Fzu1CbQ5tmThzUXfZzzYPGOD6990Yd2sffQFc9jqeGVwNsrmksTp5IKNvbKbJsltRp+E
         UGsBhOwMSdyTZmL1Twbf6vlx8utxma34d3v7BHX8wgFBTAiUKfP/Wghc+4WnRFBr0414
         KbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792578905; x=1793183705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGuu7mdTe48tzVj5UIBCGFenVGFbZZDVeQNujQoibIk=;
        b=wjWQ++VJS2SmAKHhG5ajpY6lss5fmfQ9Tx6U9L5DV1X19HnHR7WMGt/tfF5GgtB2C/
         oR340Ck/Rwpw5wb5fW0W8BkpE2ur9dYQj6/+VYQcSzGQj7e2qpdSdwSVqCTZodWEoFwl
         3BDuETn0rJ5EACZgdg001v9u89zzXaP4sd4ArWj8Oohyl69VTDhdkNV0I2Y03/0X1QD3
         lJuDIMwIRLKB32jLn8CrGq2HmKPJJ4tMmOx3RL/vNPOFf3FdMJJ1Va518kICPM8EAqE8
         cJzp5ftCsJ1Z6EhlbhDYbIy3HxCi81Q2/ck4gd4Bj3LrMMo3I6M8HceFEa9LqPYGRPM9
         UMWw==
X-Forwarded-Encrypted: i=1; AKwUvBxHyslvV76HwlZ+qCI5eW8ZrxUStPmLPER2gMaHAoQc19szWOcDgEt5JLnOtDqSe199heocoBdoGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJEJjWJ85Xe2rVIB8jquY/MsutQRX1htOZYfLKX/nlQ7J3QdEZx
	XMs5KQAAMFYmAl0eYLU/hjx9fOo7EPkhNa5mTxRVBLTRaxdharcwJWTpFeNByJgsyFeMRX665Fh
	uPZbFPpAANsUXf+7JPIZmV0Z1uZH1R3i7XKwu26BD3bNBOwuDaul4w7mQA5wHUw==
X-Gm-Gg: AYBFou1bA3LXGgGz867fNWlN1TchpIy3VyONjYqPq7s0vqApIAr6sMzLqm0eYLM/8np
	tUAkWn84KibNl7X9R0YiSNhUvSmMrC20UfD2xIQnhxI48/WLMH6ZEL8ZQ8c+ubM97a/94maB1yN
	8hNUckeINcxAuPg7xU87pgJqWmudhESHnVhSyfZj0zp9vxtcjMbxXqlY5mxAei08N/awhRvF/Pl
	pzoonKIHyo6XebbYHfA6IhZbRxftynjWwVFg9x0Ct6CZTbtAu6z9IKiyeAVC/kpwqtVedCzKetu
	on6z6Vu7fBdr2kJ41biYWSQQr+m0RXaN7bEGqYYuFgwWD7vdMUZYUEQq1CIN5aaZkfMMotZxsT+
	QB3np13JrA3LWkKa32H3svw==
X-Received: by 2002:a05:620a:17ab:b0:93e:54d2:2283 with SMTP id af79cd13be357-93f57fd125bmr366240185a.6.1792578905288;
        Wed, 21 Oct 2026 03:35:05 -0700 (PDT)
X-Received: by 2002:a05:620a:17ab:b0:93e:54d2:2283 with SMTP id af79cd13be357-93f57fd125bmr366236185a.6.1792578904793;
        Wed, 21 Oct 2026 03:35:04 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b403132037sm647584a12.26.2026.10.21.03.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 03:35:03 -0700 (PDT)
Message-ID: <26d4788b-fa4f-4f37-bd9d-ded731fb1e0a@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:35:00 +0200
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
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: Skip suspend mode switch on
 MSM8917 and MSM8937
To: Reza Kurniawan <imkyufie@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261018-psci-fix-v2-0-35f65b59eb9a@gmail.com>
 <20261018-psci-fix-v2-3-35f65b59eb9a@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261018-psci-fix-v2-3-35f65b59eb9a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I2WqkPqPPpvVn5dDoI79yIqBkiNnF3ta
X-Proofpoint-GUID: I2WqkPqPPpvVn5dDoI79yIqBkiNnF3ta
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfXylHqkSu8P6Bp
 RRtxvwe99UMjzddghRDJRkJXqPyf46Jb99g37edBvur89ChXgqrkvZmRCbwkkmznhnIP5wkmoto
 us9z8F64GM3OJ8LkXr9lsIQO/1dYALs=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6ad8955a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=J5tutDk3-wnuWQUDz_8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MiBTYWx0ZWRfX+4Idstb14KHk
 Eaog+Ta8vYZhjP2Y2avR4K/hahxRz/Yi15OmosjTsR7wNBbRxThmF3T24Va4GEOM65+/OX5Lj3e
 1uVTblIyNM2n5ghPVg96ms1e2wD49IvmnIHSRzLCpvuiWUWXurIWhKJOKEhHHI9XDfcKEG440sz
 IiJHlQqYgFi+q4K5qDW9lC7ED72LapZ5JujUrI+hUa7BoIAZyf9QtrKoiL4eDI3XsbR+HMMxQcF
 GDPCPOMg4R4cZ2H6XY7YnoPLCyaw6bfjHKKDJuBuwWLKmcPwWTV5vppVb5lqGcKIaRLGm+Y9A7I
 32cTgJExHYrAC9EZWgu+NQyUN/bxfXcXI8ts29Ercz8cL0cOtx8a88Iip6s0eDqJ8V/gSuHvHEY
 fE90bZMQV+kKwF+RAbEb8VFCi+LMDFyk9+CxkHU0PSbmTVEGjB3vLvRM6rsVIZO7vgTDTky1t/N
 NeFpZwALR8F8/4U9xaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210042

On 10/18/26 6:29 AM, Reza Kurniawan wrote:
> The PSCI firmware on Qualcomm MSM8917 and MSM8937 reports to support
> OS-initiated suspend mode but rejects call to PSCI_SET_SUSPEND_MODE with
> NOT_SUPPORTED. psci_set_osi_mode() then fails with -EOPNOTSUPP and
> probe of psci-cpuidle-domain is aborted:
> 
>   psci-cpuidle-domain psci: probe with driver psci-cpuidle-domain failed
>   with error -95
> 
> Skip the mode switch on these platforms and continue with the topology
> that was already built.
> 
> This is expected to be safe since it matches the downstream kernel
> behavior, which manages the cluster power level in addition to the CPU
> power level, just like Linux does when OSI is supported.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

