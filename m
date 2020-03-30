Return-Path: <SRS0=kFxE=5P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C646C43331
	for <linux-pm@archiver.kernel.org>; Mon, 30 Mar 2020 05:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006DD20780
	for <linux-pm@archiver.kernel.org>; Mon, 30 Mar 2020 05:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FklpY26X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgC3Fd6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:33:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41097 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgC3Fd6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 01:33:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so17758286qke.8;
        Sun, 29 Mar 2020 22:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=TvWzKkYFcT/K0oIgPGrhoik5wBx/4H13zpvGqzjSYkE=;
        b=FklpY26XWLIPwB2xNmljWmzrY6KioJytzALrAqFR8/uz/IDUwXIZz8yxfJgZ8h1jPu
         1U7WypEfu6NedFNeG9VVZ8Xj/1FZrFPUmU5l/OQV3aygioko88YG4v9ci/3OjLHzbfQ+
         +CpYZBQ0kXDB3vVMNTkuvaVIQDYdoyb37FVCVg1VXcipEBs/ku/WGJ/6RpXnRiEkiwlo
         wGB+PFDQt3w3YcztdFx3+vg7Fak0yV0pA15LloY/mP8wvK3+3V4aYwKwxK1hx6VqK3Yk
         79QFcWj9WdLOiCMWqfQsf+bigAVVY4xb3dyYTBKwfqGP9cAMQmnBbUzhIef1fjq2lnSD
         Hsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TvWzKkYFcT/K0oIgPGrhoik5wBx/4H13zpvGqzjSYkE=;
        b=d1zIWofqeWhs2iIhJszPrX65kW+0JY4MlilIvcN4fy+C9JlI8EquX+Jen6rYiIbf5g
         vDERKzg5i1/N0z2lZZub+qBwEEQYUalGTzYgGdD9xiW6KLKP6dcNuSxqeqpFctx0BMKg
         gCEedtKR/p8D4hNPE287oUJk2soar05vWlUES2r3lwFdA++YJ/2Nu0GgzVpJjXMoGlMp
         KWGfiEMQEFMGAoZ1H2S8FMNKqQaVBRYyJ6iTmwaCKizAxO3UsdWI4FuBS/fmcRROiHmw
         KjpGk/RGN6YE5gT8uAY0UUe3GDKVHFrsU3m0S7c7SZj1TirI/vBloheMSaN2L2o6EJvk
         QSdg==
X-Gm-Message-State: ANhLgQ0TqCJ3JJ9jhpZ56L3js8keBnXIraZUW1nuyG7AQAk+ydiJHCKm
        Z73gFMH5Eo51P/zH2xZBqPsQAcap+O8=
X-Google-Smtp-Source: ADFU+vsl+Mls90arlqKr2QZj0zBIml+lQgHGpmSH6avRTtpcwpX1lPy2hIJg3y3OV5tlWqDqqHe+EA==
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr10029700qkb.121.1585546437276;
        Sun, 29 Mar 2020 22:33:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-39-36-110.hsd1.dc.comcast.net. [73.39.36.110])
        by smtp.gmail.com with ESMTPSA id q44sm10797571qtq.11.2020.03.29.22.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 22:33:56 -0700 (PDT)
Date:   Mon, 30 Mar 2020 01:33:55 -0400
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gneukum1@gmail.com
Subject: [PATCH] power: supply: max17042_battery: Add support for the TTE_NOW
 prop
Message-ID: <20200330053352.GA28178@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The max170{42,47,50,55} family of fuel gauges all provide time-to-empty
estimation. As such, let's export this as a property.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 69ec4295d55d..f284547913d6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -87,6 +87,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
 };

 static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
@@ -411,6 +412,13 @@ static int max17042_get_property(struct power_supply *psy,
 			return -EINVAL;
 		}
 		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
+		ret = regmap_read(map, MAX17042_TTE, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = data * 5625 / 1000;
+		break;
 	default:
 		return -EINVAL;
 	}
--
2.18.1

