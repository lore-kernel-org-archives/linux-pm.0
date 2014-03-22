From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: ACPI and PM material for v3.15-rc1 (current queue)
Date: Sat, 22 Mar 2014 10:08:20 +0800
Message-ID: <532CF094.5070606@linaro.org>
References: <2611540.GrpzWjVQ7v@vostro.rjw.lan> <532B8A4B.9000808@linaro.org> <4752174.DIeOl6EhdE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:54409 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbaCVCIZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 22:08:25 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so3156612pbb.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 19:08:24 -0700 (PDT)
In-Reply-To: <4752174.DIeOl6EhdE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>

On 2014=E5=B9=B403=E6=9C=8822=E6=97=A5 00:40, Rafael J. Wysocki wrote:
> On Friday, March 21, 2014 08:39:39 AM Hanjun Guo wrote:
>> Hi Rafael,
> Hi,
>
>> On 2014=E5=B9=B403=E6=9C=8821=E6=97=A5 08:23, Rafael J. Wysocki wrot=
e:
>>> Hi All,
>>>
>>> My queue for the first pull request during the upcoming 3.15 merge =
window
>>> contains the material below.  Following the rule that everything I =
send
>>> pull requests for should spend at least one day in linux-next, I'm =
not
>>> going to add any more new commits to it at this point.
>>>
>>> Most likely, there will be more ACPI+PM pull request during the 3.1=
5 cycle,
>>> so if I missed something, it still may be possible to get that into=
 that
>>> kernel, but there has to be a good reason for it.
>>>
>>> Kind regards,
>>> Rafael
>>>
>>>
>>> ---------------
>>>
>>> Hanjun Guo (2):
>>>         ACPI / tables: Replace printk with pr_*
>>>         ACPI: Remove duplicate definitions of PREFIX
>> It seems that you missed some of my patches:
>> ACPI: Move BAD_MADT_ENTRY() to linux/acpi.h
>> ACPI / idle: Make idle_boot_override depend on x86 and ia64
>> ACPI / trivial: Fix the return value type of acpi_processor_eval_pdc=
()
>> ACPI / processor: Replace hard-coded "ACPI0007" with
>> ACPI_PROCESSOR_DEVICE_HID
>>
>> I think those 4 patches can be merged in 3.15 and you already accept=
ed them.
> Yes, I did not include the acpi-processor branch, sorry about that an=
d thanks
> for spotting it!
>
> That branch was in linux-next before, though, so I'll push it for 3.1=
5-rc1.

Thanks a lot !
