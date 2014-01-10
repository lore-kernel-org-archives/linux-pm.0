From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ARM: SA1100: Create dummy clk_get_rate() to avoid build failures
Date: Fri, 10 Jan 2014 14:36:26 +0100
Message-ID: <9089839.yLLXKZ592H@vostro.rjw.lan>
References: <aaadbfa341a881c8250f2d23bc77062228d2e70b.1389279793.git.viresh.kumar@linaro.org> <CAOesGMgQgOUxbj=0=AYx2pN4mh5HoDcW4p1W89+kvNtXpFmYxA@mail.gmail.com> <CAKohpo=kpyEatDfc8GZ=660sB60co4gSwxCp_brQbm5xhynmyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52480 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751388AbaAJNWf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2014 08:22:35 -0500
In-Reply-To: <CAKohpo=kpyEatDfc8GZ=660sB60co4gSwxCp_brQbm5xhynmyQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Russell King <linux@arm.linux.org.uk>

On Friday, January 10, 2014 07:14:16 AM Viresh Kumar wrote:
> On 9 January 2014 21:56, Olof Johansson <olof@lixom.net> wrote:
> > On Thu, Jan 9, 2014 at 7:08 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> There are some parts of common kernel which would be using routines like
> >> clk_get_rate() on some platforms. Currently these wouldn't be called for SA1100
> >> boards but we need these routines for successful builds of these boards.
> >>
> >> So, this patch creates a dummy clk_get_rate() routine which is being used by
> >> cpufreq core. More dummy routines might be added later if there is a need for
> >> that.
> >>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> >> Reported-by: <Olof Johansson> olof@lixom.net
> >
> > That's not the right format.
> 
> So sorry for that..
> @Rafael: Can you fix this up while applying? Or you want me to send
> this again?

I can (you owe me a beverage of my choice per instance).

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
