From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Tue, 5 Feb 2013 16:13:23 +0530
Message-ID: <CAKohpo=_Qq-_Aqy7nZD+f28-B7DY8ioQ5fe8bYKTe64A0RXeGw@mail.gmail.com>
References: <20130204133648.GE13909@pd.tnic>
	<CAKohpo=aLnhM0Op_32ohWZK5eG5nT7iK0OktBe+8ygOQW7zUqQ@mail.gmail.com>
	<20130204140908.GC15452@pd.tnic>
	<CAKohpokowK6ybYd8aDUdfFYsnzoc5VAKsuPSkfxoDqJ3k+FwGA@mail.gmail.com>
	<20130204150511.GF13909@pd.tnic>
	<CAKohpokt0xtsj1eQDMw6JgvQVp4rgFyU-vUrtuuF+0jjOVNHRQ@mail.gmail.com>
	<20130204165057.GH13909@pd.tnic>
	<CAOh2x==fyfYwz+eXmPhBJTE+_q_fHyx2drXrM789XvCfEqPBUQ@mail.gmail.com>
	<20130205091532.GA4827@pd.tnic>
	<CAKohpo=6q+Bcgq0Re=3SXM6zwub5N=vJBO=sTeEgZZ9byFK7=g@mail.gmail.com>
	<20130205102721.GB4827@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:39904 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab3BEKnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Feb 2013 05:43:24 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so7369335obb.28
        for <linux-pm@vger.kernel.org>; Tue, 05 Feb 2013 02:43:23 -0800 (PST)
In-Reply-To: <20130205102721.GB4827@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 5 February 2013 15:57, Borislav Petkov <bp@alien8.de> wrote:
> Are you kidding me? You're simply not reading what I'm saying to you:
> "... should be optional and selectable in Kconfig so that systems which
> don't need that, don't have to see or use it." Because on those systems
> it doesn't apply.
>
> How about we add an x86-specific extension which is a big wad of code
> and is needlessly run on ARM just because it is easier?

There isn't lot of code that we have to keep inside the macro you suggest.
Its just an if else (with single line block), which would give the parent
kobject. Nothing else.

I didn't wanted to create a macro for just that. For me an if/else is not that
big code.

Anyway, if nobody else comes on my side i can create that macro for you.
But, personally i would prefer code without such macros.

--
viresh
