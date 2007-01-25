From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] [PATCH 0/6] [-mm]: ACPI: duplicate ACPI procfs functions in sysfs
Date: Thu, 25 Jan 2007 05:50:25 +0000
Message-ID: <20070125055025.GA9066@srcf.ucam.org>
References: <1168083306.5619.34.camel@localhost.localdomain> <20070107055424.GA24853@srcf.ucam.org> <200701071931.20306.david-b@pacbell.net> <200701242314.23169.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701242314.23169.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 24, 2007 at 11:14:22PM -0500, Len Brown wrote:
> On Sunday 07 January 2007 22:31, David Brownell wrote:
> 
> > > However, I'm not entirely sure /how/ that integration should happen. If 
> > > both the Linux driver and ACPI know how to enable wakeup for a device,
> > > what should writing to power/wakeup do?
> 
> If a native hardware device driver knows how to talk to the device,
> then it should win, and ACPI should lose.

My concern is that there may be cases where the ACPI wakeup code 
interacts with the platform in a way that the Linux code doesn't, which 
may be somehow necessary. I've no evidence that this is ever something 
that would actually be an issue, but on the other hand, this is ACPI...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
