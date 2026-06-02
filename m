Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6713C9EE8
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392487; cv=none; b=btZZ6J9VbfVnZCN6a392tWJdLfXGCpgDABiBf7US6j/nE0o+TKfoB9mVULNSw6N4xdQ7zpZOx4LgmuGFapIMHM8s1sTSVJN4BkqWLok/H0rfsC477HIOqUIqVCgqoeSZ8DRhJcLgS75Pope3/5IR6NQipcR61isXcrw6cSyMFpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392487; c=relaxed/simple;
	bh=KOv9YH+3FUbVV6ZbzGnVEusvGbPURLmC4FhUS4K2pMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isdq2qfpa7RBST0tF2CB7juMG4zn2Dudgrmn1LKps7REWzL/v+XSReDkNOcmcxxsqmRegA4krulEHd0SLTOMgrHdJScO2EPYt8NQ/GqlxHERH9dObjOBV1i4pOqwwuclxzlBHuKj7Ko2B7MFHw+gFMyWw4zx3N/xN0MYz7rRB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YwxFHEsg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jpu5r88+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YwxFHEsg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jpu5r88+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528Qnbc3430226
	for <linux-pm@vger.kernel.org>; Tue, 2 Jun 2026 09:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NvkSp804GhdyyZxMLRn3wWP/E8RApPPQQ9Kgdfsxspw=; b=YwxFHEsg44bedKWL
	GumsKAuUMyork49N72gk66HyaeoAg9nAmhZIequaFKa/ySrtHRWHFHEMszXDKksA
	3WiImZS14pa1B0HgA71AX4S+J8ds0w3IXBDgFb3KkBiUEnlkIoIFy5QhIisWd1Sp
	hj1uU4JRZ/QHuo9TZQUV0H5Ax4JLbdBYkAE28tN6M2mqbxarttAGEChnZXOlNXqS
	r0t7vbFu3SKRQZc3HXAsB3DDIV5OGd3wIn1f66qKItL12Y5X+1plsW75oPZitXrW
	EHb0bs/NzLRl8kVWYdQEB4WC1fd9FQPAEs4ZMoyK6NgdvfQKe0SG7C6sx0kPyOPL
	aggZwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mhsdg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 09:28:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8596daabdeso2330389a12.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 02:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780392485; x=1780997285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvkSp804GhdyyZxMLRn3wWP/E8RApPPQQ9Kgdfsxspw=;
        b=jpu5r88+TxdJ7JY0v2W/iDf2BpMDHQFS+y9jTrvP9E9fdzKZt2fDDpSsW+XKM3IKG5
         9viqUuPmP+SdoWk5hPaa83beg6t9dNIQFS3PcMLhdGJ1fJuY6COUuOFJZ7qHDmE62c1O
         SOHYHlxFRpa01deHmcRqbZ+2ElYbKr9eMVJC2msA9DN+kj61+fpl4ENexdYE4huptmQu
         dk+E7YfySSLPRcUreBVejRcOtnykfTxHR+RGYadMu3lskeXEVylnH4Sw5765UULS5ImL
         aipxdUnsNGlFdKefZCsJ7Vd2/mQ5oqD3DnMvW/3EKgRhTXMzhjsQeOVehUZSXhwPXnWW
         LqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392485; x=1780997285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvkSp804GhdyyZxMLRn3wWP/E8RApPPQQ9Kgdfsxspw=;
        b=dIx2jIV65j1URf6IkT1+lvsk6bDPUL4UPjQT+A0kbvxU8a0cnnboKO62J1LtFR34MQ
         9FmWfX8h53zObhWeMOaL9fhV+kBtGKsfuXlvdG2cgV6uT2YLs+/nzibI3bl80gLOn4Kj
         pJG1s4S03M6l9rR98nxW9n+4ksq/TcKSiPjepvTDaV/y60IgUhO9VDbqyQLWt7rh7S5V
         R8hZgbhvGTkWvzzMuTNImu/4YjaJdHOs5ib101a+vbm5t4cO0p2KFWCSJotmkdYs61Kg
         yraZWWAoO1quNWO0r/YCnzD9d31FaHpYSwPnQC9uyKo18vTpN4rCNbSfhzwpJlhvmhlp
         aRhA==
X-Forwarded-Encrypted: i=1; AFNElJ/SduDl7hSuMUaPMDugdbqwLMMzyykdxhSg/syZPZ+P+5yPgPSnmMnYj3MibqXB0TZy1PPwH0sEGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpogvt44OhUkgCqmqNxIsGTGxXBd+WYeAhZAN+sYnIk4yLnwu4
	8YiDktQKLNpVIlFdDHuwO1w6paKS/rBTCP/gKgXecEnI4in8wL3FVgOQQXBG9vLGDe8GgSzXwAt
	1RRpi01kq9adzX795KKwoR5PhlV5CeHaTcB6gj37mXqx5iklbzyXmxPZN9bwzxw==
X-Gm-Gg: Acq92OGa8RQ67zj0TbQdZ4niUu8KERsmq8f9DgGCs7Z5tJPje8Ulw/ZMAPwS2nKKpEz
	J4nEMOLgP/GXg2JqbyhhCeKHws0/u6OWrdibLifhzb+W0Re+N3iFEWrzcSSl2Xfu/WSduBNLN4g
	l7dOZgftXRW98gZy87oeRu1HgHaMcNwgn4R9v9CDFJO5gRoGEmaLpvGIbKJsHjw5S/+/ZwPtrBi
	gptWG9Vn/oU5rD2YM9AcQ3TAXx2VV0y4l68/vMde1TrTyEKWXpJLySL4v1y+nBVieP/gE1+t8QN
	KUPuZCoy8DN7hCI4jkcR3WaWgDkJsbuQduusmbYZO6lJ1wOvaLsz+4nWqulUrgn+uANz03vXzU6
	KnoJkTnWniW92fVz8lSJtAtrm82LkJuyRGJ/qjCQxrEPkkXJm7opMBGqwyEvWX2S0ymq1bCJZ1q
	OIASmgP2WA+oLMX6Hw5c9aZlZ2+3O+SJ8o
X-Received: by 2002:a05:6a00:91e7:b0:842:277d:f72a with SMTP id d2e1a72fcca58-842277e030emr12603226b3a.33.1780392485064;
        Tue, 02 Jun 2026 02:28:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:91e7:b0:842:277d:f72a with SMTP id d2e1a72fcca58-842277e030emr12603205b3a.33.1780392484581;
        Tue, 02 Jun 2026 02:28:04 -0700 (PDT)
Received: from ?IPV6:2405:201:c416:5052:81a2:4375:a071:12a2? ([2405:201:c416:5052:81a2:4375:a071:12a2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8421bfec5cbsm11760197b3a.41.2026.06.02.02.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 02:28:04 -0700 (PDT)
Message-ID: <afeab8fd-6951-46a3-8b92-9c3b7075949e@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 14:57:36 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,shikra-epss-l3: Add
 EPSS L3 DT binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
 <20260524-shikra_epss_l3-v1-1-b1528a436134@oss.qualcomm.com>
 <20260530-victorious-resourceful-muskox-cdeadb@quoll>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <20260530-victorious-resourceful-muskox-cdeadb@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4OCBTYWx0ZWRfX4YKiqu1nO33W
 8sINSGQPNBWciJhp902mXp11Tknea7YdE1VFpWODw4QFasarFKL7tmVtoClxntyGv5pwhjxBoig
 OVS/TFsH1TIDFySWbSilW9kSnAFAYPvYCoOlvYImcyJhfGpIgggEZSHMXQcRzVu96ma1vwzo+Nu
 tA8MJ/vFWQQf3WwWKL/B4/qGjW5ai6zBbrUDGJGyeqDE+5goX/gXcIgcVP8zxpgWIWS1vVbyuMh
 3cJC6FEVVLZ+Y66oO4m4XPnHFRKIWhidrXH+CnsL8sEjBwvlAc7Q6CUj02tt7yC2ryUY5lKB1io
 V1mSkzfUEy83XwYSmWUc1h24lY2D+AXyOf/4S+LgFnMKAojHfyqXNEL6ktUVKr5FA9JBqJ+w5Ag
 ceZQVGsgn3OhvSXm9IOWBSu/Dfr7QaNfqxRfdYJ81Rf70mtQrtp9mKQSFAIGpwJxUNYilwsEiUP
 5hLunrN1O7uIzOFr1AQ==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1ea225 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NjHEnLPE2D3hUEva9SUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: Zq_Ah3WhylBRamU4l79Z_pTkyOtjxsh7
X-Proofpoint-GUID: Zq_Ah3WhylBRamU4l79Z_pTkyOtjxsh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020088



On 5/30/2026 4:38 PM, Krzysztof Kozlowski wrote:
> On Sun, May 24, 2026 at 06:03:35PM +0000, Raviteja Laggyshetty wrote:
>> +  '#interconnect-cells':
>> +    const: 1
>> +
> 
> I do not see any differences against OSM L3 binding. Why isn't this
> device there?
>

The EPSS L3 on Shikra is similar to EPSS/OSM L3 on other Qualcomm SoCs,
but supports only twelve LUT entries. Due to this hardware difference,
the generic compatibles are not applicable, so a new SoC specific
binding is introduced.

Thanks,
Raviteja
 
> Best regards,
> Krzysztof
> 

