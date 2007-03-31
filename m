From: David Brownell <david-b@pacbell.net>
Subject: Re: Power Mangement Interfaces
Date: Sat, 31 Mar 2007 09:52:43 -0700
Message-ID: <200703310952.43696.david-b@pacbell.net>
References: <20070330235759.GC4252@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070330235759.GC4252@cosmic.amd.com>
Content-Disposition: inline
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
Cc: linux-pm@lists.osdl.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 30 March 2007 4:57 pm, Jordan Crouse wrote:
> Hey all -
> =

> I'm happy to report that the OLPC power management effort is proceeding
> nicely.  We have suspend to RAM functional, and the system is resuming
> back to the framebuffer console.

Good to hear that.  Now, if the same could be said for the *typical* PC
platform, I'd be much happier!


> We have the usual blips (USB), but =

> those will be resolved in the fullness of time.

USB once worked fine (I spent more than enough time testing it in all
kinds of configs) but usbcore has changed a lot since then ... I hear
that some of the root hub stuff got broken.


> I am now turning my attention to handling wakeup events - in particular,
> events that we can set at run-time.  My thoughts on the matter are =

> detailed here:
> =

> http://wiki.laptop.org/go/Power_Management_Interface

You seem to be completely ignoring the /sys/devices/..../power/wakeup
event attributes.  Why?

 =

> I use the ACPI wakeup infrastructure as an example because a) it exists,
> and b) it works. =


In my experience, (a) is true and (b) is very false.

Minimally, (b) is false because resuming from S1 or S3 sleep
states doesn't generally work under Linux, regardless of the
type of wakeup event.  The recent IDEACPI patch made a big
difference on at least one system though.

Another reason (b) is false is that it only handles built-in
devices.  Taking USB as an example, ACPI only knows about the
root hubs ... but not the fact that a USB mouse or keyboard
can be a wakeup event source.  The /sys/devices/.../wakeup
files manage those.


> However, it doesn't share nicely, and it is a /proc =

> file, so I sat down and thought of a more /sysfs friendly and generic
> model.  I did keep APCI in mind, figuring that if a generic framework was
> designed well enough, they could slowly transition over as well (which is
> why the ACPI list is CCed).

To the extent that Linux ever has a "plan of record", it's that ACPI will
transition /proc/acpi/wakeup contents into /sys/devices/.../power/wakeup
as part of removing the /proc/acpi stuff entirely.

That is:  there *IS ALREADY* a generic framework for wakeup events, one
that's already deployed ... and used for various devices.

As with most PM-related things on Linux, there's an issue with getting
decent cross-platform support for it.  However, that generic stuff does
work on various embedded systems.  Probably the best examples are ARM
AT91 platforms ... where most of the devices (USB, MMC, CF, UART, more)
can be trigger system wakeup events.  In several cases that's just by
enable_irq_wake() doing the right thing, and drivers knowing how to use
that call, but in other cases (like USB) it's more involved than that.

- Dave
