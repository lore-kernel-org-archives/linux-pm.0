From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86, arm64, acpi: Handle lapic/x2apic entries in MADT
Date: Fri, 28 Aug 2015 10:30:35 +0200
Message-ID: <20150828083035.GA17842@gmail.com>
References: <55DDB45D.2030901@arm.com>
 <1440611369-26314-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35281 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbH1Iak (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 04:30:40 -0400
Content-Disposition: inline
In-Reply-To: <1440611369-26314-2-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Cc: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>


* Lukasz Anaczkowski <lukasz.anaczkowski@intel.com> wrote:

> This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
> previously published at https://lkml.org/lkml/2013/1/21/563,
> thus putting Yinghai Lu as 'Signed-off-by', as well.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/acpi/boot.c |  29 ++++++++----
>  drivers/acpi/numa.c         |  28 ++++++++---
>  drivers/acpi/tables.c       | 113 +++++++++++++++++++++++++++++++++-----------
>  drivers/irqchip/irq-gic.c   |  15 ++++--
>  include/linux/acpi.h        |  13 ++++-
>  5 files changed, 149 insertions(+), 49 deletions(-)

Yeah, so this patch is way too large, it should be split into 3-4 parts that first 
introduce separate changes (such as renames), then add any extra functions that 
might be needed, and finally does the minimal changes that actually change 
behavior.

Thanks,

	Ingo
