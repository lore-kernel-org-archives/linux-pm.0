From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Thu, 24 Oct 2013 07:47:35 +0530
Message-ID: <CAKohpokz2SJnB1_uejtE1opmJ1ReSGO8urjMV7v3ihNX6N-qZg@mail.gmail.com>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
	<CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
	<20131023135116.GC31126@lunn.ch>
	<CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
	<20131023143657.GA31536@lunn.ch>
	<CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
	<20131023145915.GA31745@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:35838 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab3JXCRg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 22:17:36 -0400
Received: by mail-oa0-f52.google.com with SMTP id n10so1778433oag.39
        for <linux-pm@vger.kernel.org>; Wed, 23 Oct 2013 19:17:36 -0700 (PDT)
In-Reply-To: <20131023145915.GA31745@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 23 October 2013 20:29, Andrew Lunn <andrew@lunn.ch> wrote:
> So you want to know if WFI exits without an interrupt being delivered?

Yeah..

> The Marvell documentation says the interrupt should be enabled, but we
> can try it with it disabled.

Yes, that will work.. So we will not explicitly disable interrupt but let kernel
do it for us (i.e. by not registering an interrupt handler)..
