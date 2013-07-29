From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] ACPI / PM: Make messages in acpi_device_set_power()
 print device names
Date: Mon, 29 Jul 2013 16:16:31 +0400
Message-ID: <51F65D1F.9050402@cogentembedded.com>
References: <10433383.dueoNg39qi@vostro.rjw.lan> <CAOLK0pyBsD8vR0a2mcSucnD8zFTz8ZB72OPE0R9Z67SxH9VHRw@mail.gmail.com> <1375067513.2075.27.camel@joe-AO722> <1782275.A7JEhQIj8Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:51112 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab3G2MQe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 08:16:34 -0400
Received: by mail-la0-f47.google.com with SMTP id eo20so2360877lab.20
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 05:16:32 -0700 (PDT)
In-Reply-To: <1782275.A7JEhQIj8Q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Joe Perches <joe@perches.com>, Lan Tianyu <lantianyu1986@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hello.

On 29-07-2013 16:17, Rafael J. Wysocki wrote:

[...]

>>>> @@ -166,20 +166,20 @@ int acpi_device_set_power(struct acpi_de
>> []
>>>>          if (device->parent && (state < device->parent->power.state)) {
>>>> -               printk(KERN_WARNING PREFIX
>>>> -                             "Cannot set device to a higher-powered"
>>>> -                             " state than parent\n");
>>>> +               dev_warn(&device->dev, "Cannot transition to a higher-powered "
>>>> +                        "state than parent\n");

>> coalesce format please.

> I can, but then it'll cross the 80 columns boundary.

   It's not a problem with checkpatch.pl anymore. Contrariwise, it whines 
about the broken up string literals, AFAIR.

> Thanks,
> Rafael

WBR, Sergei

