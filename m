From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 23 Oct 2013 16:59:15 +0200
Message-ID: <20131023145915.GA31745@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
 <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
 <20131023143657.GA31536@lunn.ch>
 <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:43463 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3JWPDn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Oct 2013 11:03:43 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomedpd8XBPcdZX2vHy6b5=FMtbSVpNTG-eVLK1YPyPaMA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 23, 2013 at 08:30:02PM +0530, Viresh Kumar wrote:
> On 23 October 2013 20:06, Andrew Lunn <andrew@lunn.ch> wrote:
> >> So, you have actually tested your code without interrupt handler?
> >
> > No.
> 
> It would be better if you atleast try this and confirm that this dummy
> handler is required.
> 
> >> What exactly happens in that case?
> >
> > Take a look at request_threaded_irq(). It contains:
> >
> > 1421         if (!handler) {
> > 1422                 if (!thread_fn)
> > 1423                         return -EINVAL;
> >
> > So devm_request_irq() will fail, and so the probe function will fail.
> 
> Obviously I wanted you to remove all irq specific code and hence
> devm_request_irq() :)

So you want to know if WFI exits without an interrupt being delivered?
The Marvell documentation says the interrupt should be enabled, but we
can try it with it disabled.

    Andrew
