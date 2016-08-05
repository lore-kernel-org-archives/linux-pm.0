From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Runtime resume bridges before bus rescans
Date: Thu, 4 Aug 2016 20:53:14 -0400
Message-ID: <CA+55aFxV68Bp0xCfDBzvUYZiLHiRW4FAUQ07ft_2SBuCF01bSw@mail.gmail.com>
References: <5356594.Wd8M8VygiD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <5356594.Wd8M8VygiD@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dave Airlie <airlied@linux.ie>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 4, 2016 at 8:38 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If a PCI bridge (or PCIe port) that is runtime-suspended gets an
> ACPI hotplug notification, such as a bus check, it has to be resumed
> before re-scanning the devices below it, or those devices will not
> be accessible and will be treated as hot-removed.

Just checking: do you want me to apply this as a patch, or are you
adding it to your git tree and just cc'ing me as a FYI?

           Linus
