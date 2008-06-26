From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] Remove obsolete piece of PM documentation
Date: Thu, 26 Jun 2008 22:34:08 +0200
Message-ID: <200806262234.09104.rjw__1720.32793420858$1214512737$gmane$org@sisk.pl>
References: <200806121025.24668.rjw@sisk.pl>
	<20080612205118.GB11761@elf.ucw.cz>
	<alpine.LFD.1.10.0806261535140.2988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806261535140.2988@localhost.localdomain>
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
To: Len Brown <lenb@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 26 of June 2008, Len Brown wrote:
> 
> > > > > > -               Linux Power Management Support
> > > > > > -
> > > > > > -This document briefly describes how to use power management with your
> > > > > > -Linux system and how to add power management support to Linux drivers.
> > > > > > -
> > > > > > -APM or ACPI?
> > > > > > -------------
> > > > > > -If you have a relatively recent x86 mobile, desktop, or server system,
> > > > > > -odds are it supports either Advanced Power Management (APM) or
> > > > > > -Advanced Configuration and Power Interface (ACPI).  ACPI is the newer
> > > > > > -of the two technologies and puts power management in the hands of the
> > > > > > -operating system, allowing for more intelligent power management than
> > > > > > -is possible with BIOS controlled APM.
> > > > > > -
> > > > > > -The best way to determine which, if either, your system supports is to
> > > > > > -build a kernel with both ACPI and APM enabled (as of 2.3.x ACPI is
> > > > > > -enabled by default).  If a working ACPI implementation is found, the
> > > > > > -ACPI driver will override and disable APM, otherwise the APM driver
> > > > > > -will be used.
> > > > > > -
> > > > > > -No, sorry, you cannot have both ACPI and APM enabled and running at
> > > > > > -once.  Some people with broken ACPI or broken APM implementations
> > > > > > -would like to use both to get a full set of working features, but you
> > > > > > -simply cannot mix and match the two.  Only one power management
> > > > > > -interface can be in control of the machine at once.  Think about it..
> > > > > 
> > > > > I'd keep this; it is still true, and we still support both.
> > > > > 
> > > > > Maybe it should be moved into Doc*/power/apm.txt or something.
> > > > 
> > > > Yes, if there is a good sub-directory for it, please put it there.
> 
> I think this is already covered in the Kconfig help for ACPI and APM
> and doesn't need a Documentation file.

It won't hurt to have the file, though.

I have reworked the patch already and I'd rather not do that again the other
way around. ;-)

Thanks,
Rafael
