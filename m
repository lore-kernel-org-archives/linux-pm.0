From: "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 06:49:42 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B749D525F@hasmsx108.ger.corp.intel.com>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
 <20170731221645.GA5871@light.dominikbrodowski.net>
 <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
 <CAJZ5v0hMdu3hZoc4YOE6YteHLuXkO7V63cTiCbBENBGT4cLp2g@mail.gmail.com>
 <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
 <20170801063642.GA1839@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170801063642.GA1839@light.dominikbrodowski.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Dominik Brodowski [mailto:linux@dominikbrodowski.net]
> Sent: Tuesday, August 01, 2017 09:37
> To: Usyskin, Alexander <alexander.usyskin@intel.com>; Rafael J. Wysocki
> <rafael@kernel.org>
> Cc: Winkler, Tomas <tomas.winkler@intel.com>; Wysocki, Rafael J
> <rafael.j.wysocki@intel.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Bjorn Helgaas <bhelgaas@google.com>;
> linux-kernel@vger.kernel.org; Linux PM <linux-pm@vger.kernel.org>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>
> Subject: Re: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
> from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
> resume-from-sleep on v4.13-rc2+]
> 
> Alexander, Rafael,
> 
> On Tue, Aug 01, 2017 at 02:05:22AM +0200, Rafael J. Wysocki wrote:
> > Actually, I don't think it will make any difference.  Please check the
> > one attached this time.
> 
> On Tue, Aug 01, 2017 at 05:25:03AM +0000, Usyskin, Alexander wrote:
> > Dominik, can you try comment out "if (!pci_dev_run_wake(pdev))"
> > at drivers/misc/mei/pci-me.c (around line 223) to set domain callbacks
> > by force to see if this is indeed the case?
> 
> thanks for taking a look at this issue. I have tested both approaches, and
> either works fine and solves the issue. Which approach is better I cannot say,
> though.
> 
> Thanks,
> 	Dominik


Thanks for envestigation.
Our HW requires PCI_DEV_FLAGS_NEEDS_RESUME as we need to go via reset during suspend and this cannot be initiated while in runtime suspended.
We will work on the patch.
Thanks
Tomas

