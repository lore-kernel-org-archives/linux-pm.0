From: Tamas Papp <tkpapp@gmail.com>
Subject: Re: STI problem and workaround for Dell XPS 13 (Skylake, 2016) / Broadcom BCM4350
Date: Wed, 02 Mar 2016 15:13:23 +0100
Message-ID: <87a8mhotmk.fsf@gmail.com>
References: <87h9gpp5rt.fsf@gmail.com> <CADjb_WQwwGD4wQugeLf=2k7XjtPGt9o6vgqhMdLR+ALDhK7J+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34404 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcCBON3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 09:13:29 -0500
Received: by mail-wm0-f45.google.com with SMTP id p65so81894609wmp.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 06:13:28 -0800 (PST)
In-reply-to: <CADjb_WQwwGD4wQugeLf=2k7XjtPGt9o6vgqhMdLR+ALDhK7J+Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yu chen <yu.chen.surf@gmail.com>
Cc: linux-pm@vger.kernel.org

On Wed, Mar 02 2016, yu chen wrote:

> On Wed, Mar 2, 2016 at 5:51 PM, Tamas Papp <tkpapp@gmail.com> wrote:
>> Hi,
>>
>> I have a Dell XPS 13 (Skylake, 2016) and wanted to get STI working, so I
>> followed the instructions at [1]. I found that the Broadcom wireless
>> chip is waking the machine up from STI / freeze.
>>
>> A workaround is
>>
>> INTERFACE=wlp58s0
>> ifconfig $INTERFACE down
>> modprobe -r brcmfmac && echo freeze > /sys/power/state && modprobe brcmfmac
>> ifconfig $INTERFACE up
>>
>> I thought I would ask whether I should report this as a bug, and if yes,
>> where.
>>
> Some device drivers such as brcmac has the ability to wake the system
> up,  you can
> disable it by echo to /proc/acpi/wakeup IMO.

That's what I attempted first, but echo to /proc/acpi/wakeup just makes
the entry occur _twice_ -- what am I doing wrong?

root@tamas:~# cat /proc/acpi/wakeup | grep ena
PXSX      S4    *enabled   pci:0000:3a:00.0
PBTN      S3    *enabled   platform:PNP0C0C:00
root@tamas:~# echo PXSX > /proc/acpi/wakeup 
root@tamas:~# cat /proc/acpi/wakeup | grep ena
PXSX      S4    *enabled   pci:0000:3c:00.0
PXSX      S4    *enabled   pci:0000:3a:00.0
PBTN      S3    *enabled   platform:PNP0C0C:00
root@tamas:~# uname -r
4.5.0-040500rc6-generic

Best,

Tamas
