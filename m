Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96E3F4DFC
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290431; cv=none; b=pcRI32oBVrk3z3A1mXHHjbv1mbVxhIUq09kiuAvo6SnltsT3wj+OPjdrV+BQyqFKF9+HrX2gHAhTHQ4Y42/pHE95xO+R7Rd07i6lcGzTUvECtkADm8rVzA3bNuLmU44s27Hr9P+lTlEaFb9roZg55FeVL1pBAo0289FWX6HqqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290431; c=relaxed/simple;
	bh=w/o8ALu3JhTui62UkO3C0AbOHfMtZJQPDhlfOzkGK7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X90W4uTEyq8nspwcG1DyrrPPxw0SgnBiVMq9t4k+/EkLk9XDbYZOx25+KeiC5UBpzZcge9/AT3wKlrYv/yqzeB9T0Fi+jZwJnzIPrUsVqQS1SaAs7gUKdhOSOMXG4iARh7c2oLkM7aq/ZLWXi7XjpQY+RUEibu5z4CPc4kep7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTcRUO9W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZLhPebip; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTcRUO9W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLhPebip"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE6ZYH119071
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=; b=gTcRUO9WY7w9IHBq
	auVNP/PWNdAhI1JDrkGv+puTAs9PpXorZN5RUNjQianQ+YdeNO9TPyIYz3MJOgFV
	BJZxcKBPEFEP8pV4XQBpE7ekshDVFiMq2IS64bgxSKRWTKfIoS9o0tcTVAfLiLgr
	JaKdxj66r0t9f3rq3IRi0qxDJdvsXgQMCUmEUMxG207XAp0YNIi1NXUwif7nY/lL
	YAXoqYIdamdvViB08Xcsym8Xirj+eU2qHCV4tLlzn6/1fOHqY9jxFtEObzv4lID2
	VyFkjXCFJfZXGof0gXW8NdQvny8aKTr03A5j7WPxsmKfVLKyLoEpeHSbPilHoA4V
	lbMoBg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee88ba2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:20:29 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-482884a9ddaso12414611b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779290428; x=1779895228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=;
        b=ZLhPebipYPdVlkuDc3nYuv3uxf1Wni2t9WWXfxybT0KjbIEC57xO9KWc3TPLvDPEqZ
         qCCpI1DJO7edlMFhtNORdxBmBRwhDlqgm1bsp7A7Lf1pfZzptICgI4S3QeucLIyYd3FY
         XV/oMJjIPKiY6wEIxk4qC2imyQB7lEdwAYWScFEy4Z+930MZV93uJWa+jX4nr7ORduHl
         WSP1QagFejztilRtRYcKIRhS9EVybfXSwevYInIYyyJoJasKi40wo4lNgjWyTsKWALAC
         Ju/0Yfrh4CuZ9xg3ERqWO8DuIUH3bFPZELcsiZGtSNvQvEsa4d/RvbJTvQyqxWP+HVWr
         ZPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290428; x=1779895228;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mT+rMK4/HIfny/f0nd19A06TzmRHuaqZ9n+4gyyLAbs=;
        b=pTBfkcKoxr4/3H1DivzMTKqPmX/H+Dyi1ynrgxHMcti2HMMbVCdRbhvZTm3P7FdiLS
         AS/US6bbbXVTYYZSJohMlGGASfxg9O929GU1E10/+ouxIQnbelZS3o9c1X2TQuWK/WBx
         BWT4GqPdG9Ia9+SfLYv8pK+Pk/9GVZiscunDarZlLWFmHb2nQjwIv4y7Lrx7KJGfPO1y
         3ngyfPYdDSUpRHR3aKZE0nWB6AcvVqAuX9DV3F+o4ZVmGTeC0ePcJgBeNgM3zerd/g0g
         N/FzBm54flHukWnBQ7foVtsyuA3kBt9ipnRm1i/W97HGrgbpn+xFs3+pHX4rYYfihfV8
         c+og==
X-Forwarded-Encrypted: i=1; AFNElJ9IGjdx8cEL+mybdyAPmHO4WGs9Wm7cBsSKefbvWN15XdAQXupXR0Yadi5sKshb6S5qzS5aPwWWCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSKuwvsHHppncHcIP8isNrKeFVEIc0J1Fe7OA3rfNLtafAVGy
	wyqAZNeCunQLDUHLI0gvJi6YrZwgYY+vw0dIpaiGKv/zXclGgW0zvG3SoN0EQHeZlidFGLnD0zQ
	4l8Tnekp6pFz/9QDC+KrEPZU4lN8M8vKFlJ1OoWawZCuZdsnfZdbxwUPF4oK8Xw==
X-Gm-Gg: Acq92OFV6fPlm9M5ZH0/c8SygE3s+aA+ARl5cJtq6VT683stLLSviAiIKTEQPD/zkxE
	VnDgXYIJ77UFzNJHAvnfPTokMOnBMaFTcI3SPrUqDZfSwVgkBonP993DufhCfCDzV01wPvhtfwP
	asR8dtvgCC7C221aLpIhUAdHXQCBFz6y3nkUsbTio3q9ONt3AourcO1O4zwJfLt4Miz/N94GNUu
	dPunv2cA2ce7YZZlZ+OEn3F0Vl/A+fFR6l4wnRYJHdLgixJhgmQ6yrctfcvo+lpgWvsISugF8c1
	tnVLspMqFan4LsZKIGGV3uhRm0FyUMTtM+yPl0w0ARJ+MvkSfqmY1tVLjNgasf/X0Z9ZcnSkg1z
	4Xg61e8Fx67Yoxlp7zTVXxgcF4oqIYneIisqKB16ffTqFPfWKG5PTkqS9hHRYqMB1Hlr9GWAuJH
	P/RhvxSP/C0JZT6iCkrz8=
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id 5614622812f47-482e57c9a13mr17237412b6e.24.1779290428269;
        Wed, 20 May 2026 08:20:28 -0700 (PDT)
X-Received: by 2002:a05:6808:2388:b0:479:d779:353e with SMTP id 5614622812f47-482e57c9a13mr17237386b6e.24.1779290427794;
        Wed, 20 May 2026 08:20:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ed59:2b99:54ea:b713? ([2a05:6e02:1041:c10:ed59:2b99:54ea:b713])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm230047695e9.11.2026.05.20.08.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 08:20:26 -0700 (PDT)
Message-ID: <4d2cba0c-6418-4bb6-91e9-9730ad4d692f@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:20:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ with
 ADC_TM auxiliary driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
References: <20260515-gen3_adc_tm-v1-0-39ba29f9b4ab@oss.qualcomm.com>
 <20260515-gen3_adc_tm-v1-1-39ba29f9b4ab@oss.qualcomm.com>
 <aglpVX2NeQ8jxN6Y@ashevche-desk.local>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aglpVX2NeQ8jxN6Y@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: O3eNIo8XGfwdyjvvpGeRWdrn0VAcK38D
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dd13d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=-F_JFAN9hT3LZsc5xrMA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0OCBTYWx0ZWRfXwRcdV8TbM7gX
 8BmdLPxOBEBphfeyV9MjqxugGtAYI1N/FDL+9yAhHZH6ZlqYw/KOSQ5K+JE/xG1LesrBuR3FYHD
 A7GGzReRczYpsd2VXYjY6Cb6UU21YTYPbn3Gipeyr1GK9asMmupVnj5cq42ZGdq/7+lQ0xs5KIz
 tBbJxCGP4TXWhH9fLdtfNiakwIVoMzsN14A8zKTjcWyiqsqZX3ixu4wYiquSqOqD0ljEdBZjq0r
 46ssZYDnqX3cXBqxKpSb/SjnreFldh8OcrgsmcFBPwS9HcoM81fh+3iAVkbUqkbNoPhweF/CW2m
 l3Y3kLrq0YRCsJvfii1MgjDmvl54rchAlr86vdBzUpYYgDZkQ8i9BTzcah5HpRQ4KR/qVUoQP+p
 g5qoPrSMf0UAA3wHHQFR7hU49LgA3FqwNxJK6i8ZMhqO/F1HSApLTAAFnk8hMVzMEdDJ8f0DbwV
 ACasz9q4xfUnQnhCynA==
X-Proofpoint-GUID: O3eNIo8XGfwdyjvvpGeRWdrn0VAcK38D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200148

Hi Andy,

On 5/17/26 09:08, Andy Shevchenko wrote:
> On Fri, May 15, 2026 at 02:23:44PM +0530, Jishnu Prakash wrote:
>> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
>> immediate ADC reads done in this driver and for threshold violation events,
>> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
>> TM channels on the first SDAM.
>>
>> At present, this interrupt is handled only in the ISR in the main ADC driver.
>> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
>> driver by calling a notifier callback exposed from it for this purpose.
>>
>> To simplify the interrupt handling in both drivers, share the interrupt between
>> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> 
> "will"?! Do you mean this patch deliberately breaks the working setups?

No, the interrupt is definitively shared between the iio and the thermal 
sensor. So when submitting the previous series, all IIO patches were 
picked up but I asked Jishnu to revisit the interrupt handling in order 
to make it shared. That is what he did here by reworking the ISR in the 
IIO and resending the thermal sensor I did not pick for this reason before.

This patch does not break working setups.
