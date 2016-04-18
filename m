From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Mon, 18 Apr 2016 23:00:46 +0200
Message-ID: <5357210.7C6VxI046A@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <CAL_JsqK2oAX2jw6GjT7RUWkhL2zPB9=QUQ--S2u-1t852GG7VQ@mail.gmail.com> <20160407083036.GB3201@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51633 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbcDRVBS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 17:01:18 -0400
In-Reply-To: <20160407083036.GB3201@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robherring2@gmail.com>, Rob Herring <rob.herring@linaro.org>, Krzysztof =?utf-8?B?S296xYJvd3NraQ==?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Matthew McClintock <mmcclint@codeaurora.org>, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mason <slash.tmp@free.fr>

On Thursday 07 April 2016 14:00:36 Viresh Kumar wrote:
> On 01-04-16, 09:15, Rob Herring wrote:
> > On Fri, Apr 1, 2016 at 5:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > >
> > >
> > > And the cpufreq-dt driver can match /cpus node's compatible string against
> > > "operating-points-v2" and create a device at runtime ?
> > >
> > > @Rob: Will that be acceptable to you? We are discussing (again) about how to
> > > probe cpufreq-dt driver automatically for platforms 
> > 
> > No, I don't think that belongs in /cpus.
> > 
> > Part of the problem is this requires a DT change if you switch between
> > a platform-specific driver and generic driver.
> 
> Right.

How likely is that to happen for future platforms though?

I'd rather see a whitelist for the existing platforms (as started
by Viresh), because we don't know what other out-of-tree platforms 
use the "operating-points-v2" binding that are in fact not compatible
with today's driver.

If we add one way to identify machines that are known to follow
the binding to the degree necessary to make them work with the
Linux driver (whatever way that would be), then the only remaining
worry is about machines suddenly breaking because of a change in
the Linux driver, and we can work around that in the kernel if
necessary (or revert whatever broke the platform).

> > I don't understand the issue having a little bit of code to parse the
> > DT and create the device.
> 
> I am fine with that, we were just re-evaluating our options 
> 
> > If you are worried about having a long list
> > of platforms,
> 
> At least I am not.

The length of the list is not the issue here, it's the requirement
to edit the list for each new SoC that gets added. That causes conflicts
and constant churn.

> > you could instead check the tree for operating-points-v2
> > property in the cpu node and create the device unless the platform is
> > black-listed.
> 
> I don't really like the black-list idea much. It forces a Non
> cpufreq-dt platform to edit cpufreq-dt related file, just to make its
> own cpufreq driver work.
> 
> I find that ugly somehow 

Agreed.

Sorry for the late reply, I'm still catching up with email from two
weeks of travelling.

	Arnd
