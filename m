From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 23 Oct 2013 19:55:12 +0530
Message-ID: <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
	<CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
	<20131023135116.GC31126@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:55981 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3JWOZN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 10:25:13 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so877899oag.35
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2013 07:25:12 -0700 (PDT)
In-Reply-To: <20131023135116.GC31126@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 23 October 2013 19:21, Andrew Lunn <andrew@lunn.ch> wrote:
> There does seem to be a convention that kernel.h and module.h come
> first, and then i have the rest in order.

Atleast I am not aware of any such convention and so got
confused.

> +/*
> + * Handle the interrupt raised when the frequency change is
> + * complete.
> + */
> +static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
> +{
> +       return IRQ_HANDLED;
> +}
>
> What more would you like to see in the comment?

Ahh.. I read it as "Commented interrupt handler and so it is no
more registered" :)

So, you have actually tested your code without interrupt handler?
What exactly happens in that case?
