Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491949;
	b=Z4gUvaQVjC/Jy8Qb+6qHOlU2or2mLIJHBTeZ9YlAw28iSpCps5k8ssQDCNcs9QoVKt9K
	 K9wZNRMNpFSvBlX0xng0RAM/8OiSTDhJTvFSF3ezb4Uqzz/oSZEMGussBuSmc5Y+HIhvN
	 lH4bu/1amjxhU/UE9rekJrXeqvPBSCP90NHjVUf9fOWSfNu/zPugp5RFre9xdzR427zJJ
	 oY74dERuhnvDBO4mHqnYk6M8P7MyjciYRiqB9s3l6uQDIsmfjxLQPQbxfsOC2u1K+c9Te
	 Jn25idTp6MLXkdXiIvG1foU7w/92EXufSPeVD3E+dAkp/nngHWb9vbhzHknOyTQih1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mLeqBaTgJ20aTc9spiaAIGrYYecfKuCtitYoCZ1tdAs=;
	b=dPsM8zcQ8CQoktWUzdSesycZbFfDawApOwYXZL+TA792OU7L5/ZdPHp9uEIW8BFYASgR
	 K6YAwIqrZPJk5zjTRskECnAVc6c8+fvr5q4rHdI8M4ABijUZGxe7DKXBZHDdjEfpqRKnE
	 F260aV3VBKFTV+zGtDy+Ny2NcOgSi+sY8O3GMe9U69R8VfpeElrgflisn8jwpuWkgPLDz
	 7L+u+HrSSoQJmnnE50PKXC2bfnZYumWQ4igiNEBBXhv0sE7lRuHT3TYnZnQhRBfZLLt/7
	 Cma1yBLgirMWwU8BGE+CJZDOe6sT7RnWvRdHhIV60ZQpKuVan0eFM09XyvvZbA8jYMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb56eWOg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GeZoGGJL;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8A0606A333
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8A0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cb56eWOg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GeZoGGJL
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8IBfv620620
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:25:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mLeqBaTgJ20aTc9spiaAIGrY
	YecfKuCtitYoCZ1tdAs=; b=Cb56eWOgfpOLdx2wuarL92jytqocs3Wb/IfJOJ+n
	ywjf2DWmupscEzijhRAnP6mg7ec9w3B5lX+tRC48KQdVtWyDOGoUGs6bUMdHmUNx
	E9MgKujWpKCGjKkN4u72lnhw1jmpbgAUOhJj98MsYazjPmVxB5JdDYXbSAWYuUPJ
	dWaIFAFZUzURTS/f4hvRbq8MVes9C2u8XH9bI+PNuE3WNNZMadp/3qanXmyU4OKn
	EWBAGspfIVLzRJkpDfDX1Ybd8MX/6rG45XyFFkuFJ+lIycMkyH6lmtg5GSp4LlP3
	P+XxP+ckB+J5FhfkQiqG2AoHoakxbHFt7ONkQuE0Gx6c1Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nsyh4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:25:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f33438950so802171185a.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491947; x=1793096747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mLeqBaTgJ20aTc9spiaAIGrYYecfKuCtitYoCZ1tdAs=;
        b=GeZoGGJLsbNN1cpmEcUUMWC79peGPPdwgL4jctkKkxspURbnjKGxv/Pc4oeoHvDJcW
         a6/CC5zfpuSVxsY+m3F0oUHWKpw4GIAjLSKHbB1pJ7/DC8TFWkFyEp5nX0ZooUg4lQW7
         SF+hdYLEBQ6d8v9923f19OY3E+gk9Y7QfoxdHRa07jb37f3luNttYkDenlvDaEwKty4Y
         H/A4sx4+K8e0xBdXW1LoA1kC/KpYpBLQi5PajQ3tCFFnepNaybRruYASgZslvxvaiiM8
         hBDrrCtOYw0yXLPnqKp8qebdnj7NfK7roDW9LkaC9hAtooA4hyyx28EBUg5ErtuOD1Tx
         xegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491947; x=1793096747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mLeqBaTgJ20aTc9spiaAIGrYYecfKuCtitYoCZ1tdAs=;
        b=2QAGK7+20t70LSVdtsb8M3bpzYEsd4XB0XcjUAGWPc9s8PWNhtknB1TjCJJUidzRO9
         lpzECuc8csf1cCn9n4cB5zA8/YsNkEdCl0TwXP69RicfXeCNELmG2Cpg6AvIz28MpHG3
         F7Pwdg7kaDY2aH9E1mQptWE4JeCUsJHR05n5sFk0TSHUbDWvoTH5yb5n/8gKuojqggh4
         2dG6MH8U9ikYx/Ap8iVtmTl1o1zMjsxqQLqArzZZk1RjuIohOPp8qpjmR7pzToH6YAC3
         qQ+JS4MiJXHD+GWcqde5+YMAEk+YTWWn4SAjWU0UIdmZ9rIYAAp/cpbEcf1Z39RcoiVV
         E1FQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfs2mgqk297pc59CQEoKm+i1U+6OqNxh0clOlsc/7JWxuaJp7wHMSxRLPzHmrE/yZOGciznBn0XA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKmyQVCl9BQJHlKgbn3kdbhhuhv9pyAEVtM3vT2BjBg0sdxrvS7
	tVsv6Ggi10rkU+iXGinpVaFXOFZk8AkepuuZAKrsA6xTs9tPg9uZ8nUThFlLeamoRucteWYhJr9
	vSdM8fNBknSRAJdQvBElfs2ujj+5ooerasdNdbXMlbl8r2KXgKxxxSEdPks/loA==
X-Gm-Gg: AYBFou0ImwSPy8q1e9RUh3N6ifPggwQUSgi7x3CLMvPQidrFY1/J9KGDJjgFVnwPCd7
	t2z2cSpnayQ+4f+fJWXNGWgb/udwFJW4ikCqtqbTB0sfEewRkjdzJKjeX1wz9UAAYLVmIQL2YIb
	pZGVnIv+JE/rVSoEbrEUL+a8QtjhTmDaZaYdUR7M9hO2ch7Ho7R1Rd8Z0hw5qNB6ZwPaDnbiXZe
	XPpAOXmH8Z1LQPkaYdzEjO4xX5e1VTZJh2+V2kAx+fgw5UcYwUD7Dvdllz9fvYLrxMOavuJljKz
	RR8bc/I0QY3EoqterXL6baZmIoshXuA/lOonVoduxPtYagzVCvod4DSykFS/RwPsnYtgqEfaOK7
	BaMtP/W40ZE74e+wcOUrwEcTp0lQM+K01sq48stPxDnA0blk8QkgSQ7BEd1cHnjiQIXZisqky5S
	MVhkfL1V6KMzXB
X-Received: by 2002:a05:620a:6019:b0:93f:38ee:68b9 with SMTP id af79cd13be357-93f38ee713emr1081444585a.28.1792491947417;
        Tue, 20 Oct 2026 03:25:47 -0700 (PDT)
X-Received: by 2002:a05:620a:6019:b0:93f:38ee:68b9 with SMTP id af79cd13be357-93f38ee713emr1081441285a.28.1792491946837;
        Tue, 20 Oct 2026 03:25:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab20a8b3a4sm28145191fa.1.2026.10.20.03.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:42 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:25:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: interconnect: add Qualcomm MSM8998 NoC
Message-ID: <guychj77ohhlnhzw4bcgglcfiwyppgt7wzd677smjbd777kmpv@s4bclghi335b>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
 <20261019-msm8998-icc-v1-1-c2da3934b6c8@oss.qualcomm.com>
 <20261020-daft-competent-saluki-a080c7@quoll>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-daft-competent-saluki-a080c7@quoll>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX63H5nH8xwG7Q
 qd8rtt7+fA5z4A3VTOzVG5SxZAtzWvcxGeI29e+bmmj6F6KXuAxehSMz6DVEeg1cdyM1jpOGX4U
 5p2WKIPr6rsfvNG9dekACuqSTaWENFg=
X-Proofpoint-GUID: bTzcGJiGL7IWLNfTo_VgxPTQGPhCzrnN
X-Proofpoint-ORIG-GUID: bTzcGJiGL7IWLNfTo_VgxPTQGPhCzrnN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MSBTYWx0ZWRfX4pXXhJ+mJjMt
 JamblvSJmeMRys0D4BSkgvgdVO1P5auEgTKsULthQzAZ1M6d1M3Fck6Yqvq9pSDT4/4XD+9PauZ
 j38ftZuHZoldHZEoAhds54FFWpoPJoAsq4vkI7m98mU11wtHfDde49L8hCnnwEQBfHYmpZVzUBy
 wYq75txPt8umpDIwH2IoSpfbRVBy/Z5g1au3u70M/tKAFPUtRBQb+jI4/Sq91SxTiEcdX/Z4sNV
 RSLHTIwM2ae3DWMBy57FC6hu7wBlFg8C798hzZAaR3X8ymmPwvMKeFD2fA94GV8j9i40Lm9wVXf
 /FmFyBP/jRy4nTqmPodTC5h+tJr+B3cAJTg17q6vT4Ujkgs2leGLbK3nA5wIJM8eX46DMv9+eKf
 kqn36J0eH1tX+WR8i0BbacdHgG2foqJHY4dsUyfh0I+qcGpR2o3q/uAnCOqtBLJfkj5eLoP1zSs
 zFv+CdqIYLnRtG55u9w==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad741ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NwY7b9YWZjBNx-CeCFIA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200041

On Tue, Oct 20, 2026 at 10:24:24AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Oct 19, 2026 at 05:12:39PM +0300, Dmitry Baryshkov wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,msm8998-a1noc
> > +      - qcom,msm8998-a2noc
> > +      - qcom,msm8998-bimc
> > +      - qcom,msm8998-cnoc
> > +      - qcom,msm8998-gnoc
> > +      - qcom,msm8998-mnoc
> > +      - qcom,msm8998-mnoc-ahb
> > +      - qcom,msm8998-snoc
> > +
[..]

> 
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > +    #include <dt-bindings/clock/qcom,mmcc-msm8998.h>
> > +
> > +    interconnect@1008300 {
> > +        compatible = "qcom,msm8998-bimc";
> > +        reg = <0x01008300 0x77d00>;
> > +        #interconnect-cells = <2>;
> > +    };
> > +
> > +    interconnect@1740000 {
> > +        compatible = "qcom,msm8998-mnoc";
> > +        reg = <0x01740000 0x10000>;
> > +        clocks = <&mmcc MNOC_AHB_CLK>, <&mmcc MNOC_MAXI_CLK>;
> > +        clock-names = "iface", "mnoc_bus";
> > +        #interconnect-cells = <2>;
> > +
> > +        interconnect-mnoc-ahb {
> 
> I do not see how this can validate. You do not allow any children in
> your binding. Your tpo-level properties should define all possible
> properties and nodes.

This was validating because mnoc node explicitly allowed the children.
I'll move the declaration to the top node and constraint it separately.

> 
> also, name should be just "interconnect"
> 
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry
