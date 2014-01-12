From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
Date: Sun, 12 Jan 2014 19:53:37 +0100
Message-ID: <20140112185337.GA6810@amd.pavel.ucw.cz>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
 <20140112114717.GA31318@amd.pavel.ucw.cz>
 <52D287B1.3090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D287B1.3090106@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> >Could we get some more descriptive names for the domains?
> 
> They are listed like this in user's manual, e.g. DOMAIN_F, DOMAIN_I,
> DOMAIN_G, etc.

I guessed so. So the manual sucks. Would it be feasible to get it more
descriptive (like "Domain_G (GPU)")?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
