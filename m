Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67584BE437
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647538; cv=none; b=PTZl/XfmNDrtZfiBDo66eO2NEulCRJ838SiUi1B/aIOJuLGYLndyYrQvHny+ivnoZ/T8NhZqWJkmpnv5AWlg4I9h9Fsf4O1cOwBWQIYD1Y5seZEvjeKqO/eCeeP0nBGHRm0iEN7hdGCZe+RTJezng6m1kAfYQ2nag47BhgGHLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647538; c=relaxed/simple;
	bh=kcYWCICZxy4tVxR3vKSLEGl5RDtmSqe639LHqvGgn/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNsPvn88/oGmBr+opZLNakTJ4QJodyxnjFZ80oalQGNqtjGmuOvXs9xXDRd+88efpgXyW3+W6T4As1OhwR7ITLg8S/qM/yiimb1Z7hz/rxIWE65sRisVaxw0bNONIAa5DyWWG9aEGCPv78aM9KRSjomO3M8fv6H6qLtLoY6or/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ol6zTXKF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WQ6cWPSe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ol6zTXKF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WQ6cWPSe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9Zvhw1390219
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLidpK666Qo4PK2scTKJdMHZcsfWyON6rHKOqwd2TFY=; b=ol6zTXKFnD4JTeBU
	LZXVlSGRIKpqvNI1JClyH012G5SMoW8Ppahz1raOklot6VsMWHMYfVhtpyAaWCPj
	WTgTCywUIvGYku13D8HmsBIWW/pVIDGQJIdsMnS+tcIVHq2vjIvxPnsjrNYdbfc2
	eJdfsaO7QUfPiJo0wGQwacAQnmbDxkhHKCuxMrRzI2R22cFj9V2UNjrDp93n5+pe
	5mgoEIrhrg+Q+uTwPhqe6QR9gn627UkrHHGaXuEJLqd5iXgtBzxQiiCSNBYO8lNj
	2UoeA8Oo6OkdXu07QvdSnKXptZhDFtDz/eoxuPlHLBdZqBIxlzIS//t1nIoX6nkv
	xyuEHw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d4aj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 12:18:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so659680a12.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789647525; x=1790252325; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLidpK666Qo4PK2scTKJdMHZcsfWyON6rHKOqwd2TFY=;
        b=WQ6cWPSe+8YeDcCL883G9ejMZz0V3ezAjQNLo3AENMGy1hc6IBP9t/beR0ApBs20Z0
         1jfoHdkgYn+NJZdapejY1RzTjXE+I/IBqqhjiO4JuLS2/ixrEMh9x513viOpFUhwt6F2
         fRFz1j9ygMkURQkX2z9TAZEvapErPJW0DU9FoqdfKR+mioR8WmJb+9b2pdB3pbkDH/tW
         84e1RtbgTfuy7hNka+oBL5O5xYAUlJMPq91aHaVNb9SNEa6qsPPR1g8CkLAEWmRdhPLg
         GHozZe5Dh8YOdKX2oh43fn97DCVU+gvJYyrEW14uCJwScYXHFENpLNq7fpAN7LiNDsCC
         Uoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789647525; x=1790252325;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLidpK666Qo4PK2scTKJdMHZcsfWyON6rHKOqwd2TFY=;
        b=1q4gAChjiplWF+BaizQodVqR7xYo8X8cBUm/JSRftlrVoGneqUsN5x/QgqLC+6gWnS
         vRo9xKdazS+Jv4Um2DwQnQPsNCgrfLfc1Fs1OTlU9EaE8u9XGxU3QeWX1zAFNjnz8MR6
         d0HYSgyb5Wyi8vM1snB4xEbTqhG9texyGCeyPOj3WiiI6GvzRpbyA26cVOJKJVq58mmJ
         ZJMWXFK9kl2vfak8EhgJ/geaAtx10UWp1oxYf7wop47L5Kv/kalQxBvzWKdw1UFtMWO7
         ubBckWcGIYcMyEoz2C+8ZEmrgaCAGbJksbhDwN2+3RnmEJf/3UqLcLVSgHp1k+vXnj6K
         fBVg==
X-Forwarded-Encrypted: i=1; AKwUvByeYcvOFkLkaz6sSjt8FyXds9ihSkdmp/jaSr2Y1rTQ/8RATAMGjXGGa57wUKmv/otpvghm0bVjkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lCCpZAdSfFiHaQZGN/qNqMFaWXt44sTswwlzBFmULk42PnjV1h
	emWbP+Rfq9xg9olSVcQdoLEp9+ILR+6CIFs2wu3tdO7tn9S0qpap9yOjCGn9C7xzI9QDlTfFjnP
	HxsPULCPyeP7I+qrlWayISMdiIM1PPOJ4krWU7H8kuFFe2tXiV7+98KIL6SegcQ==
X-Gm-Gg: AYBFou2VLB7uzG5z1Sn9ncbil8H9rBJUFE0xIMbQgGVUVs3aW5RZ9sqHvfmcptGzTID
	FquIsPPdUdDrkLWvVRULLAkDbTv+3m29YfmzmC2MlcF3CWyZYGOQ64ZIbZeXJMYeA4EfwUvgNge
	5IsFMkuJcYdPr56yuQyqSci4Le2eg+7048EekoqrCSs8LPubMi8RFGM4078u4JkY6zEoTtJq1yx
	AlKLc9lGknbAwc+hRMJ7iQy15NcdXjEc+lIBsH/R5onDIBzAa39OVwEgn99bWCgcLdjTkatan/y
	Il1rfWyC1xE+q5bni+K0MMLe+nVoS1tqqPIxAo5H3QsrMexNEZcQgMQmrizgCECSnRpmY2nxSJc
	Z1z2ikpPMQTtcCzbsY/uAI7uHcw++iks=
X-Received: by 2002:a17:902:f686:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2dd8e76a15dmr143388025ad.21.1789647525393;
        Thu, 17 Sep 2026 05:18:45 -0700 (PDT)
X-Received: by 2002:a17:902:f686:b0:2da:ef81:37e7 with SMTP id d9443c01a7336-2dd8e76a15dmr143387145ad.21.1789647524708;
        Thu, 17 Sep 2026 05:18:44 -0700 (PDT)
Received: from [10.218.9.75] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89c3316dsm25970945ad.0.2026.09.17.05.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 05:18:44 -0700 (PDT)
Message-ID: <f14f40ef-47dd-453a-875f-6cdc6804a9fd@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 17:48:31 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v25 04/10] firmware: psci: Add support for PSCI auxiliary
 devices
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan
 <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz
 <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti
 <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-4-4aaf5c09b5c2@oss.qualcomm.com>
 <CAMRc=MdCWHQZ+CgW05jYA1GGJdMUwKJEBAiAvRCvx=UqvjLiUg@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MdCWHQZ+CgW05jYA1GGJdMUwKJEBAiAvRCvx=UqvjLiUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: eWMAINQ5Xu_gXXlNWlMQAIpLe_4N7Euj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3MSBTYWx0ZWRfXxzM/AWhUIPsW
 DulLaZ7krQO5AM4bCVdufXVG88MrVF32sK+14hWZuDllryTYQV2ZMjuG7AexdSRPZQ5ijdbrnw+
 1Uvp6iYDb0jMelv286BXCuiIcjwwUVg=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aabdaa6 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=mLyWk11G7CGH-Ip0H1gA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: eWMAINQ5Xu_gXXlNWlMQAIpLe_4N7Euj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3MSBTYWx0ZWRfX9MOQbnaiIkLl
 5YwzB5fR6ZTktzpO0L5VkMzZWFL4kTiBitTq2wg744TA8KiGKrbcSGP/afOaZptMZB4ikgAole0
 15jWCSg9QDpo2KGhpb2urKmm47H8V/g0zkOQnWOsFmW/A1Eo7WftTmOh//bAgGhWji1ZYictxJe
 IEOe1UAAY+LDYZyywY8uF/2N9YeSYPcUm0X8M/QX2H2vdBoAzhj8brgCVr2IywmNmncQSwqIlZl
 othw5DfAqIPtUUQKWzGdCQaG8nQxcYteD8gG7vStkcBEn36AzgRGP1cBelKrjYjWJwkc49l7Q/2
 57Y4/HXh6g+ASCtA56EKDJ1eg/fQfuQam1LpKpI93OP0ifFnXLAaBhO2S1GITSghpvzlLnWRfg8
 9ewydTkG40ufxSkjoQ/e0b+EwbSREgFZYPmlt04ze72l9XkQXE3E3qcLNy0pbBteQAawWfbqNbi
 bCJFXZh1jZa/TAXZAQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170171



On 9/16/2026 2:59 PM, Bartosz Golaszewski wrote:
> On Mon, 14 Sep 2026 16:59:08 +0200, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
>> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
>> Currently, both the PSCI core driver and cpuidle-psci-domain bind
>> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
>> introduced, would also need to bind in the same way, leading to multiple
>> drivers attached to a single device node.
>>
>> Introduce a PSCI auxiliary-device provider that binds to "arm,psci-1.0"
>> and registers PSCI child devices on the auxiliary bus. As the first
>> user, register cpuidle-psci-domain as an auxiliary device.
>>
>> Update cpuidle-psci-domain to probe as an auxiliary driver and use
>> the PSCI device node for power-domain traversal.
>>
>> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
>> Suggested-by: Lee Jones <lee@kernel.org>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   MAINTAINERS                           |  1 +
>>   drivers/cpuidle/Kconfig.arm           |  1 +
>>   drivers/cpuidle/cpuidle-psci-domain.c | 31 +++++++++++++++-----------
>>   drivers/firmware/psci/Kconfig         | 14 ++++++++++++
>>   drivers/firmware/psci/Makefile        |  1 +
>>   drivers/firmware/psci/psci-devices.c  | 41 +++++++++++++++++++++++++++++++++++
>>   6 files changed, 76 insertions(+), 13 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 207a6e2db70c..9c0334ee2ed2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21932,6 +21932,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/arm/psci.yaml
>>   F:	drivers/firmware/psci/
>> +F:	drivers/firmware/psci/psci-devices.c
>>   F:	include/linux/psci.h
>>   F:	include/uapi/linux/psci.h
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index b88b01aa5829..f22e18b05053 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -36,6 +36,7 @@ config ARM_PSCI_CPUIDLE_DOMAIN
>>   	bool "PSCI CPU idle Domain"
>>   	depends on ARM_PSCI_CPUIDLE
>>   	depends on PM_GENERIC_DOMAINS_OF
>> +	depends on ARM_PSCI_DEVICES
>>   	select DT_IDLE_GENPD
>>   	default y
>>   	help
>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>> index b9e4ad7d43a3..0ce6a83f6588 100644
>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>> @@ -9,10 +9,11 @@
>>
>>   #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>>
>> +#include <linux/auxiliary_bus.h>
>>   #include <linux/cpu.h>
>>   #include <linux/device.h>
>>   #include <linux/kernel.h>
>> -#include <linux/platform_device.h>
>> +#include <linux/module.h>
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/psci.h>
>> @@ -122,14 +123,10 @@ static void psci_pd_remove(void)
>>   	}
>>   }
>>
>> -static const struct of_device_id psci_of_match[] = {
>> -	{ .compatible = "arm,psci-1.0" },
>> -	{}
>> -};
>> -
>> -static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>> +static int psci_cpuidle_domain_probe(struct auxiliary_device *auxdev,
>> +				     const struct auxiliary_device_id *id)
>>   {
>> -	struct device_node *np = pdev->dev.of_node;
>> +	struct device_node *np = auxdev->dev.of_node;
>>   	bool use_osi = psci_has_osi_support();
>>   	int ret = 0, pd_count = 0;
>>
>> @@ -177,16 +174,24 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>
>> -static struct platform_driver psci_cpuidle_domain_driver = {
>> -	.probe  = psci_cpuidle_domain_probe,
>> +static const struct auxiliary_device_id psci_cpuidle_domain_id_table[] = {
>> +	{ .name = "arm-psci.psci-cpuidle-domain" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(auxiliary, psci_cpuidle_domain_id_table);
>> +
>> +static struct auxiliary_driver psci_cpuidle_domain_driver = {
>> +	.probe = psci_cpuidle_domain_probe,
>>   	.driver = {
>> -		.name = "psci-cpuidle-domain",
>> -		.of_match_table = psci_of_match,
>> +		.suppress_bind_attrs = true,
>>   	},
>> +	.id_table = psci_cpuidle_domain_id_table,
>>   };
>>
>>   static int __init psci_idle_init_domains(void)
>>   {
>> -	return platform_driver_register(&psci_cpuidle_domain_driver);
>> +	return __auxiliary_driver_register(&psci_cpuidle_domain_driver,
>> +					   THIS_MODULE,
>> +					   "psci-cpuidle-domain");
>>   }
>>   core_initcall(psci_idle_init_domains);
>> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
>> index 97944168b5e6..68e381f1a618 100644
>> --- a/drivers/firmware/psci/Kconfig
>> +++ b/drivers/firmware/psci/Kconfig
>> @@ -2,6 +2,20 @@
>>   config ARM_PSCI_FW
>>   	bool
>>
>> +config ARM_PSCI_DEVICES
>> +	bool "PSCI auxiliary device support"
>> +	depends on ARM_PSCI_FW
>> +	depends on OF
>> +	select AUXILIARY_BUS
>> +	default y
>> +	help
>> +	  Say Y here to enable auxiliary device support for PSCI.
>> +
>> +	  This creates auxiliary devices for PSCI functionality implemented
>> +	  outside the core PSCI firmware driver. These devices allow PSCI
>> +	  child drivers to bind through the auxiliary bus while sharing the
>> +	  PSCI firmware device as their parent.
>> +
>>   config ARM_PSCI_CHECKER
>>   	bool "ARM PSCI checker"
>>   	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
>> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
>> index 1956b882470f..8e75a0ed6f74 100644
>> --- a/drivers/firmware/psci/Makefile
>> +++ b/drivers/firmware/psci/Makefile
>> @@ -1,4 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   #
>>   obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
>> +obj-$(CONFIG_ARM_PSCI_DEVICES)	+= psci-devices.o
>>   obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
>> diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci/psci-devices.c
>> new file mode 100644
>> index 000000000000..f1eca61e3269
>> --- /dev/null
>> +++ b/drivers/firmware/psci/psci-devices.c
>> @@ -0,0 +1,41 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +#include <linux/auxiliary_bus.h>
>> +#include <linux/init.h>
> 
> I think you need module.h not init.h.

Ack.


> 
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +
>> +static int arm_psci_probe(struct platform_device *pdev)
>> +{
>> +	struct auxiliary_device *auxdev;
>> +
>> +	auxdev = __devm_auxiliary_device_create(&pdev->dev, "arm-psci",
>> +						"psci-cpuidle-domain", NULL, 0);
>> +	if (!auxdev)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
> 
> I would prefer you to move the code between the patches a bit. This patch
> should already be introducing the full, future-proof infrastructure for
> registering multiple auxiliary devices, so maybe add a static table with device
> info? Then in patch 10/10 you'd just extend it for reboot modes.

Ack. will update it.

> 
> I'd also not add any ifdef guards here and lesses the build-time dependencies.
> You can register the device alright, it just won't get probed if the reboot-mode
> support is not there.

Ack.

thanks,
Shivendra
