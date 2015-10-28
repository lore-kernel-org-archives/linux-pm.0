From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3][v2] Fix incorrect using of acpi irq
Date: Wed, 28 Oct 2015 04:19:49 +0100
Message-ID: <3737060.CpjVzmXRgF@vostro.rjw.lan>
References: <1445706127-20110-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445706127-20110-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, October 25, 2015 01:02:07 AM Chen Yu wrote:
> This series of patches are trying to convert codes who use
> acpi_gbl_FADT.sci_interrupt incorrectly to use the right irq
> mapped by acpi_gsi_to_irq.
> 
> Chen Yu (3):
>   ACPI: Using correct irq when uninstalling acpi irq handler
>   ACPI: Using correct irq when waiting for events
>   ACPI / PM: Fix incorrect wakeup irq setting before suspend-to-idle
> 
>  drivers/acpi/osl.c   | 14 +++++++++-----
>  drivers/acpi/sleep.c |  6 ++++--
>  include/linux/acpi.h |  6 ++++++
>  3 files changed, 19 insertions(+), 7 deletions(-)

Series applied (with some minor changes to patch subjects and changelogs).

Thanks,
Rafael
