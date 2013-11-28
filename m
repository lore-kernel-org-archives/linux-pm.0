From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Make sure CPU is running on a freq from freq-table
Date: Thu, 28 Nov 2013 21:31:53 +0100
Message-ID: <1591147.c0NqbMglPZ@vostro.rjw.lan>
References: <046513da96dfec919a1a41d270c167147d4a9c8d.1385353358.git.viresh.kumar@linaro.org> <2065797.S0ijuuXCoe@vostro.rjw.lan> <CAKohpomDu0Xh8Q1PEo3n+JwE26GkJTxhdezGPs7aJwJXjaTvLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54138 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753913Ab3K1UTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2013 15:19:02 -0500
In-Reply-To: <CAKohpomDu0Xh8Q1PEo3n+JwE26GkJTxhdezGPs7aJwJXjaTvLQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Carlos Hernandez <ceh@ti.com>

On Thursday, November 28, 2013 07:44:02 PM Viresh Kumar wrote:
> On 28 November 2013 19:42, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, November 28, 2013 07:11:17 PM Viresh Kumar wrote:
> >> Okay.. So wouldn't it be better that we add this special flag only when we
> >> face a real problem? Otherwise this flag might stay unused for long time
> >> and then we might end up removing it..
> 
> What about this one?

Well, so are you saying that the problem is only theoretical now?

> > SKIP_INITIAL_FREQUENCY_CHECK ?
> 
> Looks fine.. In case this is required, you want this to be set initially for any
> driver?

That depends on what is less work and code churn.  How many platforms/drivers
have this problem today?  Which ones are they?

Rafael

