From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 8 May 2015 15:32:30 -0400
Message-ID: <CAJvTdKnoZhworj21Bsdt5ttGK+vQQ0tB_0-2Aok-rdsU8VvNkg@mail.gmail.com>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<Pine.LNX.4.44L0.1505081026250.1219-100000@iolanthe.rowland.org>
	<CAJvTdK=ok=xWR16R-3_+kpxujBSFOLqQ3DNNyFgE-Kc8en=PTg@mail.gmail.com>
	<20150508201310.5c4ccfaa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:33234 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932230AbbEHTcc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 15:32:32 -0400
In-Reply-To: <20150508201310.5c4ccfaa@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, May 8, 2015 at 3:13 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> 2. worst case latency is obscene, there are examples of some
>>     syncs which take over 3,000 ms to complete.
>
> ATA is pretty open ended on this. I believe the vendors use 7 seconds
> just for the cache flush as their limit because after 7 seconds some non
> Linux OS's blow up. However if my suspend/resume crashes (as still I'm
> sorry to say happens far too often) I don't want my last ten minutes of
> work trashed.
>
>> Unfortunately, sys_sync() can be a significant pain point,
>> even for systems that run Android.
>
> Android devices often have slow I/O devices coupled with a lot of memory
> so yes that is true.
>
> There are however some very important reasons for using sync() in a
> suspend
>
> - I can read data off the suspended machines disk volumes even though I
>   can't write to them. People do this.
>
> - Suspend requires the firmware, drivers and kernel all get it exactly
>   right. On a lot of machines therefore suspend is still a buggy pile of
>   crap. Sync is extremely valuable given that you can't be entirely
>   sure your system will resume.
>
> - Users habitually do stupid things like removing USB dongles from
>   suspended boxes and thinking afterwards. Perception is that the device
>   is off therefore you can unplug it.
>
> So I think its inappropriate to change the default. Allow users to turn
> it off by all means, and I imagine many phones would use that.

FWIW, 18-months ago, I proposed a patch to make the sys_sync() optional
"[PATCH 1/1] suspend: make sync() on suspend-to-RAM optional"
and feedback was that fewer choices would be better.

Note that user-space has full license both before and after this patch
to sync().  Indeed, the s2disk and s2ram utilities do exactly that.

> Some of this however is crappy suspend/resume handling. If the suspend
> subsystem was doing its job then for the cases of timeout triggered
> suspend it would have triggered most of the disk writes ten seconds
> before it tried to suspend properly ;-)

No problem, continue to use s2ram on your system -- and to the extent
that sync works, your data will be on disk.  (sync reliability is a
different topic...)

Understand, however, there are systems which suspend/resume reliably
many times per second, making policy choice of having the kernel hard-code
a sys_sync() into the suspend path a bad idea.

thanks,
Len Brown, Intel Open Source Technology Center
