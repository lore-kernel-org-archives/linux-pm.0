From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Tue, 13 Jun 2017 12:24:42 +0200
Message-ID: <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com> <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34208 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdFMKYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 06:24:44 -0400
Received: by mail-qt0-f178.google.com with SMTP id c10so164670624qtd.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 03:24:43 -0700 (PDT)
In-Reply-To: <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Heiko Stuebner <heiko@sntech.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Philipp Zabel <p.zabel@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux USB List <linux-usb@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, "Maciej S. Szmigiero" <mail@maciej.szmigi>

[...]

> +
> +/**
> + * of_pwrseq_on - Carry out power sequence on for device node
> + *
> + * @np: the device node would like to power on
> + *
> + * Carry out a single device power on.  If multiple devices
> + * need to be handled, use of_pwrseq_on_list() instead.
> + *
> + * Return a pointer to the power sequence instance on success,
> + * or an error code otherwise.
> + */
> +struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +       struct pwrseq *pwrseq;
> +       int ret;
> +
> +       pwrseq = pwrseq_find_available_instance(np);
> +       if (!pwrseq)
> +               return ERR_PTR(-ENOENT);

In case the pwrseq instance hasn't been registered yet, then there is
no way to deal with -EPROBE_DEFER properly here.

I haven't been following the discussions in-depth during all
iterations, so perhaps you have already discussed why doing it like
this.

Anyway, that means all pwrseq instances needs to be registered an
early boot level, to be safe. To me, that seems like poor design
choice.

[...]

Otherwise I think this looks okay to me.

Kind regards
Uffe
