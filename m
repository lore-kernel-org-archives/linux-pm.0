Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074644A724
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122152; cv=none; b=BrX108UzoIO3LntA1SZoQgEAScYrePzcZPYTM2ltEA36GD7nHvALNBSA4mLMA3ElTW3Bgd4lJ7uKaQfPTWKRMQC7AwG2d9zO+cIZ6n+qa09rQKeZY/T8gHnRbG3oJIenn57A5EQrnq15fYPZqRM9g6iC6BUyZRk6tDWhShPVsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122152; c=relaxed/simple;
	bh=GzOOsRGt7BjS1JAsyiCzz9u/awbv5loIcnCVceWzTEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcw8w+AdO4ZWCX3HD91iykcNOxJMHe+zStdWmpMVn53767vXQV6fSy1ebrzV2kegy387EG8NTfC7fLfexPL8NymX1d9AT0HMjtIniF45iWfIgDPpZiXs0NSZPmUgYlIHaTH//mGVWIBAU2YdMeeFDQwsWRAn9QbOxCO0HMxYxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UQRuEAmP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=btX8UjL5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UQRuEAmP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="btX8UjL5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBce5Z3338719
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iVHBlxWJeXGJFrYO2asjzSD1IwEuFXzGOnyE3qzwe0Y=; b=UQRuEAmPLakw2Yq9
	WGKbJjpnzHeqkGM10aWtkSr7o25OTdPiJpRneCl6UpY+nAcZerSWlQZGSS8rk5+Q
	91dRhgRrJmyqT55CT/N56GZU9xgIOBaIcpXc4Aufaxrov86WKCrAg96fGbCb7Kg6
	Wgztym83nrAsPKy9BghxCVK2FYa0uOdaTvqbt+TvdfDajvV7pqoyfJqulCNRU9GY
	yhOpSEp7H0ebSjuq407tJyLWIY6YIFnBSaRoNlQHksldgLi08TvT9awzITfbJpCZ
	uShW6sREE5OtxIkUMRKlsCCArUHjWHKZizaGuprYc8dvy0W8lQBbgh62L3zwVjqP
	eM0OyA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mkw6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 13:29:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so8545273a12.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784122148; x=1784726948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iVHBlxWJeXGJFrYO2asjzSD1IwEuFXzGOnyE3qzwe0Y=;
        b=btX8UjL5KBGVPjnf6WU+RCyUnKwB27Om9nkb5H2V9ARXJFq6B5mXK/14Qxvixenknr
         eWQEGbsOtw8prtLK9d1YjzRh259QlMJAwQiwh++m6xXQ5lmTEWibcnL9eo4LQ+dQveD2
         woA7ocPD4Be1eqlah/v2/l7qQAUXsEVwQT8+RBFJQi4Kuq1sp7nTV42vsavkml3v+vfu
         SBTV74za7jHXua1ep8xCy7wCLcU+YryVjuS/F2HKSe+QjH3vWoPXaRLNedYzghqM5UpU
         qYLtKcIVbGzfadSPYg83xS3tD4EOqMGBqa5YPYCC1iAMiraKaEGEyCp+JzQvPzmnv2l0
         vnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122148; x=1784726948;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iVHBlxWJeXGJFrYO2asjzSD1IwEuFXzGOnyE3qzwe0Y=;
        b=OWy1fWT5nA+VNcdcvzhAAq5cUMQd4eSp4G6TDa3I88Gi0RphEFPwJ0wev0QFL1c1KA
         0nKJm17XRYuncTHFGOQuBFIRiqFXqRbGBHnDCWjqUbztx2IQGM70yKycO1nxPgtlbsKz
         IC3UXBOQcaggHzPioiMAavnMGYJdpaiEq79k3ohTmwHmtsCtx/E6CHOrQwq+eZrK7fnT
         SNoYrO2A+8uOt2YZ516kyC/9iP9wmfTTKDrnP6lccNboGCnKtxviVPyeRl9esZh50973
         7NGEWvt91dfOQGF2JUwCWKQ0/acKtxHDUX1D7OW2fZs3qze2iQemyTI5I8z4eGcVvM+/
         I2Fw==
X-Gm-Message-State: AOJu0YxvP1+X50q/PLO8LlVETQPzePMmh18SeKaHMlxZjx4KUAEmgpIb
	MaRz5sjl3S2KBcF12vrQN3rTVT00Hi+UdBM9ePoTnA3cOFjsthIdBRMIqaHXfxU86G+0ZlucyZo
	2YqVqZh4RG+6bCzROQCoYQYJuvmbbjjRSxg2yB82jY+KnBo1QFK9YUawjKrVv0A==
X-Gm-Gg: AfdE7cnf2gAgmgc/CUO1wPvACTzzHCgW6VAFfN8L3X2oqj0oV5nTGJ+oB78AU+4wqCN
	PiTPObX+aNdSfjYoicbubgLvxS4yOXnOlk+FniU2X2tZd8POGSO7eX5isxafpmbi9lFHqODO1ug
	2dpfiXMGY6IP6Xpzbkt71U5iHPMzrgEqjY8CXwA3TnCTVc2u67uFiTKmPN01RlFgCwYJZhSIimx
	DP0uLjQ3958huZcQW1p+hp5JOnaXddJE216zXuLjMvtBp+1CvDvGa2mO0SgbfJraCMQvK7zH8Xz
	GE+FH5EdwA6N7uR3HO8qXekkM6BKoKGvOxuUO+bNKbsGWrPFU2xMW1QELZo0A11dNEOSSgeTmH+
	seUEw/RwPEC9TwKZt/ZnBsd4eDcUyS/qDHuMGYLlNdnUR4A==
X-Received: by 2002:a05:6a20:3944:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3c36c131f83mr2942623637.16.1784122148001;
        Wed, 15 Jul 2026 06:29:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:3944:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3c36c131f83mr2942595637.16.1784122147562;
        Wed, 15 Jul 2026 06:29:07 -0700 (PDT)
Received: from [10.219.57.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4365b0dsm2735217c88.15.2026.07.15.06.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:29:07 -0700 (PDT)
Message-ID: <4c52d360-caaa-4c77-b1b3-d6b7e78f7fc7@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 18:58:54 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 09/13] mfd: psci-mfd: Add psci-reboot-mode child cell
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Florian Fainelli
 <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger
 <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-9-e7453c548c21@oss.qualcomm.com>
 <CAMRc=MezSb1hohMsNPR96-hnTr0fjrqZ2ZDKUhwnOWycW3Muzw@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=MezSb1hohMsNPR96-hnTr0fjrqZ2ZDKUhwnOWycW3Muzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNCBTYWx0ZWRfX3JJti7Ozii5v
 9ZNFbwblYyzNsARd3Ucll27w07gaXuBgKtACPjrkfgWktwJS2tsVFC/3l4DFDoDn3oWwLC5IMyE
 1VrY1mB13AtmK/Mr1YXp/7LPXDSWnGB6z95w4mkFpxhoGzMRbKLmfxOcobdLjbYG04d1jfuYppt
 X/ddY1SmlQgN1ZDLn+2Gfpnys/bDWLlTBIQFvKiASj3K5A1o4GdjqEi4k25IL6og2rBF+/bcDqh
 RBBUBBywsfhviyobRoQm3eNsGFFxXbSZmYE9Up0xtsyckoBt6UGjDNoWBHQRjLcn29DrCeIPvjD
 yvpJwZ/UmKFHZItk/gdo0GLfMNMOCLccP4YocQaWZsdBvO2uhpIH0/aqtACgfXvCsV4mJ5VXU1q
 zGXN/rH6TLvxkFCvnkK3/Hu9VwFSf/OFVyejeW9lyzZBe8rWa6Mlhl617HB4gj9tRqWnTfLN+JL
 cY/0PsbfF7ZxGgcLWcg==
X-Proofpoint-ORIG-GUID: 7CY8z8z0bUlSQyOHcP6FYOmPGuWWu9FN
X-Proofpoint-GUID: 7CY8z8z0bUlSQyOHcP6FYOmPGuWWu9FN
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a578b24 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Tp_YqcUnzpVuw28kZAUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNCBTYWx0ZWRfX7taIx2KMSqAJ
 avODm2lnZG6knczAIYnbwvZ2N7DYAsn3F42nfmqSKAexmSoDDGrXWh+h76yXYwoTX6M21TaXTKc
 WwMDEXCIxtof0WJT2/Qjygs8VxHUr20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150134



On 15-07-2026 18:44, Bartosz Golaszewski wrote:
> On Tue, 14 Jul 2026 19:16:37 +0200, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
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
>>   drivers/mfd/psci-mfd.c      | 30 +++++++++++++++++++++++++++++-
>>   drivers/power/reset/Kconfig |  2 +-
>>   2 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/psci-mfd.c b/drivers/mfd/psci-mfd.c
>> index 7affd6bb09dd..8c6b78ac471b 100644
>> --- a/drivers/mfd/psci-mfd.c
>> +++ b/drivers/mfd/psci-mfd.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/property.h>
>>
>>   static const struct mfd_cell psci_cells[] = {
>>   	{
>> @@ -14,10 +15,37 @@ static const struct mfd_cell psci_cells[] = {
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
>> +	struct fwnode_handle *fwnode;
>> +	int ret;
>> +
>> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, psci_cells,
>>   				   ARRAY_SIZE(psci_cells), NULL, 0, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	fwnode = device_get_named_child_node(&pdev->dev, "reboot-mode");
>> +	if (!fwnode)
>> +		return 0;
>> +
>> +	fwnode_handle_put(fwnode);
>> +
>> +	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>> +				   psci_reboot_mode_cell,
>> +				   ARRAY_SIZE(psci_reboot_mode_cell),
>> +				   NULL, 0, NULL);
>> +	if (ret)
>> +		dev_warn(&pdev->dev, "reboot-mode child cell failed to add: %d\n", ret);
> 
> Why do we have to look up the named node here anyway? Shouldn't MFD core handle
> that already in a generic way?

yes. MFD is handling this. Will remove this explicit check.

thanks,
Shivendra
