Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9913B8406
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793842; cv=none; b=mO2Q4xwsu1b6dP/kXHTwRDsawNwX0nQmDr0n929RQwzflr2JY7SErHuELQaC+vy1CA1rV07TbIyIgcsNADEp6+iKeM4jFIJ36dhyJh/CS9EKfGTgdCFIUArCu59uEBNribwveme7zCoNuUv7ljHKJRJlL6a/WlTKdc7r+6REX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793842; c=relaxed/simple;
	bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYhmT2+PgkVMZ3V1sBElJ3/db4GJmOGZV+EwXTMCuNDmdPyNemuKgcJ+EOoqOh0b4m5vPWComliKrapnZCqWbGI8GS96H5bS27fGNApKHG3LSKhNnC12pfVfwDFNNqrUcT+ySa42svDeZMftR1gSlAXtWmamdZm8vOiyoRpvSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pB1PvYyE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BC/6aT81; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pB1PvYyE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BC/6aT81"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpsH63513372
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 21:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=; b=pB1PvYyErK43eAPY
	8GRxW3u7AM7AHohNM0M3cHCMCNo1VwAlgiEmlPBRRhAH3qzvDhBijYNB8Mozuu1t
	A0lh6pes7yXko1c9nG+m9lUnW0Id2COTnlBJXuVbwlwJcKrTpdQyWe3r3T1io7Wj
	SjhPG5n4X8xvsENTS0CdPmtrRTaEQKdFIWa0HxwsCZDv1rMxb4234qxcRW5FPYMB
	6eFs8mtHEJekZQyzkcvtIws/TE/h1OvUe7QYba9+pcSqPKlYR/Ya1dKobZLgN1kS
	yEs0DqhocJ+ok1uVUHzxmQen9ZwP+lp1oWjuC5BaSko7GFzEEpB+JYeXEl2cRUyP
	AHWxDg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1v8f51-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 21:23:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f2d983d109so15903546eec.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778793838; x=1779398638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
        b=BC/6aT81v1IKW/jRwglaUTZ4VgJb2m3X6e9uWA651mOdjSw+TgBCXkCV7f96Pw1cVl
         wn6mSAxs4FEVjWeTtHXkzZtKjJV5huI2Zn7f+CDjCiriUFZLuPqDIG5YBVR5aldhMLXI
         ci/VRXNk3Utuwa2don0zO2DNcyJuF//bCB/n3OJc73fNuQJhS5wB95iVyekLwW1+Nd2d
         E6Uq5h+lRYDiFrhoqqChO++WST91KGaUC1AO5ucDI47A2hiC5JzpAM3B/iKZaXBSHwdc
         Qs5XTy4XIjQf/6X108DAOmE/gUwpHCQJ1bDiJkcL9Dl41ELCKjU07Fw/MmIY36QF3jML
         c/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793838; x=1779398638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi9wq6ITuBhZ0//XzAr/F1HphLRzl3ZxiOclMvD0KoE=;
        b=rrhU7C2dz5L9+IVzGhf0maWBNw3DaNV3ZZzt5qJFsmW1O5sFtGD5Wnd/wsVXWaqS0/
         NfQ6GRTjne9SPDX4gus7p1ylXm9l73jjTPhzOd3eCBHpSb60AMHe4JRCaU8K66jW5Gbp
         8shbfy+YCbaC/5Lc9gaYCr4MnlGlrTxKPSNvszPtwOtH7ZdNHZwK+P64W5UDDgJ3ZoIz
         0hNLTLRo9qvlh8AV8YBdOTp2AJdOsVjTtNsSntayyLaoqVYu/7yTNxUfoKsgCfpTKqa6
         ukcA3vydG7KYFxhKvj9ZHrXNU8CURsvnesGZheZNbHTLzy0MYz7V4tTiiBZAwqqqm94D
         Sp6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gUdsRn2dic7jI0bR7I6N5Cl0TeC34Cu9E55oQH/ceXi5Mh2jkMmN74yJ3RRy38vOuloViIC3iDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQK7abMOziRW8w2i1TW+Bf2o80+AQcH09Te41CvNlg4uRo4n95
	ua3ep2E6QGMyRS6vegEanSLR/wfhY1ZH9o7zS1BXdcor9pA30dt/2QwPtID0ZZsUpbGrF1lkLUv
	6hpgwcN/yYHMbas3YeY6ToOzHkmuIzXMgQWokFRMqYi4RYlou65aKgN86AeVc1w==
X-Gm-Gg: Acq92OGBGfog6Gzraa5nRnAHdupv33j67+sMTHdNAT3Tz0eRfhHufQ0se0OaVdGTN+w
	tRnMvRr9bG9eOB+ibOGheNz+6aGedT/ZYnCyEB7Lq5YcnLLzvrqCbQhoAld2IkHXU+p+0dsx3Np
	1NARX4f1QBTAuSpcWrbstZEVFg7CV+fnHbm4B5RuQkYJo82dZguKg0VV6Cs9l6+xuSZGjYekdny
	shlQvdZeysxqX15qPmwYBgOk+xGBOTKSxZOLm8U+2wblok88xy7xxcJ1MNOj8bjJTBInZ2Ri6FA
	e/6BZ9I1TERQkQTcbEXI1Egd/ogHo3rlJVMOphi2z3UdDktYYXe/+oB2O603JffvsNOx/CJEwyR
	bJRPiWZhlxnR418ZrtLVLmrvtmXdIgKZSR2szfUAhb1wR8NrB6L4mjsv3fWyxTTkzEtbAEZShMK
	1i
X-Received: by 2002:a05:7300:724f:b0:2ed:27a3:eae2 with SMTP id 5a478bee46e88-30398189fa8mr789534eec.15.1778793838372;
        Thu, 14 May 2026 14:23:58 -0700 (PDT)
X-Received: by 2002:a05:7300:724f:b0:2ed:27a3:eae2 with SMTP id 5a478bee46e88-30398189fa8mr789513eec.15.1778793837795;
        Thu, 14 May 2026 14:23:57 -0700 (PDT)
Received: from [10.73.236.148] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302946f2149sm4468333eec.11.2026.05.14.14.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 14:23:57 -0700 (PDT)
Message-ID: <8857fc71-aec6-4682-b4f4-0bd463f367c4@oss.qualcomm.com>
Date: Thu, 14 May 2026 14:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] scmi: Log client subsystem entity counts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jyoti Bhayana <jbhayana@google.com>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linusw@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260513-scmi-client-probe-log-v2-0-36607e9dd540@oss.qualcomm.com>
 <20260514164422.0eba9a61@jic23-huawei>
Content-Language: en-US
From: Alex Tran <alex.tran@oss.qualcomm.com>
In-Reply-To: <20260514164422.0eba9a61@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxMSBTYWx0ZWRfX3avj/Cg1h4MJ
 xdsD/1La+nqBSNx+/umnP4h37ix+ctKiLhRimOuaRDntb/e3Tn6jD99gz6ZB58JxGS7T9X+/4YN
 QOwFo0oET8TYLvEfwkCIjSE1EwtFFwMEyXTUh5mVw8PZFVx7uU54hMTjrxWdb/hN+oDUzurkLRO
 b7mi0kpVF7gpxPvauqln0d1E0H41Oh8dRWlU8Ua63e1gnIBrZUlnwhXcfBj8DzJ6Q8WJRmXwp0p
 ALkrUQ0MaooMbKlqkFLfJ6XXr9IzPWU1oEnBWhGiGmNi3kkKJ/YGhrNJhFvJXmIqrg+dm79O27N
 1L3nNFMkGKJ8Q4yrlIIR4UuCexzPu7F7A2l5V/FCcdkB8sjjE0mK9TW6IiNaoHUe8U5xl+QXQP0
 aBqFWNDItGZuw3Fh2C10AUsdYqPomm/yQyw9/IA3pkdq/Tyt/vg4w5oht0wxPAQyAl/YJf3us6f
 yah8aku+YaLfrKVBTig==
X-Proofpoint-GUID: ytOf77toxlsxftB1YKwn8MuZr5fJboDH
X-Proofpoint-ORIG-GUID: ytOf77toxlsxftB1YKwn8MuZr5fJboDH
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a063d6f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=yQWfTViADuQTjb5oKp4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140211

On 5/14/2026 8:44 AM, Jonathan Cameron wrote:

> On Wed, 13 May 2026 10:16:53 -0700
> Alex Tran <alex.tran@oss.qualcomm.com> wrote:
>
>> SCMI client drivers do not consistently log the number of supported
>> entities discovered from firmware. This information is useful during
>> debugging because it shows which domains or resources were exposed by
>> firmware during probe.
>>
>> Add logging of the number of supported entities to the SCMI cpufreq,
>> pinctrl, reset, hwmon, and powercap client drivers after a successful
>> probe. This aligns these drivers with the existing logging in the SCMI
>> power and performance domain drivers.
>>
>> Signed-off-by: Alex Tran <alex.tran@oss.qualcomm.com>
> Hi Alex,
>
> Just curious but why +CC linux-iio and IIO folk?
>
> May be you had a false suggestion to add them from get maintainers.
> If so be sure to check it's suggestions make sense!
>
> Not to worry - we can all hit the delete button ;)
>
> Jonathan
Hi Jonathan,

Originally, there was another patch in this series to add the same functionality to scmi_iio probe but it was dropped. Apparently running b4 prep --auto-to-cc does not prune stale entries from the cover letter. Will manually remove all entries and rerun the command in the future.

Alex
