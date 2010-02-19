From: "Ai Li" <aili@codeaurora.org>
Subject: Re: platform specific pm_qos parameters
Date: Thu, 18 Feb 2010 18:37:27 -0700
Message-ID: <000301cab104$18622070$49266150$@org>
References: <000601ca804d$ce010190$6a0304b0$@org>	<20091223162348.GA16543@mgross-laptop>
	<000901ca9003$2a8dd400$7fa97c00$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <000901ca9003$2a8dd400$7fa97c00$@org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: '640E9920' <640e9920@gmail.com>, mgross@linux.intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I haven't seen any further discussion in this thread.  Are people
still interested in the topic?

linux-pm archive seems to have chopped off a part of my reply from
earlier.  I'm including it below in case interested folks did not see
the entire email.
 
~Ai

> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-
> pm-bounces@lists.linux-foundation.org] On Behalf Of Ai Li
> Sent: Thursday, January 07, 2010 6:38 PM
> To: '640E9920'
> Cc: linux-pm@lists.linux-foundation.org
> Subject: Re: [linux-pm] platform specific pm_qos parameters
> 
> Apologies for the very late response.
> 
> 
> > My initial reaction is why can't we come up with a good
> > abstraction that would work for the product families?  I think
> > its ok for a pm-qos option to exist but not be used on every
> > architecture.
> 
> Main buses and peripheral buses are possible abstractions.
> However,
> using our shipped devices as a guide, the number of each type of
> buses can vary.  The number of main buses can go from 1 to 2 or
> more.
> (For example, there can be different types of memory in a single
> device and each type of memory sits on a separate main bus.)
> The
> number of peripheral buses can go from 1 to 3 or 4 or more.
> There
> are also a great deal of variations on what hardware blocks are
> connected on what buses.  The interconnection of CPU, memories,
> DSP
> engines, peripheral hardware through the various buses change
> from
> device to device, making practical classification/abstraction of
> the
> buses difficult.
> 
> From a system point of view on power, controlling the bus freq
> is
> also related to controlling freq of various PLLs, clocks, hw
> clocks.
> Because many of them are used by multiple hardware clients and
> drivers, they appear to be good candidates for pm_qos as well.
> Unfortunately for these hw entities, the number and the types of
> hardware instances vary even more across devices.
> 
> One may think that the system/hardware designers have gone
> overboard
> with all the complexities.  Perhaps they have.  But one major
> advantage of the compartmentalization and multi-levels is that
> unused
> or under-used entities can be turned off or turned down, saving
> more
> power.
> 
> Some of our devices on the market do not run Linux.  Some others
> run
> Linux but only use pm_qos in a limited fashion, for example,
> CPU_DMA_LATENCY.  We hope to collaborate with the community to
> extend
> pm_qos, enabling power control in a better, smarter way.
> 
> Abstraction is more preferable.  Good abstractions that make
> sense
> across a wide variety of architectures and platforms, i.e. x86,
> arm,
> powerpc, however require lots of knowledge and insights.  With
> limited participation and inputs from arch/platform folks, the
> top-down approach seems problematic.
> 
> Adding platform-specific parameters enables a bottom-up
> approach,
> where archs/platforms can first come up with parameters that are
> relevant to their targets.  As more people uses pm_qos and
> various
> parameters gets incorporated, it can become easier to spot
> common
> ones and to make them platform independent.  Given Linux's
> distributed development style, the bottom-up approach may work
> better.
> 
> 
> > > I haven't seen much discussion recently on platform specific
> > > pm_qos_params.  Are people still open to the idea?  I also
> > would like
> > > to help working on it.
> >
> > I worry that this is the road to hell.
> >
> > If the platform specific pm-qos parameter is accessed by any
> > platform independent driver code then its a big failure and
> > leads to code that will give me a rash to look at.
> 
> Not sure that it is a big failure.  The guarantee from pm_qos
> framework has always been best-effort.  If a specific QoS
> parameter
> does not exist, the caller can see that from an error return
> code
> during add_request and compensate in some fashion.  Or, pm_qos
> framework can return a "no-op" pm_qos handle.  The handle can be
> a
> singleton handle that does nothing with the update requests.  In
> other words, drivers and other code can always request a QoS
> value,
> but there is no guarantee that anything will be done to honor it
> unless a platform actively provide back-end support for the QoS
> parameter.  I think the behavior would be consistent with that
> of the
> existing pm_qos framework; on arch/platforms where no code has
> registered with the pm_qos notifier chain or used
> pm_qos_requirement,
> the QoS values are not acted upon.
> 
> 
> >
> > So one requirement for platform specific pm-qos parameters I
> > have is that such parameters shall only be accessible from
> > platform specific code and not from any platform independent
> > stuff.  (I don't think this is possible in C, so I'll need
> more
> > convincing to not block this idea.)
> >
> > I welcome help coming up with good pm-qos abstractions for the
> > multiple bus bandwidth problem above.  Having a nice
> discussion
> > about the problem space would be good start, then we can
> propose
> > some possible abstractions and prototype some implementations.
> >
> > It also is important to provide some application specific
> > motivation as to why the buses you are calling out can not
> self
> > throttle without causing issues.  I once had a graphics bus
> > example in mind but I've been told that graphics drivers have
> > the data needed to do effective throttling and they already do
> > so.  Therefore I shouldn't bother with such parameters.
> >
> > I don't know if I believe that but I don't feel like arguing
> > with graphics experts too much on the matter without a
> specific
> > application where the need for such a parameter could be used.
> > i.e. I need a graphics driver author or graphics Si vendor to
> > step up and tell us they could do a lot better with power if a
> > pm-qos parameter for graphics bus bandwidth existed.
> >
> > So do you see my issue?
> 
> I understand.  Using our shipped devices as an example, graphics
> hardware shares the bus with other hardware blocks.  The
> freq/bandwidth of the bus can be adjusted to accommodate needs
> from
> all the hardware blocks.  When the bus is running out of
> bandwidth at
> its current freq to satisfy the graphics hardware, the graphics
> driver can throttle its need.  Alternatively the driver can
> pre-request its QoS so that the bus freq is fast enough for the
> graphics hardware.  Looking at it from an opposite direction, if
> there is no QoS request on the bus, the bus driver can lower the
> bus
> freq to save power, knowing that it is not ruining any graphics
> performance.  I'm not suggesting we add a graphics bus QoS, just
> to
> convey that QoS parameters are useful on shared entities, like
> buses,
> clocks, etc.
> 
> 
> >
> > I hope I'm not scaring you off.  I want to do more with pm-qos
> > but it takes collaboration to make it happen.  Today, I feel
> > adding platform specific PM-QOS would put off solving the
> > problems by enabling device specific parameters that would be
> > forever out of tree and delay the collaboration needed to move
> > forward.
> >
> > --mgross
> 
> I'm hoping platform specific pm_qos will encourage collaboration
> on
> multiple levels: core folks, arch folks, platform folks, device
> folks, etc.  At first, various new parameters may show up in
> arch
> trees, platform trees, or device trees.  But as common QoS
> parameters
> are found, they can be migrated to the main tree.
> 
> The idea of QoS aggregation in pm_qos is very powerful.  IMO, it
> would be beneficial to apply it not only to platform-independent
> QoS
> but also to platform-specific QoS.
> 
> ~Ai
> 
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
