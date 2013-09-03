From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 02/27] gpiolib-acpi: convert acpi_evaluate_object() to
 acpi_execute_simple_method()
Date: Tue, 3 Sep 2013 10:17:57 +0300
Message-ID: <20130903071757.GW7393@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
 <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:23687 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927Ab3ICHMa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Sep 2013 03:12:30 -0400
Content-Disposition: inline
In-Reply-To: <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

On Tue, Sep 03, 2013 at 08:31:50AM +0800, Zhang Rui wrote:
> acpi_execute_simple_method() is a new ACPI API introduced to invoke
> an ACPI control method that has single integer parameter and no return value.
> 
> Convert acpi_evaluate_object() to acpi_execute_simple_method()
> in drivers/gpio/gpiolib-acpi.c
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> CC: Mathias Nyman <mathias.nyman@linux.intel.com>
> CC: Mika Westerberg <mika.westerberg@linux.intel.com>

Nice!

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
