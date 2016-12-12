From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/3] bq24735-charger: allow gpio polling and sharing
Date: Mon, 12 Dec 2016 12:00:21 +0100
Message-ID: <1481540424-19293-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

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
Peter

Peter Rosin (3):
  power: supply: bq24735-charger: simplify register update to stop
    charging
  power: supply: bq24735-charger: optionally poll the ac-detect gpio
  power: supply: bq24735-charger: allow chargers to share the ac-detect
    gpio

 .../bindings/power/supply/ti,bq24735.txt           |   2 +
 drivers/power/supply/bq24735-charger.c             | 154 ++++++++++++++++++---
 2 files changed, 138 insertions(+), 18 deletions(-)

-- 
2.1.4
