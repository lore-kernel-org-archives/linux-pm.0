From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 20:43:17 +0000
Message-ID: <20070108204317.GA24181@srcf.ucam.org>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701071831.18186.david-b@pacbell.net> <20070108101026.GA14485@srcf.ucam.org> <200701081239.08687.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701081239.08687.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 08, 2007 at 12:39:08PM -0800, David Brownell wrote:

> In that current API there's no way to tell anything at all about the
> target system state inside a driver's suspend() method.  So if there
> were some characteristic of S4 (or S3 etc) that mattered to the driver
> (it should test for the attribute, not S4/etc since S4 is ACPI-specific)
> the driver couldn't do anything about it ... so as I said, not useful.

Well, it's not just a matter for the driver - in terms of userspace UI, 
we want to be able to expose which wakeup events will work in suspend to 
disk. If the API can't currently expose that, then we probably want to 
look into ways of fixing that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
