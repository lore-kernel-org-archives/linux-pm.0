From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 09/12] PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
Date: Tue, 31 Oct 2017 15:09:33 +0000
Message-ID: <20171031150933.oho2ffvuj3iagx4m@dell>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <5094729.JAaD38WncM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5094729.JAaD38WncM@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Oct 2017, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the intel-lpss driver set DPM_FLAG_SMART_SUSPEND for its
> devices which will allow them to stay in runtime suspend during
> system suspend unless they need to be reconfigured for some reason.
> 
> Also make it avoid resuming its child devices if they have
> DPM_FLAG_SMART_SUSPEND set to allow them to remain in runtime
> suspend during system suspend.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/mfd/intel-lpss.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Is this patch independent?

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
