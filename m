From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain look-up
Date: Tue, 09 Sep 2014 15:45:20 +0200
Message-ID: <1916405.TGJZ1EAH2O@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> <8273189.CFBBe805uk@vostro.rjw.lan> <20140909114051.GT2601@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140909114051.GT2601@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@co>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 09, 2014 12:40:51 PM Mark Brown wrote:
> 
> --FJ0JV+AOCbvjFtNn
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Mon, Sep 08, 2014 at 11:26:49PM +0200, Rafael J. Wysocki wrote:
> 
> > The s-o-b is more of a gray area, but again it is supposed to be possible
> > to verify which it won't be if it bounces.
> 
> That's always going to be an issue with signoffs - people's addresses
> can and do go bad at any point.

I know and that's a gray area as I said.

Whether or not it is appropriate to submit a patch with an s-o-b that is known
to bounce is a good question to me.

It is true, though, that this particular patch was originally submitted when
the s-o-b address didn't bounce, so I may restore the tag when applying the
patch.  Need to think about that.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
