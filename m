From: "Brown, Len" <len.brown@intel.com>
Subject: RE: on-ness
Date: Mon, 17 Apr 2006 17:43:23 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB63588C3@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============75604011677986649=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Richard A. Griffiths" <richard.griffiths@windriver.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============75604011677986649==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

> Thinking about the discussion of the ON field. How about Limiter? Then
0
> maps to no limit (max power, max freq, whatever) and any other number
is
> some limit of performance/power, similar to what was decided for Idle.

my scribbles on generic sysfs device directory file names say:

state:
on	- running and available
off	- requires a full device initialization to be usable

idle: # = "how idle"
0 - active, not idle at all eg C0, D0
1 - idle. eg C1, D1
...
n - most power saving, highest latency idle state, eg. Cn, Dn

idle_max
max # that can be in idle file above

speed: # = "how fast"
0 - minimum speed
1 - 
...
n -- highest speed, highest power

speed_max
max # that can be in speed file above

So describing the ACPI states using these:

state = on: online
state = off: offline

idle = 0: C0
idle = 1: C1
idle = n: Cn

(for devices with D-states, replace Cx above with Dx -- since they are
both describing a state where the device is present, but not executing
and with increasing latency before resuming execution)

speed = 0: Pn
speed = 1: Pn-1
...
speed = n: P0

Not immediately obvious how to articulate Throttling states here,
would probably need an additional file similar to "speed", since they
are effectively multiplied.  Maybe simply:

throttle
0 - full speed
n - min speed

Re: state
unclear if on/off is sufficient, or if hotplug wold need any
other states.

---

sounds like you're suggesting the inverse of "speed" where
0 is max performance and max power.  I'd certainly be happy
to have 0 mean P0 for processors -- but "on" and "speed"
are certainly the opposite of what we want to call this.
Maybe "powersave" to capture the concept of an executing
but power saving operating point?

-Len


--===============75604011677986649==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============75604011677986649==--
