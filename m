From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Fri, 03 Jun 2016 03:43:11 +0200
Message-ID: <2735911.VQvHH3XKf9@vostro.rjw.lan>
References: <cover.1464876460.git.viresh.kumar@linaro.org> <CAJZ5v0h23n7k66fRdmARXStOYFVTpVSQQVa1bN3YixehG=eD4w@mail.gmail.com> <20160603000134.GS3725@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41581 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750926AbcFCBjT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 21:39:19 -0400
In-Reply-To: <20160603000134.GS3725@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Steven Miao <realmz6@gmail.com>, Steve Muckle <steve.muckle@linaro.org>

On Friday, June 03, 2016 05:31:34 AM Viresh Kumar wrote:
> On 02-06-16, 22:35, Rafael J. Wysocki wrote:
> > Quoting from this very cover letter "This change allows us to remove
> > the (duplicate) sorted-freq-table, which
> > was added by following series:", so why to add it in the first place?
> 
> Okay, that's fine.
> 
> > Besides, there already is a number of tables (per policy which in some
> > important cases pretty much means per CPU) in cpufreq that contain
> > more-or-less the same information.  For example, if acpi-cpufreq is in
> > use, the ACPI layer has a table coming from _PSS, the driver creates
> > freq_table to pass to the core and there is an additional one for the
> > stats.  And your series adds one more just so it is ordered.  Come on.
> 
> Of course.
> 
> > If you want to clean that up, fine, but please don't do that in a
> > hurry.  Let's talk about it a bit more without sending any more
> > patches in that area for the time being.
> 
> Okay, I will send all the fixes that you can apply cleanly now in a
> separate set.

Thanks!

> So, yeah, I get your overall concern. What about this:
> - A single patchset to make sure the current policy->freq_table is
>   always sorted in Ascending order of frequencies.

Be careful here.  acpi-cpufreq sorts the table in the descending order
and at least acpi_cpufreq_fast_switch() assumes that.

> - And this sorting will be done per policy only when the policy is
>   first created.
> - Which would eventually mean merging this series with the [v2 0/2]
>   one.
> 
> Will that work ?

Well, it may. :-)

I would like you to talk to Steve and agree on the approach, including which
changes to make first, though.  You are both from Linaro after all ...

Thanks,
Rafael

