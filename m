From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain look-up
Date: Mon, 08 Sep 2014 23:26:49 +0200
Message-ID: <8273189.CFBBe805uk@vostro.rjw.lan>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org> <3105400.7vSnq2rA6s@vostro.rjw.lan> <CAMuHMdURbp8a0Ps2sZUZn7UHcWXZvRgS-4ubk1r=wGgXZ1PHmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdURbp8a0Ps2sZUZn7UHcWXZvRgS-4ubk1r=wGgXZ1PHmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie@kernel>
List-Id: linux-pm@vger.kernel.org

On Monday, September 08, 2014 10:53:09 PM Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Mon, Sep 8, 2014 at 11:08 PM, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> > BTW, I get bounces from t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, so I won't apply the patch with
> > that as the "From" field.  And the s-o-b from a bouncing address is worthless
> > too.
> 
> In the mean time, Tomasz has moved:
> http://www.spinics.net/lists/arm-kernel/msg357102.html
> 
> Still, the From/SoB indicate attribution to Samsung, so I think it should be
> kept.

The "From:" field should point to a submitter's address that is actually active,
so that (s)he can handle problem reports *sent* *to* *that* address.  I'm not
going to apply anything with a bouncing "From:".

The s-o-b is more of a gray area, but again it is supposed to be possible
to verify which it won't be if it bounces.

Also note that this is not Tomasz who is submitting this patch today, but Ulf
who doesn't even work for Samsung as far as I know.

So I'd suggest using "Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>" as a "From:", remove
his s-o-b entirely (and using the Ulf's one only) and add something like that
to the changelog:

"This patch was originally submitted by Tomasz Figa when he was employed
 by Samsung.

 Link: <URL-of-the-original-submission>"

This way Samsung will get the recognition and there won't be bouncing addresses
in tags etc.

Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
