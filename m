From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 4/4] ACPI hibernate: Introduce new
	kernel	parameter acpi_sleep=s4_nonvs (rev. 2)
Date: Sun, 26 Oct 2008 13:18:15 +0100
Message-ID: <20081026121815.GD1607__7631.04288275844$1225023885$gmane$org@ucw.cz>
References: <200810222249.20629.rjw@sisk.pl>
	<1224715892.8156.16.camel@nigel-laptop>
	<200810230110.04039.rjw@sisk.pl> <200810230119.55519.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200810230119.55519.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Nigel Cunningham <ncunningham@crca.org.au>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-10-23 01:19:54, Rafael J. Wysocki wrote:
> On Thursday, 23 of October 2008, Rafael J. Wysocki wrote:
> > On Thursday, 23 of October 2008, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Wed, 2008-10-22 at 22:54 +0200, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > ACPI hibernate: Introduce new kernel parameter acpi_sleep=s4_nonvs
> > > > 
> > > > On some machines it may be necessary to disable the saving/restoring
> > > > of the ACPI NVS memory region during hibernation/resume.  For this
> > > > purpose, introduce new ACPI kernel command line option
> > > > acpi_sleep=s4_nonvs.
> > > > 
> > > > Based on a patch by Zhang Rui.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > >  Documentation/kernel-parameters.txt |    5 ++++-
> > > >  arch/x86/kernel/acpi/sleep.c        |    2 ++
> > > >  drivers/acpi/sleep/main.c           |   19 +++++++++++++++++--
> > > >  include/linux/acpi.h                |    1 +
> > > >  4 files changed, 24 insertions(+), 3 deletions(-)
> > > > 
> > > > Index: linux-2.6/Documentation/kernel-parameters.txt
> > > > ===================================================================
> > > > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > > > +++ linux-2.6/Documentation/kernel-parameters.txt
> > > > @@ -149,7 +149,8 @@ and is between 256 and 4096 characters. 
> > > >  			default: 0
> > > >  
> > > >  	acpi_sleep=	[HW,ACPI] Sleep options
> > > > -			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig, old_ordering }
> > > > +			Format: { s3_bios, s3_mode, s3_beep, s4_nohwsig,
> > > > +				  old_ordering, s4_nonvs }
> > > >  			See Documentation/power/video.txt for s3_bios and s3_mode.
> > > >  			s3_beep is for debugging; it makes the PC's speaker beep
> > > >  			as soon as the kernel's real-mode entry point is called.
> > > > @@ -159,6 +160,8 @@ and is between 256 and 4096 characters. 
> > > >  			control method, wrt putting devices into low power
> > > >  			states, to be enforced (the ACPI 2.0 ordering of _PTS is
> > > >  			used by default).
> > > > +			s4_nonvs prevents the kernel from saving/restoring the
> > > > +			ACPI NVS memory during hibernation.
> > > >  
> > > >  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
> > > >  			Format: { level | edge | high | low }
> > > > Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
> > > > +++ linux-2.6/arch/x86/kernel/acpi/sleep.c
> > > > @@ -161,6 +161,8 @@ static int __init acpi_sleep_setup(char 
> > > >  #endif
> > > >  		if (strncmp(str, "old_ordering", 12) == 0)
> > > >  			acpi_old_suspend_ordering();
> > > > +		if (strncmp(str, "s4_nonvs", 13) == 0)
> > > 
> > > s/13/8/
> > 
> > Sure, thanks for catching that (it was a different string in the original
> > patch).
> 
> Fixed version below, already with your ACK. ;-)
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACPI hibernate: Introduce new kernel parameter acpi_sleep=s4_nonvs  (rev. 2)
> 
> On some machines it may be necessary to disable the saving/restoring
> of the ACPI NVS memory region during hibernation/resume.  For this
> purpose, introduce new ACPI kernel command line option
> acpi_sleep=s4_nonvs.
> 
> Based on a patch by Zhang Rui.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Nigel Cunningham <nigel@tuxonice.net>
> Cc: Zhang Rui <rui.zhang@intel.com>

ACK.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
