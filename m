From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/6] cpufreq: governor: New data type for management part
 of dbs_data
Date: Fri, 4 Mar 2016 11:19:24 +0530
Message-ID: <20160304054924.GB27109@vireshk-i7>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <3567040.O8oI5B24Ng@vostro.rjw.lan>
 <20160303055359.GI2891@vireshk-i7>
 <CAJZ5v0iq52nSHH7L_zhr1mWiCFyAGQsZvKFg4Aifvw8gj_AQ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35517 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcCDFth (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 00:49:37 -0500
Received: by mail-pf0-f179.google.com with SMTP id x188so5443826pfb.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Mar 2016 21:49:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iq52nSHH7L_zhr1mWiCFyAGQsZvKFg4Aifvw8gj_AQ+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On 03-03-16, 20:26, Rafael J. Wysocki wrote:
> So this is a totally bicycle shed discussion argument which makes it
> seriously irritating.
> 
> Does it really matter so much how this structure is called?
> Essentially, it is something to build your tunables structure around
> and you can treat it as a counterpart of a C++ abstract class.  So the
> name *does* make sense in that context.

:(

I thought you will apply this patch to linux-next *now*, as it was quite
independent and so gave such comment.

> That said, what about gov_attr_set?

Maybe just gov_kobj or whatever you wish. 

-- 
viresh
