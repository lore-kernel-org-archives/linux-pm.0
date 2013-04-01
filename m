From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: suspended DRAM bridge
Date: Mon, 01 Apr 2013 23:09:09 +0200
Message-ID: <5159F775.30805@fold.natur.cuni.cz>
References: <5159BAC9.80700@fold.natur.cuni.cz> <35938665.ZFvDxnCU3l@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:43400 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757666Ab3DAVJN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Apr 2013 17:09:13 -0400
In-Reply-To: <35938665.ZFvDxnCU3l@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

Rafael J. Wysocki wrote:
> On Monday, April 01, 2013 06:50:17 PM Martin Mokrejs wrote:
>> Hi Rafael,
>>   I have a simple question. Why seems my DRAM controller suspended?
> 
> I suppose that runtime PM is disabled for that device and therefore
> runtime_status is meaningless.

But I really mean this pair of values:

/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended

/sys/bus/pci/devices/0000:00:00.0/power/control:auto


> 
> And really, that attribute is for *debugging* things by developers who know
> what they are looking for and not for random poking.

Well, if me or you are to figure out why laptop-mode-tools make my life
even more miserable with hotplug issues the requests to provide

grep . /sys/bus/pci/devices/*/power/runtime_status
grep . /sys/bus/pci/devices/*/power/control

provide crap. How can I infer something if I cannot trust the values?
Don't you think that this is the reason why you have a headache and me as well?
Seriously, only pcieport driver reports PME# enabled/disabled messages
in my system although

find  /sys/bus/pci/devices/*/power/ -name control | while read f; do echo on > $f; done

should trigger similar message from other drivers as well! Provided they are
somewhat equally verbose under same kernel debug level. But they are all silent.
And if I start to think what the values mean it looks silly my only DRAM controller
is suspended.

I really do think that devices which cannot be ever suspended under a particular
condition should not claim they are suspended if they did not.


I reported that I sometimes see only PME# enabled (or just disabled) in dmesg
from a same device in dmesg *NOT* the accompanied opposite action on the same device.
As I see that most of my pci devices do not ever report a change of their status
I was hoping /sys/bus/pci/devices/*/power/runtime_status is correct.

> 
> Besides, this is a host bridge, not a DRAM controller.

Hmm.

> 
>> Does it make any sense in a laptop computer? How could the laptop work at all?
> 
> I suppose it wouldn't work if the PCI host bridge were suspended.  At least
> it couldn't access memory and the PCI bus then.

Thank you, had the same, although naive, expectation.

Thanks,
Martin
