From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating cpufreq table
Date: Tue, 25 Nov 2014 21:47:40 +0100
Message-ID: <1620245.pJZHDc87Jv@vostro.rjw.lan>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org> <20141125014435.GA28906@developer> <CAKohpomFOJWc4C9rWbCmcW7e1kUO=C=awO9RFvBVA0-H2dHjZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57728 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750812AbaKYU00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 15:26:26 -0500
In-Reply-To: <CAKohpomFOJWc4C9rWbCmcW7e1kUO=C=awO9RFvBVA0-H2dHjZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On Tuesday, November 25, 2014 08:56:00 PM Viresh Kumar wrote:
> On 25 November 2014 at 07:14, Eduardo Valentin <edubezval@gmail.com> wrote:
> > You are right! I got confused because even with your patch, the
> > sequencing is not working. Looking to that behavior I, somehow, thought
> > the _init function in cpufreq-dt was about init() calls. But in fact, it
> > is driver initialization callback.
> 
> :)
> 
> > However, by the time of ->init() the cpufreq_driver is not really ready.
> 
> I agree.
> 
> > Or at least, the cpufreq layer is not ready. A call to
> >
> > cpufreq_frequency_get_table()
> >
> > for instance, it is not working.
> 
> I know the story you pasted here :)
> 
> > The cpufreq-dt would need to add the of based cpufreq cooling only when
> > cpufreq layer is ready. Any other better cpufreq driver callback to add
> > the cpu cooling?
> 
> There is nothing as of now atleast.
> 
> > We could sort this out by polling in thermal layer for the cpufreq table
> > until it gets ready, but I believe that would be a dirty hack.
> 
> Yeah. Probably we can add a notifier for cpufreq-driver addition/removal.
> That's the best we can do I believe.

Can we please avoid adding any new notifiers?

We can add a new cpufreq driver callback to be invoked by the core when
everything has been set up for this purpose.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
