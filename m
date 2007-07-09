From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: Hibernate after alarm wakes from STR
Date: Mon, 9 Jul 2007 11:40:14 -0400
Message-ID: <20070709154014.GF27828__23023.8356897191$1183995600$gmane$org@dmt>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707081315.40560.david-b@pacbell.net>
	<20070708223121.GB4964@dmt>
	<200707081944.04598.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707081944.04598.david-b@pacbell.net>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On Sun, Jul 08, 2007 at 07:44:03PM -0700, David Brownell wrote:
> On Sunday 08 July 2007, Marcelo Tosatti wrote:
> > On Sun, Jul 08, 2007 at 01:15:40PM -0700, David Brownell wrote:
> > > On Sunday 08 July 2007, Richard Hughes wrote:
> > > 
> > > That is, we may want to provide a bit more information about the
> > > specific event which triggered wakeup.  I don't believe there is
> > > such an interface, in general.
> > 
> > What would be a nice interface? Perhaps an additional file under
> > /sys/devices/.../power/wakeup_fired or something (only for devices with
> > can_wakeup set).
> 
> Better a /sys/power/wakeup_event (or whatever) that's more easily
> found.  It could link to the device issuing the event.

As you mentioned, there might be two wakeup sources (RTC and power
button for instance) or even more at the same time.

Do you think its fine to simply but the device separated by spaces in
the wakeup_event file?

Sounds fine by me, but what about the one-value-per-file sysfs rule?

> > > Plus, the notion seems kind of racey to me.  (If you press a key
> > > right while the wakealarm fires, you don't want hibernation..)
> > 
> > Then you check if the any key or other wakeup event has happened other
> > than RTC... I don't see any problem with that.
> 
> It might be best not to need to re-activate the whole system from
> STR though ... it ought to be possible to just power off, having
> already written the image to disk.  Right?

Perhaps, yes... 

> Yes, there's all that stuff about how to quiesce the system properly,
> freezer/icebox/flamesuits/etc.  Regardless, going from STR to fully
> operational and then hibernating would take time and energy that
> might not be available...

True, that needs to be taken into account.

> - Dave
> 
> 
> > > > Is this something we can do (or should do) for OLPC and general ACPI?
> > > 
> > > I'd certainly rather see laptops doing that than what they do now:
> > > running the battery out, and needing filesystem recovery!!
> > 
> > Yep.
> > 
> 
