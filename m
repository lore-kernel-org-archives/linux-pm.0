From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 6/6] [-mm]: ACPI: duplicate ACPI "info" attribute in sysfs
Date: Sun, 7 Jan 2007 16:39:40 +0100
Message-ID: <20070107153940.GA23879@elf.ucw.cz>
References: <1168083333.5619.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168083333.5619.40.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

>  
>  /* --------------------------------------------------------------------------
> +                              FS Interface (/sys)
> +   -------------------------------------------------------------------------- */
> +extern struct subsystem acpi_subsys;
> +
> +static ssize_t info_show(struct subsystem *subsys, char *buf)
> +{
> +	return 	sprintf(buf, "version:                 %x\n", ACPI_CA_VERSION);
> +}

One value per file... so it should omit "version: " string at the very least.

Plus I do not think we should have this file at all. ACPI is pretty
much in sync with kernel these days, and we do not have 

/sys/scsi/scsi_core version nor /sys/vm/vm_internals_version etc.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
