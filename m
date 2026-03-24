Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993523F7870
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353905; cv=none; b=dvA2nPD+xqilwwEDgHIVE7Lo8qLRDfkWduyBC39rA7Wt8b6RUtgc07N69RWYE1/vy/PHyBBavpny1cV2021agEhBcCeFjwgxPmRDUlG+R5bZi56AasZTRaTsiF//4WFY3uiqElA/SSsVQr5FkCZND9MvanLnTxuOSvczTCCV7s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353905; c=relaxed/simple;
	bh=INmeiGJKMXk+0PJEej2mrgVEmYRHxRGrlBMc5p0a5aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8zjpJiPzz+Tl9TkXO/POpgGuXeCKG+o2sRGZSxBz8PctYzMpc/ZsEgle7UWjTQwMAMc+X6bBu67nQFm2HZ7CGeBumU2O8NatAn2VHr1gZWAiggJVPYBlNIRo8UOtKZmi+72aQ1HgF7doCC+ooGEnK/MTnAXxn3DUWG0BRVF1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eiiwG5ed; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbRi+ybS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eiiwG5ed";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbRi+ybS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O9mmOJ890470
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=; b=eiiwG5edacFrpRTZ
	EtFrpYBAz2dzEh8QgxuzMve34/TbRlhIqFNx0EIQC9p4hZ2Sc1R0WIg2sTP6BzrM
	ZMpxlfMwVzsguvbqR5NsG0MiTxuaUDz7gQK9z/PxTLu1TEuNtp0aZM+jWN5B0FTG
	cAEb6aMA1eo/Z0VWzsnyIojgSv0Q7zlmm7vQ+g3Jors7pW4zXq4WIA+Gen1trqxO
	8FKevj/nVzz62rhyId8j2AORT2bDOzfq1W9g4Gu+AsQMotjMluRzjhztxSKw7emf
	qjozK5HoD7x8HTa7uMYLbYLYuYjcsGG4hg2oWm9+adG+aTQzddUtS3YHqtw1B3gb
	YkEiWw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3k1x9qy9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:05:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b091c3f891so29674025ad.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774353832; x=1774958632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=;
        b=WbRi+ybSq4e9zxeIDKMB3zYpcvgUUZIDXnZf7g73kTxLpOos5gPMNHtFs8UOfh6Tod
         sJXw+70MV4V4CiKrPAeMebBf5hDrh4ZHj0mCt2ndeBdCwxTg06Z7dQBmTDqKVprUtU5D
         rz1xNVDdL8Nv3fJwxoSHudHmmUbM3dBlaVhvI0/lyMygDCfcJL32pDOvY9b27HWATsbr
         xmSQYf1/mGl9mWEG7pHObsRYc31JMTnTmOGYj8ZsS9F4N+hFZa61vJ1dUJfpzUFDxkqC
         65U56QXJF2weVzss9W8nWdYl1WoFBxiy6WNY18D43gxgHne7TxYr2s1J8yCdAFLausxw
         qxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353832; x=1774958632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5IUEO5PyBIerJfWjfzoqFirzXsSOD9hNzXQV1mXr0E=;
        b=EMO6mCYz3aNOHTVVZ0oyUFJwFqfMy9Ms5FVYiMZF7nn4/2d7OLTl0wgjmga71KIUR8
         mhHpC+pEDIAVIksdMM+OVVYsYVaZZbvlkiJNTcoIoQtP1AeSSIvOlBZYRYSENeA20M5/
         I9yzgCj523iD8C9zTRexMV9QZwuFMwZbBFCWn/bh4sjQuT4QjVP9atIizKE32vMRyMwi
         wGWbXfsOWsU6yNqANr1653wif9u4pP0WkVcEUGvk1jQyaZklNtAvefJesgknYPqJ08vi
         mAkncdhKLHFiPOp6YfiW+ENwohmgclArAYssEmvqD7AfrpOReyFHvyj4+EIuieoHckuX
         YtKg==
X-Forwarded-Encrypted: i=1; AJvYcCU76g625II2YOKcBTKmEhQbJ8DQwxBPu2G7OgKOC8FyPUdxq9uC0gLjjipSp4IZArJneIdSG2Jaww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaimPI6rvxImwfk9tD/NQqCELKZTn+l0RPiO3MCpcWAWrrOave
	V6/Mr62Ua3P7TEZxCvlFw2F+XPYDJzvczkQuNSDX5WJWp2ycdqVHOjifdxRJpgRil9AayZmCOH/
	3Gq1AIHSgo3bLCOlF4J0N83nLKHK0d1gGI7vPX1WLMhE+utt/7vnanqfO8g40yQ==
X-Gm-Gg: ATEYQzwAzJYhwBZiZjSuTV8fcbeG5h/r5+V1g/z6UfpwcseSFtt125J+FUd36Kd6Dn7
	c1n5cE8G+wlHyVK9bvWg6noSqeKLuQh7O74eNi/BOLD+wG6iD3yxW5Inqvk8Jmvjf2MUGkIXudx
	ECGvftZUlKEFbTfU8ru7ZUR3/+K4P4rPEhAtngmgPyZcWdSW6tj5/DpiVjP5SLAh28Z5ZLrXfNR
	Rdg36kiKZVDLmBL0HRJ719SxRs4+NLByEa73yU7ozL2phWrfR/GJ6zLxBFPSJCDKUGFgLxfuIzp
	NAxC2c4LRU25chU82Y2HBO/iFagpDDws7BbG7auPE9Q4j9pRNFrjQTz1vaUgVHgK5AVonmv5iGu
	sv6m05+AfLiqUf16r8Q6VwERlCjDaidWr9N/QitxdwyGO10ls1ok7Dg==
X-Received: by 2002:a17:903:3ba5:b0:2b0:5aab:c40a with SMTP id d9443c01a7336-2b08277aecamr143662595ad.31.1774353831149;
        Tue, 24 Mar 2026 05:03:51 -0700 (PDT)
X-Received: by 2002:a17:903:3ba5:b0:2b0:5aab:c40a with SMTP id d9443c01a7336-2b08277aecamr143662045ad.31.1774353830506;
        Tue, 24 Mar 2026 05:03:50 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm208995095ad.45.2026.03.24.05.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 05:03:50 -0700 (PDT)
Message-ID: <f97c6dfa-55dc-4792-95d6-4aa1bce3694d@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 17:33:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] PCI: Add support for PCIe WAKE# interrupt
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
        sherry.sun@nxp.com, driver-core@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com>
 <20260313-wakeirq_support-v8-3-48a0a702518a@oss.qualcomm.com>
 <4n5heks4oymfz75wiajyc5zuzzulmwyfj2couudbi7gi67h2rk@smpnmyhdjkns>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <4n5heks4oymfz75wiajyc5zuzzulmwyfj2couudbi7gi67h2rk@smpnmyhdjkns>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA5NiBTYWx0ZWRfX/CziBRVf1+Rj
 kf78jHXGt2W9HiUHwl1bunlvC/aAhjLXnP0s7Y6NI6d8bNXjzJf//TYQe30XpC6rG43VFzm+n+v
 bN2Y2HPChqMei8yHX/OlnRkJyFRev03GQXM8e32kVmoWCGw0PdcvwBDvrFoVdGqoW4DwCQZxXks
 iVfTE1nJbhGRv17KHdkA7/D4xiTXUHGLy5S9cOMtFjbTozd0x19E7rDCCdw8T5wmJzECNzPkBwu
 30Hfr5Wuj7EPA2hhnA+FwHrjAors3K1Zny+kHUIaXRRPmbl2vRjZ+nuK1/q4N0rVel5HciHk8qi
 dZmFs/ETNJAmLThOpCpbXVKpstFeY7sJZhV1IR2VTrZNsK1TQ+slpmDNEPUIF+j6njccgNrssCc
 KLIcFA4ZdP+UFiaMdgQJTo5/0rGe+qgjtpdre3NN+A3lUSDERsj2KguolHCL/WmXKZu7qUuF2j0
 7rXfcT10Bu5D6e5TmOg==
X-Proofpoint-ORIG-GUID: tZ0-42F0EMVnG2es_wPsAG8mJgfWnLf4
X-Authority-Analysis: v=2.4 cv=O880fR9W c=1 sm=1 tr=0 ts=69c27dec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
 a=rFA5VEQNUbPbIC_WhckA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tZ0-42F0EMVnG2es_wPsAG8mJgfWnLf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240096



On 3/17/2026 12:56 PM, Manivannan Sadhasivam wrote:
> On Fri, Mar 13, 2026 at 12:38:42PM +0530, Krishna Chaitanya Chundru wrote:
>> According to the PCI Express specification (PCIe r7.0, Section 5.3.3.2),
>> two link wakeup mechanisms are defined: Beacon and WAKE#. Beacon is a
>> hardware-only mechanism and is invisible to software (PCIe r7.0,
>> Section 4.2.7.8.1). This change adds support for the WAKE# mechanism in
>> the PCI core.
>>
>> According to the PCIe specification, multiple WAKE# signals can exist in
>> a system or each component in the hierarchy could share a single WAKE#
>> signal. In configurations involving a PCIe switch, each downstream port
>> (DSP) of the switch may be connected to a separate WAKE# line, allowing
>> each endpoint to signal WAKE# independently. From figure 5.4 in sec
>> 5.3.3.2, WAKE# can also be terminated at the switch itself. To support
>> this, the WAKE# should be described in the device tree node of the
>> endpoint/bridge. If all endpoints share a single WAKE# line, then each
>> endpoint node should describe the same WAKE# signal or a single WAKE# in
>> the Root Port node.
>>
>> In pci_device_add(), PCI framework will search for the WAKE# in device
>> node, If not found, it searches in its upstream port only if upstream port
>> is Root Port. Once found, register for the wake IRQ in shared mode, as the
>> WAKE# may be shared among multiple endpoints.
>>
>> dev_pm_set_dedicated_shared_wake_irq() associates a wakeup IRQ with a
>> device and requests it, but the PM core keeps the IRQ disabled by default.
>> The IRQ is enabled only when the device is permitted to wake the system,
>> i.e. during system suspend and after runtime suspend, and only when device
>> wakeup is enabled.
>>
>> When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume() to
>> bring the device back to an active power state, such as transitioning from
>> D3cold to D0. Once the device is active and the link is usable, the
>> endpoint may generate a PME, which is then handled by the PCI core through
>> PME polling or the PCIe PME service driver to complete the wakeup of the
>> endpoint.
>>
>> WAKE# is added in dts schema and merged based on below links.
>>
>> Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
>> Link: https://github.com/devicetree-org/dt-schema/pull/170
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/of.c       | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.c      | 10 +++++++
>>   drivers/pci/pci.h      |  2 ++
>>   drivers/pci/probe.c    |  2 ++
>>   drivers/pci/remove.c   |  1 +
>>   include/linux/of_pci.h |  4 +++
>>   include/linux/pci.h    |  2 ++
>>   7 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 9f8eb5df279ed28db7a3b2fd29c65da9975c2efa..b7199d3598b31b62245716c178a5a73565efc89e 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -7,6 +7,7 @@
>>   #define pr_fmt(fmt)	"PCI: OF: " fmt
>>   
>>   #include <linux/cleanup.h>
>> +#include <linux/gpio/consumer.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>>   #include <linux/pci.h>
>> @@ -15,6 +16,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/of_pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_wakeirq.h>
>>   #include "pci.h"
>>   
>>   #ifdef CONFIG_PCI
>> @@ -586,6 +588,78 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
>>   	return irq_create_of_mapping(&oirq);
>>   }
>>   EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
>> +
>> +static void pci_configure_wake_irq(struct pci_dev *pdev, struct gpio_desc *wake)
>> +{
>> +	int ret, wake_irq;
>> +
>> +	wake_irq = gpiod_to_irq(wake);
>> +	if (wake_irq < 0) {
>> +		pci_err(pdev, "Failed to get wake irq: %d\n", wake_irq);
>> +		return;
>> +	}
>> +
>> +	device_init_wakeup(&pdev->dev, true);
> Just set wakeup only if dev_pm_set_dedicated_shared_wake_irq() succeeds.
ack.
>> +
>> +	/*
>> +	 * dev_pm_set_dedicated_shared_wake_irq() associates a wakeup IRQ with the
>> +	 * device and requests it, but the PM core keeps it disabled by default.
>> +	 * The IRQ is enabled only when the device is allowed to wake the system
>> +	 * (during system suspend and after runtime suspend), and only if device
>> +	 * wakeup is enabled.
>> +	 *
>> +	 * When the wake IRQ fires, the wakeirq handler invokes pm_runtime_resume()
>> +	 * to bring the device back to an active power state (e.g. from D3cold to D0).
>> +	 * Once the device is active and the link is usable, the endpoint may signal
>> +	 * a PME, which is then handled by the PCI core (either via PME polling or the
>> +	 * PCIe PME service driver) to wakeup particular endpoint.
>> +	 */
>> +	ret = dev_pm_set_dedicated_shared_wake_irq(&pdev->dev, wake_irq,
>> +						   IRQ_TYPE_EDGE_FALLING);
> Isn't WAKE# a level triggered signal?
Ack. I will change IRQ_TYPE_EDGE_FALLING to IRQ_TYPE_LEVEL_LOW.
>> +	if (ret < 0) {
>> +		pci_err(pdev, "Failed to set wake IRQ: %d\n", ret);
> s/wake/WAKE#
ack.

- Krishna Chaitanya.
> - Mani
>

