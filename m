Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8152BE5B
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950350; cv=none; b=HwOhoiOW7dG594XfIk0M/szoQL6uHMzHtzKrb9QfkLF0QE34z80QPSywL66Rwi071emWRxfq9ObhQ3uaR19hgMwZpzRK3rbCiHin2uJCUOJHrBMWGQCMuoVO4kinbx7hqNP+NZdmNyAZq4yI7cX9dnaNtuJHthNbm8g02aiUjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950350; c=relaxed/simple;
	bh=jmbAAFgr7TKmfga90H6yeCGflLP1Wp+vEdczbBX7l8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGHGsSu12JKUnOL0gP8YqfixsRuxUW5Va1+pt2XJ4Oo71aulPxHZEDwbdXen8map34yTKgM7F3rqEzLyXWL7ymdmXZMYFDLWKRyKFxSLGFzApnWlVUrsfPnEnhqKXAmsgvKlyTK+7WqWTGmIcoJmwX90/rxYRL59X5mp45j0bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XldYhwa1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LuzLixPj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XldYhwa1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LuzLixPj"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689AS4te462951
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 10:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2xKwPc64yrAFpc/aolhuXPiL0+Ipk5BZd21HOrdB2R4=; b=XldYhwa1FF2xaOWg
	CcoGrzzL6x8yJd/SL6S8mX9UPVeGo1XHTD12mjkkLYlB/m3AadVC8ypDLsWvqifl
	AcKXBaH6eg5KWiUO0NFR+l21yUQYOxB9QeyLFVQHTFpE2dV0MpwCubgeqzD6zxz7
	lPNIyo0RhdrZDAy6qmlr+KaJYxaBzfCFZuMkw9UwjLr5qOwimx0F/m/MkQdIga6+
	QRLM0jAxnz7BdpNhnYw3GAG7b0pHNPcP45400LkyOFDYhlPtZmSv767j7/k0znSu
	mOrjP0hbn3vfkSaH4RtU7gypmFZO8rlBaZnEJPj7Y0e5GFZ4UCGi6CZpX1PFugPU
	bhgzTQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjywr1hq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 10:39:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db050d469fso45528415ad.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788950348; x=1789555148; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xKwPc64yrAFpc/aolhuXPiL0+Ipk5BZd21HOrdB2R4=;
        b=LuzLixPjey0jS+zs8ORq1mPsdw8Mls2FS3wwJWV1xm5+KwZmeO1u1pAGp0Q4J6Ana0
         POnZZv4l9BIx2huXYRTaaX3GcZv5TRwJz28uBUk8HoxR62S8Z7SC4bSA8AV/mYYnlIxL
         hK2ke20QZA/bjqkY+d1zpv/a3xSz0U8+LsK6/Z5vIls0M/9TF9eqCtiMXUuU22fFYN6i
         xC2yieVSGa9c8VZylhWsTkdOlON8Qw+36MJtsTYoMCeLeTPaYYc+bcvEzPDhsfYWhK8x
         usl5sgkFe9Vl1JvRcfAcnyEpvQLao9jtSvGT85BKmf1Dc5Ozb2BG5P1htbL7oGEMikuJ
         SJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950348; x=1789555148;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2xKwPc64yrAFpc/aolhuXPiL0+Ipk5BZd21HOrdB2R4=;
        b=Y0j34meFmWbpfym587Cffly0qWzU0iAEVX6hvc6lIZypGT9iQjwDdzrLsHU5Xj2lZR
         23CLGb/AlQukHkR69Tl3ww1xnD+Na/svB/Vv/foJ4KCnbaxbpNCd/YQtrCoHHO2ERQm4
         rRQ40CCBqkdw5q2lOYfgfYeiwCnQxIaaMmV2TyeH0AKl5KVsIIuZ7RvwRMtBNFtLAE8g
         cQQIEeHr3n47NL2b4p8mOEzNaV6VyMLlPgK6JasZr7/1qA75enzS44xj76+R1/CgcRcV
         1N1nsNgUcP0x7oKIqjHEJ01ZLOJK+WG3U6vRT2LEZ4OlaxYvRUWmtXS7yUotdIL1E1IE
         aW7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxE9+iXaCsWbv/U4d6cfA2S8Lbk4EEikGyqLRmPcUtbXVk7K1cD+eoMHKDrH79DYFc5U9UN0ScNiA==@vger.kernel.org
X-Gm-Message-State: AFuF++n58wuUTQm0mKvoi3PBMm32IY5Q20pPvzoDCmxJ71/LkakPLPTR
	jCPP1DmrW3E7t5IkGKlrgzj25gtpTgxptRl5FIqtlPJ4N+IN4/JyYicen34fa3ngcnE0s6g9Z/b
	wfKQUVDBc2X8qxUFHkjc/YhaZmL2pWz+C5ngIOqpmwWLIGRsoTSl1Dx5Ekk64Sg==
X-Gm-Gg: AYBFou1UKzAwgb1sWukFnKzaqXKHbtk6T3LPU4IJo66xfxmVSDnLXJp1K7v5TE/IcMM
	0QBQwcUkkq+i/mvB6xEyU4LmRg462wXCZbngwSUmUVAaF1WOuS6VrAjoV+fzjoBaocZbsCtqWIZ
	81rBeUeIgnaWHjmDcPqX2sZAugsmg7Iv8OPGGeizxFz1iWhDd2ZL3rJ/O3FMBx3/xKQixiX2Uqk
	IEYDhUytQq3LDewsMoUENLHzb6EmqKIQQpFdN5E89CTRh95bnbZ7kAPBS/RRPDwiU0DyGsMIO/A
	Jf2Ulf8UINy2rNr6COuruEGxzp3Hs/7h7bASaFCZhzwRYUjVqfslgUHa3TA04uPzcB4N2Grck7X
	9Z5aO0jnFOgNYG6P8K0HXBE8b6/66Kg==
X-Received: by 2002:a17:90b:2741:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-39b087f4ceamr40180500a91.25.1788950347863;
        Wed, 09 Sep 2026 03:39:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2741:b0:398:9beb:a2b7 with SMTP id 98e67ed59e1d1-39b087f4ceamr40180429a91.25.1788950347238;
        Wed, 09 Sep 2026 03:39:07 -0700 (PDT)
Received: from [10.218.7.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b608409sm49527269eec.21.2026.09.09.03.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 03:39:06 -0700 (PDT)
Message-ID: <b796333c-00d3-4376-ba04-78525853abaf@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 16:08:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] arm64: dts: qcom: pmk8850: Add ADC5 Gen4 peripheral
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-5-9c49b2eea6f9@oss.qualcomm.com>
 <4cd975ee-6d63-46dd-93ef-7c6ac1931837@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <4cd975ee-6d63-46dd-93ef-7c6ac1931837@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a4YAM0SF c=1 sm=1 tr=0 ts=6aa1374c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=9IytrtFQB66JICvi6PwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExOCBTYWx0ZWRfX6pkLjBFUmcz8
 YgCD2SREpx9Cmbi+X6mxoIsiWZeS2KM0SwlVYBqxmdB636/cqNCZM9qE21ij00KN1ryWhjWghbE
 JxFpUksyNANb5McwLa69AfGie7MsOHHCwPfO9WPazA4q99Nx1380c7rvYLUbf+YzZFMkaWdhBzx
 rZqFxYOnyf4jn9xM/mRM3bdontUY0xjhPA/3daKUum9n6AFC8eDFjbkPvZdMugCbxwFMyFfDq2s
 wS9cQx8QvS6QnvO2CI2u9eU9qDjdIudu6QzDzhb9PO+U4YyeS6hsHjXrjae+PgVY6aehAD1RgQs
 64tNRy7Vcs8JK5Rm/nly/ViMlh7z2vIekpJVtTOVBq43NX2l7lsLdedynjehC7yqJhL6DZSSJgX
 BQAOXWR9GKJTO2X4Kgn11jFjGkOU+OXoUqN2ylGh+TDxhJM/ztieocJK0b6+UjsrLXPNlbeLG3C
 PxZlslnFIujqXlQqK6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExOCBTYWx0ZWRfX0SIJ+jfp8Z8h
 3ldAcF3fcbt5nuY8jdfGqs168DIb86pk03ZuTbX7EPNrEr4/8bCbmW1cs/8yjn8BsglRaBY88gn
 oXg/bmUfRUy7lglUQZb3tbOKAwuHgUw=
X-Proofpoint-ORIG-GUID: KX_V21nvR88YtFIUbFipnGUsrCe9Y1Zv
X-Proofpoint-GUID: KX_V21nvR88YtFIUbFipnGUsrCe9Y1Zv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090118

Hi Konrad,

On 9/3/2026 2:08 PM, Konrad Dybcio wrote:
> On 7/31/26 8:06 PM, Jishnu Prakash wrote:
>> PMK8850 has an ADC5 Gen4 peripheral that acts as the master ADC for
>> the platform, communicating with ADC peripherals on other PMICs on the
>> system. Add the ADC peripheral node with PMK8850 die_temp and
>> xo_therm channel nodes under it initially.
>>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/pmk8850.dtsi | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pmk8850.dtsi b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
>> index c7ba72fd48bc..44d1d1957f8a 100644
>> --- a/arch/arm64/boot/dts/qcom/pmk8850.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pmk8850.dtsi
>> @@ -7,6 +7,7 @@
>>  #include <dt-bindings/input/linux-event-codes.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/spmi/spmi.h>
>> +#include "qcom-adc5-gen4.h"
>>  
>>  &spmi_bus0 {
>>  	pmic@0 {
>> @@ -45,6 +46,30 @@ pmk8850_gpios: gpio@b800 {
>>  			#interrupt-cells = <2>;
>>  		};
>>  
>> +		pmk8850_vadc: adc@9000 {
>> +			compatible = "qcom,spmi-adc5-gen4";
>> +			reg = <0x9000>, <0x9100>;
> 
> nit: one a line would be perfect
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 
> P.S. can we also add some more channels that look like they would
> be present on all 8850 installations, e.g. offset-ref, vref-1.25
> etc.?

Yes, we can add those default channels too for all the PMICs used here
in the next patch series version.

Thanks,
Jishnu
> 
> Konrad

