From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 15:45:59 -0500 (CDT)
Message-ID: <200510052045.j95KjxIF020225@olwen.urbana.css.mot.com>
Content-Type: multipart/mixed; boundary="===============15311689986168897=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Alan Stern"'s message of Wed, 5 Oct 2005 16:08:03 -0400
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: david-b@pacbell.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============15311689986168897==



| From: "Alan Stern" <stern@rowland.harvard.edu>
| 
| IMO we could avoid the need for power_state by removing the guarantee
| about never calling ->suspend when a device is already in a low-power
| state.  The system sleep code could issue an optimistic ->suspend call,
| and if that fails then do ->resume followed by ->suspend.
---

That assumes it's "safe" to call suspend regardless of device power
state - that in the worst case, the device will just return failure.
That seems reasonable, but it's a constraint driver writers would want
to know about.

---
|
| People have already pretty much agreed that ->resume needs to take a 
| pm_message_t argument, and that will mean changing a lot of drivers.  We
| ought to settle on a decision about the rest of this too, so we won't
| have to go through and change them all yet again.
---

Yes, it seems reasonable to tell the device what state the system is
trying to get to, so it can determine what state it needs to be in to
support that.

---
| 
| (BTW, a theoretical advantage of passing a pm_message_t to ->resume is
| that a driver could use the _same_ subroutine as a combined
| suspend/resume
| method.  :-))
---

It would be nice to encourage code cohesion by NOT encouraging
multipurpose interfaces...

---
| 
| The PM core shouldn't worry too much about redundant calls.  Drivers can
| easily filter them out, and the core won't have enough information to
| detect them in general.
| 
| As I see it, we can use the new .name field to distinguish between the 
| different kinds of system state change calls.  The PM core could export 
| strings like (for FREEZE):
| 
| 	APM-standby, APM-suspend, snapshot, kexec;
| 
| or (for SUSPEND):
| 
| 	RAM, S3, S4, S5, shutdown;
| 
| or (for RESUME):
| 
| 	snapshot, RAM, kexec.
| 
| Something like this will provide drivers the means for telling which
| target state to use, thus addressing one of your biggest complaints
| about
| the current system.
| 
| Of course, this means that drivers will need code to map these 
| higher-level names to the appropriate target state, although that code 
| wouldn't need to be very sophisticated.  It would have to be smart
| enough 
| to recognize that when .event is PM_EVENT_RUNTIME, the name indicates
| the 
| requested power state directly.
---

It would be nicer if the system didn't need to know anything about the
internal state of the devices, but could just tell the device what
system state it wants to go to and let the device map that to whatever
internal state or sequence of sub-states the device needs. This would be
helped if the set of system states were either (a) a limited set of
well-known states or (b) described as a set of state-constraints that
describe what facilities are available to devices in a given state
(e.g., "Bus XYZ shut down") and what demands the system might expect
the device to provide while in that state (e.g., "provide wakeup
signal"). Or, maybe that's what you were describing and I just misread
it.

scott

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



--===============15311689986168897==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15311689986168897==--
