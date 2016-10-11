From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH v2 1/2] cpufreq/ondemand: Introduce op to customize
 mapping of load to frequency
Date: Tue, 11 Oct 2016 08:30:05 +0200
Message-ID: <20161011063005.GB4102@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160923165632.GA9786@suselix.suse.de>
 <20160923170256.GB9786@suselix.suse.de>
 <20161005040118.GJ4664@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:36179 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJKGa3 (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Tue, 11 Oct 2016 02:30:29 -0400
Content-Disposition: inline
In-Reply-To: <20161005040118.GJ4664@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On Wed, Oct 05, 2016 at 09:31:18AM +0530, Viresh Kumar wrote:
> On 23-09-16, 19:02, Andreas Herrmann wrote:
> > Introduce op for ondemand governor that is used to map load to
> > frequency. It allows a cpufreq driver to provide a specific mapping
> > function if the generic function is not optimal for the driver.
> > 
> > Performance results (kernel compile with different number of jobs)
> > based on 4.8.0-rc7 (with and w/o my patches on top) from
> > an HP ProLiant DL580 Gen8 system using pcc-cpufreq:
> >  - Intel(R) Xeon(R) CPU E7-4890 v2 @ 2.80GHz
> >  - 60 CPUs, 128GB RAM
> >  
> >                     vanilla                  generic_map_load_to_freq function
> >  # of jobs  user    sys   elapsed   % CPU      user    sys   elapsed   % CPU
> >     2      445.44  110.51  272.99   203.00    445.56  111.22  273.35   203.00
> >     4      444.41  126.20  142.81   399.00    445.61  126.10  143.12   399.00
> >     8      483.04  150.58   82.19   770.40    483.51  150.84   82.17   771.40
> >    16      626.81  185.01   55.00  1475.40    628.01  185.54   55.02  1477.80
> >    32      816.72  204.39   37.26  2740.00    818.58  205.51   37.02  2765.40
> >    64      406.59   51.12   14.04  3257.80    406.22   51.84   13.84  3308.80
> >   120      413.00   48.39   14.36  3211.20    413.61   49.06   14.54  3181.00
> > 
> > Similar tests on another system using acpi_cpufreq didn't show
> > significant performance differences between these two kernel versions.
> > 
> > Link: https://marc.info/?i=20160819121814.GA17296%40suselix.suse.de
> > Signed-off-by: Andreas Herrmann <aherrmann@suse.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.h |  5 +++++
> >  drivers/cpufreq/cpufreq_ondemand.c | 35 ++++++++++++++++++++++++++++++-----
> >  2 files changed, 35 insertions(+), 5 deletions(-)
> 
> NAK.
> 
> If we are absolutely required to hack it in some way, then I would
> prefer your first patchset as the noise was limited to only your
> driver.
> 
> We aren't going to provide such operations from the governors, sorry.

Yep, understandable.


Andreas
