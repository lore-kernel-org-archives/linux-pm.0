From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 4/4] x86, acpi: Handle apic/x2apic entries in MADT in
 correct order
Date: Tue, 08 Sep 2015 16:22:12 +0100
Message-ID: <55EEFD24.1050606@arm.com>
References: <20150827093738.GA21134@red-moon> <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-4-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-5-git-send-email-lukasz.anaczkowski@intel.com> <1441710480-17622-6-git-send-email-lukasz.anaczkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55121 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839AbbIHPWR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 11:22:17 -0400
In-Reply-To: <1441710480-17622-6-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

On 08/09/15 12:08, Lukasz Anaczkowski wrote:
> ACPI specifies the following rules when listing APIC IDs:
> (1) Boot processor is listed first
> (2) For multi-threaded processors, BIOS should list the first logical
>     processor of each of the individual multi-threaded processors in MADT
>     before listing any of the second logical processors.
> (3) APIC IDs < 0xFF should be listed in APIC subtable, APIC IDs >= 0xFF
>     should be listed in X2APIC subtable

[snip]

> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index ececeac..bc23220 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -239,6 +239,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
>  	struct acpi_subtable_header *entry;
>  	int count = 0;
>  	unsigned long table_end;
> +	int i;
>  
>  	if (acpi_disabled)
>  		return -ENODEV;
> @@ -269,7 +270,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
>  		for (i = 0; i < proc_num; i++) {
>  			if (entry->type != proc[i].id)
>  				continue;
> -			if (!proc->handler || proc[i].handler(entry, table_end)) {
> +			if (!proc->handler || proc[i].handler(entry, table_end))
>  				return -EINVAL;

This needs to be moved into the right patch, because this is otherwise
not bisectable...

	M.
-- 
Jazz is not dead. It just smells funny...
