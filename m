From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 17:54:57 +0530
Message-ID: <CAKohpo=ABkc3ku=YrS7=Df_65s3OPg+eAa80gCEkiK4dNc+x4g@mail.gmail.com>
References: <20130204165057.GH13909@pd.tnic>
	<CAOh2x==fyfYwz+eXmPhBJTE+_q_fHyx2drXrM789XvCfEqPBUQ@mail.gmail.com>
	<20130205091532.GA4827@pd.tnic>
	<CAKohpo=6q+Bcgq0Re=3SXM6zwub5N=vJBO=sTeEgZZ9byFK7=g@mail.gmail.com>
	<20130205102721.GB4827@pd.tnic>
	<CAKohpo=_Qq-_Aqy7nZD+f28-B7DY8ioQ5fe8bYKTe64A0RXeGw@mail.gmail.com>
	<20130205110407.GC4827@pd.tnic>
	<CAKohponiiVO_P2EDDTUHeoo7j3FG-ELtP8oLwfdEQ3HkgOS77g@mail.gmail.com>
	<20130205111918.GD4827@pd.tnic>
	<CAKohpomUsDr0YJmOxjymcAAJnfOxKfzxGL4iHuif1qCAvy0OYA@mail.gmail.com>
	<20130205113242.GF4827@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34316 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab3BEMY5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 07:24:57 -0500
Received: by mail-oa0-f46.google.com with SMTP id k1so73253oag.19
        for <linux-pm@vger.kernel.org>; Tue, 05 Feb 2013 04:24:57 -0800 (PST)
In-Reply-To: <20130205113242.GF4827@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 5 February 2013 17:02, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Feb 05, 2013 at 04:56:03PM +0530, Viresh Kumar wrote:
>> Just some kind of indication from platform driver is required about
>> how/where it wants its governor directory to be present.
>
> The indication is this:
>
> config CPUFREQ_PLATFORM_DRIVER_X
>         ...
>         select CPUFREQ_MULTIPLE_POLICIES
>
> You really need to slow down and really look at what I'm proposing.

This indication isn't enough. On a single image solution, we need to
identify the system which needs support for multiple policies and
i still feel we need that variable type indication :)
