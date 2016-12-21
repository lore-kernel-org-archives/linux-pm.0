From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Wed, 21 Dec 2016 17:41:36 +0100
Message-ID: <20161221164136.GM30952@lunn.ch>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
 <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth>
 <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw@mail.gmail.com>
 <20161221155929.o4ihvqezbuqx2stl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161221155929.o4ihvqezbuqx2stl@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

> These models can just be added to qnap-poweroff, which handles
> exactly this special case as far as I can see.

Nope, qnap is much, much simpler. The configuration of the serial port
is simpler, and it only needs to send a single byte. Here we have all
sorts of checksums to calculate, stuff coming back from the
microcontroller, etc. The complexity is much higher.

V1 of this patchset did extend the qnap driver. But in fact, very
little of the original code was left afterwards, and lots of new code
was added. So i requested a new driver be written, rather than extend
my qnap driver.

I would not like to see the nice and simple qnap driver get all this
code added to it, making it much harder to maintain, for very little
gain.

     Andrew
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
