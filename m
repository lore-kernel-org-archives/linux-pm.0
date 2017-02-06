From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Date: Mon, 6 Feb 2017 09:05:11 +0530
Message-ID: <20170206033511.GC3131@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-4-code@mmayer.net>
 <20170203042917.GL7458@vireshk-i7>
 <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33094 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbdBFDfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Feb 2017 22:35:15 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so24212827pge.0
        for <linux-pm@vger.kernel.org>; Sun, 05 Feb 2017 19:35:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <markus.mayer@broadcom.com>
Cc: Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 03-02-17, 17:00, Markus Mayer wrote:
> On 2 February 2017 at 20:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 01-02-17, 17:06, Markus Mayer wrote:
> >> From: Markus Mayer <mmayer@broadcom.com>
> >>
> >> Enable all applicable CPUfreq options.
> >>
> >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >> ---
> >>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> >> index 4eb5d6e..6fda604 100644
> >> --- a/arch/mips/configs/bmips_stb_defconfig
> >> +++ b/arch/mips/configs/bmips_stb_defconfig
> >> @@ -26,6 +26,16 @@ CONFIG_INET=y
> >>  # CONFIG_INET_XFRM_MODE_BEET is not set
> >>  # CONFIG_INET_LRO is not set
> >>  # CONFIG_INET_DIAG is not set
> >> +CONFIG_CPU_FREQ=y
> >> +CONFIG_CPU_FREQ_STAT=y
> >> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> >> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> >> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> >> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> >> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> >> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> >> +CONFIG_BMIPS_CPUFREQ=y
> >>  CONFIG_CFG80211=y
> >>  CONFIG_NL80211_TESTMODE=y
> >>  CONFIG_MAC80211=y
> >
> > Rebase your stuff over pm/linux-next and you will see some changes here. Also
> > schedutil is the new governor in town, you must give it a try.
> 
> I'll definitely turn on SCHEDUTIL. As for the changes in next, I don't
> see any conflicts. My series applied fine on top of linux-next from
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/. Did
> I use the wrong tree?

No, but you didn't follow the right process. You should use 'make
savedefconfig' to update the defconfig.

The symbol CONFIG_CPU_FREQ_STAT_DETAILS is removed from the kernel
now.

-- 
viresh
