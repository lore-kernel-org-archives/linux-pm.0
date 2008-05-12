From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] ACPI PM: Add possibility to change
	suspend sequence
Date: Tue, 13 May 2008 00:34:05 +0200
Message-ID: <200805130034.06604.rjw__4538.48406109518$1210631872$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl> <200805091923.36763.rjw@sisk.pl>
	<20080512072301.GC24094@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080512072301.GC24094@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 12 of May 2008, Pavel Machek wrote:
> Hi!
> 
> > Index: linux-2.6/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > +++ linux-2.6/Documentation/kernel-parameters.txt
> > @@ -157,6 +157,11 @@ and is between 256 and 4096 characters. 
> >  			default: The hardware signature is checked during
> >  			         resume from S4.
> >  
> > +	acpi_old_suspend_ordering [HW,ACPI] ACPI suspend ordering
> > +			Enforce the ACPI 1.0 ordering of the _PTS control
> > +			method wrt putting devices into low power states
> > +			default: ACPI 2.0 ordering of _PTS
> > +
> >  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
> >  			Format: { level | edge | high | low }
> >
> 
> Hmm, I have a wild idea...
> 
> acpi_sleep=old_ordering
> 
> ...and reuse the same variable we already use for
> s3_bios/s3_mode. Then, we'd be able to blacklist the systems needing
> old_ordering from s2ram...
> 
> I guess this whitelist should better be done in kernel, but short-term
> ability to whitelist from userland could not hurt...?

There's one problem with that, acpi_sleep is x86-specific and it's actually
handled in arch/x86/kernel/acpi/sleep.c .  Well, ok, I think I can handle that,
but it won't look nice.

Thanks,
Rafael
