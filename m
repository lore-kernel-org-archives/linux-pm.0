From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 08/13] PCI/portdrv: Simplify PCIe feature permission
 checking
Date: Mon, 12 Mar 2018 15:20:59 +0100
Message-ID: <20180312142059.GA11186@wunner.de>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152062203293.77693.8159909590216160503.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180312080402.GE10358@infradead.org>
 <20180312140316.GB194000@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180312140316.GB194000@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Keith Busch <keith.busch@intel.com>, Sinan Kaya <okaya@codeaurora.org>, Frederick Lawler <fred@fredlawl.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 12, 2018 at 09:03:16AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 12, 2018 at 01:04:02AM -0700, Christoph Hellwig wrote:
> > > +	 * We assume we can manage these PCIe features.  Some systems may
> > > +	 * reserve these for use by the platform itself, e.g., an ACPI BIOS
> > > +	 * may implement its own AER handling and use _OSC to prevent the
> > > +	 * OS from interfering.
> > > +	 */
> > > +	bridge->use_aer = 1;
> > > +	bridge->use_hotplug = 1;
> > > +	bridge->use_pme = 1;
> > 
> > If we start out with enabled maybe these should be disable_foo flags
> > instead?
> 
> I went back and forth on that.  "disable_foo" is nice because the
> default value is correct (zero means enabled).  But then you end up
> with things like:
> 
>   if (pcie_ports_native || !host->disable_hotplug)
> 
> where the "!host->disable_hotplug" is a double negative, and I have a
> really hard time reading that.

native_hotplug or, if you want it reversed, platform_hotplug
(or firmware_hotplug?) might improve readability.

Thanks,

Lukas
