Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF91358369
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099438; cv=none; b=QfRwpLwrpzvLvedR+vEr44VORhWSpE1ZYU2DfF6DRM9LUI7jrVdV9DW1wBaOvdLC6gnckeur+YEwVhB9lqjs+o6gbHzwcg9DzbW2MMVtVya4+jWm9tLR5B1Dewlv47i10Lqg8nNf9bgSxvxFW/QyXpkxKrnT2+64voSfxAYt6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099438; c=relaxed/simple;
	bh=i2IPgYVR6Ld9n24vmKw7wlfB6C16UoQiG5rHqnU45Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6owpP+8+Dd5Pb5GZYypRT4ty/Bp5RENJc/ydQZ9ptWxahUC//d+1+/pdomYgQldzcUy0raiS1CZCgE4EMhMTt/vWrhG/hooppVG0XpXYrFkeQA/mPAoJJXD+YKVNzGbyLdKhO5PQYSSlCmZXiINpC1+4EseRf9eDMQXSYJCJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hsjpl2Ho; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GodQb+Yj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hsjpl2Ho";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GodQb+Yj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631M437t2798835
	for <linux-pm@vger.kernel.org>; Thu, 2 Apr 2026 03:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SUF9Sm+/aFQ9Q9LGQgA6Lail
	S0HG4qty4JdVJILkImE=; b=Hsjpl2Ho3osr8/sN2dRPsX9eMk9P3nnUcSo+13Pt
	03bHApFgztTc4OIESBavEzBCixwkLfghlJarPFGwp6QGGBHhIxpaI9dKLGbAsELm
	pEN4LJcNKoD6jlTxC4vLFIHcZdBO0jNZlZfKIdSmEX4uIxB6pbvHA2/aIrQf0mob
	VHafumbC+G/GpXNAr6vEZkZmab3QDdoNsmD2hKFp+TspI6t+1gNv9EK96SF9SDnE
	d8cqbxiDaOrJ+yyjTaIsX6PKKDafLXbXQBLv1VdxEzXB7cwXHa9ZdS1vZrK5PBY7
	ov0KKrrGgQapDV09Ohgx4k5sFTjlpQgK05xX/IjircUkhA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96hk1ywe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 03:10:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c18175fc54so2455487eec.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 20:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775099434; x=1775704234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUF9Sm+/aFQ9Q9LGQgA6LailS0HG4qty4JdVJILkImE=;
        b=GodQb+YjBe4KjD742Wcq8sZn377SF9R5oN7/fQOjO8jJnAS570OE+sFVYBbwyRIScg
         o6U/ueZFrVISjDCoDD9ySqTHcPjvPNoaHtbzh3OqtwBwfCEfxlueEvTnFIdnTET8QIxL
         f6LZBnnLnn/9uppSbm8V+OZz8M7U/jjC4N5ziTiRWuPfpNaNq3zdLQVu5WhXM2yPq85N
         y0rjKxDcCtHb4hNVN16s+1VG1whl+YZ2nZtQXiY0KBQn3D2WnYKIKST4Mh86nq0/Huee
         GuubPo337HJL4gKmZBDCy8+Mgoq67HDmFGy3LDBGDutTGSu4Hc2kyx2EuE35zNObmSSx
         JOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099434; x=1775704234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUF9Sm+/aFQ9Q9LGQgA6LailS0HG4qty4JdVJILkImE=;
        b=TbKX7hxFL9RL+G28qpAcb68DeXJEpIfFvQvUFGSVmzzuBHf81+mTI6paBAoj4BMg49
         iE9r0fy61tMU5wqP/6nuhmxdJwIeN46lTAdE9IiRsF94gly2VBeX+QXClCRiGvPlGQOw
         R6XXsM8gwUXhNHsCpQ9mJwZvnGSg6JDknnUmZYIRuYglexkIMUyBanspEWC3qmknMj7H
         hSgr76hn3jkyOaX3bw4L4vf6O1b4xtYEnIqqcOV4hrYcReuOjr/Pvg+7kFG1B9aUCN8O
         Nw++XU7yP1TXZFNRUDB5v6MNC7AUOh1bTU5XBf7MFYifeRSafnF2TYjrfHj3xCo60Hjj
         GXCg==
X-Forwarded-Encrypted: i=1; AJvYcCX/+GzkwsbtQ704laKgeRigZz1cUo3Vhp6XKIbw3EO4QeWZaUwpKJHnmxwItWy65f9bZZHEMt9lBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdHheA+nlawM3Mhupu2mySWCIKGv8D0rCfseBTZFn+0vcBOAtJ
	fiV9eeBqBPsFxMtwXSTXfbjaptjzz8Mrh1QXY90D4f/BwC8nhm06shgW/syQdnTbhuTogxEK7TJ
	NM3LmZ3t+HpdnN5I0DUCZBxVxYYB0LOq3GZ5xdSsSGop8DgC/EJ5ezLSDTkcCMQ==
X-Gm-Gg: ATEYQzyjusQvRIsikIILz88C32DezlUibsuaPjP857TH/TO6ISEB1gCRap3+6EICFAB
	0D3Rm2HuSSI62tIr4yul6dMKjHb3t6WeIchtE/1/YVzr8LANtt+FxIZtrxf7kjfVp5uycWntVni
	7s2gJqu2eN9U1yCMxPHfxGVwrbw52aFTi2waNn4jYc1xUAb730YzF1GPNe7nSkKw7uJehiXjJkU
	Wd8JnWA0spDAbnfnkKEveJ7/9sMdHYPfrmkcBU8Uiw/pweK7t6Envm8+bOXaLOSOTqxk7OLlUvh
	IV1ERRJ8aEl1CpBMWamwHntztDNmIP8XZerdgTlao9zIpd++krsRl2M98UbDghtNC66MOBtv8Qq
	Z7uiogobRlxIMlR4emJ5HCbwjoMneEAzynaDNQ6TF78dTPmfuy4OVucIG2l7k1vlsUbjViQDKZe
	8=
X-Received: by 2002:a05:7300:2213:b0:2c0:becb:7640 with SMTP id 5a478bee46e88-2c931276dd6mr3580622eec.12.1775099434051;
        Wed, 01 Apr 2026 20:10:34 -0700 (PDT)
X-Received: by 2002:a05:7300:2213:b0:2c0:becb:7640 with SMTP id 5a478bee46e88-2c931276dd6mr3580610eec.12.1775099433506;
        Wed, 01 Apr 2026 20:10:33 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cafd073194sm283615eec.28.2026.04.01.20.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:10:33 -0700 (PDT)
Date: Wed, 1 Apr 2026 20:10:31 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
Message-ID: <ac3eJ7lGevZwElfk@hu-mdtipton-lv.qualcomm.com>
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
 <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
 <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
 <acH7aEBvSbiNwhBz@hu-mdtipton-lv.qualcomm.com>
 <DHG7CMLREKDF.2L5V5VQCEYDKH@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHG7CMLREKDF.2L5V5VQCEYDKH@fairphone.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAyNyBTYWx0ZWRfX38BAez+AE2/i
 KPYDKCNYj5HCRgDZNPgG/VJwhwKLu2UWSr3dM4X0BwdcybC/vn+xa4KCqn1fpmhov+azYgz+7O1
 5A0CYhxUvoP6Ba3Jq64yPeM0BNrQ2ohzQQJiIRKzu2j1YdMsH4aTXgyMFm+LdxlASZRTohQL1OC
 ZWMPy68qLtzT9Ga9dHPIJKFD0Z1dt/1Mad+7AVmDyMYonF1/+/CL0KZTkz9M97MVYvTNyxQ83ix
 9M5kG0nMzIbVkkAOET8mmQObgKqjkn5aMp6uOG2MGxkUhtzAstw7cB7mtpXqtCzoObH14XIZeSl
 WckRVyDk6padJmsSReqwqzjapmljhqM2N8zOSsmFAe/yI3932hQCjHWnVXO+6JlrprF9VhIDQEu
 3qh8AI8wfP3xdYzILFyWvtn2AkJV+5lyqQkF3ag/YIBdrq05SfsQxD7nGyE37BMhI35D4vY84jB
 ldHin3Hoaf6udUjUn5w==
X-Proofpoint-GUID: cxaMPm28WvUd0VAuPLnQTohtTrzMMKNH
X-Proofpoint-ORIG-GUID: cxaMPm28WvUd0VAuPLnQTohtTrzMMKNH
X-Authority-Analysis: v=2.4 cv=e9ULiKp/ c=1 sm=1 tr=0 ts=69cdde2b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=W6naqKN7AAAA:8 a=hMnAP9elBZEPa_KQw-IA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=Xp8b5NkTPdl8jt_qJiRs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020027

Hi Luca,

On Mon, Mar 30, 2026 at 04:55:40PM +0200, Luca Weiss wrote:
> Hi Mike,
> 
> On Tue Mar 24, 2026 at 3:48 AM CET, Mike Tipton wrote:
> > On Mon, Jan 19, 2026 at 11:28:07AM +0100, Konrad Dybcio wrote:
> >> 
> >> 
> >> On 1/19/26 11:20 AM, Konrad Dybcio wrote:
> >> > On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
> >> >> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
> >> >>> Document an interconnect path for camcc that's required to enable
> >> >>> the CAMSS_TOP_GDSC power domain.
> >> >>
> >> >> I find it confusing. Enabling GDSC power domains is done via power
> >> >> domains, not via interconnects. Do not represent power domains as
> >> >> interconnects, it's something completely different.
> >> > 
> >> > The name of the power domains is CAMSS_TOP_GDSC (seems you misread)
> >> > 
> >> > For the power domain to successfully turn on, the MNoC needs to be
> >> > turned on (empirical evidence). The way to do it is to request a
> >> > nonzero vote on this interconnect path
> >> > 
> >> > (presumably because the GDSC or its invisible providers require
> >> > something connected over that bus to carry out their enable sequences).
> >
> > The GDSC itself shouldn't depend on MMNOC in order to turn on properly.
> > It should turn on just fine without it. There *is* a dependency between
> > CAM_TOP_GDSC and MMNOC, but it's in the opposite direction.
> 
> I can personally just write from practical experience, as Qualcomm
> doesn't share any relevant documentation with OEMs.
> 
> Without this patch the GDSC refuses to turn on.
> 
> [  291.055839] ------------[ cut here ]------------
> [  291.055860] cam_cc_camss_top_gdsc status stuck at 'off'
> [  291.055878] WARNING: drivers/clk/qcom/gdsc.c:178 at gdsc_toggle_logic+0x138/0x144, CPU#4: hexdump/1995
> 
> With the patch it turns on just fine, no issues seen.

I haven't observed that behavior, and I just reconfirmed on a more
recent chip. I explicitly toggled this GDSC on/off while MMNOC is
collapsed and it turns on fine. And if I disable MMNOC while the GDSC is
still on, then MMNOC gets stuck entering collapse. But I haven't tried
on Milos, specifically. It's possible there's some behavior unique to it
that I'm not aware of.

Regardless, the correct solution for both issues (MMNOC getting stuck
turning off or the GDSC getting stuck turning on) is the same. Which is
to vote for MMNOC on behalf of the GDSC as your patch does. And is also
what we've done downstream.

> 
> As Konrad has written, originally I didn't see any issue because that
> interconnect was being kept alive by simple-framebuffer where I've added
> 'interconnects' to keep the framebuffer alive. However when testing
> without this, the GDSC would refuse to turn on, which led me to this
> patch series.
> 
> Additionally you can see in downstream devicetree you can also see an
> interconnect defined for the "cam_cc_camss_top_gdsc" node:
> 
> https://gerrit-public.fairphone.software/plugins/gitiles/platform/vendor/qcom/proprietary/devicetree/+/refs/heads/odm/rc/target/15/fp6/fps_overlay/volcano.dtsi#2943

Right, this logic was originally added to prevent MMNOC from getting
stuck in collapse, rather than to prevent the GDSC from getting stuck
turning on.

Mike

> 
> Regards
> Luca
