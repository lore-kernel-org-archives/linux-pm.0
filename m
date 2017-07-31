From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] PCI / PM: Skip bridges in pci_enable_wake()
Date: Mon, 31 Jul 2017 22:59:32 +0200
Message-ID: <CAJZ5v0j623DO77BUh0fxkD1Fpi9-qcWRXF2Z_sAHbRnuzBp92w@mail.gmail.com>
References: <3116391.JNS1F4DjTg@aspire.rjw.lan> <1895122.yvmCHzQO3z@aspire.rjw.lan>
 <20170731205337.GF9303@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:34242 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGaU7d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2017 16:59:33 -0400
In-Reply-To: <20170731205337.GF9303@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>

On Mon, Jul 31, 2017 at 10:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Jul 21, 2017 at 02:38:08PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> PCI bridges only have a reason to generate wakeup signals on behalf
>> of devices below them, so avoid preparing bridges for wakeup directly
>> in pci_enable_wake().
>>
>> Also drop the pci_has_subordinate() check from pci_pm_default_resume()
>> as this will be done by pci_enable_wake() itself now.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

>> ---
>>  drivers/pci/pci-driver.c |    4 +---
>>  drivers/pci/pci.c        |    7 +++++++
>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> Index: linux-pm/drivers/pci/pci.c
>> ===================================================================
>> --- linux-pm.orig/drivers/pci/pci.c
>> +++ linux-pm/drivers/pci/pci.c
>> @@ -1909,6 +1909,13 @@ int pci_enable_wake(struct pci_dev *dev,
>>  {
>>       int ret = 0;
>>
>> +     /*
>> +      * Bridges can only signal wakeup on behalf of subordinate devices,
>> +      * but that is set up elsewhere, so skip them.
>
> A specific pointer to this "elsewhere" would be useful here.

OK
