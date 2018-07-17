From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with
 pcc-cpufreq
Date: Tue, 17 Jul 2018 11:36:20 +0200
Message-ID: <20180717093620.ym6phfmr3rfvsxyo@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com>
 <20180717085039.kqxwbkgruhj5qxtx@suselix>
 <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
 <20180717091152.l4ixicbp6imvqtsr@suselix>
 <CAJZ5v0hu6d26Qu1d-NRoO8RXic2ooTEfXzcmJyRGPSOsH6OznA@mail.gmail.com>
 <20180717092721.onkaf3qsu7te6syi@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180717092721.onkaf3qsu7te6syi@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > >>
> > >> [cut]
> > >>
> > >> >
> > >> > On balance before this commit users could use pcc-cpufreq but had
> > >> > already suboptimal performance (compared to say intel_pstate driver
> > >> > which can be used changing BIOS options).
> > >>
> > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
> > >
> > > I think this is because of (in intel_pstate_init()):
> > >
> > >         /*
> > >          * The Intel pstate driver will be ignored if the platform
> > >          * firmware has its own power management modes.
> > >          */
> > >         if (intel_pstate_platform_pwr_mgmt_exists())
> > >                 return -ENODEV;
> > >
> > 
> > OK, because of the "Proliant" entry, right?
> > 
> > So it looks like we have an issue there.  We find the entry and we
> > look for _PSS.  It is not there, so we assume that the firmware is
> > expected to control performance, which is not the case.

FYI, there is another BIOS setting on those systems. It's called
"Collaborative Power Control" (AFAIK enabled by default).

Only if this is disabled, firmware is (alone) in control of
performance. (And of course in this case neither pcc-cpufreq nor
intel_pstate will be loaded).

> > It looks like we also should look for the presence of the PCC
> > interface in there.
> >
> > I can provide a patch for that, will you be able to test it?
> 
> Yes, I can test it.
> 
> > >> It should be initialized before pcc-cpufreq (according to their
> > >> respective initcall levels), so in theory intel_pstate should be used
> > >> by default on the affected systems anyway.
> > >
> > >> What BIOS settings need to be changed for that?
> > >
> > > Already answered in other mail.
> > 
> > Indeed.
> 
> 
> Andreas
> 
