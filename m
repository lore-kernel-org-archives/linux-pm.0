From: Len Brown <len.brown@intel.com>
Subject: T30 boot hang with CONFIG_PM_LEGACY=n
Date: Wed, 27 Sep 2006 00:00:40 -0400
Message-ID: <200609270000.40760.len.brown@intel.com>
References: <20060927024628.GA29182@redhat.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20060927024628.GA29182@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Jeff Garzik <jeff@garzik.org>
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

My T30 doesn't boot if CONFIG_PM_LEGACY=n
unless "apm=off".

Seems that this build option causes PM_IS_ACTIVE() to be constant 0,
which disables APM's check to see if ACPI is running:

apm_init()
	...
        if (PM_IS_ACTIVE()) {
                printk(KERN_NOTICE "apm: overridden by ACPI.\n");
                apm_info.disabled = 1;
                return -ENODEV;
        }

Apparently when CONFIG_PM_LEGACY was created, CONFIG_APM depended
on it, so apm.c wasn't built.  But that dependency was later removed so it is now possible
to build APM with its check for ACPI  mysteriously disabled -- much to the unhappyness
of my T30.

What's the plan here?  Perhaps that plan should be written down
in kernel/power/Kconfig? 

config PM_LEGACY
        bool "Legacy Power Management API"
        depends on PM
        default y
        ---help---
           Support for pm_register() and friends.

           If unsure, say Y.

thanks,
-Len
