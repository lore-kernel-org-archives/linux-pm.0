From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 0/5] PCI PM refinements
Date: Thu, 29 Sep 2016 14:11:17 +0200
Message-ID: <20160929121117.GA6648@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
 <20160928165445.GB5658@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160928165445.GB5658@localhost>
Sender: linux-acpi-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 28, 2016 at 11:54:45AM -0500, Bjorn Helgaas wrote:
> On Sun, Sep 18, 2016 at 05:39:20AM +0200, Lukas Wunner wrote:
> >   PCI: Afford direct-complete to devices with nonstandard PM
> >   PCI: Query platform firmware for device power state
> >   PCI: Recognize D3cold in pci_update_current_state()
> >   PCI: Avoid unnecessary resume after direct-complete
> 
> I applied the patches above with Rafael's acks to pci/pm for v4.9, thanks,
> Lukas!  I particularly appreciate your changelogs -- they're very readable,
> complete, and consistent in style.

As a non-native English speaker I cannot imagine a bigger compliment,
thanks so much!


> >   PCI: Avoid unnecessary resume on shutdown
> 
> Sounds like there's still a little discussion on this, so I haven't applied
> this one yet.

Yes, indeed I need more time with this one.

Thanks!

Lukas
