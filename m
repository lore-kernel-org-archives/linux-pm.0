From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH 0/2] power: supply: bq24735: poll register if no ac-detect gpio
Date: Wed, 21 Dec 2016 22:29:51 +0100
Message-ID: <1482355793-16190-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi!

My patch [1] "power: supply: bq24735-charger: allow chargers to share the
ac-detect gpio" is perhaps a bit hard to digest. And while I still think
some way of sharing the ac-detect gpio is worthwhile, I thought of another
way to solve the problem at hand. Instead of polling a shared gpio, it's
as simple as polling the chip for what it is outputting on the ACOK pin.
And the code is already there! It just needs a tweak to allow this mode of
operation.

This appears to work just fine for me, and the difference is in the noise
since my shared gpio pin happens to be on an expander on the i2c bus, so
I end up with i2c traffic for each poll either way.

Cheers,
peda

[1] https://lkml.org/lkml/2016/12/13/786

Peter Rosin (2):
  power: supply: bq24735: allow polling even if there is no ac-detect
    gpio
  power: supply: bq24735: bring down the noise level

 Documentation/devicetree/bindings/power/supply/ti,bq24735.txt | 4 ++--
 drivers/power/supply/bq24735-charger.c                        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
