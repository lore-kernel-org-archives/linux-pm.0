From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Issue with commit de3ef1eb1cd - PM / core: Drop run_wake flag
 from struct dev_pm_info [Was: MEI-related WARN_ON() triggered during
 resume-from-sleep on v4.13-rc2+]
Date: Tue, 1 Aug 2017 17:32:24 +0200
Message-ID: <CAJZ5v0jhm6YYn3oyXpLGgFL9DHaCv_k=47hhUwFdcDhmaq-PUw@mail.gmail.com>
References: <20170730085908.GA2298@light.dominikbrodowski.net>
 <5B8DA87D05A7694D9FA63FD143655C1B749D3C1C@hasmsx108.ger.corp.intel.com>
 <20170731221645.GA5871@light.dominikbrodowski.net> <CAJZ5v0i2MiLv6J+Wo1sUXoCKK9iG_e7pVdb0Uo5uzLXkyxpDUg@mail.gmail.com>
 <CAJZ5v0hMdu3hZoc4YOE6YteHLuXkO7V63cTiCbBENBGT4cLp2g@mail.gmail.com>
 <C980C034A53E0646B96866D6CE3D187A4D9129A0@HASMSX106.ger.corp.intel.com>
 <CAJZ5v0gBpDKpRbhx0tbLWXG1e8Dd4ZPZGDQ5Vq2f8phX2cpFGg@mail.gmail.com> <5B8DA87D05A7694D9FA63FD143655C1B749D55CC@hasmsx108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:37336 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdHAPcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 11:32:25 -0400
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B749D55CC@hasmsx108.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Usyskin, Alexander" <alexander.usyskin@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Aug 1, 2017 at 3:58 PM, Winkler, Tomas <tomas.winkler@intel.com> wrote:
>>
>> Hi,
>>
>> On Tue, Aug 1, 2017 at 7:25 AM, Usyskin, Alexander
>> <alexander.usyskin@intel.com> wrote:
>> > Hi
>> >
>> > We using pci_dev_run_wake that changed in mentioned patch to decide if
>> > to replace usual PM callbacks with domain ones.
>> > IIRC, the mei device is not remote wakeable on that platform, so we
>> > should set domain callbacks.
>> > There was a patch in PM framework that squashes runtime suspend with
>> > usual suspend for some devices.
>> > May it be that now pci_dev_run_wake returns true form mei and we are
>> > not setting domain callbacks?
>> > In that case we going through PCI device level PM path and may trigger
>> that squash.
>> > That will explain lack of mei logs on suspend.
>> >
>> > Dominik, can you try comment out "if (!pci_dev_run_wake(pdev))"
>> > at drivers/misc/mei/pci-me.c (around line 223) to set domain callbacks
>> > by force to see if this is indeed the case?
>>
>> Why exactly do you need the pci_dev_run_wake(pdev) check?
>
> We need to re-review this code now, but as far as I remember.
> On some platforms with NFC connected via MEI, there was no PME enabled,  hence we needed to keep in band irq opened for rx to wake us up.

But pci_dev_run_wake() returning "true" doesn't guarantee that wakeup
signaling will actually work.  What it tells you is merely that
everything appears to be in place for wakeup to work from the software
perspective and it is a bit biased on the optimistic side, so I'm not
really sure if that's what you need.

Maybe you should just override the PCI PM unconditionally and do
what's needed from you PM domain callbacks.  Dunno.

Thanks,
Rafael
