From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/4] ACPI / PM: Make acpi_bus_init_power() more robust
Date: Tue, 22 Jan 2013 09:10:56 +0200
Message-ID: <20130122071056.GB2239@intel.com>
References: <1792467.qHBR6KraFh@vostro.rjw.lan>
 <24285515.9Jp3KUo9Px@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <24285515.9Jp3KUo9Px@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2013 at 03:09:01AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI specification requires the _PSC method to be present under
> a device object if its power state cannot be inferred from the states
> of power resources used by it (ACPI 5, Section 7.6.2).  However, it
> also requires that (for power states D0-D2 and D3hot) if the _PSn
> (n = 0, 1, 2, 3) method is present under the device object, it also
> must be executed after the power resources have been set
> appropriately for the device to go into power state Dn (D3 means
> D3hot in this case).  Thus it is not clear from the specification
> whether or not the _PSn method should be executed if the initial
> configuraion of power resources used by the device indicates power
> state Dn and the _PSC method is not present.
> 
> The current implementation of acpi_bus_init_power() is based on the
> assumption that it should not be necessary to execute _PSn in the
> above situation, but experience shows that in fact that assumption
> need not be satisfied.  For this reason, make acpi_bus_init_power()
> always execute _PSn if the initial configuration of device power
> resources indicates power state Dn.
> 
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

You can add also,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

if you like. Thanks for fixing this.
