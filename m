From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 00/13] Runtime PM for Thunderbolt on Macs
Date: Wed, 20 Jul 2016 14:48:02 +0200
Message-ID: <23327309.oKKvvEl2AM@vostro.rjw.lan>
References: <cover.1463134231.git.lukas@wunner.de> <CAJZ5v0i4TJ_nFj4x2couZqPyrjWhig5fFRfG2LNCHfG=3h1CBg@mail.gmail.com> <20160720072359.GC8066@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160720072359.GC8066@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Huang Ying <ying.huang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 20, 2016 09:23:59 AM Lukas Wunner wrote:
> On Fri, Jul 08, 2016 at 03:28:12AM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 7, 2016 at 5:02 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > (1) Would it be possible to allow dev_pm_domain_set() for already
> > >     bound devices? (It would allow me to simplify this series
> > >     considerably.)
> > 
> > I don't think so, because setting a PM domain generally changes the
> > set of PM callbacks for the device and it may not be safe to call it
> > after the driver has been bound.
> 
> That sounds more like a locking problem than anything else.
> 
> If the system is awake and the device is active, it would seem safe
> to change its set of PM callbacks. Am I missing something?
> 
> How about checking in dev_pm_domain_set() if pm_runtime_active(dev)

Realistically, you'd need to disable runtime PM too or at least bump up
the usage count.

> and calling lock_system_sleep() / unlock_system_sleep() to ensure that?

That might work.

Thanks,
Rafael
