From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: STI problem and workaround for Dell XPS 13 (Skylake, 2016) /
 Broadcom BCM4350
Date: Fri, 4 Mar 2016 09:41:06 +0800
Message-ID: <CADjb_WQcXK5kc4d9isPGcw6=oVUbnZ9P77owOcmq=KSh7wEYbw@mail.gmail.com>
References: <87h9gpp5rt.fsf@gmail.com>
	<CADjb_WQwwGD4wQugeLf=2k7XjtPGt9o6vgqhMdLR+ALDhK7J+Q@mail.gmail.com>
	<87a8mhotmk.fsf@gmail.com>
	<CADjb_WQQdrFFpyRghk=nvZKeXA_ZY_dCYbEDtVGrEEk0LhVN=w@mail.gmail.com>
	<8737s8uj49.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33765 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbcCDBlI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 20:41:08 -0500
Received: by mail-wm0-f47.google.com with SMTP id l68so1400385wml.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 17:41:07 -0800 (PST)
In-Reply-To: <8737s8uj49.fsf@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tamas Papp <tkpapp@gmail.com>
Cc: linux-pm@vger.kernel.org

On Thu, Mar 3, 2016 at 3:16 PM, Tamas Papp <tkpapp@gmail.com> wrote:
> On Wed, Mar 02 2016, yu chen wrote:
>
>> Currently the  0000:3c and 0000:3a might have the same pnp object name PXSX,
>> unfortunately  the 'echo' will find the first math device in the
>> wakable list, and maybe
>>  0000:3c was probed before 0000:3a, so... maybe this is a weakness.
>>
>> Maybe you can disabled the wakable feature directly in device sysfs,
>> for example,
>> echo 0 > /sys/devices/pci0000:00/0000:3a:00.0/power/wakeup,
>> you might need to find out where 0000:3a:00.0 is.
>
> I tried that, but the module has problems after wakeup. I have to remove
> and insert it again with modprobe.
>
> Still, this is an OK workaround, thanks for the help. I still don't know
> if I should file this as a bug, and if yes, where.
>
Does the following fix make sense for you:

cat /proc/acpi/wakeup
PXSX:0      S4    *enabled   pci:0000:3a:00.0
then you need to echo PXSX:0 to disable it,
and for 3c, it would be PXSX:1
