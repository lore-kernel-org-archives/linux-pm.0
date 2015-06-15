From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: commit 70fea60d888d caused s2ram regression with WD disk
Date: Tue, 16 Jun 2015 01:07:52 +0200
Message-ID: <4618053.DJx4o6Y2Ql@vostro.rjw.lan>
References: <20150615025536.GA26473@aaronlu.sh.intel.com> <s5hoakhgqdj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42861 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754355AbbFOWl4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 18:41:56 -0400
In-Reply-To: <s5hoakhgqdj.wl-tiwai@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Aaron Lu <aaron.lu@intel.com>, linux-pm@vger.kernel.org, Mark Scott <markcscott@talktalk.net>, Benoit Goby <benoit@android.com>

On Monday, June 15, 2015 01:31:04 PM Takashi Iwai wrote:
> At Mon, 15 Jun 2015 10:55:36 +0800,
> Aaron Lu wrote:
> > 
> > Hi,
> > 
> > As explained by Takashi:
> > "
> > So this looks like the cause.  The recent kernel has a watchdog for
> > async resume workers, and if it expires, it panics.  This explains why
> > 3.12 worked; the watchdog was introduced since 3.13.
> > 
> > The timeout length is unfortunately fixed in Kconfig, set to 12 as
> > default.  And this seems too short.  We should extend this to at least a
> > minute, I suppose.  Also, it'd be better to be dynamically
> > configuratble.
> > "
> > https://bugzilla.opensuse.org/show_bug.cgi?id=934397#c5
> > 
> > The upstream bug page is here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=91921
> > Since Benoit isn't registered there, I write the email for discussion.
> 
> Thanks Aaron for starting a thread.
> 
> Below is a patch to make the default value a bit safer.
> 
> I can submit another patch to add a boot option to change the timeout
> value, too, if anyone thinks it's worth.  Just let me know.
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] PM: Increase default DPM watchdog timeout to 60
> 
> Many harddisks (mostly WD ones) have firmware problems and take too
> long, more than 10 seconds, to resume from suspend.  And this often
> exceeds the default DPM watchdog timeout (12 seconds), resulting in a
> kernel panic out of sudden.
> 
> Since most distros just take the default as is, we should give a bit
> more safer value.  This patch increases the default value from 12
> seconds to one minute, which has been confirmed to be long enough for
> such problematic disks.

That's totally fine by me, so I can apply the patch unless somebody has a
better idea about how to address the issue at hand.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91921
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  kernel/power/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 7e01f78f0417..9e302315e33d 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -187,7 +187,7 @@ config DPM_WATCHDOG
>  config DPM_WATCHDOG_TIMEOUT
>  	int "Watchdog timeout in seconds"
>  	range 1 120
> -	default 12
> +	default 60
>  	depends on DPM_WATCHDOG
>  
>  config PM_TRACE
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
