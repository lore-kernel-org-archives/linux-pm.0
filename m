From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH 1/1] cpufreq: pcc-cpufreq: Re-introduce deadband effect
 to reduce number of frequency changes
Date: Thu, 22 Sep 2016 19:54:48 +0200
Message-ID: <20160922175448.GA25183@suselix.suse.de>
References: <20160819121814.GA17296@suselix.suse.de>
 <20160819122101.GB17296@suselix.suse.de>
 <20160829060153.GA5094@vireshk-i7>
 <20160901132140.GA10183@suselix.suse.de>
 <20160907050201.GK27345@vireshk-i7>
 <20160916094727.GA4026@suselix>
 <fecb55b0-63ed-1d11-d85b-16cc73f2010b@semaphore.gr>
 <CADmjqpNE9f7fzQjWsHKB4wEjLq-4ZvQpaC314OcLdQ-i_TAABg@mail.gmail.com>
 <20160919161611.GB17693@suselix.suse.de>
 <CADmjqpOuXnri2MdJyvGVgkJ0tsbDMb7Q1O=x65-7OHGWwViOJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:34231 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034388AbcIVRzS (ORCPT
        <rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
        Thu, 22 Sep 2016 13:55:18 -0400
Content-Disposition: inline
In-Reply-To: <CADmjqpOuXnri2MdJyvGVgkJ0tsbDMb7Q1O=x65-7OHGWwViOJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <skarafotis@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, Thomas Renninger <trenn@suse.com>

On Mon, Sep 19, 2016 at 10:39:18PM +0300, Stratos Karafotis wrote:
> On Mon, Sep 19, 2016 at 7:16 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > On Fri, Sep 16, 2016 at 09:58:42PM +0300, Stratos Karafotis wrote:
> >> Hi,
> >>
> >> [ I 'm resending this message, because I think some recipients didn't receive
> >> it. ]
> >>
> >> On 16/09/2016 12:47 μμ, Andreas Herrmann wrote:
> >> > On Wed, Sep 07, 2016 at 10:32:01AM +0530, Viresh Kumar wrote:
> >> >> On 01-09-16, 15:21, Andreas Herrmann wrote:
> >> >>> On Mon, Aug 29, 2016 at 11:31:53AM +0530, Viresh Kumar wrote:

  ---8<---

> >> > It seems that the decision how to best map load values to target
> >> > frequencies is kind of hardware specific.
> >> >
> >> > Maybe a solution to this is that the cpufreq driver should be able to
> >> > provide a mapping function to overwrite the current default
> >> > calculation.

FYI, I've created new patches to address the issue.

First one will be to introduce a map_load_to_freq function. The
default being what commit 6393d6 introduced (no deadband).  Second
patch will than introduce a specific function for pcc-cpufreq to fall
back to what was used before commit 6393d6.

I just want to assemble gathered performance data and I am planning to
send those patches tomorrow.

> >> I'm not familiar with ppc-cpufreq drive but maybe patch 6393d6 just
> >> uncovered an "issue" that was already existed but only on higher loads.
> >>
> >> Because, with or without patch 6393d6, if the specific CPU doesn't
> >> use a frequency table, there will many frequency transitions in
> >> higher loads too. I believe, though, that the side effect it's smaller
> >> in higher frequencies because CPUs tend to work on lowest and highest
> >> frequencies.
> >
> > Might be. I didn't test this specifically.

Hopefully I'll also find time to gather some ftrace data wrt this.

> >> What about a patch in ppc-cpufreq driver that permits frequency
> >> changes only in specific steps and not in arbitrary values?
> >
> > Which steps would you use? What scheme would be universal usable for
> > all affected system using this driver?
> 
> Just an idea. I would split the frequency range (max_freq - min_freq)
> into ~10 steps. But I'm not familiar with the affected systems and
> of course I can't prove this is an ideal approach.

I've modified the pcc-cpufreq specific map_load_to_freq function to do
just that (map load values to 10 discrete frequency values) instead of
falling back to the deadband (pre-commit-6393d6-version).

Unfortunately this resulted in lower performance compared to
pre-commit-6393d6-version.

> > I had played with an approach to only make use of min_freq and
> > max_freq which eventually didn't result in better performance
> > in comparison to code before commit 6393d6.
> 
> Regards,
> Stratos


Regards,

Andreas
