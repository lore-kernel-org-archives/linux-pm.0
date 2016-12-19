From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Mon, 19 Dec 2016 17:03:45 +0100
Message-ID: <20161219160345.GB16612@lunn.ch>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
 <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:58794 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755195AbcLSQDz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Dec 2016 11:03:55 -0500
Content-Disposition: inline
In-Reply-To: <20161219153802.vhcish35qyjbpevj@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Roger Shimizu <rogershimizu@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

> > +	reset {
> > +		compatible = "linkstation,power-off";
> > +		reg = <0x12100 0x100>;
> > +		clocks = <&core_clk 0>;
> > +	};
> 
> This might be another user for UART slave device [0].
> [0] https://lkml.org/lkml/2016/8/24/769
> 
> Is the UART port used for anything else besides the reset
> controller?

I don't know much about these specific devices, but the qnap
equivalent, there is a user space daemon which also talks to the
microcontroller, for things like a temperature sensor, buzzer, etc.

https://www.hellion.org.uk/qcontrol/

So the UART can be in a messed up state, which is why the QNAP driver,
which this code is modelled on, reset it back to a good state.

      Andrew
