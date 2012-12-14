From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood SoC
Date: Sat, 15 Dec 2012 06:25:39 +0900
Message-ID: <CABMQnVJHyfzJaDeMM20Hg=G4R8r2HfGO_pVJ+scZMwUeTKfJYg@mail.gmail.com>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121207232459.GA4304@obsidianresearch.com> <20121207235904.GA15078@obsidianresearch.com>
 <20121208000850.GZ14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50868 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296Ab2LNV0L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Dec 2012 16:26:11 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so802621wib.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Dec 2012 13:26:09 -0800 (PST)
In-Reply-To: <20121208000850.GZ14363@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

Hi,

On Sat, Dec 8, 2012 at 9:08 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 07, 2012 at 04:59:04PM -0700, Jason Gunthorpe wrote:
>> On Fri, Dec 07, 2012 at 04:24:59PM -0700, Jason Gunthorpe wrote:
>> > On Sat, Dec 08, 2012 at 08:15:50AM +0900, Nobuhiro Iwamatsu wrote:
>> > > Some kirkwood SoC has thermal sensor.
>> > > This patch adds support for 88F6282 and 88F6283.
>> >
>> > Thanks! I was just about to write this.. Looks good here.
>>
>> Ah, looking closer:
>>
>> $ cat /sys/class/thermal/thermal_zone0/temp
>> 37
>>
>> That should be 37000, the value out of the driver should be in
>> milli-Celsius.
>>
>> I'd use this equation instead:
>>
>>       *temp = ((322 - reg) * 10000 * 1000) / 13625;
>
> Be careful of math overflows... make sure you do this calculation using
> unsigned arithmetic as temperatures above 157 degress will cause this
> to look like a negative number using signed math... However, that
> probably won't ever be noticed because at 157 degrees, you'll definitely
> be outside the operating limits of the device.

Oh, OK. I would like to thank you pointed out.
I will fix.

Best regards,
  Nobuhiro


-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
