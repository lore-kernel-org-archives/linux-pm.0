From: mark gross <mgross@linux.intel.com>
Subject: Re: Adding PM QoS parameters
Date: Mon, 27 Apr 2009 13:46:45 -0700
Message-ID: <20090427204645.GA30787@linux.intel.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
	<20090406211237.GA25173@linux.intel.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC7972A5@dbde02.ent.ti.com>
	<20090409185738.GA26224@linux.intel.com>
	<loom.20090414T111905-377@post.gmane.org>
	<20090415183545.GA3679@linux.intel.com>
	<aa8983610904210108v6490ee58hfa47ef126dca0f7d@mail.gmail.com>
	<20090421234320.GA13911@linux.intel.com>
	<50855c020904270550m3fc3d2aanc2a150715937667f@mail.gmail.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <50855c020904270550m3fc3d2aanc2a150715937667f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matteo Carnevali <rekstorm@gmail.com>
Cc: Patrick Bellasi <derkling@gmail.com>, David Siorpaes <david.siorpaes@st.com>, linux-pm@lists.osdl.org, Premi Sanjeev <premi@ti.com>, Stefano Bosisio <stebosisio@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 27, 2009 at 02:50:22PM +0200, Matteo Carnevali wrote:
> On Wed, Apr 22, 2009 at 1:43 AM, mark gross <mgross@linux.intel.com> wrote:
> 
> > On Tue, Apr 21, 2009 at 10:08:18AM +0200, Derkling wrote:
> > > On Wed, Apr 15, 2009 at 20:35, mark gross <mgross@linux.intel.com>
> > wrote:
> > > > > Hi,
> > > > >    we are a group that since some months is working on "Constrained
> > Power
> > > > > Management" in STMicroelectronics.
> > > >
> >
> 
> Hi, I'm Matteo Carnevali and I'm working in ST with Patrick on the topic of
> CPM.
> 
> 

snip

> >
> > do a thought experiment around network bandwidth, where multiple
> > applications ask for max bandwidth from the NIC.  (just like they all
> > expect to 100% of the CPU resources)  You quickly get to a point where
> > (just like for CPU resources) that aggregating cumulative QoS requests as
> > a sum becomes silly.
> >
> 
> Yes, if many applications all ask for the MAX bandwith from the NIC it is
> not
> relevant to aggregrate in an additive manner... and the problem turns into a
> resource management one.
> 
> On the other hand I think at the case the NIC has multiple operating points,
> 
> defined by the local driver configuration, where each point can be
> characterized,
>  for instance, by a certain amount of power required to work and by a bound
>  of bandwidth it can provide,
> e.g. :
> - 1 watt power consumption -> max 12 Mbit/s
> - 2 watts power consumption -> max 24 Mbit/s
> - 3 watts power consumption -> max 54 Mbit/s (full bandwidth)
> in a dummy scenario like this it may be useful to aggregate bandwidth
> requirement with an additive method, instead of max - min.
> 

I'm not seeing it.  Unless all the applications you are planning to run
"know" what the minimal network bandwidth they require, changing the
aggregation method is deployment specific.
...
um, perhaps adding a mechanism for changing the aggregation method would
be a useful addition to PMQoS?
 



snip

> >
> > Hardware will only get better at being idle, the longer a system can
> > do a low power idle the more likely user mode applications (policy
> > managers mostly) will need API's to modify constraints.
> >
> 
> You're right, but in our ideas we would like to exploit different hardware
> devices' power states (not only the lowest idle state) and to select the
> best
> states (mapped to an operating mode of the device) in each instant, in order
> to
> grant the required performances and to waste as less power as we can.
> 
> So, both drivers and applications can set a constraint on an abstract
> parameter
> (like bandwidth and latency) e.g:
> - Applications: ask for more network bandwidth or require a certain latency
> on a
>  bus, for example to decode a video stream.
> - Drivers: if a driver realizes that it can set its controlled device in a
> less
> consuming operating mode while granting the QoS, it sets a constraint on the
> 
> abstract parameter that maps its operating modes on the whole system.
> 
> At this point of the game, applications' constraints are pushed down at
> drivers'
> level and drivers (that have a deep and complete knowledge of their internal
> 
> state, operating modes and hardware capabilities) "collaborate" to find an
> agreement on the new value of the abstract parameter. In this way the best
> (optimal or sub-optimal) system-wide configuration can be found.
> Collaboration is achieved through shared knowledge of abstract parameters.
>

But, this collaboration agreement is what PMQoS was meant to provide
(in a best effort way).  What's missing from your point of view?

--mgross

 
