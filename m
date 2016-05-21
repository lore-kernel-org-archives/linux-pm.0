From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v8 2/4] power: reset: add reboot mode driver
Date: Sat, 21 May 2016 11:27:53 -0700
Message-ID: <CAOCOHw7-YEH7aNhA57OscdJQC7aftDx0+MfHgAJR6SPRGNCNpw@mail.gmail.com>
References: <1461567051-21734-1-git-send-email-andy.yan@rock-chips.com>
	<1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35405 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbcEUS1y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 14:27:54 -0400
Received: by mail-ig0-f180.google.com with SMTP id bi2so11471987igb.0
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2016 11:27:53 -0700 (PDT)
In-Reply-To: <1461567336-21834-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, heiko@sntech.de, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, sre@kernel.org, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, dbaryshkov@gmail.com, David Woodhouse <dwmw2@infradead.org>, alexandre.belloni@free-electrons.com, moritz.fischer@ettus.com, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org

On Sun, Apr 24, 2016 at 11:55 PM, Andy Yan <andy.yan@rock-chips.com> wrote:
[..]
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig

[..]

> +config SYSCON_REBOOT_MODE
> +       bool "Generic SYSCON regmap reboot mode driver"
> +       depends on OF

As this isn't really useful without syscon (but still compiles), I
would suggest adding:

depends on SYSCON || COMPILE_TEST

> +       select REBOOT_MODE
> +       help
> +         Say y here will enable reboot mode driver. This will
> +         get reboot mode arguments and store it in SYSCON mapped
> +         register, then the bootloader can read it to take different
> +         action according to the mode.
> +
>  endif
>

[..]

> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c

[..]

> +
> +#define PREFIX "mode-"
> +
> +struct mode_info {
> +       const char *mode;
> +       unsigned int magic;

If you're using of_property_read_u32() to populate this directly you
should have this as u32.

> +       struct list_head list;
> +};
> +
> +static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> +                                const char *cmd)

Magic comes from an unsigned property and is passed as unsigned to the
regmap api. Please make it unsigned int throughout the implementation.

> +{
> +       const char *normal = "normal";
> +       int magic = 0;
> +       struct mode_info *info;
> +
> +       if (!cmd)
> +               cmd = normal;
> +
> +       list_for_each_entry(info, &reboot->head, list) {
> +               if (!strcmp(info->mode, cmd)) {
> +                       magic = info->magic;
> +                       break;
> +               }
> +       }
> +

[..]

> +int reboot_mode_register(struct reboot_mode_driver *reboot)
> +{
> +       struct mode_info *info;
> +       struct property *prop;
> +       struct device_node *np = reboot->dev->of_node;
> +       size_t len = strlen(PREFIX);
> +       int ret;
> +
> +       INIT_LIST_HEAD(&reboot->head);
> +
> +       for_each_property_of_node(np, prop) {
> +               if (len > strlen(prop->name) || strncmp(prop->name, PREFIX, len))

There's no reason to iterate over the string twice here, strncmp will
exit with -1 if you hit a '\0' before strlen(PREFIX). So you can drop
the first check without any difference in functionality.

What passes this checkout though is if the property equals PREFIX, but
this is probably better to handle as an error, rather than skip over.
So do that below

> +                       continue;
> +
> +               info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
> +               if (!info) {
> +                       ret = -ENOMEM;
> +                       goto error;
> +               }
> +
> +               info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);

You need something like this here:

if (!info->mode) {
    ret = -ENOMEM;
    goto error;
} else if (info->mode[0] == '\0')
    dev_err("mode too short");
    ret = -EINVAL;
    goto error;
}


If you do the kernel a favor and submit a patch to
drivers/base/devres.c adding devm_kstrdup_const() you don't have to do
the goto dance at all.

> +               if (of_property_read_u32(np, prop->name, &info->magic)) {
> +                       dev_err(reboot->dev, "reboot mode %s without magic number\n",
> +                               info->mode);
> +                       devm_kfree(reboot->dev, info);
> +                       continue;
> +               }
> +               list_add_tail(&info->list, &reboot->head);
> +       }
> +
> +       reboot->reboot_notifier.notifier_call = reboot_mode_notify;
> +       ret = register_reboot_notifier(&reboot->reboot_notifier);
> +       if (ret)
> +               dev_err(reboot->dev, "can't register reboot notifier\n");

You're returning an error but haven't freed your info->modes.

> +
> +       return ret;
> +
> +error:
> +       list_for_each_entry(info, &reboot->head, list)
> +               kfree_const(info->mode);
> +
> +       return ret;
> +}

Regards,
Bjorn
