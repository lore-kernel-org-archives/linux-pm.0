Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D433913B584
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034983; cv=pass; b=Hkypm4puN06f1bN43VwcYUVHFWtDRhJiGtzDk+5NKKh9wsKXBpqNbBdiFfP26DWpagGQcEIHvdAAlcobvz7CUlCYLFT5KZXBcnGIJZg2W49SAglLV7/DwxHD1tYFrOOyCevXxVG4xXL5XpDEaM/fSLrfpDrbai0QOloTIiIwbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034983; c=relaxed/simple;
	bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5E+NepYULisSrXdEOmN9DQ5dzhiR/BdO8O1ZOiIegladsO7xeN7r5FbpBqw/hFQSt5HqzJIkV/QxoFUnzFT5+bO7uZKNcK9pWJDD9vA5abSHi7jwS3UygyToyXSeF6XUZoB4V0wltT/AKoJOogxiRd6Qx3IR8Vne0HkR0n/4LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeDP1noV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cioL0yS+; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeDP1noV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cioL0yS+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBNu0f438934
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=; b=jeDP1noVY97TJJm4
	cIhajSXeAsAmHOxUZ5w+rrnFsmDqOKfN4qv1NciKwvl0a9vv59ESqt6/YuJgOXKd
	2U4f3xsKnro776B5eQXUkzzonn9zUj4EjUY0CcmNrVrEgX1hsU92QRCgcXc88Zk4
	AtF76m99A0GiWR0qvmuA/OQHihEj2e1+CtLRE0wEH12PxEsaH+fBoJe1xohiHUcX
	R229DzrrEXb5VIR1CijlNq+5VjsfmV0mgJza7rCEwLCI9oqIAHjuyOO3YurOejU1
	OXk05tjGT7idOG9xzgxgye2BrDtcmOkjjdNsDeOVdRx43SKY0RtvrJ1yvDvre5qj
	UD2uKw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudh9s7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:16:20 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8efe7db1c42so73452236d6.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784034980; cv=none;
        d=google.com; s=arc-20260327;
        b=n/68wSDMJRreciqXT4pxIwPpK91RNPgsfblIn7mVwToSxnTsmmVC/HkSh6hkcqPSlQ
         I47YPpbhvTYzDYyTgVkHl5524T3k5JKmuOcY9Xb25npSxL+Ye0HjT3q3N51AZhjytLx9
         r+nQHaL25QITMCoSPvtS20KHDlSHYJjgtRtkClpLBRBtYNP1R25JjZojCuUELo6xctrQ
         ya7dQ4XtGMvNx8G5THWfTHRDUAbwMmTbx3SsXsT8lgfvlrWmZggRDLoJCDfAXBSSNEey
         u8aJ4JeiznZp27lj9E3d9oj276oD1iz1apreBy0oLvdzRxx0owTh3f9wDnmJZPkRJ2qg
         +nZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        fh=rYtNS03Kyha1Dye2kj1xIvnET8Mrktg5PcnkuNcVkvQ=;
        b=BaptgONrk7erYy3WLchX4f1Omi6eyLvz0sxLIFFP9jdJaIFE8QoZPXedlYmte5jd5m
         zTHmtT8ENvmBfoP88H19qR/mKZnra3y5BIV8H++W351PmaJlwtTM2ATX8onfTc8T+n4k
         G+4OMOygWGu4TB4k8e6yzT2y/BCS1ERyeHxgcHwWVYIEZB//aBpGrGa5y3Zc/C+SgMdJ
         JBDwZfRN0TZ0zZFUYuFe9tTtK5XgshqbgcXe/sCFf6wd0QIYERiBb+SixwwczUku/kdJ
         Y/9RQzoMFFeYE26NxcIdVQh167t6jhbRjdzVDqYG5pr5vllsrPM4aK4HcAhto1aAIh1J
         pAJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784034980; x=1784639780; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        b=cioL0yS+m7iQ+Un4y9KPRfCvUwbZxC0xQRu+SZmRcgaQHlaMpOuyJETcrk+xsCydJS
         rx/JXZ0vlPSJ46zxZ/moLbkLzEFFO0TXJ979XZx4o6mPym2i9kzroOI5kygxFEe6Bi5R
         LgVxo61fu3nXasj+kizAbtRICOyjFgRCjtp6XrZ7uzeP0UIS813j7bgUxON3fRhe9zGY
         e7doqxvCPS1+FdTC+4IGTzIMO34POO2/rH3keQo332wYpg9bskUCjm7FIcDtJLzWa07O
         /D1x4xq5YKRCc7P8jD/k0p8unDHZTD20lZwtiaqEydbmFKT/XzVNkmPqitS0BB28LQTQ
         x6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034980; x=1784639780;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jd5DJDKksYD7YmBkR0dFjXMUrqs3kGnAsls6yHowXHA=;
        b=RbZ6DTA4dBuO5QH7MXmH97J9gRCDL+Fa+Yz5Ym3jtu8j93KgWOI8tr27bmePqNZ/zi
         C4rtku0GR//Cmq346Q9GUjMPX2L6wclJI9V7b616EBJVaqyo5y9pimf4J0Q5sKwje9XA
         pyjRYMHf7vFfs7JNi+Yj/YU1q4ESv8pOvv+kVCxtNcc6V5kP5cJJ9d6nc/WW0MnUzshL
         7vd0W9omrr97zX07OaCNifa3Wu0pzqgG8rExbTrTnVGSWPojBRtnV2MmPzgKl1GyeFJs
         458UtalIGz/dSCZ7BzF+L4gu+YBttjp6Bf4QXaBpCW8Uu7wE7q02NYdlZSOQ7R0+q3wK
         H7/w==
X-Forwarded-Encrypted: i=1; AHgh+Rr/h7kxL2cnekrwb0Acr6otIAnA1qiMudkZ2ksMKu8bUoKYa9r9IcyQOF1WxdRdES2S6OuYnxlkew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+JAWDfLu8IF3lEC5mZ0wNfIg19seEUfAnc9QNMiRAEVvNudS
	yqJVC8b2oZDy5dV6zrbid+Q7SWqhikmhQ8Oz3YW7mCObz6MPi3hImTlOrb7EaNioOANCarVgKXC
	INZktSkDP4AjjOqac7Rl20l7haWaTligOpA/lYwa+ivIWEPHG7yEBzXvq1TQJKJ5NSJZihb4Hnv
	oM0OreegGKUdAqZ6fzWCNGobkbTRnQ6KhTG7/f8cigXng5
X-Gm-Gg: AfdE7cmeW5wNlqPpoP9UyzySqr+QEaFpBav8yohEf8VZvkoIqCXHZwW3pItjk7prpaC
	R1vgEXMJ/tht7NJAVP6qDoKzBx/6ci2z1uCKhGaZO328fwyRBLRSERAk7+Ufwv+2ZkfMvSIozSI
	4+dlfJJu2FD1uVBaMvfApaWgi81R7lnm5bq8LBRMfGZS2mhog+2RDPKW3jXlOYEM1xiKkp
X-Received: by 2002:a05:6214:2689:b0:8f2:67bb:a37d with SMTP id 6a1803df08f44-90747d19fb5mr45880316d6.57.1784034979491;
        Tue, 14 Jul 2026 06:16:19 -0700 (PDT)
X-Received: by 2002:a05:6214:2689:b0:8f2:67bb:a37d with SMTP id
 6a1803df08f44-90747d19fb5mr45879656d6.57.1784034978901; Tue, 14 Jul 2026
 06:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7f7e8c9589d937b60e43168845ab4fda15037a3.1783603600.git.michal.simek@amd.com>
 <ak_Eu_eQKalPMwo-@pluto>
In-Reply-To: <ak_Eu_eQKalPMwo-@pluto>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:16:07 +0200
X-Gm-Features: AUfX_mxKzpq6RPl9OYBnCrjfKgjOcnNPKcB_AjUZghzaf78uP1r8iO8ekjIwd1s
Message-ID: <CAPx+jO9KMcxnmt-wT5jaApj9p7s11B6eSG6K08Jt9J=-vXxjhA@mail.gmail.com>
Subject: Re: [RFC PATCH] firmware: scmi: Make SCMI arch independent
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, git@amd.com, vincent.guittot@linaro.org,
        Souvik.Chakravarty@arm.com, Alex Shi <alexs@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        David Lechner <dlechner@baylibre.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Len Brown <lenb@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linusw@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Pavel Machek <pavel@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yanteng Si <si.yanteng@linux.dev>, arm-scmi@vger.kernel.org,
        "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
        linux-arm-kernel@lists.infradead.org,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "open list:ENERGY MODEL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: IfwCAmg8Og0Zxp-U6qPyEUeGgWNd7yEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOCBTYWx0ZWRfX+wqkoTrr6Q0x
 CV5F6pTMBC0zJVzlb52qpNgMBOl60+wkLlnxKmp9nnw1TIcISoayW9Bp7bP8suD+XxwGThlhIIU
 Ub0dLuIOL4oF3uQKLYoTFByCkEr0arYG6TnaZMnSko9IrZWNoEwk1807fKNcZn2xA1/tF/0ApEU
 5CD8TeowBInHl3n8/KBXE00a96t4uHlGKPWQvdbc8ny99lZ+vcsMes5avR16TgbW2puPfp8hCqJ
 bYaOzzurjzPm3md7eLcaH3TLYSOmkOc9fEjl3ABuCYrRL4TPtbAsXcABAzHcNuGWSliBeNvYikI
 qrpNZkJUs1IJPRD/2Wcd3qRWuWNezBgloVKQJO4KtEAVp+XXySNawTTSfjTRdrh/vzg418mZWJ6
 kGnWAcu8mACu5vaL/tLJI3s0HgJKZ8lfJ+7DKme3tSScU7tu6ygykSu3f0bXFiRp1XjsY0HuPxL
 yjsiY87ZWX4lkXCBFsQ==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a5636a4 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=7CQSdrXTAAAA:8 a=K75D1l0-MnsISjLg7T4A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOCBTYWx0ZWRfX380ru+iydVcx
 SRx0ABD+54QhRTaYEEh9kHC8I2+JqyH3GRDtyqbROJ0NFVsmsIVggQw+EuEmDvr/BTKkxnfyZjy
 UYu+S6QusQ3rfAxugDDXejsdwOfiDfE=
X-Proofpoint-ORIG-GUID: IfwCAmg8Og0Zxp-U6qPyEUeGgWNd7yEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140138

On Thu, Jul 9, 2026 at 5:56=E2=80=AFPM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> On Thu, Jul 09, 2026 at 03:27:00PM +0200, Michal Simek wrote:
> > On heterogenious systems like AMD/Xilinx FPGA there is a need to talk t=
o
> > SCMI server from different architectures than ARM that's why remove
> > ARM/ARM64 Kconfig dependency with also remove ARM from description and
> > rename folder to reflect it.
>
> While I understand dropping the dependency on ARM (I always wanted to do
> that and test if it worked at all on some otehr archs with QEMU), I am
> not sure about the whole renaming party ? why is needed just for
> cosmetic reasons ? it is at the end an arm originated protocol so I dont
> see it as a being wrong to be named as such even though used by other
> archs...I have not really strong opinion on this...

This is certainly not my call to make, but I have to admit that I
fully agree with the above.

Usually we don't rename files that indicate a legacy platform name,
just because a new company/platform wants to make use of it.

>
> ... my concern really is ... wont this full scale rename simply generate
> a lot of un-needed churn for future fixes and/or backporting ?

We have some git magic to overcome most of these problems, but it's
not always straightforward, I think.

>
> Thanks,
> Cristian

Kind regards
Uffe
