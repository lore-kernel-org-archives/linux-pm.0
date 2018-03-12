From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v3 0/6] sched/cpuidle: Idle loop rework
Date: Mon, 12 Mar 2018 10:28:35 +0100
Message-ID: <6289621.2bafQveClD@aspire.rjw.lan>
References: <2450532.XN8DODrtDf@aspire.rjw.lan> <001801d3b90c$99232600$cb697200$@net> <000c01d3b98d$016eeb10$044cc130$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000c01d3b98d$016eeb10$044cc130$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Rik van Riel' <riel@surriel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, March 12, 2018 12:02:14 AM CET Doug Smythies wrote:
> On 2018.03.11 08:52 Doug Smythies wrote:
> > On 2018.03.11 03:22 Rafael J. Wysocki wrote:
> >> On Sunday, March 11, 2018 8:43:02 AM CET Doug Smythies wrote:
> >>> On 2018.03.10 15:55 Rafael J. Wysocki wrote: 
> >>>> On Saturday, March 10, 2018 5:07:36 PM CET Doug Smythies wrote:
> >>>>> On 2018.03.10 01:00 Rafael J. Wysocki wrote:
> >>>
> >>> ... [snip] ...
> >>> 
> >>>> The information that they often spend more time than a tick
> >>>> period in state 0 in one go *is* relevant, though.
> >>>>
> >>>>
> >>>> That issue can be dealt with in a couple of ways and the patch below is a
> >>>> rather straightforward attempt to do that.  The idea, basically, is to discard
> >>>> the result of governor prediction if the tick has been stopped alread and
> >>>> the predicted idle duration is within the tick range.
> >>>
> >>>> Please try it on top of the v3 and tell me if you see an improvement.
> >>> 
> >>> It seems pretty good so far.
> >>> See a new line added to the previous graph, "rjwv3plus".
> >>> 
> >>> http://fast.smythies.com/rjwv3plus_100.png
> >>
> >> OK, cool!
> >>
> >> Below is a respin of the last patch which also prevents shallow states from
> >> being chosen due to interactivity_req when the tick is stopped.
> >>
> >> You may also add a poll_idle() fix I've just posted:
> >>
> >> https://patchwork.kernel.org/patch/10274595/
> >>
> >> on top of this.  It makes quite a bit of a difference for me. :-)
> >
> > I will add and test, but I already know from testing previous versions
> > of this patch, from Rik van Riel and myself, that the results will be
> > awesome.
> 
> And the results are indeed awesome.
> 
> A four hour 100% load on one CPU test was run, with trace, however
> there is nothing to report, as everything is great.
> 
> The same graph as the last couple of days, with a new line added for
> V3 + the respin of patch 7 of 6 + the poll-idle fix, called rjwv3pp,
> is here:
> 
> http://fast.smythies.com/rjwv3pp_100.png

That looks great, thank you!
