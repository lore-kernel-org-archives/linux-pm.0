From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: Hibernate after alarm wakes from STR
Date: Sun, 8 Jul 2007 18:31:21 -0400
Message-ID: <20070708223121.GB4964__5677.37508467889$1183933960$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707081217.53071.david-b@pacbell.net>
	<1183923098.2814.8.camel@work>
	<200707081315.40560.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707081315.40560.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: rtc-linux@googlegroups.com, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, devel@laptop.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 08, 2007 at 01:15:40PM -0700, David Brownell wrote:
> On Sunday 08 July 2007, Richard Hughes wrote:
> > On Sun, 2007-07-08 at 12:17 -0700, David Brownell wrote:
> > > 
> > > I think so ... although that's unfortunately another difference
> > > between the legacy x86-mostly code and the newer RTC framework.
> > 
> > (sorry for hijacking the thread)
> 
> I changed $SUBJECT ...
> 
> 
> > Is this the interface should stuff like HAL use to do:
> > 
> > * Suspend for 10 minutes
> > * auto wakeup and then hibernate...
> 
> That is, "Suspend-to-RAM" or "standby"?  Yes, assuming that works on
> this particular system.  Arguably that would be a direction for
> cpuidle to think about too, but I think alarm-driven wakeup is more
> ready-to-use at this point.
> 
> 
> > I figure we can do a suspend setting the rtc using the ioctls and then
> > we wakeup, and HAL has to know that we woke up from the alarm rather
> > than from a lid event or keypress.

On OLPC hibernate would be suspend-to-disk, but we haven't done any
testing with that yet. It would be necessary to check for available disk
space before attempting it (or reserving space perhaps?).

> ... although I don't know whether that particular distinction is
> made to userspace right now.  ACPI provides a bit like that, and
> at least a few other systems can do something analagous.

Yes, we can poke at registers to find that out.

> That is, we may want to provide a bit more information about the
> specific event which triggered wakeup.  I don't believe there is
> such an interface, in general.

What would be a nice interface? Perhaps an additional file under
/sys/devices/.../power/wakeup_fired or something (only for devices with
can_wakeup set).

> Plus, the notion seems kind of racey to me.  (If you press a key
> right while the wakealarm fires, you don't want hibernation..)

Then you check if the any key or other wakeup event has happened other
than RTC... I don't see any problem with that.

> > Is this something we can do (or should do) for OLPC and general ACPI?
> 
> I'd certainly rather see laptops doing that than what they do now:
> running the battery out, and needing filesystem recovery!!

Yep.
