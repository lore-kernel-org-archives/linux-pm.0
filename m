From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] PM / Runtime: Support for generic
	I/O power domains
Date: Wed, 4 May 2011 19:08:25 +0200
Message-ID: <201105041908.26070.rjw__23901.1202044368$1304528969$gmane$org@sisk.pl>
References: <201104290154.12966.rjw@sisk.pl> <201104292211.03702.rjw@sisk.pl>
	<BANLkTimbUQ9-U9yPkCspf=dL0JfyXqbSng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimbUQ9-U9yPkCspf=dL0JfyXqbSng@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 04, 2011, MyungJoo Ham wrote:
> On Sat, Apr 30, 2011 at 5:11 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > Well, not really.  There are a few things to consider.
> >
> > First, in general, there may be devices that have a real parent and belong
> > to a power domain at the same time, so we can't "steal" the parent
> > pointers from them.
> 
> Ah. right we only have one parent per device. Ok, setting a power
> domain as a device's parent is not going to work for some devices.
> 
> 
> However, I have some other questions.
> 
> 1. pm_genpd_runtime_suspend and pm_genpd_runtime_resume are opened to
> outside (not static and "extern"ed). Are devices supposed to call
> pm_genpd_runtime_* directly?

I suppose you mean drivers.  No, they aren't.

> Shouldn't they be hidden so that devices
> are forced to turn on/off power domains with runtime_pm framework
> only? Is there any reason to expose them?

I thought some subsystems might bypass pm_genpd_init() and use their own
initialization, in which case the extern definitions would be useful.

That said, they aren't necessary at the moment, so I'll make them static
in the final version of the patch.

> 2.  If we can assure that related clocks are not turned on when a
> power domain is shutting down, it'd be nice.

If you look at the shmobile patch at
https://patchwork.kernel.org/patch/742932/
you'll see that it uses the ->stop_device() and ->start_device()
callbacks for this purpose.

> I guess it would be sufficient to let it "WARN" at
> gov->power_down_ok().

Sure, you can do that too.

> Is it the intention of governor?

No, the intention of the governor is to make it possible to take
for example, latencies, into account when deciding whether or not to
power down the domain.  In short, my idea is that the governor will
have information on how much time it's going to take to power down
and resume the power domain (along with all devices) and, on the other hand,
what maximum wakeup latency is acceptable for the given power domain.
It will compare the two numbers and return "true" if the second one is
greater, for example.  That said, I don't have a clean use case at the moment,
so that's more of a future stub than something necessary right now.

> Thank you! I also think this is going to help us a lot, too :)

Good to hear that. :-)

Thanks,
Rafael
