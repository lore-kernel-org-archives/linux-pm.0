Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FD481FC3
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122509; cv=none; b=plYtaBcQcl+aOM1/QtObyAEewEYoKo22iJZ9LUD6+ft5lbuZY+ledQ19Et0aOCb0oaO9+Z4tIsbwnyWwOiVIcEUivfYsbcUYkTZf1e9CioAcxlqKwMsVK2pIIso+UVMdQ2aKVCoQ/V3Oaxnl/iDE+5EEji6xpoyOv3xNbAyRGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122509; c=relaxed/simple;
	bh=0wyFjk6+HsLkh0IWAAfHqhQH/saWyrsDjN+FLese9gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=miacnJ3S0trkmhKdZe8pk+Vuj8xkwoZYL4YvMwHDFo3p7TQcU0pggxngD9Djw/c2PwixYiiRbDGj85OqEj2Nls3BrvH0i781G4WUJzEJ0awdV3/hdTMMY38WPQbj6E97KC1SRAfYs4OyL2aCfp+B/FQu7+6ui7kvD9gLyvng7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXq4Gun5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kEqyKRU8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXq4Gun5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kEqyKRU8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IEnNn32975550
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 16:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5wrVlxV2ZYKRyaZUFJ64W1+7jk91kePK3xZ/2YeTQmo=; b=nXq4Gun5XcmOC5dK
	Mh4iQTzfSmdrY+wgULxisEUfKzQfDG7UDajUXs/gdYGfua2IDz00AY9tjkcE65/R
	junGhwRNh1RMCGjrImutOIPiDR58esbE44e2C6N8Slb2V5Kl+pw8iyvQhKQ3I1dg
	sAnvIHm4/N07gJzusBIBJjAEtoWaIDizjft2u49QjI+ADKs0ixM4Ct9Eo108ESjK
	UOY0dfLUBWfKjy7kjFZzYmmpd3Ju61ZFY/aAXoTihVLq2j4GNEC81tEfnsYD7D7z
	e5LawrUW6fWSCWZnD+x3gjbdQjiOzx961j36m89GJdFoM4gLF/SR5swWhq+DQqUY
	frFksg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48e33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 16:41:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-367fd7b8825so2480761a91.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779122506; x=1779727306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wrVlxV2ZYKRyaZUFJ64W1+7jk91kePK3xZ/2YeTQmo=;
        b=kEqyKRU81OIYfYjPS98wAMvZYVTSbmswNpRAQeFsLnRgkXhrM9YFMUsfI6DnlyAZgK
         gGkiJpIF7h9E9hEWgtfNTFDR/XRZmIvPm35oMA+840SNaJ4NktKZe4tgOxCVZVN+uunc
         PecX3rWo9jNXup8xMZilrQbiZCV8SUEAmCcr/vtSmKWMJNSrePzJLc+kkQrECo4TFg5i
         lQph1iAu6YU/jZCMg2QZfnYM5LKOJMNRGBjI6XceVyjLKm/EpeIteU8cRgjJ+w4Y0ZaK
         xQRPDyLumSTjHY3PURTfU1muZ7Xbh+812OxFx+XIZT+jSxDtedyA1WXYYxYnoEs3OJjH
         75LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122506; x=1779727306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wrVlxV2ZYKRyaZUFJ64W1+7jk91kePK3xZ/2YeTQmo=;
        b=RTe7uL1dEeCTn43lEzrlL8ubmkzrorkZiZG+1et/dQJJx5Xhwfx+Eo7Mbz7AQXDKad
         8bqGOY9qH0x9VNXwXb040zcf4zKI62xE7T0tYTeAfs1BE/GMwhowU/K2h15ux3QURt0k
         zKHFbBxAI+4nW2I0ZK8x05I5dbTLbML5EF3FKeeWC8wiAXjPW6btILbgPpzbJmLj3fHs
         hDcTB0qZupx8mL1PcIWHXnXCC0Ncm7xh+qQsC2F0FQn0F+iFtc250fYZ2xBNuB/j+T0q
         Sgle6ULlrjCZj/uRR9MkTMZoMd0aF3L5xl3tTNL5TnnlKvrjMZf1z+UMeXWSrmaOBUgH
         Jtmw==
X-Gm-Message-State: AOJu0YwOyl1cb0vmjMjN1WZa99QChejtEVT1LdUCUwuPLiBQ8E6x7HqC
	aSiTQKF2tX/xLGgQ/1yvPvuNlswQidoP2uOsEfIPEzeRyhzsRwMoR825NSSfU42ODPmCd1HPUhL
	HMeSuBpymWsJ/mF0r/YpGlraYu4Iz/qw9kAgadcVtRJmTUPpYCaYdXPS4ldSzcQ==
X-Gm-Gg: Acq92OH3RTN/YRn4wMWu6e8W4v3ypqnof3cv0CSjRSjOTghHY5lFQm/WU7RVEBQ6Mjk
	yyqgIgNqklkd/hqn8wl9fSo7cwWR7jA3cNm1GKcW5pT3FG4plpTX3aAA0CdYTZ+LhL/F4UrJR0N
	QjlvHiYb4L1pdQGx7Wv2j6XMrCqPFVP5daBQ6RVQL+Y7c++ZxSipzQAGS5rFJsYS7QUiJUxBVgH
	a6muFGPhlEUJWL5iAM2RWI7kiX0/TPSFVozQqJgGopp6z/0ensehtUYRr3yOMJp5mVvIY5OFpRW
	SHpMhjZG+5S5sabkmYhjLentNFphDDSWFUdVMok/t7oDkpZg9V/gsSCZX6OkkW4r00ENFgLPfMZ
	rp06LvXKxjTQyz27jo6vKa64KC6JOgGrz89ddW5VvN72FsBBAX68/Lr43
X-Received: by 2002:a17:90b:1c82:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-36951c9fad8mr15054664a91.20.1779122505862;
        Mon, 18 May 2026 09:41:45 -0700 (PDT)
X-Received: by 2002:a17:90b:1c82:b0:35f:b7f5:9cd with SMTP id 98e67ed59e1d1-36951c9fad8mr15054630a91.20.1779122505327;
        Mon, 18 May 2026 09:41:45 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.226.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36959f52fe4sm5744383a91.5.2026.05.18.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:41:44 -0700 (PDT)
Message-ID: <f604833d-b333-4514-91fa-3cf95f99f9e7@oss.qualcomm.com>
Date: Mon, 18 May 2026 22:11:33 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/13] mfd: core: Add firmware-node support to MFD
 cells
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
        Srinivas Kandagatla <srini@kernel.org>,
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
References: <20260514-arm-psci-system_reset2-vendor-reboots-v22-0-28a5bde07483@oss.qualcomm.com>
 <20260514-arm-psci-system_reset2-vendor-reboots-v22-8-28a5bde07483@oss.qualcomm.com>
 <CAMRc=Mde7Y3CQ3yi=U+999JyHTNacebiK8jJhHuYBGaqn59yYg@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mde7Y3CQ3yi=U+999JyHTNacebiK8jJhHuYBGaqn59yYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b414a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=y87zbT2qfcRNAzJ9VcpEUA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=GJNFty8P_8wqzycR5nsA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: DjufivUeyOogBc2aELTaZss867M7XLRc
X-Proofpoint-GUID: DjufivUeyOogBc2aELTaZss867M7XLRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NCBTYWx0ZWRfX6BJDZpKY5xqQ
 k1KYSnl1H7yMnrEnVh0n5WLuX8A5fOyqKCt/jHyndtwJQOCE5AFcqCDsNy5MJYxR6ou34IY00Pz
 f0lA5LHadzDJZCxeSGe7gZ+jLJyKnLhAEdcJLSGo1pTv+VOCeSklQgts243kRAOERMKpqZceOyc
 R7KM8MxDE/ZhUkd9rfGMNudRsnHWNHFRffRmcHmpOvl87n9tBWymW2KOIlPYU6ho9/54bttpRj/
 BgsWiNIhaj0tobuGR6UvghIOLklpimEPIWm7WB0thv0oZvp9fKhqbSVqfF06J5ZVrvNKT/sl+rt
 M/Fa+a/BakCf9KkK2fTHbPRK7SHuKWIF/TdFjE4cRYsvk9umg+d9bsNeceXGIsWXSwzkfX/x9AF
 vHLfALoHrvjv94Aa9YpXF10Oeneit4KCmRF9DeeI2uvZtMacME4g+qSQs3cDe1QOmCFMz6IXuWq
 Y7veqPsqOxa1KSH4M8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180164



On 18-05-2026 14:27, Bartosz Golaszewski wrote:
> On Thu, 14 May 2026 16:25:49 +0200, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> said:
>> MFD core has no way to register a child device using an explicit firmware
>> node. This prevents drivers from registering child nodes when those nodes
>> do not define a compatible string. One such example is the PSCI
>> "reboot-mode" node, which omits a compatible string as it describes
>> boot-states provided by the underlying firmware.
>>
>> Extend struct mfd_cell with a callback that allows drivers to provide an
>> explicit firmware node. The node is added to the MFD child device during
>> registration when none is assigned by device tree, ACPI, or software
>> matching.
>>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>   drivers/mfd/mfd-core.c   | 30 ++++++++++++++++++++++++++++++
>>   include/linux/mfd/core.h | 14 ++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
>> index 7aa32b90cf1eb7fa0a05bf3dc506e60a262c9850..cc2a2a924d6d3044e29a9f864b536ee325ed797b 100644
>> --- a/drivers/mfd/mfd-core.c
>> +++ b/drivers/mfd/mfd-core.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/acpi.h>
>> +#include <linux/fwnode.h>
>>   #include <linux/list.h>
>>   #include <linux/property.h>
>>   #include <linux/mfd/core.h>
>> @@ -148,6 +149,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
>>   	return 0;
>>   }
>>
>> +static void mfd_child_fwnode_put(void *data)
>> +{
>> +	fwnode_handle_put(data);
>> +}
> 
> Ah, this seems to answer my previous question, but...
> 
>> +
>>   static int mfd_add_device(struct device *parent, int id,
>>   			  const struct mfd_cell *cell,
>>   			  struct resource *mem_base,
>> @@ -156,6 +162,7 @@ static int mfd_add_device(struct device *parent, int id,
>>   	struct resource *res;
>>   	struct platform_device *pdev;
>>   	struct mfd_of_node_entry *of_entry, *tmp;
>> +	struct fwnode_handle *fwnode;
>>   	bool disabled = false;
>>   	int ret = -ENOMEM;
>>   	int platform_id;
>> @@ -224,6 +231,29 @@ static int mfd_add_device(struct device *parent, int id,
>>
>>   	mfd_acpi_add_device(cell, pdev);
>>
>> +	if (!pdev->dev.fwnode && cell->get_child_fwnode) {
>> +		fwnode = cell->get_child_fwnode(parent);
>> +		if (fwnode) {
>> +			device_set_node(&pdev->dev, fwnode);
>> +
>> +			/*
>> +			 * platform_device_release() drops only of_node refs.
> 
> Which is a separate problem we're discussing elsewhere. It should probably drop
> the fwnode reference it holds, not the one of of_node.
> 
>> +			 * Track non-OF fwnodes explicitly so they are put on
>> +			 * all teardown paths.
>> +			 */
>> +			if (!to_of_node(fwnode)) {
>> +				ret = devm_add_action(&pdev->dev,
>> +						      mfd_child_fwnode_put,
>> +						      fwnode);
> 
> What if the device never gets bound to the driver? The release will never be
> called, this is why it's wrong to schedule devres actions for unbound devices
> and one of the reasons for patch 1 in this series.
> 
> What I suggest for now is: in tear-down path: see if the cell has the
> get_child_fwnode() callback and - if so - drop the reference. Add a big, fat
> comment saying that this must be removed if we decide to switch to dropping the
> device's fwnode reference in platform driver core which may happen soon.

Ack. sure. lets me work it out.

thanks,
Shivendra
