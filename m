From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/2] cpufreq: Sort policy->freq_table
Date: Thu, 16 Jun 2016 21:47:39 +0530
Message-ID: <20160616161739.GB24612@vireshk-i7>
References: <cover.1465295033.git.viresh.kumar@linaro.org>
 <27658050.4ol4GjkJ1n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <27658050.4ol4GjkJ1n@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org
List-Id: linux-pm@vger.kernel.org

On 08-06-16, 02:19, Rafael J. Wysocki wrote:
> On Tuesday, June 07, 2016 03:55:13 PM Viresh Kumar wrote:
> > Hi Rafael,
> > 
> > I have spent some more time on this stuff and finally came out with a
> > very simple solution. I hope you will like it more than the previous
> > versions.
> > 
> > Instead of trying to sort the freq-table passed by the drivers, which
> > was complicated and would have broken some drivers for sure, this patch
> > just checks if the freq-table is sorted or not.
> > 
> > If it is sorted, then we just use a different set of helpers for it. The
> > table can be sorted in both ascending and descending orders now and
> > helpers are present for both the cases.
> 
> Well, that's something I was thinking about from the start. :-)
> 
> > All the patches are pushed here for testing in case anyone wants to try:
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/sorted-freq-table
> > 
> > V3->V4:
> > - Written from scratch really, completely different approach.
> 
> I'll look at the code later this week.

Hi Rafael,

Did you get a chance to look at these? Steve may be blocked on this :)

-- 
viresh
