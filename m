From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 23 Oct 2013 09:59:26 +0530
Message-ID: <CAKohpo=7nw4ECXg_5e2wJQ8-+ie4Q0cuC+LpLOAePJ6AmCT2EQ@mail.gmail.com>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
	<1382186261-14482-2-git-send-email-andrew@lunn.ch>
	<CAKohpok2scsSU7eFOP5LYmQar8xfOqG4-b3z4sVS6JOgnxVcpw@mail.gmail.com>
	<20131022155758.GA26694@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:48378 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3JWE31 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2013 00:29:27 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so284738oah.19
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2013 21:29:27 -0700 (PDT)
In-Reply-To: <20131022155758.GA26694@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 22 October 2013 21:27, Andrew Lunn <andrew@lunn.ch> wrote:
> The hardware raises an interrupt when the change is complete. This
> interrupt is what brings the CPU out of the WFI. I don't know the
> interrupt code too well, but i think it is necessary for the driver to
> acknowledged it. The interrupt core code counts interrupts which
> nobody acknowledges, and after 1000 are received, it disables the
> interrupt. That would probably result in the machine locking solid,
> never coming out of the WFI. So i'm playing it safe and handling the
> interrupt.

Theory looks correct AFAIK.. But it would be better to give it a try
on real hardware, hopefully you have that :)

Also, in case this is required, it would be better to document it a bit
over the routine..

> In theory yes. In practice no. It is a fixed rate clock. prepare and
> enable are actually NOPs for this type of clock. However the API
> documentation explicitly states you need to call prepare and enable
> before you can call clk_get_rate(). But i can add error checking if
> you want.

Leave it then..
