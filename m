From: Paul Fox <pgf@laptop.org>
Subject: OLPC's power manager
Date: Wed, 18 Aug 2010 17:36:41 -0400
Message-ID: <5418.1282167401@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-ID: <5415.1282167401.1@foxharp.boston.ma.us>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

rafael asked me about OLPC's power management daemon at linuxcon, and
since people keep mentioning user-level suspend managers, and since
we have an example of one, this seems like a good time to summarize
what we currently deploy on the OLPC XO laptops.  our daemon
("powerd") certainly isn't perfect, but in daily use it works pretty
well, and has been able to adapt to new needs as well as it can, given
current limitations in the drivers and our hardware.

design goals:
    - fully support XO power saving capabilities, including
	- system in S3 with display active
	- wake-on-wlan, and keeping autonomous mesh active during S3

    - no X11 dependency, including for the (minimal) splash-screen UI.

    - minimal hal/udev/dbus dependency (largely because my background
	is in the embedded world, but also simply to reduce unnecessary
	dependencies).

operation:
    - events are communicated to the daemon via a named pipe.

    - user "idleness" is indicated by 4 events:  3 successive idle
	events, and an "active again" event.  these events are
	provided by an ancillary system daemon which already monitors
	all user input in order to support other XO-specific keyboard
	features.

    - the three configurable user-idle timers can be configured to dim
	the screen, turn off the screen, and enter S3 state, in any
	order (well, "dim" after "screen off" doesn't make much
	sense).  three different sets of timers are selected,
	depending on whether the laptop is externally powered, is on
	battery, or is being used in "ebook" configuration.

    - a fourth timer allows for automatic shutdown when the system has
	been suspended for "long enough".

    - the major power inputs -- battery levels, external power
	insertion, the power button, lid switch, ebook-mode switch --
	are also communicated by events.

    - wakeups can come from all the usual sources -- keyboard, lid,
	power subsystem, wlan, etc.  due to h/w limitations, USB ports
	are unpowered during suspend, and can't cause wakeups.

    - a "hard" suspend can be forced with the power button or by
	closing the lid.  when in this state, those are the only two
	configured wakeup events.

inhibiting suspend:
    - applications inhibit suspend by creating pid-named files, or by
	touching the modtime on a single well-known file -- either
	will work.  powerd will refuse to do an automatic suspend if
	any pid-named files exist, or if the touch-file has been
	touched recently enough.  (abandoned pid-named files are
	detected and removed, so programs can be wrapped with "touch
	$$; exec foo" to make them suspend-inhibiting.)

    - in addition, suspend can be inhibited by:
	- the presence of certain USB devices (by class, vendor, or
	    product ID)
	- elevated CPU activity
	- camera in use
	- VT i/o (mostly a developer convenience)
	- network activity (certain classes of traffic, as detected by
	    custom iptables rules)

current behavior:
    - current default configuration (on XO-1.5) is fairly aggressive,
	and puts the system to sleep, leaving the display active, if
	there has been no user input after 15 seconds.  the display
	will wake and dim after 3 minutes of inactivity, and will wake
	and blank after 7 minutes.  the system will shut down after
	sleeping for 4 hours, unless on external power.

    - suspend won't occur if certain types of network traffic have
	been seen within the previous 5 seconds.  (most outgoing, and
	some incoming packets)

    - suspend won't occur if the CPU is more than 15% utilized.  many
	of the XO's important applications are user-created animations
	(written in Scratch or Etoys), or user-created music, etc. 
	it's important not to interrupt those when in progress.

logging:
    - to facilitate power optimization, most power-affecting events
	are logged.  we've thought about possible mechanisms to
	retrieve these logs, but haven't implemented anything.  (we
	do request the logs when problematic laptops are reported in
	the field.)

experience:
    - we rarely, but definitely, see the suspend vs.  wakeup event
	race.  since most of our wakeups are user-initiated, usually
	this just means an extra keystroke.  missed wlan wakeups are
	worse.  the race is narrowed as much as possible by rechecking
	the input queue as late as possible, but obviously any kernel
	mechanism(s) which helped close this hole would help.

    - the inhibit heuristics are simple, but simplistic:  staying
	awake because the cpu is "busy", or because we've seen TCP
	traffic in the 5 seconds prior to suspend, are both error
	prone decisions.  few apps have been made suspend-aware -- if
	we did more of that, the accuracy of the heuristics wouldn't
	be as critical.

    - since suspends usually happen with an expected wakeup time, they
	are invoked via "rtcwake -m mem".  this makes rtc wakeups
	unavailable for other applications.  XO 1.5 has an additional
	wakeup timer implemented in the EC, which we could potentially
	use instead.

    - with the support of a few small helper daemons (that handle user
	and power input monitoring) which are written in C, powerd is
	implemented in bourne shell, 99% of which is posix compliant. 
	(the use of the -t option to the read builtin is the one
	exception.)  there's no doubt that there are some tasks that
	would be better implemented in a different language, but
	there's something to be said for fast prototyping and ease of
	maintenance.  the use of shell also makes one more part of the
	laptop "transparent", which fits with its educational role.


repo is here:
    http://dev.laptop.org/git/users/pgf/powerd
and the keyboard/touchpad monitor is here:
    http://dev.laptop.org/git/users/pgf/olpc-kbdshim/

paul
=---------------------
 paul fox, pgf@laptop.org
