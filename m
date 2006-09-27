From: Dave Jones <davej@redhat.com>
Subject: Re: T30 boot hang with CONFIG_PM_LEGACY=n
Date: Wed, 27 Sep 2006 00:20:29 -0400
Message-ID: <20060927042029.GA3571@redhat.com>
References: <20060927024628.GA29182@redhat.com> <200609270000.40760.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609270000.40760.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 27, 2006 at 12:00:40AM -0400, Len Brown wrote:
 > My T30 doesn't boot if CONFIG_PM_LEGACY=n
 > unless "apm=off".
 > 
 > Seems that this build option causes PM_IS_ACTIVE() to be constant 0,
 > which disables APM's check to see if ACPI is running:
 > 
 > apm_init()
 > 	...
 >         if (PM_IS_ACTIVE()) {
 >                 printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 >                 apm_info.disabled = 1;
 >                 return -ENODEV;
 >         }
 > 
 > Apparently when CONFIG_PM_LEGACY was created, CONFIG_APM depended
 > on it, so apm.c wasn't built.  But that dependency was later removed so it is now possible
 > to build APM with its check for ACPI  mysteriously disabled -- much to the unhappyness
 > of my T30.
 > 
 > What's the plan here?

Good question.  There's no real replacement for pm_active in the non-legacy
config afaik. Perhaps the cleanest alternative is to undeprecate that macro?
The only other option I can think of is doing something like this in apm.c ...

+#ifdef CONFIG_ACPI
-        if (PM_IS_ACTIVE()) {
                 printk(KERN_NOTICE "apm: overridden by ACPI.\n");
                 apm_info.disabled = 1;
                 return -ENODEV;
-         }
+#endif

	Dave
