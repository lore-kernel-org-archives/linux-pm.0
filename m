From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 01/12] tools/power turbostat: simplify default output
Date: Sun, 19 Apr 2015 17:02:59 -0400
Message-ID: <CAJvTdKmySBOFetr_-yDZPZreaMb_9SBCP7QOBGpxVS2O-=ia6g@mail.gmail.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
	<1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
	<000301d07aac$d1856bd0$74904370$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:34262 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbDSVDB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2015 17:03:01 -0400
Received: by laat2 with SMTP id t2so113557803laa.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2015 14:02:59 -0700 (PDT)
In-Reply-To: <000301d07aac$d1856bd0$74904370$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

I hear you, Doug.

Personally, I *always* use --debug, and I *always* re-direct output to a file.

The fact of the matter is that on modern hardware, there are now more
columns than will fit on a screen, and most users will not even
understand them.  Further, there are more columns on the way...

I started to go down the road of picking and choosing columns, but it
seemed that "minimum/everything" made more sense.  And in that world,
minimum seems to be a more reasonable default.

thanks,
-Len




On Sun, Apr 19, 2015 at 10:26 AM, Doug Smythies <dsmythies@telus.net> wrote:
> On 2015.04.18 17:40 Len Brown wrote:
>
>> Casual turbostat users generally just want to know MHz.
>> So by default, just print enough information to make sense of MHz.
>>
>> All the other configuration data and columns for C-states and temperature etc,
>> are printed with the --debug option.
>
> I almost never use turbostat to obtain MHz.
> I only use turbostat to observe Energy or Power, and C-states.
>
> I am not in favor of this change.
>
> I do not want the extra clutter that comes with the --debug option
> (although I do use it sometimes).
> When doing experiments manually, without a script, it is convenient
> to have many energy or power samples visible on the screen all at once.
>
> Note: If I am using the acpi cpufreq driver (i.e. rarely), then yes
> I use turbostat to obtain actual CPU frequencies, as I know of no
> other way.
>
> I reviewed some help type forums, and yes while many postings involving
> turbostat are about CPU frequency, there are also some about power.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Len Brown, Intel Open Source Technology Center
