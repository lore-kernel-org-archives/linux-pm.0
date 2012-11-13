From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -v2] ACPI/PCI: Make PCI devices notified when its power
 resource turned on
Date: Tue, 13 Nov 2012 11:58:44 -0700
Message-ID: <CAErSpo6LqWfXd3NY2pDsE0RmWNKApyF+Lbv8_Bvq3ULMuy7Bvw@mail.gmail.com>
References: <1352249879-11406-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352249879-11406-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 6, 2012 at 5:57 PM, Huang Ying <ying.huang@intel.com> wrote:
> A set of power resources may be shared by multiple devices.  When all
> devices share one set of power resources is put into D3_COLD state,
> the power resources will be turned off.  When one of the device is
> waked, the power resource will be turned on and all devices share it
> will be powered on to D0uninitialized state.  These devices should be
> resumed, so that they can get opportunity to go to low power state
> later.
>
> v2:
>
> - Fix build error
>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_bind.c |    2 ++
>  1 file changed, 2 insertions(+)

I applied this to my pci/misc branch as v3.8 material.  Thanks!

Bjorn
