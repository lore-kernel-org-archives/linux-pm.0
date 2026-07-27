Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC241A793
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167890; cv=none; b=njDsWkLpCjtF4EIxwcJt3QK134PbBMC8ZK9FkaWXBx83g8FjcUUylwgKgDEnOGNYJq+cRgZ0PukUbS7G7QibbApO0fD9yFcdoWeHr4Fbd/uDhVQCqY7F3AyMK8W7YW+12VXO8aus/sJquszczbqN8TyFjVbTkoMimXxp+T6rn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167890; c=relaxed/simple;
	bh=0qgXgsgKz+Wf+EBl6K98gB4VaUU8bIC1KbXt+cAj0ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4xC05OoBFiGxUIxKEStOt18ugJQ5GlEn0Zcfji6St6r/CY95Z+tdRP6uWF2TpbDqis9/JhF8OW+1vFE+uvvtBtM4RgHl4hY0lGGsyS2XCL4sauMKcoCqBG/HIea1y/R+LvjB/PQ4yKV6XinBle08PwmdIxzeW75kaCe59oUzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SxUsxFlS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bG01MU3X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxUsxFlS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bG01MU3X"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlWgI3663456
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=; b=SxUsxFlS/7d6Yns0
	iUZrDoVICIZA0MNpDx5vj3JI5tbW9KFxdauO75yWPAJwBcaC0b3A1gxD79xJZGaM
	SVGY7izUUeF6kve/xBE/m9hBEiBj/UEInLukdoYu1LhZsscHNYiQrDW7JR56DwCD
	hbCPgAnO2ArR+A9P2LxAlNsxtT8r2uL+y928lXAacKN/aGBkcdGVJLfPzN+4+8W8
	ieW/AMWBdjsmSCQjJcYei2lwHyQubbGYPqP6VJu85lG04U5SJVMoz384xZWxmXfd
	xnZcdyXFGbhRG4gofi1LHuS859bb3vmDDy9bf5vxGA2cBsRon4oc9WHMmHCvmcth
	qtgOrA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp2asjbq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:58:06 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8653ad27so66260257b3.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167886; x=1785772686; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=;
        b=bG01MU3XKNk+N3TIPHOI2d6+P1NxGGs9OoYSF/Lcm83YZ0VgjSaK4uINXg+MLbX4lF
         cqO81kpkLUUMEOnHK69QCdpnVcJk5zFwIwbTLTdRyL9HL6vk6WJrsS7J3zF60Ua5qAHO
         +K2DXvs6ePYaQSedTTY6vbOMwlY/JBtR4MrlKzs18FtjTWjmdFkOntIYzsN3VfI/39+3
         wvBKXcubFj9DzdAHZ+WxOF1/K+gn2ZnMlspgukahdODTJJxHmC2qU54x8lM6m97e9Eyk
         AMFwheiPL3MniR6pcdHx7s2098lE0W/HZw2vnaoiH0JuT+JlOAIziupqhWmqpLiwRQvO
         Z+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167886; x=1785772686;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LVfiUpXLe7IIhGQGDrjXg5r0Ni0HjutTb9UTyNs+C8=;
        b=fNhsEnTsZvHRXskzp5tiSS8Rwe3CbJOHEmzqnolcbk0YjzYGiIC4ZlcpI13HgoPk5P
         UjPqunm2GbLoGf5PS14ibQEfL5zP07DXPSGMVKVt9Z/Ksp/WE+fyu3o/NALn3I+bRkiu
         3OFjrrGbmNqGYGoblXxxiHjpWGqyI9E1u5IyN/DF2HDzuKy21w6gzSiGDWMnjgm5cShC
         v4/VRi2YhE2MKzcS/NfzZM48Vqc/OuRxzyRPUL8j5egULMjaS4jCUf8cXENRpIAuxfOE
         RHCMpfU3/IobepM8vJCUHQzFsopBO6z/M738l4TAM92/Xt7MgKqKehLYfxFr0l8OE03M
         SMGA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Xcu7sKLbVGF2y7PUymZ3SDKl9PlY/LUcTl9kSenCi8evFAx3S0bK+Tla12QQax5GmFc5C+4j0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUT7JCUXKZP4/19Wj7CkO1wzVczeaOXs+r6em8W5tlV4Riq2W/
	pvUyywKUghqswVIYD5NiUtneMoMiigG6Rb0a2r5xGZES4BLiwqPN3RMJHvMUK7wFtK7FW0TOZqO
	3beEzYwn8Pr4VeRW6ajPCDokKIzhJuVDLGpI+zLmXbjxi5/jHV7pu73U6lASArA==
X-Gm-Gg: AR+sD13T6Rc42waihiLxSU3fQwkJNT2oxK4a3E3cYbZD8XfqSUMqxX1NjLgxUScWCRR
	T0Wx2wqlHjZLFVbZNTQoho0e1ubckfOMROT6rsX3eGrX5DcDNxyKUKLyJrgyeoelkvLNAR5Qr5S
	O9itWT45qk8mxdcDr3R21E89WVqaaK7fssn3TzzHQex/jXukrIBB3bFsiisvRlUQCKcMXmGSKpV
	o8gj22ipuN7YuqBFxIL65Ax1JT/BNOAwhnVQvXE6Giw4T9YnCB4SXAbsiuULFC/z7F9PVHtYSEK
	c4mrwl8p0L5fUNSGsYv1BsVB9EUejzKPt86wWiGSWwhoEGiInn8BsRz/P0L5sBUxrIjwJPmBHyV
	pOdAPuJ4WjxCKkr131VRqzZJEw9lFzA+P
X-Received: by 2002:a05:690c:e3cd:b0:81e:ddfc:3d6c with SMTP id 00721157ae682-81f93aa9ec6mr370217b3.56.1785167885950;
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cd:b0:81e:ddfc:3d6c with SMTP id 00721157ae682-81f93aa9ec6mr370047b3.56.1785167885432;
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.243.103])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657a14d9sm34165037b3.13.2026.07.27.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 08:58:05 -0700 (PDT)
Message-ID: <7b8d823b-8721-4dcf-8615-ba32e34c8e65@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:27:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
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
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX3hA4MjSz8KF6
 yWnT4IyQU/X+WL/Ilpc52Ib/8NzIdSTk294WjWjp/5ayLfk5AulUXlAjtjbw2uIf+cghgP79I+B
 QKJSN7gbeavWfyOyRJI5qnhYFKU3S/pctFV/Hg0KoTD8ZIfGCyg8cx8WtMEGBt4HzzAbuMpj3o5
 VC48sHlMXFO2mBmZU8pAOEUpDEfRYBMVQ05x6F8wtT4P74AIEIU7pLD5dwHw0cVJSRib13qR6im
 bt6nnsfU+4luWlnUji+pKftORystMVmCKPASYGhIYzCQOEkRn5S3R8nWU8UW3cCiKCHK/kYDVjE
 t7ZCoD25cQ5SG1VsVCupwkuTCXpXtqMORm1ZkJnpRvtDQJQ4LI3mLK5UcOKeR2ejkojCZkbqi09
 iObZB05RZIMMROE7xDwxXonQF6pvS8A6TwAYFgyG/Dwg4N38uPcjG5M5dSfKFPGBwRuJ/RPSsjf
 5o4Akka/wgi02DXe1EA==
X-Authority-Analysis: v=2.4 cv=UPbt2ify c=1 sm=1 tr=0 ts=6a67800e cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=EvQFEFD3jZIngB+Plrtaxg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=WbzeOWjvF3M0CV0e1dwA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OSBTYWx0ZWRfX13du7jdfxEDB
 gtAbJthm1MjalA+obqxgDWZI+nxH1fvCQosXroXfwdoNLkOsfp4CZ0dQ/I6YD6BbTJwp9LBOYsT
 TlkXw6lqCXleWYxtPokiIWmOT6kWvrw=
X-Proofpoint-ORIG-GUID: XosxuuRFYWMC7tLp6kb60BvNWaEYxXgL
X-Proofpoint-GUID: XosxuuRFYWMC7tLp6kb60BvNWaEYxXgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270149

Hi Konrad,

Sorry, I missed carrying your Reviewed-by tag from v1 for this patch:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

If the patch is otherwise okay, please feel free to apply it with the tag
added. I will also include it if another revision is needed.

Thanks,
Rahul


On 27-07-2026 21:15, Rahul Samana wrote:
> The PCI core needs to associate the DT node below the QCS6490 PCIe host
> bridge with the enumerated PCI-to-PCI bridge device before child nodes can
> be matched against the PCI topology.
> 
> Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
> bridge can be matched by the PCI device class.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index fa540d8c2615..12594967d2c2 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -2296,6 +2296,7 @@ pcie0: pcie@1c00000 {
>  			status = "disabled";
>  
>  			pcie0_port: pcie@0 {
> +				compatible = "pciclass,0604";
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> 

