Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CE44213F;
	Wed, 22 Jul 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718019; cv=none; b=RMo2Ln+RQ+ZB0SKgm2HvCUZPxshutjjZsCzFiucc+AJsIoin08IELqvRbUTuutrK9m0r0tC6lvJdWkV7qu8K1/Thu0aNBLusSHkI/4Hw7m8mFBcNv8zsNqb4NGsqZOooaY6KQm4r49KoMlXJBMwabICxZrAmE6NqFSLlt1q/6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718019; c=relaxed/simple;
	bh=2GRIDFKJriOhECj5qyNQMERg6nVcV6ymuCZ7+ezCY6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHJW7qkjhIykhNjlyBOwEBKSuRhgI8R++JA5g0uJl7G3B66gHm1UAiOsr+NUE0hA8wsOr+J/WEEtV+FZ4KIf7mQmj+rDdRY5c+KoXAqlDlVfNw9jgYAsY0yveVJRrVHSbnOAjKHWgKUHugjGnXPmP11MVBI6yBRw6Qw6/QpYP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8r6NbKy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8r6NbKy"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M8xKFg237638;
	Wed, 22 Jul 2026 11:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KThUoFS1hIxZJoa2/iiQNDkG
	wygIFOVubqzx112XKRI=; b=Q8r6NbKykLiesqOUuYyXugqWLraO3zN+e3tMv6tb
	OSpVfVS6WXJzmusLcwaaqiRHycfQxnSWPSmfogCDUKjBxb9Ub/XdMqWLmUdsL+xu
	8CHGGUGPQcSEGKyn7A8e6V0kYFAPSlfN69a+yw8Ncps3GijVutcvyRp5RHorx5Tn
	xlkytVepo6xXJtSoDucwyxiKpZ0X1GtxYEnOdgLvJSo2H/OWvYnl8q8vmSPqV86x
	BC3I8fGr7gmdPPmnlxrhyTOUml9iUkcCpzvYfJfMBXSvhRtFoqQ9RfZ1b8T8qL+B
	R0T/Mw4G6429LCJVy1M8Uad2WZpaGumH6XNnxvW+xNuuIw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn1rtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:00:14 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MB0AJh029402;
	Wed, 22 Jul 2026 11:00:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fgj3wh1pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:00:10 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66MB0ALi029372;
	Wed, 22 Jul 2026 11:00:10 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66MB0AZw029365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 11:00:10 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 7B656B2A; Wed, 22 Jul 2026 16:30:09 +0530 (+0530)
Date: Wed, 22 Jul 2026 16:30:09 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260722110009.7e7yhz6j55nwu6no@hu-kotarake-hyd.qualcomm.com>
References: <20260713-b4-add_pwrkey_and_resin-v5-0-3bea476e1453@oss.qualcomm.com>
 <20260713-b4-add_pwrkey_and_resin-v5-1-3bea476e1453@oss.qualcomm.com>
 <20260721-lovely-quick-tarsier-768113@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-lovely-quick-tarsier-768113@quoll>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a60a2bf cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jTth_t_kvktUG8lvQfEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: YIj32mZ6U5eVfnWHN19yrVtxovq1yzyL
X-Proofpoint-ORIG-GUID: YIj32mZ6U5eVfnWHN19yrVtxovq1yzyL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfX92+oojfC2IMQ
 m/YxcQ0z6YZEAVpClZyINJBKDpdfPkpeKXv3P2rTcfjfcgranr4XYcdVQsqZE60YO2obKDivJBB
 0CZdjIV/KdD7vf3NtMUK1ZsJt8qalUo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfX4qmIcX0g5U/r
 hx3elejB7XDOWSkrSCw1gYLZlTvQeCs/eGuLP2DYuNYq5SRLgr9XLjAKNzTJYTP9ZiQ3e2yG7wg
 yk+bOpkY1nNAeP0DRN4V0TU2LZ7Oc35VaVs/K7Wkpv4lj7ekkZveNG3ORKtihgIqDDkAX3ewDho
 L8SJYHMkXJteR1D7BdrlkBLbourdQYa6En1hoc/a5fKCAQgTBirmVjmt0GQzkaa7eCTkOGnmbgk
 MovsOGEwG2r6oCPCcsLWhs3kyT+p4XKnaDKKzq/rKu0sxr4IZxb7QAlTW70E7CgUeT132BAYC5h
 UouUe2YqRlY8PF3AFrjrHZ0J7Z1zeDDV04rj2k7wVWH6wJJRFedMQLPjgCfYkjj61+hYfwfhYZV
 xxJbYHfZXO+RqCW+Q0DAWxlHpczmIGjr/KIZQ8lkyBbEY6Pe4QtxPhM3079mnEbipgWqi6VEqTb
 5a1ELTeBy4FrAafTySQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220106

On Tue, Jul 21, 2026 at 08:53:16AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Jul 13, 2026 at 05:28:14PM +0530, Rakesh Kota wrote:
> > PMM8654AU is a distinct PMIC variant from PMM8650AU despite sharing the
> > same PMIC subtype. PMM8654AU implements additional registers added to
> > the "hlos" register address spaces, so add qcom,pmm8654au-pon as a
> > fallback to qcom,pmk8350-pon to distinguish it from the baseline
> > PMK8350 PON implementation.
> > 
> > The GEN3 PON peripheral requires two register address spaces: "hlos"
> 
> What is gen3 pon here? It is the first time this appears in the commit
> msg.
>
GEN3 refers to the PON peripheral generation, as described in the reg
description in qcom,pon.yaml. 

> > for the primary PON block and "pbs" for the address needs to be
> > specified to facilitate software debouncing. Set minItems: 2 for reg
> > in the qcom,pmk8350-pon if/then constraint to enforce that both
> > address spaces are always present.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> > Changes in v5:
> >  - Set minItems: 2 for reg in the PMK8350 if/then block to enforce that
> >    both hlos and pbs address spaces are required for GEN3 PON peripherals.
> > 
> > Changes in v4:
> >  - Remove the contain for PMK8350 and new if:then for PMM8654AU as
> >    suggested by Krzysztof Kozlowski
> > 
> > Changes in v3:
> >  - Update the commit message.
> > 
> > Changes in v2:
> >  - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
> > ---
> >  .../devicetree/bindings/power/reset/qcom,pon.yaml     | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..09eea48c709e5e42c45c1949ee1d06298dea1f91 100644
> > --- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > +++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
> > @@ -17,12 +17,16 @@ description: |
> >  
> >  properties:
> >    compatible:
> > -    enum:
> > -      - qcom,pm8916-pon
> > -      - qcom,pm8941-pon
> > -      - qcom,pms405-pon
> > -      - qcom,pm8998-pon
> > -      - qcom,pmk8350-pon
> > +    oneOf:
> > +      - enum:
> > +          - qcom,pm8916-pon
> > +          - qcom,pm8941-pon
> > +          - qcom,pms405-pon
> > +          - qcom,pm8998-pon
> > +          - qcom,pmk8350-pon
> > +      - items:
> > +          - const: qcom,pmm8654au-pon
> > +          - const: qcom,pmk8350-pon
> >  
> >    reg:
> >      description: |
> > @@ -105,10 +109,9 @@ allOf:
> >      then:
> >        properties:
> >          reg:
> > -          minItems: 1
> > +          minItems: 2
> 
> You wrote that PMM8654AU has additional registers. This implies pmk8350
> does not have them, so why are you changing this?
> 
> Also, that's an ABI break and I see no relation to the goal of adding
> PMM8654AU. Don't combine independent works into one commit.
> 
Agreed, will split the minItems: 2 fix into a separate patch in the same
series.

regards
Rakesh Kota
> Best regards,
> Krzysztof
> 
