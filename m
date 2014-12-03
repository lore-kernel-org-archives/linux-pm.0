From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Add ability for PXA2xx CPUFreq to be compiled as a module or, not at all
Date: Wed, 03 Dec 2014 03:21:55 +0100
Message-ID: <1732555.JfkHq48zY8@vostro.rjw.lan>
References: <5472AD1E.8010005@tul.cz> <CAOh2x==+amATsYbASxr8D6z5x3UOxySLY_kNXzDvoSB4_tycAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56762 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751293AbaLCCAb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 21:00:31 -0500
In-Reply-To: <CAOh2x==+amATsYbASxr8D6z5x3UOxySLY_kNXzDvoSB4_tycAA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Petr Cvek <petr.cvek@tul.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tuesday, November 25, 2014 04:35:27 PM Viresh Kumar wrote:
> On Mon, Nov 24, 2014 at 9:29 AM, Petr Cvek <petr.cvek@tul.cz> wrote:
> > Add ability for PXA2xx CPUFreq to be compiled as a module or not at all.
> >
> > Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> > ---
> >  drivers/cpufreq/Kconfig.arm | 8 ++++++++
> >  drivers/cpufreq/Makefile    | 3 +--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> Make sure you cc Maintainers to get quick responses.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch queued up for 3.19-rc1, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
