From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/5] ACPI / ARM64: remove usage of
 BAD_MADT_ENTRY/BAD_MADT_GICC_ENTRY
Date: Fri, 7 Aug 2015 17:57:01 +0100
Message-ID: <20150807165701.GI19308@e104818-lin.cambridge.arm.com>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>
 <1438894770-31163-3-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43673 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbbHGQ5G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Aug 2015 12:57:06 -0400
Content-Disposition: inline
In-Reply-To: <1438894770-31163-3-git-send-email-al.stone@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, patches@linaro.org, Marc Zyngier <marc.zyngier@arm.com>, linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Thu, Aug 06, 2015 at 02:59:27PM -0600, Al Stone wrote:
> Now that we have introduced the bad_madt_entry() function, and that
> function is being invoked in acpi_table_parse_madt() for us, there
> is no longer any need to use the BAD_MADT_ENTRY macro, or in the case
> of arm64, the BAD_MADT_GICC_ENTRY, too.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
