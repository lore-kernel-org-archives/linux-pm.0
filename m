Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFA397E83
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578576; cv=none; b=o35ex2LBXOWAE4cb8thNV+Qs9AbfR+htqxcJuEtAAXD0NRHVDtTIUjJ9IPIKYzKpFTzccsiT3qrIwQZYM/hr8jHa6o4TA6dyy7uTV0LJj8iucjqDLyf7ScQ35ZV9SmwSx2El58yRwZ1AtawWmvH/FXadFgL3dpfdpkCcnvn8NbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578576; c=relaxed/simple;
	bh=2J4zbkyCRkdxpNFBhWUmGJNe5DuiJpTy1rHHoz6v0sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGBs7fy1+GjN6S87hf1W8Y3TflOY7Pvm9frOFWfamriG4NcY3uYWHg10l44FiZnQFzct3dzMAbrBEhWO98QN3i8j4+A+5KSyuXTBHCECJedugSboyN4ZhrbrP5fNK0fB2rG66lRi6sem+nare8wUt+lf2YgG0lQOaQrgb465U80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cr5xdDtv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kkRqQyMH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cr5xdDtv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kkRqQyMH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CgAIr3402637
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 16:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qSJcvPei7/x1R8FChuHMtIgl
	/NlquKOCcLN6Tv4gsmE=; b=Cr5xdDtvlik4Drtz1kPoA3z34IKBFzqnTMjxrSd3
	ojJPDQMtaeGaI6qTE3fa+FBqTwweOyajC/unTRF9d0NdiLw4p6nbaU0su+1jPoox
	iyf45rI6ks9tNu2Bb9gE3+NjVx5denIfZkT76VV0RVntOeXupCGkQLNj0wMVmz0z
	+jRV2jOITI+joE/VU36q92+U4HlUdtZr8B4CerlNA2itA3o/knjaieiIwa9DVdR+
	98CSOtQEd/nQvZQ1fPxU2RNt2UpwmkbG8CkCQthvpN0kd/f3+CHty1ie68stgnBo
	VFaatLb9STrj0S8NCoanCMwmViKg46MLJxbI5qIgNON57Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhuj1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 16:16:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so39575eec.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578573; x=1776183373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSJcvPei7/x1R8FChuHMtIgl/NlquKOCcLN6Tv4gsmE=;
        b=kkRqQyMH5q+sH4/tzqN0tGTFr3nufjZYbfMO9jLIv0ByxIIvz+kZGBem0L8ZGYKm/N
         DhPwq31cFQtFVHkQoNOmkmYIo3E4M6qui6C2C3DszPjueNIFWbldcqh6lQFE4DF89T57
         Pml176a0+PQSu1NJf4SybK5fYMUI5V1ph1OyaVDRWvfeK2HujLeAAB5fxDgvTMPhhJlV
         5e9+xLdi683D8H/eRoqix1LZBtTLvIt+wDOIB2qKmPV2natWWZnxyLQMOdxEl/HfI0FN
         dAO5uzWa4nESmhfOi09g5WWG30lKZkeqRb5ibmXXE1ppgxxhHTSlBNVxGZcOzXCmz9Lz
         UOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578573; x=1776183373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSJcvPei7/x1R8FChuHMtIgl/NlquKOCcLN6Tv4gsmE=;
        b=O5poQJVQ3u5VN6YvSzVe1lxFu3tTgmOeUrbpD77Np5FybdChG282twJdodcENKBeLi
         E3XRzcbAIj9Ii+mvfFblIKAMRrCQ02fpE+voZRHZOXT7R/qXPS//c9sGeL5WY0nwSPLn
         cE9tTXPcskmvoCaiUcmIvUTOgcmQOrV7EHbPD9lqImIByGa35ZvxkCK/NFyN49eCMr4A
         4SsO+Si/QwYyLmkl46TLa4VEOrrOPjxm8D24q7nn3YK7t8FTzIIJFIJ20B8rVALGhxni
         LX0OX2J4DXHkwjE1PhjwX0OBuFWQZYrYvUlCWvr7eB/EI9sCRpWKchriR3XcJ5Dj9Njv
         crLA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8IVny3UcTOmh+AYLlqAyGrZTvC20W4Fg8Vx2mVcz7+9FrM2IhEDUHuv/PuJgRrV0cfOfnUGCWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlGW9r+FPPEvjnPM38CWlh4clifIdko8EcW5Fko9rlojnpbpCQ
	YZ9jzTcTn/C2HyxXam26eVoRdX06hDldrTceWIHlpFYogKAzDdZARYTqojcWrGqkh9qT98vta1z
	IzLr9SPoxsU+iAyRaxOesE9wx51e528PE9dw/ENKeoz3W9Y/sR2Ky752hm+UOEQ==
X-Gm-Gg: AeBDiesp/+74ADyMkA22esUABnSyyTc2kOnOgutbKsNySTBW3Yw1pd7ON41IgkEzpX1
	jS2tz/gQTMSIi4l7hE0v60pA8y4z2s07GnuEUVKaK+uBXE+A7XE7YRxuZr0MA09QegNiBrQxlMn
	8D7Mxp11DLvQ/yV8FTHftAAdN1LxhDp0v+vq9Pn3FolAod4pI5U5eYVGIBRkwtMIDsQ4/HO82RE
	s7J7x/e2x//igNWQMj7XfkpmUmsqvwMVRugawTIh8yhD6PNZYaFxhBpK7/gXgoT3Ra0fqV1nXOG
	6m3gidMmn9RewdwVsm7S11E51SPCiJTqpFiUKLzBKqvwMjUKH0q8dkI9e+/qc7zcWdY6OJcAu+s
	RGAwc4Ibi5lT8eMEtynHAXDkh98iNP9uC9ZZJZCvEm/LlYCfLXeMimmB/H6wienBeuxrR4U8Bqz
	I=
X-Received: by 2002:a05:7301:3d06:b0:2c5:6140:54d6 with SMTP id 5a478bee46e88-2cad60cbee8mr8792161eec.1.1775578572542;
        Tue, 07 Apr 2026 09:16:12 -0700 (PDT)
X-Received: by 2002:a05:7301:3d06:b0:2c5:6140:54d6 with SMTP id 5a478bee46e88-2cad60cbee8mr8792136eec.1.1775578571936;
        Tue, 07 Apr 2026 09:16:11 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c20c0c2sm17775196eec.17.2026.04.07.09.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:16:11 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:16:09 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Hawi SoC
Message-ID: <adUtydkb4q7FfbS8@hu-mdtipton-lv.qualcomm.com>
References: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
 <20260406-icc-hawi-v2-1-6cfee87a1d25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-icc-hawi-v2-1-6cfee87a1d25@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NiBTYWx0ZWRfXzxq7lI342MA1
 TJe6dUtxSLn6jijz8QBb9c7vIT+ENfCJdazaJQXHpGrjH2rr9iwDp0xWaLO3W8QrAV3W4BRqr5t
 aoO+pSMTGVcCCbyYq9zThWRVsNv9TJyf+UjySrLf4+0Y70ReuZBrs9hao57ikj9mJs0f8JGDwpd
 yvU718XDOScMOMiz6icJAsvCzt7ANVNRcKWERbZIGSDP4nGN1HGbur3PV5MDKuMo/6lb8A1px+3
 yIz/s/OfumhNmvZVR3SeOUbDURukeKRjlc1lInOpPTFDWYxsWpxO5eCcJ0ByLjFe0MaZOhx23me
 mExwPkWBfbHGHpIfP2sPdrMHU0/cvo1qXd0SuvuFTQaTHZcTz+peUhp90P2F+5zHbZeOG8VHW9b
 5dfRKhzpGKiGPNoDgoGYFArfXI50OsiCBZo5+x66cIIHnin6Xkv7MdWCVCJtok3OHq35F6VJHHM
 ehO0uTW9qRVnK2FhDKg==
X-Proofpoint-GUID: ITjoHulALxzpAMuk5gV2KVbNrpiINmS3
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d52dcd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5zgHMrtXnVmdyp8FnAAA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: ITjoHulALxzpAMuk5gV2KVbNrpiINmS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070146

On Mon, Apr 06, 2026 at 04:04:41PM -0700, Vivek Aknurwar wrote:
> Document the RPMh Network-On-Chip Interconnect of the Hawi platform.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,hawi-rpmh.yaml      | 131 ++++++++++++++++
>  include/dt-bindings/interconnect/qcom,hawi-rpmh.h  | 164 +++++++++++++++++++++
>  2 files changed, 295 insertions(+)
> 

[..]

> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_HAWI_H
> +#define __DT_BINDINGS_INTERCONNECT_QCOM_HAWI_H
> +
> +#define MASTER_QSPI_0				0
> +#define MASTER_QUP_2				1
> +#define MASTER_QUP_3				2
> +#define MASTER_QUP_4				3
> +#define MASTER_CRYPTO				4
> +#define MASTER_IPA				5
> +#define MASTER_QUP_1				6
> +#define MASTER_SOCCP_PROC				7
> +#define MASTER_QDSS_ETR				8
> +#define MASTER_QDSS_ETR_1				9
> +#define MASTER_SDCC_2				10
> +#define MASTER_SDCC_4				11
> +#define MASTER_UFS_MEM				12
> +#define MASTER_USB3				13
> +#define SLAVE_A1NOC_SNOC				14

Let's align these values.

Thanks,
Mike
