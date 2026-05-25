Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0320010A
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701266; cv=none; b=nNUoPSvH8+X9ma6a+xRuigpT1S/3IYZcu6di2jgZh/fRAkMfg5QfiLoadboSIu5FCpbDEycyDaBczL3X4E3kMgtc9dXzQCt11zJDPvyUHQvT4uuk27nTgELxQaHvAItGh1UeKsslTgDOjRF2cS93hqXfxh/fDidCpZMN3otcjQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701266; c=relaxed/simple;
	bh=mb83qbbxTmGxdL5OR5cWgWlR5gSfuaef+L9b3Ihqdd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIS27ldi+iVglHqO/3GPozkXe2UsZIAaJC4XNCE8Y+8D/3wYNKpMvcqbgZJDGkEulSsy6A2+TuSFPlqlxHgKbiJCCTIANseeDAiELbkoSOZl3WuW5HoK0xB0kU5fjirbOmbzYLjhzfBDjbNeXWYO+W8NkObnQpBGPDKHKROnr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mmOJRszz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvEUM4wb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mmOJRszz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvEUM4wb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3ZtQG981344
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=x2UemusCsMVtYZL72zrXHcNp
	cJp6eLVEC6vKKsQ8QBo=; b=mmOJRszzSuMpo7ZhjzQDWwbvTKpTkIkycy39pmpP
	ipxraPadlmA2unYtt0f33C85tZXcowA5qSXv79/iNfgy0ddZmEp5sdrkHTwvVPiM
	jDMb4hDV1kfVeGyIO7H/txARoku2Xu3WS9lZaZlaeI+atQOlIXrsBYN8LjBaXF7q
	x4yCz5EwOgOkZHhbD+lMipY7Tq86vxK2y0tlXpILRjj0QiCjo6jUg8H5Um2fXZ6P
	mn0rl9f3EXINXE5QDwyE/fAZpwudnDFnuWz0UAHZYEEGNMDe6NAahoBFtkGRFFnt
	ujacOxGq8gYxujTfPrcjRQMqLVy7YLeKEki+WF/QBrVUIQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386p85j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:27:43 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5753ef2562aso6990583e0c.2
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701263; x=1780306063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2UemusCsMVtYZL72zrXHcNpcJp6eLVEC6vKKsQ8QBo=;
        b=gvEUM4wb43wIK0qiMlM0C0417PtzJSiNdFSnUPVUkgGTc0qG6tdNB3/69ilwa+x9o3
         1ciDjkcdGPceLQVDMz3juhZZPmsLEhtGqMxFBHExbLfiLG4nT+lFluV+rZ2I3Z5Eeupf
         D7MdWfC3nTKBwG+5w6YbZAgG7Wb0s+hgFfxNPsDJHoBh9Gie5hIrR2umeZdJw/olN3lG
         OjVDCEPz2rqF+c7jGaNYBKVE1w5XbGj7dp7GgWXsdKhmggrc//O1375k3MlTRV5tQiqv
         DKQAWSYU0z2ETub5dKgfFhGgObLSOJtP/0Ld5Jpv57jTPDRocoFOOZn9koixltXGOTDQ
         +Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701263; x=1780306063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2UemusCsMVtYZL72zrXHcNpcJp6eLVEC6vKKsQ8QBo=;
        b=LFkMVnD3qUqj3cdmCw6Wp5GGYhglHIzjz+Th76DkDs0u+fwrr7PObRJAqT4cy/MtEW
         RWGZ6OHFA6qF5ecBLRX+0I0a76DdQdAnawIJGkrTdP8O3qwuLfNZkbijO7MDt5XQQM/M
         qP7o8tYISsHjA+nKuXPntPD51Y1ZVLdyb6gfezwy8J0bSa8979dO/QZXo4+U4Tdn+4uT
         RBqfZtimlp/YdWprQxjOlsw8qo1qtGMjxyxOXILBGkEzYTY+RTZJDO3wrw8Uklk+REJL
         7MVt1UvYQJOvk8Qo4dNAyAfL7j3vY3rq7+md8P8yZL2ERsK6b/8tKOPgk51Od0WeFx1o
         x8LA==
X-Forwarded-Encrypted: i=1; AFNElJ9TXxIoX2LbAuUbIqEvoRQK4hiXi9z0clm3rn41rFV2usRsYgiIQRzAumrNZp1E7mWgW4ygmymNYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRrGdGd7ikU26MK5n22XKlCos1xGPWCx6QUIDCdmQVp9i1vTD
	gx8DBX40bN4ZdJj/AfvsqbqOGGxuRASWgJqrIvm2mS/JUiCuCIOOZoenrwEIpF18yLn5ZNLv9m9
	PLTCac/pSc+Js/HVLRd7LKv32uWti4XhK3LcJ53744TuGu+o49BoVNu3Pke554w==
X-Gm-Gg: Acq92OFUC6hmhjWx1VzokOgIk1RAitcFgiNNm2SRGAoMDLVqPj2koaxljGAFze930me
	Fh2lzdsODiNiD+nKY94Tsy+FdCwP/rvGGvvzw6Ly2kN1B/GeaZCL/AnFhKW7eVfKDvbshpeh/yu
	1/2WcjLHaWXlzyY7IZRs2dAzSKErwlBUjRTHGkpaxZkq3ysaMmgorBQDBAyRze3mkYb8b7fw0Yz
	gRngIrqzXxmcAhA39Bq1BLwpzIo6cfmACe4pVezfUMXOR9JB7S+czSJNFVzqGQ025LkkFvGV6Q0
	o7fen6h6q/Z5MGY0iRLyBQrqZ0flVe//F6rdfIzJDzySE7h4/zmtSbj9kC9r3XPHROqqluXPOvi
	DBSU+1LuXZUprqpiNrvpaACaDAxkzghjExb8lXjsj3JB3Ze+7/aWk/xGBIMWn2qDgO16aF1E9Up
	wTIcfhm/rHb+k52pmW+LY469XH0S3YysEmjJZq001GM2i4zA==
X-Received: by 2002:a05:6102:809f:b0:62e:c54:fccb with SMTP id ada2fe7eead31-67c85c33d2emr6532618137.28.1779701263300;
        Mon, 25 May 2026 02:27:43 -0700 (PDT)
X-Received: by 2002:a05:6102:809f:b0:62e:c54:fccb with SMTP id ada2fe7eead31-67c85c33d2emr6532596137.28.1779701262751;
        Mon, 25 May 2026 02:27:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb37a7sm2564336e87.2.2026.05.25.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:27:41 -0700 (PDT)
Date: Mon, 25 May 2026 12:27:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH 09/16] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Message-ID: <4guumv7ve7rshw2pjvumenopxsefha7hvj26tw2pgayz24ytxk@iry6qyqqqs74>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-9-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: bhI2OIAZ0Gj5wBDTn_kQyWyvVtEpaUy8
X-Proofpoint-GUID: bhI2OIAZ0Gj5wBDTn_kQyWyvVtEpaUy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NiBTYWx0ZWRfXx5QRdX8PX2Gh
 RbDT0Buc6lNMfM1RceLdrlggM/x9tS5GXR5VCo58eTelLZqneG1CL97ZCvDHCW3UFj7O7hrezaI
 aUfy6pmkpd1EeKYm9piMsZxKD5MOYlx+ynktXceg1hsaTMYrazcyxsg1Cv4jqyi5AYBxCWCfj/e
 nFpVN/lzpcrw6B+sMvEd3CZEfLg/hpQad5bL0o2BdDhk39ii818SboUEcmNCFbDkOKZoYiBg3tJ
 eQcFMB3xvPos8tqfVdv52IjRDAchP9ll2MZoxlvGm8FgJzmYRsuKIIsE+ZdBEl0EZX8gWFwzhJy
 rCUWzYIcCGWlVk8DVd/arwEixY4LfVz7tms0hJVgIzgg7cF2GXr5FHR+gmQYjyPodnoT7BkXLfN
 WoKTh8L6q3sOCnyAOK37t6aefn18Lnnt9DqwgyrzOtAmaHU5CJCQ7mSjz4L52bQc+fszjb7Isl8
 Ll9V4Qz5YHZl5EC97/A==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a14160f cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=6L8jDZTAue_LqfRzy1MA:9 a=CjuIK1q_8ugA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250096

On Mon, May 25, 2026 at 01:19:13AM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 
> +
> +		remoteproc_lpaicp: remoteproc@b800000 {
> +			compatible = "qcom,shikra-lpaicp-pas";
> +			reg = <0x0 0x0b800000 0x0 0x200000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
> +					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
> +					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
> +
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "xo";
> +
> +			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
> +
> +			qcom,smem-states = <&lmcu_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			status = "disabled";
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
> +				mboxes = <&apcs_glb 9>;
> +				qcom,remote-pid = <26>;
> +				label = "lpaicp";

No FastRPC for LPAICP?

> +			};
> +		};
> +
>  		sram@c11e000 {
>  			compatible = "qcom,shikra-imem", "mmio-sram";
>  			reg = <0x0 0x0c11e000 0x0 0x1000>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
