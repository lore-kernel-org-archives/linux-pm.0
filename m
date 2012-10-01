From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH 1/6] Introduce acpi_match_device_id().
Date: Mon, 1 Oct 2012 09:37:53 +0300
Message-ID: <20121001063753.GE15548@intel.com>
References: <1348817910.10877.321.camel@rui.sh.intel.com>
 <20120928141347.GC15548@intel.com>
 <744357E9AAD1214791ACBA4B0B90926322C156@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926322C156@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@secretlab.ca>, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 29, 2012 at 01:31:52PM +0000, Zhang, Rui wrote:
>  
> > > +{
> > > +	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
> > 
> > If the device is not bound to an ACPI handle this will return NULL. And
> > I don't see you doing that in this series meaning that..
> > 
> 
> 
> You're right, I should set pdev->archdata.acpi_handle to the I2C
> controller in i2c_root.c.

There already is an API for that - check drivers/acpi/glue.c.
