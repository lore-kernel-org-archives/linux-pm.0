Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FB3FE66D
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479053; cv=none; b=nu3zJuyoYH8Bm6sPcc9KoMkBt32TCI0Drn17JGfg3sDy1D1caKqv8mkoeVnY+2F2x5TXAJdAqVrBTi0/99DAGff7cxMtbIs6IaftwrlAE7o/2exqledDTN+zXic2IcICOAMZeRBZXWXPyIeJj1TSyG1Udnk7XwhyvjgwSDotUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479053; c=relaxed/simple;
	bh=npaGFJnfYo3kLHM/yY+IRCA9qU4oY8XIL7aOWfcIOFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hUFBrTccIUwjUzXD7AgtDJxvBhs4+W0eaJVKhN4M9sMwGOleJmd7uNhNWEiv/j9hiPNIWeOI3HnRgob25SwFfkpwRwlwuUTZVBRTZWnccSBbFmpoKbHcLywm2vG1fW1oCRkzmlXr5gAXrhxsEoeYNX7ZqUnpg5EWg8iwhqlVvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ/Witbl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XQsb91e1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ/Witbl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XQsb91e1"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TG5Wcp3857014
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFEQeqYDr3vnx+CdaU4srnuC/dtlq0bO49Y8PJlmqAU=; b=cZ/Witblgi6EIXKS
	qbLMR/8oRr23GtyI45c0j39vYBwbeHYolz7VXgngtSVVN9so1MoXHt8hzNY0LVNu
	2Hxyjce0Q+t4qLd3Hco9LKxXJReg4MmcK6iaEdwiDdNp82Ekb9teAJfsGwk0kQJX
	/lfBomu2tcDL96kUKW62mWcmX+yYL6O4xfdDQF3jOQ+/+dF31p7PKxm41eR5XsA3
	uQcwFycHKTDJ3MokteQ05wITXxc1uvF2sOjxmzdKyXNpdLd+xsIYgEv/lOGRXPuV
	PRIqXu2wMKgV6tnBWeYthWK0q2ADut09i2ALBhuFLL+lyf9itLbrQrleYckYIzBf
	nDqlBQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71g0x9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:10:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2497cc190so6139165ad.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479045; x=1778083845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFEQeqYDr3vnx+CdaU4srnuC/dtlq0bO49Y8PJlmqAU=;
        b=XQsb91e1eNZyeGVDZD83UDPnRGuCLx3DIh3kE5EH00Try0584BD3QnxCiHzs3fVuvG
         hRCIZiClfAZRngqgSrN1LF5sFF/KYwfuCwkyXkGfjKKzu/JQRi9kGvreiyq0U5H1ed6Y
         Q5CoSKN/M0fZH0DLFmxQX5e1TPdVxnCYdzS11GJANoSAz4o6ZYYyIJ8cXuFhb9wKcVM8
         0f6/h61FWGgyW2elZQul7kyrNWc6ibPcj1l+tPT70Iw+hXACQh+J7QbCs0r3aTfEgvwO
         Pj6L/+Cve/UBWWzn0FU0YRFSH88eGZP5I7XL/s/B//tN6/Kt8J1tA8eH/u4wNFVKkEs6
         xzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479045; x=1778083845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFEQeqYDr3vnx+CdaU4srnuC/dtlq0bO49Y8PJlmqAU=;
        b=eRibJ5akz8JAaZWKb1N6rcka9NCWHFKMjmxIPt5XucIqkuO/4+4vwkGyUGGLA2maa0
         BCzONuGVsVF2+CoCfdq0JHeu5bX6EQOzTNYcqUgucfnM7915/DbAzMp4sJ6oPJ16pqIm
         lKJ/s6uyExkTHRis5/Mj2rlqcV9nTvXqPaaIIQfS4UZ8ej6+VW13viVm6vcaiAHXXLxE
         aiiPvNCqbth+WZ+6cAl7XldLleRtHiXBnIkcZDehaqBHfYPOz3sfLCao+vVPFgGdNe7a
         O8oJ8mWKifgBsSVRkZ7mEmqt5KeiuAdwK9Po3cCxFOjXVMzNsu+yLE/Tacx0XgCRkQJR
         jJJw==
X-Gm-Message-State: AOJu0YzAGDKKjOwNts1ukuftpkR2FLwwAYWChmHGmpVfgXsmhPJzripx
	OYJUoEg0SwK5bq+F25x2WdrWiDm1unFVZfOToMTlv6CC29yNIF/FdRFGXOekSaNRYuVJT0oWrPE
	u0SKRUtRJqlZ95G7W4oYIDbj7QtnU5BwssU8OLspSIpZb1sDYnD0eXl/T73/cdQ==
X-Gm-Gg: AeBDievs/YVaCdXKzBMIOTWaBT8kjebNsNtkeKBvQQfCNFcRs6EOoJam6qOoHRGGV0x
	HGVG/FB7719DsSOKaDJ2n2KlD2FbvxF7eQkuN4ou3VfR+wkPqWE0Z5v3qJgCsGiEXLFNcWsGpLQ
	5bTFR6JmnngOTiiWfSKe4bnRLSjfCyDipgTELrLuYamoKM/PG2AO4BrHXhiOuzZ2qMHhYhbI5ew
	J+Ok5Jb5AlhhhGFDo7r204ljRiZCNpgEl/ViBotH+5asIPmAk6aIDX4ElUlEtRu38lv0c74lIJC
	rzMd3niVoOsDohE9xPfmnJrmg0x7c1PSiQZWPD6zy/Hhrb+SRoz/mrIekvyM7RKIK7yRhlETQc6
	ARhu8+YNuQt5AZ+CVbFTM7jUU7yJnd5F6FQkpbdMKO8TVsVqZAXvGWLNAzjPh4lf7+Q==
X-Received: by 2002:a17:902:cf0b:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b988368538mr33084345ad.2.1777479045158;
        Wed, 29 Apr 2026 09:10:45 -0700 (PDT)
X-Received: by 2002:a17:902:cf0b:b0:2b2:3eec:c75b with SMTP id d9443c01a7336-2b988368538mr33083725ad.2.1777479044502;
        Wed, 29 Apr 2026 09:10:44 -0700 (PDT)
Received: from [192.168.29.31] ([49.43.226.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b99852135asm7875085ad.73.2026.04.29.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 09:10:44 -0700 (PDT)
Message-ID: <37ab0178-1c9d-409e-bbaa-832f8075afa4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 21:40:32 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 08/13] mfd: core: Add firmware-node support to MFD
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
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-8-dcf937775e73@oss.qualcomm.com>
 <CAMRc=Mf+-04Zr7jjRoaxTzO3LKSMyQ7DzxJc=dHNSyThEUiq_Q@mail.gmail.com>
 <c0677503-8073-4940-8eb0-c06b34f843d2@oss.qualcomm.com>
 <CAMRc=MdxpSXiqAn-8Az4ig4N8TFVdE9psacPVG9J9KehuFnbwA@mail.gmail.com>
 <d6112b9c-01ea-483c-98fe-b480e78872e5@oss.qualcomm.com>
 <ce92a493-5016-41a2-8337-d2227cdf760a@oss.qualcomm.com>
 <CAMRc=Md_OON4cAGcJ=jDu=VY_mw0qa8HPz4VCDxYLpr7JMxLRw@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CAMRc=Md_OON4cAGcJ=jDu=VY_mw0qa8HPz4VCDxYLpr7JMxLRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HvLI1uhu3-Bo_3G6aW8iWWq4-OJsSZAO
X-Proofpoint-ORIG-GUID: HvLI1uhu3-Bo_3G6aW8iWWq4-OJsSZAO
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f22d85 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Y3Rdv8TwbQrKP7QTPRCa6w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KxIdvRQG5D7s9ip59WoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MyBTYWx0ZWRfX9H4FrUQIvfhP
 IbVZGZs2lcCWNyCb2d2VJ1vdQpjgUCTJfTFhrXbmYP9WmO9opJMSnAXdT4SrvXKh7WUBJol1x2p
 9MQgvWZa896Bi0fv0T5s0O2gBFGeV5E+B2VFkzuu6xjVrrgkicCTS/tr5mPQoOtQu6j6HEBqZkm
 +eMplBSSurjkkM0TJarRwEvkWYdRN3/qPOYP1ghm18iNQ/2p5llkerCcWJL7HCeaIEGoakHGii8
 q6wZN2hf7IHCaiBfULruADEig02uYVWeUelnZTyGBdWQ+g9fU9Nm+q9xB3GtA7rW59QNTmEtcMT
 MWvp80m1knKRjgS0StWvgoS2zl/Is0iT7wqAJe6jvshUKkPRQCC4G2EFmCJnPwbPwWr3sjCyBb6
 BBEEsIMD78qjrXNVloMocUjqoitsnMqdvFHdF9TMBWEasLJlTycxbg/88IaqUhF0qCvi7GCBXSe
 2KVqLMDb9j0zxEsXg8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290163



On 29-04-2026 15:20, Bartosz Golaszewski wrote:
> On Wed, Apr 29, 2026 at 11:46 AM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>
>>>>
>>>> If set, it would be called from MFD core and would do the name lookup
>>>> and return the fwnode which would then be assigned to the cell device?
>>>
>>
>> Or should we just drop this patch for fwnode in mfd-core?
>>
>> Export a new call in reboot-mode framework as:
>> reboot_mode_register_node(struct reboot_mode_driver *reboot,
>>                     struct device_node *np / fwnode)
>>
>> Use the parent node in psci-reboot-mode and find reboot-mode and call
>> reboot_mode_register_node?
>>
> 
> No, I think the reboot-mode device (as pointed to by the dev field of
> struct reboot_mode_driver) should be associated with the right fwnode
> from the start so it should be handled in MFD core.

Ack. something like should be fine?

drivers/mfd/mfd-core.c :
+       if (!pdev->dev.fwnode && cell->get_fwnode) {
+               fwnode = cell->get_fwnode(parent);
+               if (fwnode)
+                       device_set_node(&pdev->dev, fwnode);
+       }

drivers/mfd/psci-mfd.c (goes next patch):
+static struct fwnode_handle *psci_reboot_mode_get_fwnode(struct device 
*parent)
+{
+       return fwnode_get_named_child_node(dev_fwnode(parent), 
"reboot-mode");
+}

--

thanks,
Shivendra
