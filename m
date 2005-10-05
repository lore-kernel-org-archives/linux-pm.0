From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 17:24:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510051716120.6810-100000@iolanthe.rowland.org>
References: <200510052045.j95KjxIF020225@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99547727421955612=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510052045.j95KjxIF020225@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============99547727421955612==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 5 Oct 2005, Scott E. Preece wrote:

> | From: "Alan Stern" <stern@rowland.harvard.edu>
> | 
> | IMO we could avoid the need for power_state by removing the guarantee
> | about never calling ->suspend when a device is already in a low-power
> | state.  The system sleep code could issue an optimistic ->suspend call,
> | and if that fails then do ->resume followed by ->suspend.
> ---
> 
> That assumes it's "safe" to call suspend regardless of device power
> state - that in the worst case, the device will just return failure.
> That seems reasonable, but it's a constraint driver writers would want
> to know about.

Yes.  This would be a change in the PM API, and driver authors would need 
to know about it.

> ---
> | 
> | (BTW, a theoretical advantage of passing a pm_message_t to ->resume is
> | that a driver could use the _same_ subroutine as a combined
> | suspend/resume
> | method.  :-))
> ---
> 
> It would be nice to encourage code cohesion by NOT encouraging
> multipurpose interfaces...

It's not so bad if you think of it as a simple "take care of this power 
change" routine.  That's just a single purpose.

In general, the core isn't supposed to know much about the internal states
of a device.  If the user requests a power change, the core doesn't really
know whether it's a suspend, a resume, or a move from one low-power state
to another.  From this point of view, it makes sense to have a single 
power-change method.

> ---
> | 
> | The PM core shouldn't worry too much about redundant calls.  Drivers can
> | easily filter them out, and the core won't have enough information to
> | detect them in general.
> | 
> | As I see it, we can use the new .name field to distinguish between the 
> | different kinds of system state change calls.  The PM core could export 
> | strings like (for FREEZE):
> | 
> | 	APM-standby, APM-suspend, snapshot, kexec;
> | 
> | or (for SUSPEND):
> | 
> | 	RAM, S3, S4, S5, shutdown;
> | 
> | or (for RESUME):
> | 
> | 	snapshot, RAM, kexec.
> | 
> | Something like this will provide drivers the means for telling which
> | target state to use, thus addressing one of your biggest complaints
> | about
> | the current system.
> | 
> | Of course, this means that drivers will need code to map these 
> | higher-level names to the appropriate target state, although that code 
> | wouldn't need to be very sophisticated.  It would have to be smart
> | enough 
> | to recognize that when .event is PM_EVENT_RUNTIME, the name indicates
> | the 
> | requested power state directly.
> ---
> 
> It would be nicer if the system didn't need to know anything about the
> internal state of the devices, but could just tell the device what
> system state it wants to go to and let the device map that to whatever
> internal state or sequence of sub-states the device needs. This would be
> helped if the set of system states were either (a) a limited set of
> well-known states or (b) described as a set of state-constraints that
> describe what facilities are available to devices in a given state
> (e.g., "Bus XYZ shut down") and what demands the system might expect
> the device to provide while in that state (e.g., "provide wakeup
> signal"). Or, maybe that's what you were describing and I just misread
> it.

I was trying to describe (a).  The names I listed were an attempt to 
define the limited set of well-known system states.

The wakeup signal stuff is already handled by a separate mechanism.

Alan Stern


--===============99547727421955612==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99547727421955612==--
