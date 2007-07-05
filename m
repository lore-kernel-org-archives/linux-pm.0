From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 15:47:14 +0200
Message-ID: <200707051547.15239.rjw__4549.51251526854$1183643448$gmane$org@sisk.pl>
References: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
	<200707051451.38497.rjw@sisk.pl>
	<1183639825.3818.38.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183639825.3818.38.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: mjg59@srcf.ucam.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 14:50, Johannes Berg wrote:
> On Thu, 2007-07-05 at 14:51 +0200, Rafael J. Wysocki wrote:
> 
> > > > Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> > > > wanting to resume devices during a system suspend transition?  This is
> > > > exactly what happens when those threads aren't frozen.
> > > 
> > > So, I wonder why I don't see that error on my powerbook?
> > 
> > Because you have only one CPU running while your suspend code is being
> > executed?
> 
> If that's really all the problem then what's wrong with just unplugging
> the other CPUs earlier? Sure, that makes suspend no longer perfectly
> transparent since userspace might notice the CPUs being unplugged, but
> it has to cope with that anyway since a user can do it manually...

This is a bit complicated, but I'll try to explain.

We used to disable the nonboot CPUs before suspending devices and enable
them after resuming devices, but that turned out to lead to resume problems on
some ACPI systems.  Namely, it turned out that this code ordering was not in
line with the ACPI spec that assumed specific ordering of events during a
suspend.  For this reason, we changed the code ordering and now it is more or
less in agreement with ACPI (for the first time, AFAICS).  I don't think that
anyone would like to revert that change right now.

Moreover, in the meantime we learned that the CPU hotplug code that we use
for disabling the nonboot CPUs, is generally problematic on x86 and only works
for us because we have the majority of interrupt sources disabled when it's
invoked.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
