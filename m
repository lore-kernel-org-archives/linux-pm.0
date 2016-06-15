From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 4/6] PM / Hibernate: Allow architectures to specify the
 hibernate/resume CPU
Date: Wed, 15 Jun 2016 23:10:08 +0200
Message-ID: <CAJZ5v0ipRONyMe15k=-FhcKEGM6kMh5Vu35XQexBr0SMYQoktQ@mail.gmail.com>
References: <1466012148-7674-1-git-send-email-james.morse@arm.com> <1466012148-7674-5-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35111 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbcFOVKK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jun 2016 17:10:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so6861722wme.2
        for <linux-pm@vger.kernel.org>; Wed, 15 Jun 2016 14:10:10 -0700 (PDT)
In-Reply-To: <1466012148-7674-5-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>

On Wed, Jun 15, 2016 at 7:35 PM, James Morse <james.morse@arm.com> wrote:
> On arm64 the cpu with logical id 0 is assumed to be the boot CPU. If a
> user hotplugs this CPU out, then uses kexec to boot a new kernel, the new
> kernel will assign logical id 0 to a different physical CPU.
> This breaks hibernate as hibernate and resume will be attempted on different
> CPUs.
>
> Define a weak symbol arch_hibernation_disable_cpus(), which defaults to
> calling disable_nonboot_cpus). Architectures that allow CPU 0 to be
> hotplugged can use this to control which CPU is used for hibernate/resume.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
> If this approach is acceptable, this patch should go with 4&5 via the arm64
> tree.

I'm not entirely happy with this, but if you absolutely need it and if
you can't think about any cleaner way to achieve the goal, feel free
to add my ACK to this patch if necessary.

>  kernel/power/hibernate.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index fca9254280ee..0e668a3207ec 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -70,6 +70,16 @@ bool hibernation_available(void)
>  }
>
>  /**
> + * arch_hibernation_disable_cpus - Allow architectures to direct which CPU
> + * is used for suspend or resume.
> + * @suspend: True during hibernate, false for resume.
> + */
> +int __weak arch_hibernation_disable_cpus(__maybe_unused bool suspend)
> +{
> +       return disable_nonboot_cpus();
> +}
> +
> +/**
>   * hibernation_set_ops - Set the global hibernate operations.
>   * @ops: Hibernation operations to use in subsequent hibernation transitions.
>   */
> @@ -279,7 +289,7 @@ static int create_image(int platform_mode)
>         if (error || hibernation_test(TEST_PLATFORM))
>                 goto Platform_finish;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(true);
>         if (error || hibernation_test(TEST_CPUS))
>                 goto Enable_cpus;
>
> @@ -433,7 +443,7 @@ static int resume_target_kernel(bool platform_mode)
>         if (error)
>                 goto Cleanup;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(false);
>         if (error)
>                 goto Enable_cpus;
>
> @@ -551,7 +561,7 @@ int hibernation_platform_enter(void)
>         if (error)
>                 goto Platform_finish;
>
> -       error = disable_nonboot_cpus();
> +       error = arch_hibernation_disable_cpus(true);
>         if (error)
>                 goto Enable_cpus;
>
> --
