Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ABDC64E8A
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7D2076E
	for <linux-pm@archiver.kernel.org>; Mon, 30 Nov 2020 14:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tsy7npY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgK3OBF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:01:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbgK3OBF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Nov 2020 09:01:05 -0500
Received: from zn.tnic (p200300ec2f0c0400b0063e9f0046aa3d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:400:b006:3e9f:46:aa3d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E46041EC04A9;
        Mon, 30 Nov 2020 15:00:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606744823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xj2jygsCeX42+vFyods3vwWNbd1IGvv+nMyXKR9Pfz0=;
        b=Tsy7npY3a8YC+RV/vZhRSz8qTprIVhuW0z/j3J5RdqdoEtYTpYYYvyG2W2fw0Ub4jA/4Te
        6JKLJ6MFeF2mkrzMFHe83MYBafaVxcrGhJhyWobyIgfhQz89XB98OeXji+bqwIQkLPhEHB
        3ZkN/7HSMe7PyMkP+h9ylm6JG6edChQ=
Date:   Mon, 30 Nov 2020 15:00:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     rjw@rjwysocki.net, wei.huang2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [RFC PATCH 3/4] x86/cpu: amd: Define processor families
Message-ID: <20201130140018.GC6019@zn.tnic>
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-4-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201125144847.3920-4-punitagrawal@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 25, 2020 at 11:48:46PM +0900, Punit Agrawal wrote:
> So far, the AMD processor identifier (family, models, stepping) are
> referred to by raw values making it easy to make mistakes. It is also
> harder to read and maintain. Additionally, these values are also being
> used in subsystems outside the arch code where not everybody maybe be
> as familiar with the processor identifiers.
> 
> As a first step towards improving the status quo, add macros for the
> AMD processor families and propagate them through the existing
> cpu_device_id.h header used for this purpose.
> 
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> ---
>  arch/x86/include/asm/amd-family.h    | 18 ++++++++++++++++++
>  arch/x86/include/asm/cpu_device_id.h |  2 ++
>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/x86/include/asm/amd-family.h
> 
> diff --git a/arch/x86/include/asm/amd-family.h b/arch/x86/include/asm/amd-family.h
> new file mode 100644
> index 000000000000..dff4d13b8e74
> --- /dev/null
> +++ b/arch/x86/include/asm/amd-family.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_AMD_FAMILY_H
> +#define _ASM_X86_AMD_FAMILY_H
> +
> +#define AMD_FAM_K5			0x04
> +#define AMD_FAM_K6			0x05
> +#define AMD_FAM_K7			0x06
> +#define AMD_FAM_K8			0x0F
> +#define AMD_FAM_K10			0x10

Fam 0x10 is Greyhound and a lot more core names. I'd let the AMD folks
on Cc say what they wanna call it but I don't think K10 was used
anywhere except outside of AMD. :)

> +#define AMD_FAM_K8_K10_HYBRID		0x11

That was called Griffin so AMD_FAM_GRIFFIN I guess. If not used anywhere
in the tree, no need to add the define. Same holds true for the rest of
the defines - add them only when they're used.

> +#define AMD_FAM_LLANO			0x12
> +#define AMD_FAM_BOBCAT			0x14
> +#define AMD_FAM_BULLDOZER		0x15
> +#define AMD_FAM_JAGUAR			0x16
> +#define AMD_FAM_ZEN			0x17

ZEN2 is also 0x17 but different models so this is where the family
matching scheme doesn't work - you'd need the models too.

0x18 is HYGON

> +#define AMD_FAM_ZEN3			0x19
> +
> +#endif /* _ASM_X86_AMD_FAMILY_H */
> diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
> index eb8fcede9e3b..bbb48ba4c7ff 100644
> --- a/arch/x86/include/asm/cpu_device_id.h
> +++ b/arch/x86/include/asm/cpu_device_id.h
> @@ -12,6 +12,8 @@
>  #include <linux/mod_devicetable.h>
>  /* Get the INTEL_FAM* model defines */
>  #include <asm/intel-family.h>
> +/* Get the AMD model defines */
> +#include <asm/amd-family.h>
>  /* And the X86_VENDOR_* ones */
>  #include <asm/processor.h>
>  
> -- 
> 2.29.2
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
