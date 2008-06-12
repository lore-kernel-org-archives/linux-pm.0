From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 4/4] Remove obsolete piece of PM documentation
Date: Thu, 12 Jun 2008 22:51:18 +0200
Message-ID: <20080612205118.GB11761__40217.1116009869$1213304031$gmane$org@elf.ucw.cz>
References: <200806121025.24668.rjw@sisk.pl> <20080612131253.GD5455@ucw.cz>
	<16803397.1213285081959.JavaMail.oracle@acsmt301.oracle.com>
	<200806122248.59621.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200806122248.59621.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-06-12 22:48:58, Rafael J. Wysocki wrote:
> On Thursday, 12 of June 2008, Randy Dunlap wrote:
> > --- Original Message ---
> > > On Thu 2008-06-12 10:31:38, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Remove an obsolete piece of PM documentation.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > ---
> > > >  Documentation/power/pm.txt |  257 ---------------------------------------------
> > > >  1 file changed, 257 deletions(-)
> > > > 
> > > > Index: linux-2.6/Documentation/power/pm.txt
> > > > ===================================================================
> > > > --- linux-2.6.orig/Documentation/power/pm.txt
> > > > +++ /dev/null
> > > > @@ -1,257 +0,0 @@
> > > > -               Linux Power Management Support
> > > > -
> > > > -This document briefly describes how to use power management with your
> > > > -Linux system and how to add power management support to Linux drivers.
> > > > -
> > > > -APM or ACPI?
> > > > -------------
> > > > -If you have a relatively recent x86 mobile, desktop, or server system,
> > > > -odds are it supports either Advanced Power Management (APM) or
> > > > -Advanced Configuration and Power Interface (ACPI).  ACPI is the newer
> > > > -of the two technologies and puts power management in the hands of the
> > > > -operating system, allowing for more intelligent power management than
> > > > -is possible with BIOS controlled APM.
> > > > -
> > > > -The best way to determine which, if either, your system supports is to
> > > > -build a kernel with both ACPI and APM enabled (as of 2.3.x ACPI is
> > > > -enabled by default).  If a working ACPI implementation is found, the
> > > > -ACPI driver will override and disable APM, otherwise the APM driver
> > > > -will be used.
> > > > -
> > > > -No, sorry, you cannot have both ACPI and APM enabled and running at
> > > > -once.  Some people with broken ACPI or broken APM implementations
> > > > -would like to use both to get a full set of working features, but you
> > > > -simply cannot mix and match the two.  Only one power management
> > > > -interface can be in control of the machine at once.  Think about it..
> > > 
> > > I'd keep this; it is still true, and we still support both.
> > > 
> > > Maybe it should be moved into Doc*/power/apm.txt or something.
> > 
> > Yes, if there is a good sub-directory for it, please put it there.
> > 
> > > ACK on rest.
> 
> Updated patch is appended.
> 
> Thanks,
> Rafael
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Remove some obsolete PM documentation.
> 
> The majority of contents of Documentation/power/pm.txt are
> outdated.  Remove the outdated parts of this file and move the rest
> to Documentation/power/apm-acpi.txt .  Update the index in
> Documentation/power/ as appropriate.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK and thanks.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
