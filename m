From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / docs: Drop confusing kernel-doc references from infrastructure.rst
Date: Mon, 02 Jan 2017 23:39:17 +0100
Message-ID: <2071156.SHKBpIhHlC@aspire.rjw.lan>
References: <1637935.8QKVTKQPm8@aspire.rjw.lan> <1866121.f9dSvTNiL5@aspire.rjw.lan> <20170102153920.56c48a83@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170102153920.56c48a83@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 02, 2017 03:39:20 PM Jonathan Corbet wrote:
> On Mon, 02 Jan 2017 23:05:31 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The references to drivers/base/power/main.c and
> > > drivers/acpi/scan.c from Documentation/driver-api/infrastructure.rst
> > > are confusing.  They both cause descriptions of functions that are
> > > not relevant to device drivers at all to be generated and none of
> > > them is sufficient to cover the API in a meaningful way.
> > > 
> > > Drop them for now.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> > 
> > I'd like this to go into 4.10.
> > 
> > Are there any objections here?
> 
> None here.  Sorry, somehow I failed to see this when I was putting
> together the fixes to send a few days ago.  If you want to include it in
> a batch of yours, feel free to do so with my ack; otherwise I can ship it
> Linusward in a bit.

Thanks!

I'll be sending a PM pull request in a couple of days, so I'll include this one.

Cheers,
Rafael
