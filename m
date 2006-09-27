From: Dave Jones <davej@redhat.com>
Subject: Re: T30 boot hang with CONFIG_PM_LEGACY=n
Date: Wed, 27 Sep 2006 13:15:12 -0400
Message-ID: <20060927171512.GF997@redhat.com>
References: <20060927024628.GA29182@redhat.com> <200609270000.40760.len.brown@intel.com> <20060927042029.GA3571@redhat.com> <20060927144731.GA3641@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060927144731.GA3641@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 27, 2006 at 03:47:31PM +0100, Matthew Garrett wrote:
 > On Wed, Sep 27, 2006 at 12:20:29AM -0400, Dave Jones wrote:
 > 
 > > Good question.  There's no real replacement for pm_active in the non-legacy
 > > config afaik. Perhaps the cleanest alternative is to undeprecate that macro?
 > > The only other option I can think of is doing something like this in apm.c ...
 > > 
 > > +#ifdef CONFIG_ACPI
 > > -        if (PM_IS_ACTIVE()) {
 > >                  printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 > >                  apm_info.disabled = 1;
 > >                  return -ENODEV;
 > > -         }
 > > +#endif
 > 
 > That's not a good choice - it needs to be a runtime check, not a 
 > compile-time one. Don't we have an acpi_enabled() function?
 
You're right, the above would break if booted with acpi=off.

Hmm.

	Dave 
