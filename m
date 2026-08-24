Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EC346E67
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557577; cv=none; b=nDMROe0Thxj5vfDSkrrYLKbsYR4YVyK+DweA8HTgRQqSuK5g4jSiXU51nNPHisf3FnDovsxTonBcEOS6okAP0whp4XIhTHAir11k5VYSoodv96byNSPhrnb/mYZropsjYyj/Yf1VcxYxQY33hUYhZ6m14WFps7pcJ9hkPSjq+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557577; c=relaxed/simple;
	bh=oHDdeDzlMyKWjdnEU5UCzfkNdo9yiXY2stBua2Rdasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7+oYn4EhRyhDbg6LVZYZpPxKqsA5Ok5DQeJsfd3/jaVo+sH/k9o6T8y2BXCXfgog8xkspkgobUgDZR27MIaFv3PrIUFiFX7GO8746swvIR47l4VeZo/hO56d9AbZ23PH3B9LAb4YLC5KkXbGsdJ+lDMdKioWASHV9k+Rn9ZiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebbm179a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JtraYgrk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebbm179a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JtraYgrk"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O7BfYb1815859
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u1UEfkp70xx0vLD/E4HUvwEd
	QnrJJo29zF4VvLZULIE=; b=ebbm179aTnExabRNo4ZQbYNeLgKwGWYOFwJVTYbe
	oqQKvsXbPIS8I8elsQS98Vxx9+ifEfmF2xl6pwR0vDpk1THK6e+KBrl2ngSuAuZE
	NlNcmveh9r3Un51vCDYyzd9prwusYrTg0ZrHqFp3IRpvv3nqvT/EOqmwRdr/jJ/3
	nITnt5Y0CrHAwJrnlowRDDzADz0VWXFHak9NEHJTYIxuxCXSLaaf/7bXXMiOLKV9
	sym8Elu4gUEqfg9qD/dJ3SRo/dhjM0+q8v6d9VtuK5t8HYXa2FdrnLcL4BUjZmvH
	Ak1AlFCYbns0RZO3jS/Lyo1Pw1ONdjoR5h4Rm/SrBPO0Lg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbtg45y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:46:15 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so41126991cf.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787557574; x=1788162374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1UEfkp70xx0vLD/E4HUvwEdQnrJJo29zF4VvLZULIE=;
        b=JtraYgrkcKsTYJncOuz6ucyu2ZmXE+4A32a8nmiOs3iMOIUKKQD/AdNPEmNBTHBDBf
         sJu1MC3PS9V0Vl5u9BEYK0aCyRVRTf1XGItpRUztssjQFvcCHkGXDMEgSDrTq8ZU9mFD
         nQE2Yu9PziKVgdNFG7g6flTl3rW1ZWQs7zGteeevloWzOnDZZhEq8lXrRuozN6NaE9Hs
         5PuYF8Sztx+cSmt3t0iTctlhKu0cj4wNYzkD/uK5WZFuUybpkYCmAMfGioLUGr1oaedY
         25Wu9hbMo5GGwqkS6tjDQ/3q254sqn9keOPUpa1yLXgy0mxh5vd/Cgdm20FtsXJgAZ+3
         oeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787557574; x=1788162374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1UEfkp70xx0vLD/E4HUvwEdQnrJJo29zF4VvLZULIE=;
        b=HBbY10EELdNgv+ML2DJk0gtg4qPCjgS1tVZYOrCTx68oJUC/t8HTLgghBBSFKhrEfH
         oR850v4BaSNYrTYEapTEp9Y168+XSTr0pN54lbJ8Zk2g1bDjZyrH4abh+Ct8nNUtIQiG
         bMBTtv0bHwkimAy6NkLOXA2a6AiW3/RVrxK9bKpO1ceGiezteEIFWBrG02ELec7hZ/Ac
         5aZoJSVttA3iRJsMj0Gl0IF8ZmfnfNGfLdtDzVNt97C9wZm3HLiQaDJ+fpFE/Yqtes3s
         EU+pm5nhRCxeB4Ol7zgvcs4rgrprVfedpD38DkRxSiAUpeKMWCxccVR16j/yIYa+ucis
         Pz8A==
X-Forwarded-Encrypted: i=1; AHgh+RqQt2o40/xV3k+YKNyQtjYvd4tgknrfKABKKyd9CeKz7eKTpKYlwUcV++91LFQU166HXZ1Mr8xN1g==@vger.kernel.org
X-Gm-Message-State: AFuF++lgdlnd9awjgP/yV6qUDjJ2Iphoncone6HL6qh1/nlOqgn9VdQf
	Xaai58MCAldUfml0dLhj4pFMouFLPUEcj63sWps4Dt1lLG3dXpxlm3G5J7XWVLOCznTHZsxMVwQ
	Rb0Z668cGW6bcLTdxFbnfwMIagPEx1f44IeuG8SvA/ARjNvTgO620Xdbvy+aupQ==
X-Gm-Gg: AR+sD13ayEoXBGbTup/o7QXV+RRY9RjFzqfpAMF5KM3Ze4C9s0Dj7BVZSLovdiADhto
	eSW4tofmjmhFAtPVVHW8wGmbQLjdmKOavFB5VCz+MEhsnI076qGKtWcYuqaqITnByl5bnAyg/TP
	Qj5ErOkVtg1yUy+F578A29LeyUcL09LW3NKhfHODgrztwXMX/blk8usZ9Zx87Itj1O4Xd8T3WAN
	lWwpctreFuarUdZjdQnip9IseWXSov4T5V96t7S71MiKY3kbczaGBILpc9bHKVW24giZYzwLo08
	MjJ17UNbRVeNdnCKQEHQReXS3DMBeurqJbHByXJ58H8ReCBZxM54E3pjjDT80nJ3DSfRP/cI258
	KwRddVIo8mjVVE0g=
X-Received: by 2002:a05:622a:a07:b0:52d:94c5:2212 with SMTP id d75a77b69052e-52df56f696amr234846581cf.3.1787557574369;
        Mon, 24 Aug 2026 00:46:14 -0700 (PDT)
X-Received: by 2002:a05:622a:a07:b0:52d:94c5:2212 with SMTP id d75a77b69052e-52df56f696amr234846011cf.3.1787557573742;
        Mon, 24 Aug 2026 00:46:13 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f9cbcsm1254309066b.29.2026.08.24.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:46:12 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:46:09 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh
 clocks
Message-ID: <5gwqlrycd36aqu2xhzcil6rs55v5qbe7yshhbedwacq3xvaufh@5xi4z6xyhxls>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-5-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-kuno-soc-support-v3-5-196e2b306368@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2NyBTYWx0ZWRfXydsz6/Qzfjqu
 0rrVNdwoxaeLI9gSZt/zVn2tv0oIZFKS0wDTWvDHt9LUvWugDflaSatzUHurTCMirXtnCfvsuKL
 BYbodAK1aC7jY9jdiUIa2X+U2De8rm+xB2wC/XgpcBLUMVHWZV90ME8YXh/qrooky/w6WJg3W3s
 K3PawdJDnXTmM9edS6Q49d+k2eaAABbKewER77Do1Gn55WPnaK5Rsb7UzPff5q25zpsC6hlqLq0
 Po8bxkkPMKexRvp6ncG8kE0NdIgIQEgc7DFBHEINXyd3thsA1gjoTnTUzggi/AsbEdk2n6kp86k
 fMi/FwNekzafHl8K4OLufqdCjWdeWFoY97wBKQccslU1CF5mz/SB/nsSAEatLwbD3qcQ5BGhIG5
 d5hBbu3Xvk5E3gExCVIzFiwO27VywwHDa+KhB6u5pHp7PJm3dg1EJxo8U9YkRbUUKzl70KNRcFL
 IkSryCycF9Y+OJ82Xug==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8bf6c7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-YGGs88sVoTMC7_f4VAA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2NyBTYWx0ZWRfX8X8vlbY4gBqK
 72YeragPXYl1hB3/d99h6MRq8Ymz2x2pXjp25yqiBIb0B7BGgIzDsnu3LbqIzhy6Va36S+1s6aw
 szNUHu/00B9G6js5TLK+wyWml8LeQkw=
X-Proofpoint-GUID: PJYI4o82Q1hVrTwu4NJlDK1TIswHDfrh
X-Proofpoint-ORIG-GUID: PJYI4o82Q1hVrTwu4NJlDK1TIswHDfrh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240067

On 26-08-21 21:38:58, Hardeep Sharma wrote:
> Add the RPMh clock description for the Qualcomm Kuno SoC so the
> qcom,kuno-rpmh-clk compatible can provide the RPMh-managed clocks to
> consumers: the CXO div-2 (and always-on variant), RF clock 1 (and
> always-on variant), the QPIC BCM clock and the IPA clock.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
