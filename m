Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098262;
	b=CAtK5hAcdd/ScwXiB0VM/BPYY+N2eYkmibfTMSU/kptl7lhxfWKgZUUjjwCpZapNW304
	 Fv2frqH8Yce6JQIf3dXxo+bMvOSYYFML/MGAjAS9LspzXst02B6JxmXcyi2E81M8Xk/Kc
	 UX5Kxe7eyrViN/QfvUXEg7hl/IvAIpoAk+IWAq3xoJnhrHkniEQIDhMlJJmGVTN6wIfXG
	 21PTvl6R8tb3XEExTfVhA+hCtWJr2l0C59vKdxZ4MlMkZVB0fu/+TyW3CAzqnj7zzF9Un
	 M7DRQmrJBgyQs8xxSfr2wxVyM8c19lDod5MwMKlYnFzUuLa/2l+GKWvwXQQGMdqVnpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098262;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vErTbvi/ZQPb8LIOl+0TIc0pcHPhDl9usrS5Zx4BOH0=;
	b=wz9WO2n5o7SkEAJszWdsC7oFqkClEIb4en7rWF49h1EPLzljUB3dhXLL5oFi6fBKgn25
	 8hbErFBs5LDsiSUHGWmS/swNKKR9HD/PjSJtebBq88xcPLrH7GRuVLCDbd9W0L5JPIu6C
	 vC/QKRBucN0vNeagYhWXJgzi7SmBIJ3neXFfd1VyAZNafFH1W1wcHyuP6Nqn56VwY1KPe
	 7lkBcfO6APXxyuBxKf1NC3Kk65o93uScA5qXE82wmOjqkPkv41HGiM3JQwyqZOkQ6RiY+
	 M8Aka5Fn3/NGMUL/cPTUZlGxnZSMWzQZ93KGIWUtFSaDfGN7IwNlBcmOTZBS1Wc6Gfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MSykaSTb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QNBEQLf+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4C60A381B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 10:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC4C60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MSykaSTb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QNBEQLf+
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeQTH3013052
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 10:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vErTbvi/ZQPb8LIOl+0TIc0pcHPhDl9usrS5Zx4BOH0=; b=MSykaSTbVz4cVpJP
	W00TAT5epw9ybQl4cthSPnp9x+GSgX8L3NyPaFpoucf0Kn7bIEWzWipawrbAwDT9
	ZkfrWRnF5/d2nvJ81oqbtfD1fo1oKAuqcfgguJadZfgocV4JLiOjLbLQzTdVOfZP
	8+3K1HJj1oYQNSrIef2ByCkxlyyTAaJ6LNH0HdDkecXGl2xp4JAuvJbyBq7TtafH
	SD+pu0p4+usHV8/iVFpewdhdJycp0FvSQ9VbP7ykPpnaQjuAL4RSwU1c5owvZ30H
	QGfu5ZfOw93rRldrE1RdWygi/hgBBSUkvMOBCznzIZ+2RxPQMeYkOb/08d/lRzDt
	eiugHA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3damtk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 10:51:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-533758f24f4so6248071cf.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793098260; x=1793703060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vErTbvi/ZQPb8LIOl+0TIc0pcHPhDl9usrS5Zx4BOH0=;
        b=QNBEQLf+XUsTgInZ7H4RYs4xB6D/FSyykh6R2nN9ZfXBOAAQJbe9GX8i+HU8zP+2Mi
         RXiDO8xqEriAFxjWfFYjxVWGk2F8afVp0jxRYkGZneTvDy/0FfPMh6OZK2aHcpaozNj9
         G/6w2z4dEA6PY6jASKdSfxYGc128nTPrrXvi86/554dMGOhl984kTSwPUaNzTQmWqUo7
         ajhJVVHvm4ldPF74pYc7apdmjzcinWwi3HGwNgaW59IRuZiS0sqXf1ZWmnUMww1QD3vJ
         vyxTT8sRlNQ3/0AyX2stAquChxdcZqHUGoQ0Og/ITAuE3uS23s+f47Ve3cWcoTf7MD3F
         RaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098260; x=1793703060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vErTbvi/ZQPb8LIOl+0TIc0pcHPhDl9usrS5Zx4BOH0=;
        b=sBBbmj6woWrh9s/KcKFXAuoThjBG8WkA9FCOF18KnVfPM0Fd053hviCZMRAbUYPrLw
         LW6g8A5Lr/xHMA7p+SWQmL2RMUQtD9GCzIv81AUUGyVf8nreH8+6HuOUMjttnrTgf8ha
         YDXBOCENhAhk2vUjARfPNXGtNQmd1IniyqFben/esTxyr5mIwBX5aOKbQWD48t3n6JeX
         Mt/FyQ7BkHA7zpw/OYNx+r+hKS+Y9tkJ3W3sepgVHtathnqJ7O8W+MY9WXmJOB+iOG+b
         k6Fa6CyYDtv288H9O9E2D3WIYP8YGQIRu87JAbTBaBXtCfRAJ9B8CCitERtf5Ap683TB
         RvUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxyIIr9g16KeAFeMt6hYHM2l9Mqkf+ive7fUFm4OyFRrO3rQvn7mAilOfuk+iE8eP3roRKEXK6V9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdKswrhOuoaee+7XFbbeWYiFzK/PP0jGqRomIgbP4ypmGrowQs
	lHV0ge5yTG65G4Zd+47Fgs7xHwWnUYwrOYcEBKx7s3ovZyrl4YsV1bdrE9kB0QjuM85EdPz4pQm
	kOCDJBfDFGzq+DZRHBX3ycvqzYaZ7TsMzMsMfEoVWkD5g8Rsafk49vfMW0vggVQ==
X-Gm-Gg: AYBFou3gqn4sJF0nSMCWxbTjrNutuwe3eYybHIAe1dLmncdeB0ZinIzV0UK++e4PKg2
	0eBff6/ty0CvnrujClCmTEetLHLI23vNUhrLtY7bmgs7z6UQP6LWhxndRivg3D7KLLa1oCfX5eD
	vkXII/HRroLkLnGCUNz0/PHuqIFEVJErPI/R344ey7WEKYtexZW7gWOEhO9ryaXdvOyjoU+wfFy
	jBMZOgn1A9h1Of/7In3hX3P+RCmVFulH9EIUwcw01VQFnuwI0NT/dEX3vwGbwdrC5p8bWNEyp5c
	LHolFg2sceYkeF1pgf/AtMtDt3uoqjIm/ztVFOoKEe2l1DVkJr7mDxCkeWVtPk/n6SbPNs6AdtM
	+Fo8WepktN/g4okM3X/vSVvI+IPm22Wx+oKFQTQ+mRCB0+NnUvU/3aQndSqZyhl+D6BJqOvQ=
X-Received: by 2002:a05:622a:e410:20b0:536:27d7:abee with SMTP id d75a77b69052e-5383b3b5b67mr149413441cf.2.1793098259668;
        Tue, 27 Oct 2026 03:50:59 -0700 (PDT)
X-Received: by 2002:a05:622a:e410:20b0:536:27d7:abee with SMTP id d75a77b69052e-5383b3b5b67mr149413101cf.2.1793098259161;
        Tue, 27 Oct 2026 03:50:59 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm430409566b.64.2026.10.27.03.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 03:50:58 -0700 (PDT)
Message-ID: <5884eb89-5afb-44a7-83f3-642efcbcd284@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 11:50:56 +0100
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
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add SM7250 interconnect
 provider driver
To: patches@brar.si, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261026-icc-sm7250-v3-0-aa303226298c@brar.si>
 <20261026-icc-sm7250-v3-2-aa303226298c@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261026-icc-sm7250-v3-2-aa303226298c@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX9wPtXttvqE4j
 lkmXVNvaYHvYMgh4oRGmRYIdtNgG9Ld/G1sh4pRZ3apPT067S2CWfRFUPk+7FrqvfWVaB1NU7ri
 b7jXf/mqj2PsVf/g1lDTUyyHc1Pc+PM=
X-Proofpoint-GUID: oAgyaqEzu5CvH76KjtBhOzAaITtRQXfZ
X-Proofpoint-ORIG-GUID: oAgyaqEzu5CvH76KjtBhOzAaITtRQXfZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0MyBTYWx0ZWRfX07X4rWQaHEMN
 wKutiAwpdXQCE/dKCAft3uwgl8+bQVeu71J1lYPwDRQbQfXqbCFYrczjY77qmDOFATDCTO1l63i
 0OVxu/s6hBX2Xm0pLBsZCVnSbW8fBmXlB9xnlX9Z4WHfRkh/FSbYFol13GmpqBKaO01/OpD2s6g
 o9r9D+colBhRmWLoXeKVEY7SOBNqyAxQXDBlVxeDTLpnoQWiBJrosR7tZZRMGLynMLum5Z+vrye
 EDyQDBQ68QA14CfwqQKLCq8w7fRK0qbUCFC0d+lPaAibr5FB2imEkikS1cHhuw2v+IhwbRTbkBM
 HiMtfkmHJVVt7c7vRqFC+vjGRc793OoZVBic2aAgr+/svaLbjT6lR4GrRl5syqBqu3IQzrt6Gmw
 5FQ79x0xRe9G1xULALhqFaenCjKvlNtQcCMgzK2x8IvM3Px/vG47h2Qu+m7BsnhYri4x9BrkeA7
 7EvD6Jhwz9+f83u5eQg==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae08214 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=w78OluAnvVQzWo3CabYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270043

On 10/26/26 6:48 PM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Add a driver for the Network-On-Chip interconnect providers of the
> Qualcomm SM7250 SoC (Snapdragon 765/765G/768G). It follows the layout of
> the other RPMh based providers: the nodes and the Bus Clock Managers
> come from the downstream interconnect description of the platform.
> 
> Tested on a OnePlus Nord: all providers probe, and the UFS, USB,
> display, I2C, serial and camera ISP devices get their paths without
> errors.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

[...]

> +
> +#include <linux/device.h>
> +#include <linux/interconnect.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/interconnect/qcom,sm7250-rpmh.h>
> +
> +#include "bcm-voter.h"
> +#include "icc-rpmh.h"
> +
> +static struct qcom_icc_node qhm_a1noc_cfg;
> +static struct qcom_icc_node qhm_qup_1;
> +static struct qcom_icc_node xm_sdc2;

You shouldn't need all these forward declarations

Konrad
