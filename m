Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654A43BB122
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785328191; cv=none; b=BhsAfKbyIO2WNioWujbNntMycTcW/trL5yrBa4KD67Of3TuXNOmBJhxNPggyraDCpBfl6rDE03VZ/kGsBBfN/lYEdcrYZyHoBa8fmLB5Q2XcYoLUT9+CShaqw9lzp+HoAkovMmD3fqjz2WAo5mz0A5M8d4jQwjj/yJLdif+72Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785328191; c=relaxed/simple;
	bh=eU3rIagD/DJkspdzzDXpQLbCoAx9UdH+KUAOnRqLvQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXYFZJyqVRjVJ4+1yDPA8bKKG3QI2usy/n5HHmK6zClqjIkltrM5FxNX02IaAwgKG31qXYzlEis61umoV6Yv95RqdnAT2NBlms0eY6ez4JFR8+fPxrmgkYGnI7npnbzh1xdV2vg9D8LUEVfzjD/L3+GRb/+YmoAF7UJ3x2Y11Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5zwqaXs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J6L7Xv8F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5zwqaXs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J6L7Xv8F"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCIcAZ1727896
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=; b=R5zwqaXsVQskLj4h
	cPx8jKeFWgDQkG8+6lQkJbuYaN7v5nkUmN+stni7jjCyKbve85qqHhfgwlUdW4Hx
	Hr3owy5LP8SfPElGTtoT3VLrBhDNrHIrgX1iWtzXwIZlvHj8GSNKWKjpSDc89q+5
	Huak3p5J8nZV8s6+1raiWwHphhhYxHv3mCSW7dnkreOODRqYTPv/fSJz/j9c7ycb
	WTUTKGyTErt1OsfESHkGtFS0nk76YJU5aOn4Uuf+3DBht2txoanqqUXlO5VXrnn4
	ssQqVD2TQuJp6jkMQOa0hqgK5Ecujighw2NljBSoAh0e9GTI36Dwzkbw7JUrALLX
	6VdfvA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhdp81e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 12:29:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276a49e761so1361351cf.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785328184; x=1785932984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=J6L7Xv8FhJcRSiX53bMItinX8Bly89dQRmGB+IBpDhhweEVLD1q9XYQxGvWJRAIR1A
         swI4+sReL8IdTHHZboriTRQtUCJOW0O48r1ivAF9XO2+S1F5TKGz0Ia1QYA0wyfTkvLb
         0pivbzTk9dcrjrpJiVVQ8MVdNJO5AJWXqaUL9mRTVpZ6eIN5SBX5He8PP2svkC6YGrjK
         oFok9Gbszh3DdMD6DpAojRxfPw0lENzxLk3i7+ZXeulViXS72gQ89kQC+a+jnSQTyNeg
         4RR9LscCRPpUUgtB3kK/0Fma4ORyLMqNDHey3sq5dJf/t7hj3VbYbcyCTotUAWPv3Szd
         iEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785328184; x=1785932984;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xP3ywTkDvhhxUcM07PGoh5VmOojNwTFiUi/voo4w34o=;
        b=R/0CHRccfvkZz9C3EgRryamkAwvv2vFOHNUUJmDTnhNf7MZNNU0WX/6Y68qhwQYFVU
         TYB9bBSfoxFLuH2GPOuqhzYmSRG3H9La1jaT+/LeKXjKrB1x/kMP0BuCjfpPEs+NUOaJ
         B519OrcyeZ5noTcVcxmhVVzNhkVogf+4qpg+jWbj6LRh3aJXdepBYRba6GamdXoYQb+o
         AmkrjrVCHr9ROpbGURapNsKzwaZ22Bt4zteYGT/uNXi5I03DYnKRMy/bBJmgGGOn0OoW
         fTgOKOrpdftD2TvVtMQQ04WKZPEUzBQiscDH9fd6BVtmmjXpZJ1XDOoJB6zE3d60YI2z
         3luw==
X-Forwarded-Encrypted: i=1; AHgh+RpXaTZVlKtkbWbHEymh92Rrm3zxzfzxfa8HAjWRjsG/gdk6oiIDAuV/CA4bpZcPFsXYObaZTmeVxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUVk+Ci7S1J/fFWkZdaNCeewC2ihc1TxnidqJtcbCQstQei6v
	BJNlgXBC/7AodA5qTkvGvv3bKnBoYk18PpeOT7Kbq/5YoMBf92Z+9du+5s59Wml4SQDa/q6Bknm
	MEO0czCyY45JrzE5A0jjLZoLKowSfPzhjmE88YUo0NwCVd8PFdwDYXEpdDopEqQ==
X-Gm-Gg: AR+sD13vkoUSRmiu/+4RRPA+0x5ixsFheZA2Fxs2ltOnc8Mt7/XzmcuauC8HFTLEo//
	eYcGu9ygZ/ZIK50lyEn6gF3TaAQD0n6rJTCMcllHBWIdVjhXsW5JYsG1kwpRPzSlCjs1sb/djrL
	xKMNdAIMwftW2oF3vvPvqkB0VEwgFs2seSUq/tyMW1Z7LVDMEKi9S8KseOKb10OiRQUAOzuhYjf
	querk1ecBFyfKaFpQCePeA5G4cjDJcrbRKhIcoUAl6PNaPGFNE3tgYLdoTBcmKms1HX4RIEvX5r
	CDIfvROu2npS3UbVPArFsPpBZKdCtXt1mZZYbLfnfhZCccWrcIXFVMW7BMFjRTyDPSRuxxWvxTq
	ysyPbCLoZbFCYux5Gt7OIL7lB
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590481685a.2.1785328184437;
        Wed, 29 Jul 2026 05:29:44 -0700 (PDT)
X-Received: by 2002:a05:620a:469e:b0:92e:5ef1:9072 with SMTP id af79cd13be357-93302679f1amr590478085a.2.1785328183945;
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8f981705sm53805166b.9.2026.07.29.05.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 05:29:43 -0700 (PDT)
Message-ID: <95c33eec-8eec-4d01-b0f0-1ae33ebb0bd9@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kSW7Hb3N55O97Fsx87ea2vH7AGDZOzsj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfX51HneQMiAGF6
 IgqfDDB6o2vAeO6daT4ZJxJolaySIziIIv8UBLEY8slWXHOb8IJ2f9koB2HnprdELfxW2Pq5QGm
 b8RlWmE17nXR8QBc+qBu7zJE3uZs0Uw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMyBTYWx0ZWRfX087swceiAGtO
 C95ulwLwBfjCzxihd5Uy0uBRa7xyOy/LFx8fzDFiGxhh5xR0u6l8jZHidngRVV9ZAh0R/cyWTK4
 NUI/Dv1EY0HGr93y354k7PE8vrNYfg/IWWFQShxt7f9EpYxdjEM3VBh7T9O+vAyVZn/9aSuTbS/
 XGPoeef8HSbVlSJd3a18nXojFE4mmzUGRz7ZBUOI2A688NpXbF6WFf6dgTfIm76Ksb/Dsk2DoKt
 lsUeyfNrscle6UuQeqQ6qs1VLz4t6uytlHs+M0Vz5AA5j/ygZh38h/YJhmyguiV1knd0jSbFzFg
 sYSfSJlac3JSubTZByRP7L/yx7uzdnakQzT0nR0Bwm7TUZvxgNicY73p5pBaP/Fi/mdX2bnb9bs
 Bpg0EJlgYT48Uml8S+hnRj2OhoT3V23yxizCX6PM50NhcQfPh9G0IKI8hZhSNtvoB2qEki7u74/
 L/Za0mUUM9pqjQ/9ElA==
X-Proofpoint-ORIG-GUID: kSW7Hb3N55O97Fsx87ea2vH7AGDZOzsj
X-Authority-Analysis: v=2.4 cv=TPF1jVla c=1 sm=1 tr=0 ts=6a69f239 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=fipHztts28RoyCzfkYEA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290103

On 7/27/26 5:45 PM, Rahul Samana wrote:
> The PCI core needs to associate the DT node below the QCS6490 PCIe host
> bridge with the enumerated PCI-to-PCI bridge device before child nodes can
> be matched against the PCI topology.
> 
> Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
> bridge can be matched by the PCI device class.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
