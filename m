From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 13:15:20 -0800
Message-ID: <200701081315.21443.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701081239.08687.david-b@pacbell.net> <20070108204317.GA24181@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070108204317.GA24181@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday 08 January 2007 12:43 pm, Matthew Garrett wrote:
> On Mon, Jan 08, 2007 at 12:39:08PM -0800, David Brownell wrote:
> 
> > In that current API there's no way to tell anything at all about the
> > target system state inside a driver's suspend() method.  So if there
> > were some characteristic of S4 (or S3 etc) that mattered to the driver
> > (it should test for the attribute, not S4/etc since S4 is ACPI-specific)
> > the driver couldn't do anything about it ... so as I said, not useful.
> 
> Well, it's not just a matter for the driver - in terms of userspace UI, 
> we 

... may potentially ...

> want to be able to expose which wakeup events will work in suspend to  
> disk. If the API can't currently expose that, then we probably want to 
> look into ways of fixing that.

Considering that I've never seen ACPI wakeup GPEs work at all, having
them work in the first place -- e.g. from STR -- would need to be a first
step.  It seems premature to discuss the UI of a tool that can't yet be
written on Linux...

Agreed, by the way, that drivers need to be able to tell things about the
target system sleep state.  My original examples come from USB:  drivers
need to know whether the target state requires disabling specific clocks,
which must be active for remote wakeup to work.

- Dave
 
