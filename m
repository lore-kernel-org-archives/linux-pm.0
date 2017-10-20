From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Fri, 20 Oct 2017 15:46:07 -0500
Message-ID: <20171020204607.GQ6332@bhelgaas-glaptop.roam.corp.google.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 16, 2017 at 03:12:35AM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> Well, this took more time than expected, as I tried to cover everything I had
> in mind regarding PM flags for drivers.

For the parts that touch PCI,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I doubt there'll be conflicts with changes in my tree, but let me know if
you trip over any so I can watch for them when merging.

Bjorn
