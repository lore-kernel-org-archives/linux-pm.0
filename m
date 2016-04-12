From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Documentation: power: reset: move gpio-{poweroff|restart} to proper place
Date: Tue, 12 Apr 2016 18:00:53 +0200
Message-ID: <1460476853-3306-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I did only find them after a fuzzy search, so let them be where one
would expect them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/{gpio => power/reset}/gpio-poweroff.txt | 0
 Documentation/devicetree/bindings/{gpio => power/reset}/gpio-restart.txt  | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{gpio => power/reset}/gpio-poweroff.txt (100%)
 rename Documentation/devicetree/bindings/{gpio => power/reset}/gpio-restart.txt (100%)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
similarity index 100%
rename from Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
rename to Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
diff --git a/Documentation/devicetree/bindings/gpio/gpio-restart.txt b/Documentation/devicetree/bindings/power/reset/gpio-restart.txt
similarity index 100%
rename from Documentation/devicetree/bindings/gpio/gpio-restart.txt
rename to Documentation/devicetree/bindings/power/reset/gpio-restart.txt
-- 
2.7.0

