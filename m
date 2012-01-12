From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Fri, 13 Jan 2012 00:52:34 +0100
Message-ID: <201201130052.34177.rjw@sisk.pl>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<CAORVsuUgL=5N1s7j3mHTzVgpq5sFO5nkotAZ1PeC=s0GfkWGwA@mail.gmail.com>
	<20120112030642.GD14968@mgross-G62>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120112030642.GD14968@mgross-G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: linux-pm@lists.linux-foundation.org, Antti P Miettinen <amiettinen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 12, 2012, mark gross wrote:
> On Tue, Jan 10, 2012 at 10:02:49PM +0100, Jean Pihet wrote:
> > Hi Mark, Rafael,
> > 
> > On Tue, Jan 10, 2012 at 9:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Tuesday, January 10, 2012, mark gross wrote:
> > >> On Mon, Jan 09, 2012 at 10:27:29PM +0100, Rafael J. Wysocki wrote:
> > >> > On Monday, January 09, 2012, mark gross wrote:
> > >> > > On Sun, Jan 08, 2012 at 11:59:24PM +0100, Rafael J. Wysocki wrote:
> > >> > > > On Friday, January 06, 2012, mark gross wrote:
> > >> > > > > On Fri, Jan 06, 2012 at 02:36:20AM +0200, Antti P Miettinen wrote:
> > >> > > > > > The inspiration for this patch series is the N9 CPU frequency boost
> > >> > > > > > upon input events:
> > >> > > > > >
> > >> > > > > > http://www.spinics.net/lists/cpufreq/msg00667.html
> > >> > > > > >
> > >> > > > > > and the related changes in git://codeaurora.org/kernel/msm.git tree.
> > >> > > > > > Those patches modify the ondemand cpufreq governor. This patch series
> > >> > > > > > adds minimum and maximum CPU frequency as PM QoS parameters and
> > >> > > > > > modifies the cpufreq core to enforce the PM QoS limits. There is also
> > >> > > > > > an example module for boosting the frequency upon input events.
> > >> > > > > >
> > >> > > > > > I've been testing these changes against Ubuntu 3.2 kernel on a Dell
> > >> > > > > > E6420 with the ACPI cpufreq driver. The patches are against
> > >> > > > > > linux-next/master, compile tested against it.
> > >> > > > > >
> > >> > > > > >     --Antti
> > >> > > > > >
> > >> > > > > > Alex Frid (1):
> > >> > > > > >   PM QoS: Simplify PM QoS expansion/merge
> > >> > > > > >
> > >> > > > > > Antti P Miettinen (5):
> > >> > > > > >   PM QoS: Add CPU frequency min/max as PM QoS params
> > >> > > > > >   cpufreq: Export user_policy min/max
> > >> > > > > >   cpufreq: Preserve sysfs min/max request
> > >> > > > > >   cpufreq: Enforce PM QoS min/max limits
> > >> > > > > >   input: CPU frequency booster
> > >> > > > > >
> > >> > > > > >  drivers/cpufreq/cpufreq.c     |   57 +++++++++++++-
> > >> > > > > >  drivers/input/Kconfig         |    9 ++
> > >> > > > > >  drivers/input/Makefile        |    1 +
> > >> > > > > >  drivers/input/input-cfboost.c |  174 +++++++++++++++++++++++++++++++++++++++++
> > >> > > > > >  include/linux/pm_qos.h        |   19 ++++-
> > >> > > > > >  kernel/power/qos.c            |   55 ++++++++++----
> > >> > > > > >  6 files changed, 293 insertions(+), 22 deletions(-)
> > >> > > > > >  create mode 100644 drivers/input/input-cfboost.c
> > >> > > > > >
> > >> > > > >
> > >> > > > > The following is my version of part of this patch set I was tinkering
> > >> > > > > with.  Its missing the cpufreq notification this change has and doesn't
> > >> > > > > do anything WRT cfboost.
> > >> > > > >
> > >> > > > > Would it be ok if we could consolidate our two implementations and
> > >> > > > > completely separate the cfboost stuff as a separate patch set?
> > >> > > > >
> > >> > > > > My code below is missing the cpufreq notification logic you have.
> > >> > > >
> > >> > > > Well, I have one substantial problem with this approach.  Namely, our
> > >> > > > current PM QoS infrastructure is not suitable for throughput constraints,
> > >> > > > because they should be additive, unlike the latency ones.
> > >> > > >
> > >> > > > Namely, if sombody requests throughput X and someone else Y, the resulting
> > >> > > > combined throughput should be X+Y rather than max(X, Y).
> > >> > >
> > >> > > That can be done easy enough.  However; in practice I'm not convinced
> > >> > > doing and additive aggregation of the requested QoS would be any better
> > >> > > than just taking the max.
> > >> >
> > >> > Well, I'd say it's necessary for correctness, perhaps not for the CPU, but in
> > >> > general.  If Y is the max, then the subsystem that requested X may easily
> > >> > starve whoever requested the Y by using all of the bandwidth it asked for.
> > >>
> > >> I was thinking about this from the CPU point of view more over the day.
> > >> Given that there are many times more than one make the qos requests
> > >> additive will result in quickly requesting more cpu than is available
> > >> and waisting a lot of power.   Also additive aggregation falls over a
> > >> bit on with multi-core.
> > >>
> > >> As the consumer of the cpu resources are tasks, and we can only run one
> > >> task at a time on a cpu, I'm talking myself into thinking that max
> > >> *is* the right way to go for cpu throughput (i.e. frequency).
> > There are case where the constraints values should be additive. The
> > best example is the main memory throughput and so the memory
> > controller frequency (or the L3 frequency on OMAP). The main problem
> > is to estimate the overhead of multiple simultaneous transfers.
> > 
> > What do you think?
> 
> I think the number of that get summed in you memory bus example needs to
> be tied to the number of DMA engines + CPU cores that can concurrently
> transfer on that bus.  To sum all the request I think is too simplistic
> and will result in always maxing aggregate request

That still seems to be better than simply using the maximum requested
value.

Thanks,
Rafael
