From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 23 Oct 2013 20:30:02 +0530
Message-ID: <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
	<CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
	<20131023135116.GC31126@lunn.ch>
	<CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
	<20131023143657.GA31536@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41603 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3JWPAE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 11:00:04 -0400
Received: by mail-ob0-f175.google.com with SMTP id wm4so904419obc.34
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2013 08:00:03 -0700 (PDT)
In-Reply-To: <20131023143657.GA31536@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 23 October 2013 20:06, Andrew Lunn <andrew@lunn.ch> wrote:
>> So, you have actually tested your code without interrupt handler?
>
> No.

It would be better if you atleast try this and confirm that this dummy
handler is required.

>> What exactly happens in that case?
>
> Take a look at request_threaded_irq(). It contains:
>
> 1421         if (!handler) {
> 1422                 if (!thread_fn)
> 1423                         return -EINVAL;
>
> So devm_request_irq() will fail, and so the probe function will fail.

Obviously I wanted you to remove all irq specific code and hence
devm_request_irq() :)
