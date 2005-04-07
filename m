From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Mapping Device Power States
Date: Thu, 7 Apr 2005 15:04:47 -0700
Message-ID: <200504071504.47531.david-b@pacbell.net>
References: <1112909150.21887.18.camel@linux.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============32006997039437435=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112909150.21887.18.camel@linux.site>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Adam Belay <abelay@novell.com>
List-Id: linux-pm@vger.kernel.org

--===============32006997039437435==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 07 April 2005 2:25 pm, Adam Belay wrote:
> 
> Linux supports a wide variety of hardware, each with different power
> management characteristics and capabilities.  However, power management
> statistics (e.g. calling a power tick for determining an idling) are
> generally gathered at the class device level.  In order for class
> devices to relate bus specific power states to their own state change
> intentions, it may make sense to have a table mapping each bus level
> power state to its corresponding generic Linux power state.

I'm not clear on that "In order for ...".  For one thing, class
devices aren't necessarily relevant.  For another, it presumes
the notion of a "generic" (device) power state.

But I guess my fundamental question is:  why should anything other
than its driver want to know about the device's power state?

System suspend transitions can all be handled by a "make yourself
compatible with this target system state" request.  The details of
how that's done are irrelevant outside the drivers.  Likewise,
runtime/dynamic/whatever power management operations can be done
at any time ... in fact, I'd argue all hardware should stay in
low power modes until it's actually needed, and entering higher
power modes should normally be transparent.  (So that if they
are stupid and stay in high power modes all the time, the only
penalty is wasted power.)


> Another problem with having multiple separate states is that it is very
> difficult to relate the power requirements of child devices when the
> parent has a different set of bus level power states.

That's a partial answer to my question:  sometimes a "container"
needs to coordinate power states of several devices.  OK; they
may have private agreements.  (A "bus" might be a "container",
but not all containers are busses.  Some are bridges, or hubs,
and some are less regular components involving multiple sorts
of control, data, and power connection.)

Of course, the current PM models in Linux don't exactly have such
a "container" model.  We've discussed needing child-to-parent
notificatios at various points, and those would be part of such
a model.


> I would like to explore the possibility of defining a set of generic
> power states, to which each bus level state can be mapped.  It might be
> as follows:
> 
> functional - the device is operational.
> context - the current data/operations passing through the device
> configuration - resources, firmware, settings done in *probe, etc.

The only one of those that seems needed outside of the driver
itself is whether it's "functional".  The rest are private to
the driver or maybe its container.


In short:  why should there be any Linux-wide notion like that?
Wouldn't trying to create one just be the problem of creating a
"Grand Unified Theory of Power Management"?

- Dave

--===============32006997039437435==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============32006997039437435==--
