Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDC423780
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533118; cv=none; b=tii54fcUDh9O44/zqZ1C/ySdNHktkbKzctqUwa2OkXFcCRprXe98h744ZWz1c5sNfB8Kx+LOAlKri6CRZBrHDC3BlDJcaeq1MQSS8h2U5gOkw+UEdzIxkRB7yMufwg040E0kSnHKV5JoKj7nCKekurVyC+TjK/k4Ffq2WUdipGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533118; c=relaxed/simple;
	bh=PcrQpNv0debNulNrw+/l0fJqHqprwb5hEkIU/oGjK3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPB31PMEfpH0m1x70N5Voe7yI/QZ2PE5k3sPdjvFgw2+DP8KyYJVeZpX9e4pwt4fFU/qmABprWR9fyT0OAL0Z5nEbretp40YgcklEHhyHFGcUXMo1UVbTneYDFrSiJdoWzbtHHB0ld+hNzwXGZ/yGfChS4rWyZv1FWKdOxgL80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UDIf2T/Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WRQNKj7u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UDIf2T/Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRQNKj7u"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB4CkU3664611
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ndb2tC+bNrjCtaEv2GcOaQRxLg67meiAfqQFQgJb9M=; b=UDIf2T/YdF5UCB9r
	oZ2MjTxUAxBMd6zxDRE3PpC/hkOqQLqXGPCZ9yw4UBXsmIES8WaFccZs4nLf1F24
	ZjwQ0iSmI1ZNMeeChWCVTqdKl37k1e3d8uWE85nRuU2v0nkCFtWOAG7rZ0YzImn2
	2SCp3x3KRCAEMFN8AFMfOUOB8wYdp89yv2wPDaCWM3UQfa6zU+DXvnJYS4W0DJfg
	AXcBnlnuHc26FJZ+Z6g06TC31QLV/dJtRVEnaAV19BaEqN3wz2qbWWmWy3kWK4ex
	QaFDDRhpwSFQ+x3c0Y7HqRQ7WVC6ok44R4X7x8ITy74+vGavO7jkvZaLQhFs7Qnx
	qfn3Jg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rgwcj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 11:11:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfe48ca1efso12063465ad.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786533116; x=1787137916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ndb2tC+bNrjCtaEv2GcOaQRxLg67meiAfqQFQgJb9M=;
        b=WRQNKj7uE2l9xN43lopSZuiGfm5rF0H1wxpDIQOBIIXSh0TFG+4l/OILBMDysoLKBi
         rzt/VrUI2WP2+rb9lSZh3B65XEMHq9hXGrEzhKgBSk1b5OraHWHvoCl6QSdDnN06Qc7A
         vXTcm8Rp707wAZHpQYAxySH4YXnq6zCHjdg2Pt2yYn/3i9lOEJcJZda1PQ04slRiG8Fz
         1tZV98MdsXfe9u4DmHLMmOlZqlTf6GSUpeHy6d2jarOmeZUU9em3woShojA6AUFJfzO3
         yX9yJ0db6tnTmOgLmh9wsWwDiXEerpuXvU8w1ztKeAJS095XZVMiHSfuQ4JXbX0mfVhH
         1zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533116; x=1787137916;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9ndb2tC+bNrjCtaEv2GcOaQRxLg67meiAfqQFQgJb9M=;
        b=e6cAc0DMI82wDBINKA28ECWauVa5pL2HJ6BfegObf8oHJihs0xQOiXFTzZ8HlGeSqb
         kFLtJm3o8NcNF/dOliSnx2QSh8m7SFdP74Cx8aWEbUH/7mhhK8rpG0unOxV8xN61AN0n
         qHmF/JPv6ipPc/vQIRvTwBuWpGdFM8sQrS41IvDzQ9KwCpXEpxCPJ5q2qsrch6gtCPTd
         o4WjmUUW3FoSJFLwp/KiEwKgskHo6bBlpguSygpZouXK3EP2Qbfa8Wg+CP3I/lIegtEF
         OvjS3fZahNwzrIwaI1+RBqSnKaLbXwafp2rwa6mn36VJoZj40Lfu2GDaSN4cLwTx7Mod
         vxDA==
X-Forwarded-Encrypted: i=1; AHgh+RpbV5WDEvox6pbVIMUzJeAuVaPh/PRZIAA0+Sg6FgwcLWsKvRHU4m4wGzwfWHeTWLMTVfVOkcI20A==@vger.kernel.org
X-Gm-Message-State: AOJu0YygPXJKRaagaXDz58FDGtDtUWSlFvtJioXTH1kJxtA42dUEJsRc
	z+7IFOW+ekBKn0Zi45oV5n+ZxuueQWdEx7lUN5YlIavdgT5JEPs4tJUBabMkPWwXGFLEJpZfg6O
	7fAi6WGWpnZPHipvtaNJdc+yYdbTcSfvJl1aw8aYgxIA1UIPdk0K4uF6qndBauA==
X-Gm-Gg: AR+sD12Je9OuAVm+76fHBtYkgj/bcXp0vg9cGYghcOFJvnu8yEM1Rae4Qx73UbBP/L+
	7YK4pylEsEbh+TfIclqDVDYdpUtFW7H9I4vHtyU9C6Ho314sjUMdqidEbBWuP3abPfPp8yy/jSL
	Oymixrak4hg79TK9muBKtnY0Su2cQl8lvRmNg0reGLtowA6laGnJZHhlnMqPX2mcn1p+RvAKmU9
	BK6BvKGCHawoWWlIaz0p8tdF+ce8wori4IimhZnc5QdPCPnn4UbuemVII/Myp9BIdiyyXTC1XGH
	X8VnOLb1kHFKZX+IGs71XNkeRBjSIUhAnHXcXz9p/GX2i12iAH+IuuGy9ZbYZCXi+wiUkfk7Rzh
	dbcGigTnq1M8D34YgECjdxRQvLBZZ7ZBnJw==
X-Received: by 2002:a17:902:fc8f:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2d3456f5f5cmr56902325ad.23.1786533115653;
        Wed, 12 Aug 2026 04:11:55 -0700 (PDT)
X-Received: by 2002:a17:902:fc8f:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2d3456f5f5cmr56901585ad.23.1786533115222;
        Wed, 12 Aug 2026 04:11:55 -0700 (PDT)
Received: from [10.218.44.82] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350be1504sm4886065ad.0.2026.08.12.04.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 04:11:54 -0700 (PDT)
Message-ID: <b7b68db4-a3cc-40a4-8748-527abe08934f@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 16:41:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 08/12] mfd: psci-mfd: Add psci-reboot-mode child cell
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
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
        Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla
 <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-8-889281373870@oss.qualcomm.com>
 <20260812081856.GF1072730@google.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <20260812081856.GF1072730@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5MCBTYWx0ZWRfX+H5nFOWDvlaA
 TQK8QZ/BBSjJf0hap9McuMQnZ8POPP1MT3JQWXEEgBWHXWompRRZDRrFJpDUzGVC3c2CLbIr5IT
 f0n4zJukZrtIPsg7Lm23DodGWRtHud/jQBQZqiuw2HyFznudMU+MTtNgV5ZZJkiUOG/nlhLWUlC
 NPQM3NUOl3irynfQNNUv6xe4YavuonOhy/b89AVqAXc0WRk0VEZG//9AC1cpRkDZ9loZZbXaWfP
 oNLX6t/b2S/30jcoOeah5CwlHyrwrhvnuhAAfwGB1dvA6sm//Zqq2tVZGohnDpg4ao1mCk1espY
 CbmioUrT7hYGWFo9IeOe4thPwwjS1/H2MHbyVGATwW8rS1OBbbD1xH+w+0W4FjnGqAuPoNF7IJx
 TVxY9mTkeuiOh2MwmYUU66nAEOD/YXTlQ+DbNMucOuWbOlc5h3m+DAr7ruq+jayDxMWO02oA5DG
 zGyyneo5N7NiLfZTavA==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c54fc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tp_YqcUnzpVuw28kZAUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: AeWr_KGlamxFxC9v65OUaTx79fJbghmM
X-Proofpoint-ORIG-GUID: AeWr_KGlamxFxC9v65OUaTx79fJbghmM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5MCBTYWx0ZWRfX7db4oK8Z29R0
 R1P+VpPjWeuVFfqjXxZWQfdjUrvrQOV4L4F38khykuUsbD0w1CfqixokcAcoo4QLIQW1aaxXyj+
 GnBT9+D/5gdSPjDNLSoqefOQ5O58/tc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120090



On 8/12/2026 1:48 PM, Lee Jones wrote:
> On Mon, 03 Aug 2026, Shivendra Pratap wrote:
> 
>> The PSCI "reboot-mode" node does not define a compatible because it is a
>> configuration of boot-states provided by the underlying firmware. With
>> the new firmware-node based cells in mfd-core, this node can now be
>> exposed as a proper child cell.
>>
>> Add the psci-reboot-mode child cell to the psci-mfd driver with a
>> named_fwnode. Add psci-cpuidle-domain cell first to isolate it from
>> reboot-mode failures.
>>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/mfd/psci-mfd.c      | 27 ++++++++++++++++++++++++++-
>>   drivers/power/reset/Kconfig |  2 +-
>>   2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
>> index 7affd6bb09dd..7befc4fa86f5 100644
>> --- a/drivers/mfd/psci-mfd.c
>> +++ b/drivers/mfd/psci-mfd.c
>> @@ -14,10 +14,35 @@ static const struct mfd_cell psci_cells[] = {
>>   	},
>>   };
>>   
>> +static const struct mfd_cell psci_reboot_mode_cell[] = {
>> +	{
>> +		.name = "psci-reboot-mode",
>> +		.named_fwnode = "reboot-mode",
>> +	},
>> +};
>> +
>>   static int psci_mfd_probe(struct platform_device *pdev)
>>   {
>> -	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
>> +	int ret;
>> +
>> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
>>   				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>> +				   psci_reboot_mode_cell,
>> +				   ARRAY_SIZE(psci_reboot_mode_cell),
>> +				   NULL, 0, NULL);
>> +	if (ret) {
>> +		if (ret == -ENOMEM)
>> +			goto out;
>> +		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);
> 
> Okay Yoda, but why is this okay?
> 
> Needs a comment.

sure. Will add a comment in code.

psci-mfd adds two child cells, psci-cpuidle-domain and psci-reboot-mode.
psci-cpuidle-domain is boot-critical on supported systems.
psci-reboot-mode is added separately as an optional child. For 
non-critical failures from psci_reboot_mode_cell, we want to continue 
the probe of psci-mfd.

thanks,
Shivendra
