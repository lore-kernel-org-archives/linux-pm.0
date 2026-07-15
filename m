Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF663BED59
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099815; cv=none; b=gyK4Ss9FBLQwTVpp5qUKuhk5CVFaTDQsrpbx0NROrwMQgvtLfX9jroQCTMUkIMFSRN+nyGc+eu1bYdfT+uhkJnHCBrjUP+SBRIhHVtiHt6B0+wHASieRj3H8Ys3J8Zuc7iDesQQDJp/mmjW9CxuTrvG+ePUJEy+i9KqPBUvsNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099815; c=relaxed/simple;
	bh=peEZeARG0HEMoCiHLDH3PVgVIFFbTBPIugxcmGQ/+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPvl5b+YaxKbkI5WzO8FMJVw2mG0sf6jn/2PFW9kR36CDcRL2+NbMrWNWy+R1o1y1r4QtsuX9/aBH8dJGE64qLb0v7jFmd6RxtRdveT+kN4mMtjF2ahDFzkj8NPJLwBlJIobvqOahQ5ck1kVAX6Wvw1w7PRK65kUy32ZB9JI+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dXra97zr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XccGGVd3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXra97zr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XccGGVd3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lMdn2555566
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 07:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=l55Dbn+uB739qkNMJrfJN0It
	ChWvhwJWIh3jTf2LSE8=; b=dXra97zrzYHtaS4DfcQ3OpnFrOiRtH3slBd+CqoJ
	3xpy2WHHNkmxxAQugUG7iuIqz5wxAZMnRkqy2lKDfNgPIEnWkDlXm/K6I+oyapaI
	FobOZh2DJ3TgN0yjHjYCIKtQ5EJrF6R3zWQUcbRHgFMtoAsys/YJDegCkSNqLTD0
	ePVWv1qL1ywHQF2sfztgjL4ueuYyQ8BtkJBUML92NF9DcrgkO1Pol87ZMaqCdBBP
	Lg+gzYXCMtj5x2SPqlbmdZ3I3Exlp3sFwvtvK/OY7RK1NGuXFs55v+IwkKhGMbYG
	xfJ5nkMJsNnRTrK7zLSm1ws8/CKI8k9lV9HnzNMTj3IjmQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9ktg1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 07:16:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c07f25de2so22455221cf.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784099805; x=1784704605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l55Dbn+uB739qkNMJrfJN0ItChWvhwJWIh3jTf2LSE8=;
        b=XccGGVd3djFEocJMfiD8IInQTka9uZnTzCoQA+ARfLL9sba716l0pA1uryc+2RRZgs
         FVilmtG8DVMMs318Zhing7fTQRWUievF+rOMq7g1h1Npxfo8INhXEAV1VB+vMsI3/snU
         zT/0mVr5B7WIRJmEH6Bv/ISm/12NjtQkH9EDbiH3pzSfIVksp2yjbVyRYgkpj9dK0Ykx
         sDqvaNDlvlxKVzSWYk266EP39RL9TkoDkKchSqu+sGOeCKX54cG+p1/qOdIMEdnYvZYI
         EauQdlLyFd/G35663RmxIu4Yvdg5uRyPzl8Mwlq3i9Cqjv8tLonQNi0mi0gTG/3NcZtS
         EiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784099805; x=1784704605;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l55Dbn+uB739qkNMJrfJN0ItChWvhwJWIh3jTf2LSE8=;
        b=JaDwFeYj/V1arZ23IGL1Qgc8bV/Hqs7aAmyOg6+RQs+/b/xC4EqZAImKqFEWXxP7Vg
         KqqYmzor++nJIkhDvJPxser40zZnWdsGm+ANTWWY5ABevZZ9XVUy8naWD6imIdnglYAX
         dbJvplgbiZxcrzXHz429XQGbGh5E4OriCO1ocS7nMYK9y36tonT1YLe30t/N9dnZ1nG9
         UVYvS8dhMfLWE0NkctVR/hgqF07Qe3koa9i6kxhIfOML/WOJwMx75/vmPngfost6m7WW
         53EOYuz8MvzkHi7YI2UPu8P10FISMbme70d2cPuu9/2Dzq42gLwJYi0jtl26U5fCcT54
         GLVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcAtViclmCN6GRTvqdR1DoDliNN94MuPMOlPYxTHqynteHHZppw1GvHSV3tHXF2au2STX6YTqpPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4kb2yKD+EVSov8u9iKvVBsKzFcyheTVtkYGJaEnuyybsOLyE
	J/UuddRO3Y3J4chCN7x7KHncCC3QvxIy3S6Tl2IUvZP0QajaFJHg/prQWVsEY04hY9uNkVdII3Q
	tTPtfIo/JCwZKMnxNx7aFZ9DJvNO/0pjYBRk8zXAlgZCjgsluMfdXbkvck/IJnw==
X-Gm-Gg: AfdE7cnlAksI36vbMN0Ulfx+GMRIDfKJOnl4RLB4pglfJeLuRtbmuIq8C2I4gOiVxWC
	u+cL9v1tUlDKsa1EPO7sFNgp5nXlG1QiDkxgNTvjwbER0ojGuA/EFKwY1nb6LQteDoukKF5xXGg
	190CPjiVOaRnOIwRW9oAfUJdb1JMZGXDaZl6OEXnqFBFEzpSKpZFVMQBVL8dmyftaeKMk/75twa
	FEIFMXJBeEEyd7kmOTumocHLKdCdE3lx6OQ6Mimw+8kRKR2PhuYuRyI9utJaRIZv38gEpzMoyY+
	tYAvW4KJ86qkzVo+NoXRaZ8fpCW2QQVgIM/+dANJrQjROAzAT90eQuSHaykKfLdNt6i8JJpkMnS
	iSvJpP4DLbEERAy3BX7zxkw==
X-Received: by 2002:a05:622a:229a:b0:51c:7b12:5ff0 with SMTP id d75a77b69052e-51cbf3dec76mr162829051cf.76.1784099804951;
        Wed, 15 Jul 2026 00:16:44 -0700 (PDT)
X-Received: by 2002:a05:622a:229a:b0:51c:7b12:5ff0 with SMTP id d75a77b69052e-51cbf3dec76mr162828851cf.76.1784099804356;
        Wed, 15 Jul 2026 00:16:44 -0700 (PDT)
Received: from oss.qualcomm.com ([5.12.73.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322dc6sm137697535e9.10.2026.07.15.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:16:43 -0700 (PDT)
Date: Wed, 15 Jul 2026 10:16:40 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Eliza
 BWMONs compatible
Message-ID: <j6p2aqqn427lr66n6e7gsegtrilcyidmprhyqvmsa3tbv42zgd@mgcz6xp5wi4d>
References: <20260708-bindings-llcc-bwmon-eliza-v1-1-3c7dbcbae87a@oss.qualcomm.com>
 <20260714222740.GA3177936-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714222740.GA3177936-robh@kernel.org>
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5733dd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qUYP/O48JsHWwiZSxXr1NQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Q5Zv6aI2IZJGwc6Qk4wA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -GFYVHQiEriZVdtZTQQbPWt_o8aMtE0f
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2OCBTYWx0ZWRfX9QpedzIhC5VH
 eJDcTeYgr3OZVdg5I30DuzLfq344oW6ElWbpXP3YdZWtXJrpxyV+jApbfQO/npOdy1fQ15VevBE
 KgSBsoqYcFerdMLNzJkLG0V7KWnsQYw=
X-Proofpoint-GUID: -GFYVHQiEriZVdtZTQQbPWt_o8aMtE0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2OCBTYWx0ZWRfX6iGNOKloJkRK
 u6b2POLDHStPoys5y1+dy1oDf7WDZl+QL+xPdhfaOMaG3e/Lq4IxwnTZGlS4lpTSQXeSP9fg3VI
 PytPLbA4DYU7EswO9E8F/jBHmq/TU2Zi6vx8/JpV7usFYJEb7rz41uaTyY4noxm4yBo/r/XqOkb
 46e8oWuwJ1pArRRTC3L4VfNQcogpjDIqrboZUNChwzVfwacNoYt4FnynkLxTwO+i3dpfIX/unU3
 Xwd4WcyQqMfUsBHHhUU0mz2dL5E5l96CHvkAbkTZEF0erUVPSkiWsWcNDtWMy0YpeY79EGFsC2m
 jUjSlFlFOLxW6JA97iDcaUHcpbW46hRsG0T5wCULuQhyV3F97ujHUn35qET6sjJv14V+GP7+Kre
 hNJJMjDCDkeTuAqtkLZbylnUYA6Ticg7h/DDOyysHKtgx+zMSush3dxISvyR9jHl4qxmVFWwfRc
 RERXbJdBQ/1gtlBMb5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150068

On 26-07-14 17:27:40, Rob Herring wrote:
> On Wed, Jul 08, 2026 at 02:57:20PM +0300, Abel Vesa wrote:
> > Document Eliza BWMONs which has a BWMONv4 for CPU-LLCC and a BWMONv5 for
> > DDR-LLCC paths, same as SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied, but this should have gone with the .dts using it.

Thanks. Will do that from now on.

