From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / PCI: Do not resume any devices in pci_pm_prepare()
Date: Tue, 26 Sep 2017 23:39:29 +0200
Message-ID: <CAJZ5v0gTZrRyF_ne3UP88HKUjXcdVCWHuPHLRhB9qS6aoHcddQ@mail.gmail.com>
References: <1877076.QiUpNxchJO@aspire.rjw.lan> <20170926213455.GU15970@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:46567 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966606AbdIZVja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2017 17:39:30 -0400
In-Reply-To: <20170926213455.GU15970@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Linux PM <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

On Tue, Sep 26, 2017 at 11:34 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, Sep 25, 2017 at 01:33:13AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It should not be necessary to resume devices with ignore_children set
>> in pci_pm_prepare(), because they should be resumed explcitly by
>
> s/explcitly/explicitly/

Yup.

>> their children drivers during suspend if need be and they will be
>> resumed by pci_pm_suspend() after that anyway, so avoid doing that.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I think your previous patches to this file mostly used a "PCI / PM"
> subject line prefix (as opposed to the "PM / PCI" here).  But maybe
> the difference means something?

No, it doesn't.  I'll change it to match the previous ones. :-)

Thanks,
Rafael
