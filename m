From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Fri, 3 Jun 2016 08:41:36 +0530
Message-ID: <20160603031136.GA23467@vireshk-i7>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
 <CAJZ5v0h23n7k66fRdmARXStOYFVTpVSQQVa1bN3YixehG=eD4w@mail.gmail.com>
 <20160603000134.GS3725@vireshk-i7>
 <2735911.VQvHH3XKf9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34143 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcFCDLl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 23:11:41 -0400
Received: by mail-pf0-f176.google.com with SMTP id 62so38646152pfd.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 20:11:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2735911.VQvHH3XKf9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Steven Miao <realmz6@gmail.com>, Steve Muckle <steve.muckle@linaro.org>

On 03-06-16, 03:43, Rafael J. Wysocki wrote:
> On Friday, June 03, 2016 05:31:34 AM Viresh Kumar wrote:
> > So, yeah, I get your overall concern. What about this:
> > - A single patchset to make sure the current policy->freq_table is
> >   always sorted in Ascending order of frequencies.
> 
> Be careful here.  acpi-cpufreq sorts the table in the descending order
> and at least acpi_cpufreq_fast_switch() assumes that.

Yeah, it was already fixed in [V2 0/2] series. Thanks.

> > - And this sorting will be done per policy only when the policy is
> >   first created.
> > - Which would eventually mean merging this series with the [v2 0/2]
> >   one.
> > 
> > Will that work ?
> 
> Well, it may. :-)
> 
> I would like you to talk to Steve and agree on the approach, including which
> changes to make first, though.  You are both from Linaro after all ...

Sure, we can get that done and I am not particular here on whose patches should
get in first. The outcome should be same whatever order we follow :)

Thanks.

-- 
viresh
