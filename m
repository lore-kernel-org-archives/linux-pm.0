From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH 2/6] extcon: max77843: Add max77843 MUIC driver
Date: Fri, 23 Jan 2015 16:18:54 +0900
Message-ID: <54C1F5DE.2060303@samsung.com>
References: <1421989367-32721-1-git-send-email-jaewon02.kim@samsung.com>
 <1421989367-32721-3-git-send-email-jaewon02.kim@samsung.com>
 <CAJKOXPdoDZH1CmNOkZuw_Bx9pT_drP0ZrSLB8jmJpDR+sacRjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:42115 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbbAWHTJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jan 2015 02:19:09 -0500
In-reply-to: <CAJKOXPdoDZH1CmNOkZuw_Bx9pT_drP0ZrSLB8jmJpDR+sacRjg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Krzysztof,

2015=EB=85=84 01=EC=9B=94 23=EC=9D=BC 15:38=EC=97=90 Krzysztof Koz=C5=82=
owski =EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> 2015-01-23 6:02 GMT+01:00 Jaewon Kim <jaewon02.kim@samsung.com>:
>> This patch adds MAX77843 extcon driver to support for MUIC(Micro
>> USB Interface Controller) device by using EXTCON subsystem to handle
>> various external connectors.
>>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/extcon/Kconfig           |   10 +
>>   drivers/extcon/Makefile          |    1 +
>>   drivers/extcon/extcon-max77843.c |  871 ++++++++++++++++++++++++++=
++++++++++++
>>   3 files changed, 882 insertions(+)
>>   create mode 100644 drivers/extcon/extcon-max77843.c
>>
> (...)
>
>> +static int max77843_muic_remove(struct platform_device *pdev)
>> +{
>> +       struct max77843_muic_info *info =3D platform_get_drvdata(pde=
v);
>> +
>> +       cancel_work_sync(&info->irq_work);
>> +
> Missing regmap_del_irq_chip().
>
> Best regards,
> Krzysztof
>

I miss remap_del_irq_chip() function. thanks.
I wil add this function.


Thanks
Jaewon Kim

