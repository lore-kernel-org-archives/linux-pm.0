From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/3] bq24735-charger: allow gpio polling and sharing
Date: Wed, 14 Dec 2016 00:56:42 +0100
Message-ID: <1481673405-4547-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:18713
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbcLNALQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Dec 2016 19:11:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi!

v1 -> v2 changes:
- use poll-interval instead of ti,poll-interval-ms in the bindings
- properly initialize the shared_lock mutex
- don't share gpios on active low/high mismatch
- don't regress users specifying the old ti,ac-detect-gpio form (without
  the trailing s)

I have a board that features a couple of parallel bq24735 chargers.
However, only one of the chargers has its ACOK pin wired to a gpio,
the other parallel chargers are expected to just behave the same
as the charger that has been singled out like this. Another thing
with the board is that the gpio is not capable of generating an
interrupt.

This series fixes things for me (ok, the first patch was just a
fix for a thing that initially had me confused for a bit, and is
totally unrelated. Ignore if you want to, it's basically just churn).

One thing that I wonder about is if anything should be done to
prevent unloading of the instance that shares its gpio? I thought
about adding a device_link_add() call, but am unsure if that would
be approprite? I'm not unloading drivers at all so it's a total
non-issue for me...

Cheers,
peda

Peter Rosin (3):
  power: supply: bq24735-charger: simplify register update to stop
    charging
  power: supply: bq24735-charger: optionally poll the ac-detect gpio
  power: supply: bq24735-charger: allow chargers to share the ac-detect
    gpio

 .../bindings/power/supply/ti,bq24735.txt           |   2 +
 drivers/power/supply/bq24735-charger.c             | 164 ++++++++++++++++++---
 2 files changed, 148 insertions(+), 18 deletions(-)

-- 
2.1.4

