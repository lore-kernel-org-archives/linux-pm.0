From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH v2 00/11] PM QoS: add a per-device wake-up
 latency constraint class
Date: Wed, 20 Jul 2011 06:22:08 -0700
Message-ID: <20110720132208.GA11968__42612.6951621429$1311168308$gmane$org@gvim.org>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<201107022120.47221.rjw@sisk.pl>
	<CAORVsuVt1cg04T7wKKTeaGHEDs-OEejs7+cuDXpVcCUv7r4_FQ@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAORVsuVt1cg04T7wKKTeaGHEDs-OEejs7+cuDXpVcCUv7r4_FQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 20, 2011 at 11:26:13AM +0200, Jean Pihet wrote:
> Hi Rafael,
> =

> 2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> > Hi,
> >
> > On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> This patch set is in an RFC state, for review and comments.
> >
> > First off, I'm sorry I couldn't review the patchset earlier.
> Thank you very much for reviewing the patches!
> =

> >
> >> In order to implement the new class in PM QoS the following changes ha=
ve been
> >> made:
> >>
> >> 1. Add a new PM QoS class for device wake-up constraints
> >> (PM_QOS_DEV_WAKEUP_LATENCY).
> >> Due to the per-device nature of the new class the constraints lists ar=
e stored
> >> inside the device dev_pm_info struct instead of the internal per-class
> >> constraints lists.
> >> The new class is only available from kernel drivers and so is not expo=
rted to
> >> user space.
> >
> > Have you considered a design in which multiple devices may use the same
> > list of constraints? =A0It seems plausible that the constraints will be=
 the
> > same, for example, for all Ethernet adapters in the system, in which ca=
se it
> > will be wasteful to duplicate the list of constraints for each of them.
> How would the devices be grouped together? Today it looks like the
> network throughput constraints from the device drivers are not used at
> all but rather use the CPU_DMA latency API.

This is a challenge.  Over the pats 2 years I've see basically 2 types of
PM_QoS applications.  Global or subsystem qos requests and local or
device qos requests.

Global are things like use cpu_dma_latency to block C-states or Network
latency to shape traffic into more bursty bundles.  (let the modem
sleep more).

Local are things like a spi modem or camera falls over if the clock gets
gated for more than 400uS during some critical section.

Further there is an API gap in the ability to express things like
Network latency where multiple NIC's are present and you want different
latencies for each NIC.  (note: I can see such a need coming for
multi-core CPUs someday as well.  cpu0 needs to stay hot but the others
can have infinite latency--or something like that)

BTW: I don't have any good ideas for this API gap at this time.

Part of me feels that every "bus" driver should include an implicit
governor infrastructure (like CPU freq or cpu idle, perhaps both one for
throughput and one for latency) and a QoS like list that is taken into
account on Runtime PM operations.  This would be ok for the local users
of pm_qos.


FWIW I think it should be baked into runtime pm.



> >
> >> 2. Added a notification of device insertion/removal from the device PM=
 framework
> >> to PM QoS.
> >> This allows to init/de-init the per-device constraints list upon devic=
e insertion
> >> and removal.
> >> RFC state for comments and review, barely tested
> >
> > I need to have a look at the details, but in principle this means that =
the
> > per-device lists will be usable only after the devices have been regist=
ered.
> > In particular, this means that it will only be possible to add new cons=
traints
> > after registering the device, which may be too late for some use cases.
> Hmm I wonder how to solve this issue. How to manage constraints for a
> non-present (not yet present or already removed) device? The CPU_DMA
> latency constraint API might be used in those cases.

Bus drivers would tend to be always loaded so such constraints could be
pre-registered there.


--mark


> >
> >> 3. Make the pm_qos_add_request API more generic by using a
> >> struct pm_qos_parameters parameter. This allows easy extension in the =
future.
> >>
> >> 4. Upon a change of the strongest constraint in the PM_QOS_DEV_WAKEUP_=
LATENCY
> >> class a notification chain mechanism is used to take action on the sys=
tem.
> >> This is the proposed way to have PM QoS and the platform dependant cod=
e to
> >> interact with each other, cf. 4 below.
> >
> > I guess you mean 5.?
> Yes
> =

> >
> > I think we will need something in addition to the notifier here. =A0For=
 example,
> > I wouldn't like any core code, like runtime PM or cpuidle, to have to r=
egister
> > a notifier with PM QoS.
> I am not following this. Can you elaborate a bit?
> =

> >
> >> The notification mechanism now passes the constraint request struct pt=
r in
> >> order for the notifier callback to have access to the full set of cons=
traint
> >> data, e.g. the struct device ptr.
> >>
> >> 5. cpuidle interaction with the OMAP3 cpuidle handler
> >> Since cpuidle is a CPU centric framework it decides the MPU next power=
 state
> >> based on the MPU exit_latency and target_residency figures.
> >>
> >> The rest of the power domains get their next power state programmed fr=
om
> >> the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework, via the d=
evice
> >> wake-up latency constraints.
> >>
> >> Note: the exit_latency and target_residency figures of the MPU include=
 the MPU
> >> itself and the peripherals needed for the MPU to execute instructions =
(e.g.
> >> main memory, caches, IRQ controller, MMU etc).
> >> Some of those peripherals can belong to other power domains than the M=
PU
> >> subsystem and so the corresponding latencies must be included in those=
 figures.
> >>
> >> 6. Update the pm_qos_add_request callers to the generic API
> >>
> >> 7. Minor clean-ups and rename of struct fields
> >>
> >> Questions:
> >> 1. How to retrieve the device ptr from a given device driver in order =
to add
> >> a constraint on it?
> >> 2. The device struct has recently been extended with the power domain
> >> information. Can this be used to apply the constraints on power domain=
s?
> >
> > Yes, it can in principle, but that will require some work.
> >
> >> On-going developments, patches in preparation:
> >> 1. write Documentation for the new PM QoS class
> >
> > I'd wait with that until the code has settled.
> Ok that was the intention to write the doc once for good.
> =

> >
> >> 2. validate the constraints framework on OMAP4 HW (done on OMAP3)
> >> 3. refine the power domains wake-up latency and the cpuidle figures
> >>
> >> Based on the master branch of the linux-omap git tree (3.0.0-rc3). Com=
pile
> >> tested using OMAP and x86 generic defconfigs.
> >> Tested on OMAP3 Beagleboard (ES2.x) with full RETention and OFF modes.
> >
> > More detailed comments will follow.
> >
> > Thanks,
> > Rafael
> >
> =

> Thanks a lot,
> Jean
