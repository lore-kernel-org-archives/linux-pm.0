Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB0A92E
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775339295; cv=none; b=jdl0Gqwtk/drlAdGWS8MsBVivNksgSyeHerNNSjXTx+wEdbuO3mlwXbrLpLcZXl7hOvcysWJ4N1m5CdKsBF9Zet3YcHaFihUYvAe9ByvU+GeiPCBkaudt0AG/4CKfPSPs1x7fNQPhB+aUkMFTgH+2s6LVuK9xGGYP4sAhyou8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775339295; c=relaxed/simple;
	bh=R5MFZn7on1y6XbobayspmKaqSBa/YVcbEAuZzGT4MjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WH0XWw3JoLMqIEb/2hceOB/bw6KxUs25SNWmNEB0QXTcgkfy3Jh/kJf8Ubb46roINMrJRJEkelK3BjDX0Fe4U24x8W+mge3HqmK9z1/ub0L0ZtNdlZ1cSJmKHGyFqbzl/mYAZDfoUsk/McsxRDjwiqX+LsiAln55H352qLe1Vzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9gfYadd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AQfReWEm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9gfYadd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQfReWEm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 634EpgFI3654541
	for <linux-pm@vger.kernel.org>; Sat, 4 Apr 2026 21:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tfdwPZDSDeozlLQiB/sIpQb6
	Uwmc5WQ9+LfB1oCVSs8=; b=e9gfYadd/zBkqWiDV99vJ+ePfiDxYXw2wWA4jPP8
	U1lJBTclnvhMopIC7Vj0CLFiwi2r8dqV2cFaXND2CDeP1zPq8PbrxMtoG7uzHtx5
	oMtUwebtKsnOLWbA1jJjsqBUrQxpzPGktTnNNsu8+7fY8+9HWRD8mqXC1POicTIu
	OFWyLLbnFAwgKuUcMoklN/FZP3QQ+NxTak3D4adTp3ygmtWbdjva4pSlJ5X6S4KE
	KDmW38WLcj1bMI2MXxy/1SbCH9NQXzHzkBzf47fP1bqkbgUyVY3nXiHuGlHhUTA/
	9tCPcKpmqg60oV9WoWsPikE+VQngRBWeyE/TepXGq7Lhgg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dat7u9ke4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 21:48:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b34223670so140291511cf.0
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775339292; x=1775944092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfdwPZDSDeozlLQiB/sIpQb6Uwmc5WQ9+LfB1oCVSs8=;
        b=AQfReWEmQwwW2Dg+Cs0IPOJuVQV33g/vgYdnZce09+2RMauaMQza4afJiTLRQABT+l
         qdEFmv4zVV3Ga+RKjC4xjGAN2xDhPRFywqehAgKppIHGWh9DUHb4dcb5lIn8HFY5tz8C
         o5JGhCzKzdRYFD9FnpMTKpO/lp9O2H/yPQmbHCJSxXXPWllE7HxaO0PXvK2d+F5zz4kD
         d0ZNXRqPEGLKK0CTY7U2Ju5e5fNfRhLYNGEpCd380V5B+v6SZkEeP2l+dUt3Yxhoq6uJ
         qo3On35bKpLXPBwxxSdV2N6qHcpq0r+dZ2I2A2ubVNDrNEd6+CP3FwxppGGixWCL4ZhB
         v4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775339292; x=1775944092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfdwPZDSDeozlLQiB/sIpQb6Uwmc5WQ9+LfB1oCVSs8=;
        b=nWQkyg5bX2So4wIxzOPQzhn8UhefWtYDiegZAXhj7fmue+D9ZWUUaAj6QHixRVt/Qb
         qyXQqBDqw3OME0M20mdBudP6Yuqut/Tgzss1J7RzH7B0Kl54fBycKwfPLIlufmz4A0oB
         0E7z8Xa9Eh6qr2YheSRw6+Bqu0b3/7Nm+rQj+Z55tpUH/HKJzoGJMD894SPjPhbjt3ig
         DmqNana6vzMSVYGm1Ih2Rusf5VFn/Mw1T+ggAz5A6VTSNg04TZej3iVOQ6/4z1tTndf/
         uPdYycVRxC/g+KgX0yshtC5AFrKrphBf2ViYPjjt49uIuGNtidm0TWEZ5KIrpMoiOVfT
         MGhg==
X-Forwarded-Encrypted: i=1; AJvYcCVBmYAPaM5Yb0JRbJC2ztayU3RgrFuDy+vXH3Xip9PVdL/N5GuOdRihb2Vjx6BMnOjadq+gwR4FDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFG8/zqeDoXlTjMt+83KlXLBmuxBz1d3gb8bau9xr91sGv5ONM
	EvhwU878UvweKYwjBVL5hm9oVNh/Sk/6cjdSUl0PGk7s+wcCGYOmIec1pFVgp4d1mYq6xrWhmRy
	T7+cYSmPh0s1wivQoEh+pZeumSwixe8Mc8RiMpNL7D1ieODLkMcrJLmhMIfa+5w==
X-Gm-Gg: AeBDiet4bCkv2kdHj1WdOAhYFXKVgJcJ7AL0ilKkcG4uIHMaFv5AxTzO6F2We+Gd6Sv
	nI7C5K5kabVQU6HzDe6J22/NXXqDEWadF9imMsQPCb/KfV459SukB7Hy0NNZGV6xjvNSUKjACRw
	JwlP+DStL4gQEkkspFoQ8fVIHPTtUjY6Qw61GWpkye8on6aMpWpjaQ1JxD+4aw9Lm03ubWOEYHP
	tLxCoMIBhcXPvbuJVNHSI1PFf4j8BZGOwxk8L9M5nDiuDTw4FlfU8c1u1GajF5UutR62PsE+smy
	yj7zWv6gYkD9OHke3lcgtZttcvKV7CVbUYDSHD3WKiF81D6mEFoYL3dlbROxxxyy4L41IC0V7U+
	we1ZkaMyIBDIalhovbA/4fqg28UnVRsiT6OtpJVBFH6I/b51TgSRKasc+T7r2d4amQ3wr8M337K
	y96PPj+Je1ibDDPyDRak+95Ug4C1MaGNAIvoE=
X-Received: by 2002:a05:622a:4889:b0:50d:7135:5631 with SMTP id d75a77b69052e-50d713559b5mr73311721cf.6.1775339292389;
        Sat, 04 Apr 2026 14:48:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4889:b0:50d:7135:5631 with SMTP id d75a77b69052e-50d713559b5mr73311501cf.6.1775339291911;
        Sat, 04 Apr 2026 14:48:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccc96fsm2308220e87.59.2026.04.04.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:48:10 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:48:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@oss.qualcomm.com, Taniya Das <taniya.das@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add power domains for
 Hawi SoC
Message-ID: <q7nzvopy3mz3o4fnyg7lspaim7ccf7vlj3xlsaaiq57dzvyoiw@xz5yzbjn5suy>
References: <20260402-haw-rpmhpd-v2-0-2bce0767f2ca@oss.qualcomm.com>
 <20260402-haw-rpmhpd-v2-2-2bce0767f2ca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-haw-rpmhpd-v2-2-2bce0767f2ca@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwOCBTYWx0ZWRfX9KUDmzGt20En
 BXrzqALd85GrdvxG8EtUNk9acbTq8pjLkTBsCoQDOCxYpAYnQILHXKa6REWvqhR7BCBHS4zKtkO
 ZbOuobMXl+qh6l8nA6/TBbkkD4ewqp9bcZGUGNYNp4X5nVt7D0dcvsUF9NvcGLbheACZxjNX5ph
 82Fpgh0qie32iaP+jJU2vw28wBKDouz6AFmGQCwO0DbXQYSa9XslCW3Jyg08m5018vtjqZyDlPh
 MTr5mqDyhU3j0kdguo38Xm+AH/y8cIF+hBS25UXhwGIqhJCOyunSXgH6bWQhKUrMJFOgjPmvZZL
 TEj3dmVGrelILV0pJKhbTuP58NfQdtyqxlpMKjvJmBAUMSQWnn1oUpSfZ4RQlnMm5qmak1gUuuo
 YNihtqWCn3nP0YVydjP4DmXdQRDnCL/pqVj0ILYvLvitZcZmFOa9+SvSX/wSGGFSMILfDtQJdb8
 N/+oaEY0Ci4rJh+3PMA==
X-Proofpoint-GUID: EtK2P-bvAcXqRBDLTPLDOxysr8C4vSjb
X-Authority-Analysis: v=2.4 cv=RJ2+3oi+ c=1 sm=1 tr=0 ts=69d1871c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qZ5ZlOtsQYTu7SIoqgkA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: EtK2P-bvAcXqRBDLTPLDOxysr8C4vSjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040208

On Thu, Apr 02, 2026 at 05:35:22PM -0700, Fenglin Wu wrote:
> Add the RPMh power domains required for the Hawi SoC. This includes
> new definitions for domains supplying specific hardware components:
> - DCX: supplies VDD_DISP
> - GBX: supplies VDD_GFX_BX
> 
> Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
