From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Kirkwood SoC
Date: Sat, 15 Dec 2012 06:22:14 +0900
Message-ID: <CABMQnVKgRWk2fHWjN7ibdOJTExT=w2mu4BoJwJEkMDZmXLd4fQ@mail.gmail.com>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
 <20121207232459.GA4304@obsidianresearch.com> <20121207235904.GA15078@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64668 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237Ab2LNVWq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Dec 2012 16:22:46 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so801088wib.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Dec 2012 13:22:45 -0800 (PST)
In-Reply-To: <20121207235904.GA15078@obsidianresearch.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org

On Sat, Dec 8, 2012 at 8:59 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Fri, Dec 07, 2012 at 04:24:59PM -0700, Jason Gunthorpe wrote:
>> On Sat, Dec 08, 2012 at 08:15:50AM +0900, Nobuhiro Iwamatsu wrote:
>> > Some kirkwood SoC has thermal sensor.
>> > This patch adds support for 88F6282 and 88F6283.
>>
>> Thanks! I was just about to write this.. Looks good here.
>
> Ah, looking closer:
>
> $ cat /sys/class/thermal/thermal_zone0/temp
> 37
>
> That should be 37000, the value out of the driver should be in
> milli-Celsius.
>
> I'd use this equation instead:
>
>         *temp = ((322 - reg) * 10000 * 1000) / 13625;
>

OK, I will fix this.
Thanks for your review.

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
