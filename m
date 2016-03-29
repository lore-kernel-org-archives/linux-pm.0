From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Tue, 29 Mar 2016 21:45:53 +0200
Message-ID: <12972545.Mi9sHiNJpR@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <5412084.gVvuDFzkvo@wuerfel> <20160329163649.GE14322@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56612 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbcC2TqU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 15:46:20 -0400
In-Reply-To: <20160329163649.GE14322@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mmcclint@codeaurora.org

On Tuesday 29 March 2016 22:06:49 Viresh Kumar wrote:
> On 29-03-16, 17:14, Arnd Bergmann wrote:
> > On Tuesday 29 March 2016 12:09:48 Viresh Kumar wrote:
> > > +config CPUFREQ_DT_PLATDEV
> > > +	bool
> > > +	depends on CPUFREQ_DT
> > 
> > The 'depends on' line is redundant as you always 'select' the code
> > from CPUFREQ_DT. Since they are always set together, you can also
> > just drop the new symbol, or put the new code into the same file.
> 
> I would like to keep a separate file for this, it looks awkward to update the
> driver for any new user platform.
>
> I added a separate symbol to take care of the Modular case of cpufreq-dt. i.e. I
> didn't wanted to add module_exit() code in the new file. Currently, it gets
> included in the kernel even if cpufreq-dt is selected as a Module, so we just
> create the platform-device just once and never touch it again.

Ok, that makes sense.

Regarding new platforms, I'd hope that we could manage to define an extension
to the oppv2 binding that marks a machine as compatible with opp, so we can
just look at that instead of the root compatible string. Your current series
is nice in the way it gets the hack outside of my code, but it would be ideal
if we could avoid propagating it further.

	Arnd
