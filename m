From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI/PM: D3cold support for system suspend
Date: Thu, 4 Apr 2013 12:26:52 -0600
Message-ID: <CAErSpo6m=3txSUH5Bwm7Y7K=25UWA4-kgPs_fs-Pa8jkP5WRDA@mail.gmail.com>
References: <1359434058-15918-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44758 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764480Ab3DDS1N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 14:27:13 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so706085obc.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2013 11:27:13 -0700 (PDT)
In-Reply-To: <1359434058-15918-1-git-send-email-ying.huang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Mon, Jan 28, 2013 at 9:34 PM, Huang Ying <ying.huang@intel.com> wrote:
> [PATCH 1/4] PCI/ACPI: Add target state as parameter to pci_platform_pm_ops->run_wake
> [PATCH 2/4] PCI: Rename pci_dev->runtime_d3cold to pci_dev->set_d3cold
> [PATCH 3/4] PCI/PM: Set pci_dev->set_d3cold in pci_set_power_state
> [PATCH 4/4] PCI/PM: Enable D3cold support for system suspend

Do we still need these?

What problem do they solve?  Or what new functionality do they add?
