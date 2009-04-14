From: Patrick Bellasi <derkling@gmail.com>
Subject: Re: Adding PM QoS parameters
Date: Tue, 14 Apr 2009 12:24:20 +0000 (UTC)
Message-ID: <loom.20090414T111905-377@post.gmane.org>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
	<20090406211237.GA25173@linux.intel.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC7972A5@dbde02.ent.ti.com>
	<20090409185738.GA26224@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

mark gross <mgross <at> linux.intel.com> writes:
 
> I can see that more parameters would make sense.  Can you come up with
> a set of abstractions that have a chance of being portable?

Hi,
   we are a group that since some months is working on "Constrained Power
Management" in STMicroelectronics. 

> > [sp] Here is rough outline
> > 
> >      Initialize the QoS array (with room to extend) as:
> > 
> >     static struct pm_qos_object *pm_qos_array[] = {
> >         &null_pm_qos,
> >         &cpu_dma_pm_qos,
> >         &network_lat_pm_qos,
> >         &network_throughput_pm_qos
> >         &null_pm_qos,
> >         &null_pm_qos,
> >         &null_pm_qos,
> >         &null_pm_qos,
> >         &null_pm_qos,
> >     };
> > 
> >      Assuming there is an API to add objects to this array, one
> >      could define additional param as:
> >
> 
> nah, If this is where we need to go, then I would change the array to a
> list and make it possible to add new parameters at runtime.
> 
> Note: this is how I originally implemented it but changed it to a
> compile time array to force LKML review of new parameters.  The worry
> was that driver writers would just add whatever qos param they wanted
> and we would loose on a consistent or stable ABI the user mode clients
> of the interface could expect.

I think that a good trade-off between "LKML control on new parameters" and
"platform extensibility" is hard to identify if we don't refine the concept of
QoS parameters first.
The QoS params defined by pm_qos should avoid to be not-sufficiently general,
to be really useful to applications, but also avoid to be too much abstract to
support platform-specific capabilities.
Since anyway the core pm_qos implementation is sufficiently general to handle
both abstract and platform-specific params, maybe we should better distinguish
among "abstract qos parameters" (AQP) and "platform-specific qos parameters"
PQP).

AQP should be intended to be used by applications to assert abstract
requirements on system behaviors, while PQP can be added by platform code in
order to enable the "constrained power management paradigm" for
architecture/board specific devices.

In this hypothesis the better solution would be to use a dynamic data structure
that will be initialized by the core itself to contain just the set of AQP that
has been reviewed and approved by LKML.
Platform code will then have the chance to add its own specific parameters too.

Moreover we could imagine that AQP will be exported to user-land, in order to
be asserted by application software, while PQP may be hidden within the core
and accessible only by platform drivers.


> Can we identify something that maps to voltage level that would have a
> chance at being portable to non-omap?  Higher level abstractions are
> more attractive.

I agree: user-land accessible params should be platform-independent and define
a portable API for applications.
This requires also to have sufficiently abstract parameters: e.g. network
bandwidth can be easily asserted by an application while cpu-dma-latency is
perhaps too difficult to identify at application level.

> I'm having conflicting feelings on voltage as a QoS quantity, but I
> totally see the utility of using the PM-QOS infrastructure to provide a
> constraint framework on power domains. We may need to investigate this
> more.

In the view I've depicted before: voltages can be eventually defined as PQP
and be used only by platform device drivers while being hidden to userspace.
In this case they could still exploit pm_qos core capabilities.

> Right now adding new parameters is easy (other than dealing with LKML
> questioning your choices for names and meanings)  To me you bring up 2
> issues:
> 
> 1) adding a voltage pm-qos parameter for omap power domains

In my opinion this is reasonable only if we keep PQP (Platform-specific QoS
Parameters) hidden from userspace by distinguishing them from AQP (Abstract
QoS Parameters) which instead are sufficiently general and community approved.

> 2) is it the right thing to keep pm-qos-params a compile time array and
> control the growth of the ABI via these mailing lists or make it a list
> and enable driver creation of new parameters as they wish.

In my opinion a mixed approach, using a dynamic data structure, could be more
interesting to target both requirements.

> Both are good things for us to discuss on the list.

We are tuned on this thread and happy to contribute to the discussion.

Best regards,
Patrick

-- 
#include <best/regards.h>

DERKLING

<-------------------------------------------------------------------------->
  Patrick Bellasi <bellasi at elet dot polimi dot it>
  PhD student at Politecnico di Milano
 
  Privacy:
   - GnuPG     0x72ABC1EE (keyserver.linux.it)
      pub      1024D/72ABC1EE 2003-12-04
      Key fingerprint = 3958 7B5F 36EC D1F8 C752
                               9589 C3B7 FD49 72AB C1EE
<-------------------------------------------------------------------------->
