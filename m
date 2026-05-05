Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B87347532
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975641; cv=none; b=TQhxHAtkZmdOdvX7Lb6R+jKUnMKsJxOdt9cpPz8/A1ycyTFSj9uGThaks965uuknmLivgFEle4fccOo/KPZVySdmormK2BsPD+DzwRZElREpHTrqfbDMznaUlnNybUe9MsSIbllI8D+xPmgvJfFIbEW1An5lwnYyalOSomlCus4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975641; c=relaxed/simple;
	bh=O7HJ+iuUgSEmxINiGFsHkAy2ayaorypC4azbolseFeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOgla/8Gd8Mnm52A2Q5XhNnf/JQDF2FY1GBhsHNOWWuBDxSfmh+i0aOGpkMXBEWQCoMw5QfgbrYBKdBGmLYYTE8RKkxpsMNHkSh/Wf8j3rLrrtv7NRrVg8meLu81PDXBM1vh6xhlMHEkB4Lf5KxmyjdiwPgenJecu+nPkaH3x4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VOnCOWEW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c/YdMRP6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VOnCOWEW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/YdMRP6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457176f299348
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 10:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1CHXNJkOqtV2IaCPgughLsXWthxGEfJxjBeiLJ6cvmg=; b=VOnCOWEW2TvIlK3Q
	ARgKxP57sMfAZQZcswPrCqLGi+Vaeaq1hkgTP8tJnJiGlDj3uJwNOpuXO7Mh/ht3
	V1ow7L0pE55AQi8YdjJVU2xRsE7SpptQpdDN7gGu1IWzT2ev6E+QIEAcE2a8lGKj
	oznFRpPL5xt40632azAwkNgIDIQQzFu/JK2KVqbIOKKrGcrmlP4VUAmc+yYuUax/
	XdyhFmbR8CMXpAhsfRuVhvAjAPKoQQ8nIbJMeMuaq6GSEUTMQBFH77ysT5uqMjuw
	SdMsasqBBvVFSM3+fnN5OLY/X6kaoCCEQuZu/VY78uqdTTpWIwBaTnzgHvJZ+F5F
	M20+6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvndbwwk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 10:07:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so127396341cf.3
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777975638; x=1778580438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CHXNJkOqtV2IaCPgughLsXWthxGEfJxjBeiLJ6cvmg=;
        b=c/YdMRP61bsehy4zH3CNr30nCxlTR120GoRtx+DQq0jEMkAvQq73GrwoU5aMKeC8EO
         LB/2tdpHMfMzG3iSSfFppAT/roCcMFbp9fmXQRVhBYs7Xe2g2Czya9wc//vXUQSX+90y
         CPsdcTF02aOAzS5e04zwqrTkTLHXj4Zfd5t9BYtBbsYCOJlm3kCGbI51xLSdu3FXj5aH
         kR3c1CYdMGySgTI9AHaBru8aZbPFrl1jE+zRz68TOStTXx5GOadlgMyHomyrPl/a6VGn
         REuHtWyhf6aRFLPRFSHFYH078AZsO/8ibffuGZIVoR5E8NP9rKbT7d3ljnDye6lEpTxr
         p9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777975638; x=1778580438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CHXNJkOqtV2IaCPgughLsXWthxGEfJxjBeiLJ6cvmg=;
        b=Uh9jVESW2urB2I+9vB2rlwGQIfng0yFaQ13Ip/SbLmbncudfBFQ2dgkGbbyQyV1TfF
         Pidrg/D9lv6q9ePMIpHjeFRl/r9fzupSdIwo7IWOg69fnXK2Jm2ID7CsG/CatkRkKljf
         nqg3sGkGjp2zYOq5Mfw0SG9dZ6Pcofu7SWn5JR6gWs0xq42ZtahhfhmBrWbknITAEbm7
         6Q+/0ySXxmLL4FXoWASMQ3Om3FSCdz6xsblmvHcjtQYhroDdWl48yw3IlCk4Zia0gvrL
         kRA536eEUdFi1HIzosXiwRxIF7p+lEHiLTygPWs9JqhZNN7zzALdW5O20nPWXXbzPq3y
         LNOg==
X-Forwarded-Encrypted: i=1; AFNElJ9mt4AcEqj+RMI05Zt/xvmneoGWvFo9Rg6fiI/H87E/PzgdvURsv2KQQF6yEwWbOk/HjlSkC1PgyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fwdC979FWOct314oiAFeXBAADluzoThtBHxeTM0uybxZmZSE
	NPvY+/mlRZtwHnIbrJFrj3dbBNmi5YV2OxgvQbQ92gWnS+bI8QMSA2aSXEA1g5QRrGn5UlsqKvL
	OI8VZLgMu61J+1JAV6R5bvSyZf2eQQTWrIm/kaOubb0cy71LqQqIbAnNgJ0wryg==
X-Gm-Gg: AeBDietzpF/qTsP4Qk4W5qEU9KuROn3jW9PvGLaxg+RJtDNE+GAzYejofm699G0iin0
	9TjaklwPGsR8VHA7UbRZklrtFKxonkl+Awszg6ErHMKJtImLhi93RCQQJkn+c6Fx++hC9r2mtxZ
	GmLS+HXggUeKByKN5k8Fz1BxvgIiQvHvPXJX5XPKFhZERKkAE+g1t05fMSKWqtBl0mjwAkPE88s
	IYHUheK4mlgJQWGX74/5bQimtRAO0gtWzsreHOlKUPhZd7Lg1LBiq0ctTqynqWuC36Fhuk6qOyT
	gg5Fs6LrMejezrOWvL2aOuWTYYx/fZNRfNSMRIdEHGG3NukMCrbNouWk0mQazMgBjKhPzoIF//U
	aeaBt0qVbx4RHF6ankA8GlJ0hoWdkLF7NFs4OHSX1gGuWIFml7STeLzRjOruQWxQrggTvmQBOZW
	qheBwbQoPyIBcoo0rR
X-Received: by 2002:a05:622a:4c83:b0:50f:b4c0:62ff with SMTP id d75a77b69052e-5104bfa6b9amr181644271cf.54.1777975638331;
        Tue, 05 May 2026 03:07:18 -0700 (PDT)
X-Received: by 2002:a05:622a:4c83:b0:50f:b4c0:62ff with SMTP id d75a77b69052e-5104bfa6b9amr181643591cf.54.1777975637812;
        Tue, 05 May 2026 03:07:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48c04sm3430045f8f.15.2026.05.05.03.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:07:17 -0700 (PDT)
Message-ID: <731f3161-a202-40e0-ac22-aa16ea58e832@oss.qualcomm.com>
Date: Tue, 5 May 2026 12:07:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in
 the OF code file
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@kernel.org, gaurav.kohli@oss.qualcomm.com,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
 <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
 <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AfFfhWnjYjv0kTRQ436XZlzEOmBimuAU
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f9c157 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=YZGnXRgRHs9QsuzmzP0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: AfFfhWnjYjv0kTRQ436XZlzEOmBimuAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA5MyBTYWx0ZWRfXydMDv6t3BBXb
 SJUXYNtjGYrsxL6pzsAquPFdWFPn/RuvMb6osb8daLY9LGiheegUZEBfOokLvukRKAMR+SVbjG4
 M1QeBTlfgQtCEqkbhywx5S/9tahxfkdOUE5c7lJrtSOmxK4ByfuD7FbHCq6itYDj0CI3HPaLwu5
 8zkUpBjv4AwP3T7F+fKczAgIjC47uQ50/bzYNVhuq9sM0QMe4a1IRX9jNRRLA4tw9GHCnKqW928
 t9n8K9dHR4TLR7wwK5REBK3dY/oq2wwz2y804ouBI9vVaLwrsEEQMvqer89yWxm3TnYW8nA/h37
 oGCO0uMe4Oilk+bS507kfQZwdv7ft6hg61bA9flTtWEbtDCuLXtBeJN5RoJP4UdicauAusYZbd8
 iZIYLbn2UHt/mxS3it7secezAavKFym1ZCjy8Qme+er8ZEri5bohT1NENLpPbwCDJU/0YX6MpYn
 ByK+R67tnbSzPIVCGjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050093

On 5/1/26 14:50, Rafael J. Wysocki wrote:
> On Thu, Apr 30, 2026 at 10:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, Apr 29, 2026 at 6:14 PM Daniel Lezcano
>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>
>>> The node pointer being assigned to the cooling device structure is an
>>> action done by the thermal OF only and does not belong to the core
>>> framework code. Move the node pointer assignation in the thermal OF
>>> code. Consequently, the devm_thermal_of_cooling_device_register() can
>>> call its non-devm version resulting in a more intuitive design of the
>>> API.
>>
>> I wouldn't make this change.
>>
>> It adds overhead to the OF case that's not really necessary and
>> complicates the code just to avoid using struct device_node pointers
>> in the core and I'm not really convinced that passing a function
>> pointer to __thermal_cooling_device_register() is so much better.
> 
> I would start with splitting __thermal_cooling_device_register() so
> that it becomes (sorry for the white space breakage induced by GMail)
> 
> static struct thermal_cooling_device *
> __thermal_cooling_device_register(struct device_node *np,
>                    const char *type, void *devdata,
>                    const struct thermal_cooling_device_ops *ops)
> {
>      struct thermal_cooling_device *cdev;
> 
>      cdev = thermal_cooling_device_alloc(ops);
>      if (IS_ERR(cdev))
>          return cdev;
> 
>      cdev->np = np;
> 
>      return thermal_cooling_device_add(cdev, type, devdata, ops);
> }
> 
> where thermal_cooling_device_alloc() does all of the ops and other
> checks and the cdev struct allocation, and
> thermal_cooling_device_add() does everything else previously done by
> __thermal_cooling_device_register() itself.
> 
> Then, it could be renamed to __thermal_of_cooling_device_register()
> and the non-of variant would simply skip the np assignment (and it
> would not take np as an argument).
> 
> You can deal with the devm_ variants of the above analogously.

So we will end up with:

static struct thermal_cooling_device *
__thermal_of_cooling_device_register(struct device_node *np,
		const char *type, void *devdata,
		const struct thermal_cooling_device_ops *ops)
{
	struct thermal_cooling_device *cdev;

	cdev = thermal_cooling_device_alloc(ops);
	if (IS_ERR(cdev))
		return cdev;

	cdev->np = np;

	return thermal_cooling_device_add(cdev, type, devdata, ops);
}

and

static struct thermal_cooling_device *
__thermal_cooling_device_register(const char *type, void *devdata,
		const struct thermal_cooling_device_ops *ops)
{
	struct thermal_cooling_device *cdev;

	cdev = thermal_cooling_device_alloc(ops);
	if (IS_ERR(cdev))
		return cdev;

	return thermal_cooling_device_add(cdev, type, devdata, ops);
}

Right ?

That is what I did more or less initially [1]. It resulted into 
exporting thermal_cooling_device_init_complete(). Here it is similar, 
with other functions.

The reason why I added an init callback in the 
thermal_cooling_device_register() function is to centralize the cooling 
device register logic into the core code only.

By exporting the thermal_cooling_device_add() and 
thermal_cooling_device_alloc() we duplicate the logic and IMO it is not 
desirable.

By introducing a init callback, the core code gives the opportunity to 
any extra layers to initialize some private data in the cooling device 
before the init completion

[1] 
https://lore.kernel.org/all/20260422174305.2899095-4-daniel.lezcano@oss.qualcomm.com/


