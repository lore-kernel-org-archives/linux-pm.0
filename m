From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 13:51:16 +0200
Message-ID: <CAJZ5v0gBpDKpRbhx0tbLWXG1e8Dd4ZPZGDQ5Vq2f8phX2cpFGg@mail.gmail.com>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
 <20170731221645.GA5871@light.dominikbrodowski.net> <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
 <CAJZ5v0hMdu3hZoc4YOE6YteHLuXkO7V63cTiCbBENBGT4cLp2g@mail.gmail.com> <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, "Winkler, Tomas" <tomas.winkler@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 1, 2017 at 7:25 AM, Usyskin, Alexander
<alexander.usyskin@intel.com> wrote:
> Hi
>
> We using pci_dev_run_wake that changed in mentioned patch to decide
> if to replace usual PM callbacks with domain ones.
> IIRC, the mei device is not remote wakeable on that platform,
> so we should set domain callbacks.
> There was a patch in PM framework that squashes runtime suspend with
> usual suspend for some devices.
> May it be that now pci_dev_run_wake returns true form mei and we are
> not setting domain callbacks?
> In that case we going through PCI device level PM path and may trigger that squash.
> That will explain lack of mei logs on suspend.
>
> Dominik, can you try comment out "if (!pci_dev_run_wake(pdev))"
> at drivers/misc/mei/pci-me.c (around line 223) to set domain callbacks by force
> to see if this is indeed the case?

Why exactly do you need the pci_dev_run_wake(pdev) check?

Thanks,
Rafael
