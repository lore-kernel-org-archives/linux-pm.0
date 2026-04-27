Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F1373BE9
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325176; cv=none; b=PgGTw5cLY2+XD9j19gwL7Q1ZBkevcZUAlDJnlkjDBa3ag//tHPuYzqP4JHf/x265iDs8lUZXxM2g8SAhOwaTwhXj+VyJCHmdCEX4ewjm941wtF2GD1583fauomfPFmQU0vUk1bulW5HPO+vfNT5NxWLMQOCvSYXUmLKO8w5IJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325176; c=relaxed/simple;
	bh=bSW3WAoBsrFd9H0Shnwo+F3LEYcpztafIuWLW0/ey7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+rx8o8OY4+Vo7QNBsaPO9WOG5TXF8sGuoYg7KMJEqn71sJd+ned6VBVroGRSnmLVe+KEYyq+TnBNYzB4sR7YhWiR3UZeIcxR4Zqo9pxGJpAcP+j/Z+SaDwcwgvG/I79HYiD6bWPsZ6C6YkLZYZ9T86be22nYaQQtAhqsp9RIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FFY+L/2C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KazArD5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FFY+L/2C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KazArD5x"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RGYAV23123516
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MrW1+n53XVO/1Nwe6562dqWB
	qJzHztQPyL2+RkJZeog=; b=FFY+L/2C1G3HJL/qVawdllPRlyp7UAv1KtYIMDIS
	F1Q9dke9bYRu5QNuqnupM15zObumRApEo3IO9wMWNIjh2XbGWDcKBz/jOze6ZULk
	cQ5rru4hWkHd3SJevvGAjlJKSsrlydeRFDKhNxzhUVRbOOuCqRFA3xwMZn1ErvKk
	YoDQFFn/mdN4DRW/22uUzn/4MELNd03vHYmg/IcIwYUswCcSSxWnBv1k4yzsStCZ
	kKeozLgJQxkI5CtH0lMHEgmQdimvm3jgxCGvtbWIC79C3Xf+veOQNWZWkMcvsODg
	mO+GwUUG82JgRQPSSNVsB4w5Rl7ll4z9EtgUKu2TNriJKQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgjf5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 21:26:13 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12c91ef7009so31339355c88.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777325173; x=1777929973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrW1+n53XVO/1Nwe6562dqWBqJzHztQPyL2+RkJZeog=;
        b=KazArD5xDOb8DIs8HJJvwXBRGLENTbOY7uHG1nnc4iJ5RS+wLdj8iCofRSwEbHs+XQ
         nI4uNQQVM834xBs5lXIpfN0GhY30Gjz3GoAedf48bIgmdxuyEJt+fM4dgGof2DU3ZzhD
         NgU58cz3rdqqNj6dSq7l/t1Qj04pMC69x5sc39s/avgRUxAm7v8lb4VsG4ka11640FyG
         9CwnFPF4LszHSf+K7bc3Te2BwJbtigzcFiA0IE/BL2KcMEzTo+y30Pu6FhLBrjQ9mIfa
         h7PppbdxmVz6xz75dwSVmfm9fk0NUDUgAdJPxPGRTv7drFgp/S5BNzo3YVUTEXhhXr38
         42EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325173; x=1777929973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrW1+n53XVO/1Nwe6562dqWBqJzHztQPyL2+RkJZeog=;
        b=Gf6kYQoeC9r0mdnRYbHJ6RZcBLl5XddM2WrhMLn+dk2PSVQMjf1P3isicQ36kP10OH
         MiwUx1KJ5Ahk5nOMFC7+5ZX05wfnkXKjHGwOlxvh4eJ9kzgH/rmnWCNK3b2uUdMNPzN+
         TYacJ9xH9zMKMzJn3v9tt7CiXetFRIVcCuf5Y6D7hnsYHVp8oPNexVRqCqAcqhs0hFkV
         BI9oPXYI5ga9OmkQM9l8EqVCpZkOvrV7L6W6M0wLoxxepuWSRLQX8+sJzCAb1zc63KLx
         jPGRSgP9X7QIUIbecyjrxHS15rLtbe+X/6oZJUFYrw4o3KroqSpmW2hGG2nVG+7yujRu
         FFag==
X-Forwarded-Encrypted: i=1; AFNElJ9ZFSxXbPDi/y8Jm0PDS++0QrJJdSoz1lswXCd/NRy4NhkikZ/FatWBuAFj5gBtuzSmfMKfIdIC1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYKZ+tsSzScQpqBzkFAzpgFAIDETQoTaLywyKs0x9m57jvLRt
	7wkx8ssgvAmzSKs6TNHAQ75NP88LIOyn7MsKb9dZlk+tgGZ2uqwIMG2SMlNtglfCVMtKhjP059q
	di4wZ/dKvVhdVLAEtTw3cEjUOGYg5qWz+qOgJ84PoLZkOZspUw8YiP65Dsyhw8Q==
X-Gm-Gg: AeBDievKlW+cFAxRMei297bC2BbtuP3LFQqc8aCCtbFXcm+EesIjJlWeThgpD6QxIMS
	9XuBogpGlfGI74EfiByuaYRM/JzQAKS1oeOmIarXgWjXZdeu+I3AETFV5atNCAb1x4ODEfUJSyl
	LEGn3wJgXuUALQC4fa0OtesTxPd9wSRSq8Xw8tjJGWG8voT4FWhfd/0JC96AgYCkoJUK/FtQcjr
	XDANlGZiTw7qb9UNsjng4FWtikOXH1RvFBWssxpM305HqmnOfyBL+m2drqta1+A3HpVIXX8iBQw
	60NH7/wOsIVsCkQuzzkIee11C6O3HtGVCv5kYNPDfkkI3rwNKMBQoZOBRFKZPl+LRfQv4Y4ekHj
	dvxJw5JqJs3ygk4B1lfN3/ToQsnMwANqUWvNbkng8Q4/EOJgBGOAY17Bn4T3bjZsqAFN87K5X6u
	muTAHkC5aTow==
X-Received: by 2002:a05:7022:f94:b0:123:348d:8576 with SMTP id a92af1059eb24-12ddd93f1e6mr393410c88.6.1777325173236;
        Mon, 27 Apr 2026 14:26:13 -0700 (PDT)
X-Received: by 2002:a05:7022:f94:b0:123:348d:8576 with SMTP id a92af1059eb24-12ddd93f1e6mr393385c88.6.1777325172657;
        Mon, 27 Apr 2026 14:26:12 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd93abadsm592162c88.6.2026.04.27.14.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:26:12 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:26:10 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: add Hawi interconnect
 provider driver
Message-ID: <ae/Ucn8kiDTdjPdQ@hu-mdtipton-lv.qualcomm.com>
References: <20260409-icc-hawi-v3-0-851cac12a81d@oss.qualcomm.com>
 <20260409-icc-hawi-v3-2-851cac12a81d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-icc-hawi-v3-2-851cac12a81d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIyNyBTYWx0ZWRfX9blJ2co4UbOa
 6VSjhMkwZQrQtaykKm1XkEwFV/w0iFYfrdRz5/Ynhtkb9LhO55hQ4UK/z62BG+F5EpgCkQvYrF3
 ZWtMLCXMwqSA6ClqbZDmUUvUOdlRAt05lsAcb/pD9pfRVe6hvcRetWyrOuabO7b5YDVY/wuy76g
 oXu8rlBv92UfEoyCimr0PsoKjua6Y/Q5Rs79xs1v3eAzA3eXrlM6CI56WARz4UAYoKVst1jzj6K
 8/a+26QF4XDD7j7am7oCgA6RR5IcHpN3arTUw+g2SHIxYd/+QDTki5lJdhEVtoS4chaI62Pog7S
 J8h1lk7w5oWCrvkQzhdNBeyhww/IlXqD2HHcJKalAMTn/47ALQeek+KXVyRybLU4ip338GxBVdS
 JIpKwK32Bhe5z9Ft0cOWlgDCyP7DeYylb0RRtOXI+CmXHx8HFnCZxHpRkhH+ho0bSgfQ4LKW//W
 sDzgff+g9XgAwvKWwuw==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69efd475 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4GzhDZxwaX2ww3neWW8A:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: TN8H-22YlxF63aFf59AKUQI8JM2qX0zM
X-Proofpoint-ORIG-GUID: TN8H-22YlxF63aFf59AKUQI8JM2qX0zM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270227

On Thu, Apr 09, 2026 at 02:01:38PM -0700, Vivek Aknurwar wrote:
> Add driver for the Qualcomm interconnect buses found in Hawi
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pair.
> 
> Reviewed-by: Mike Tipton <mike.tipton@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/Kconfig  |    9 +
>  drivers/interconnect/qcom/Makefile |    2 +
>  drivers/interconnect/qcom/hawi.c   | 2021 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2032 insertions(+)
> 

[..]

> +
> +static struct qcom_icc_node * const cnoc_main_nodes[] = {
> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[MASTER_GEM_NOC_PCIE_SNOC] = &qnm_gemnoc_pcie,
> +	[SLAVE_AOSS] = &qhs_aoss,
> +	[SLAVE_IPA_CFG] = &qhs_ipa,
> +	[SLAVE_IPC_ROUTER_FENCE] = &qhs_ipc_router_fence,
> +	[SLAVE_SOCCP] = &qhs_soccp,
> +	[SLAVE_TME_CFG] = &qhs_tme_cfg,
> +	[SLAVE_CNOC_CFG] = &qss_cfg,
> +	[SLAVE_DDRSS_CFG] = &qss_ddrss_cfg,
> +	[SLAVE_IMEM] = &qxs_imem,
> +	[SLAVE_PCIE_0] = &xs_pcie,

We're missing the equivalent for SLAVE_PCIE_1. 

> +};
> +

Thanks,
Mike
