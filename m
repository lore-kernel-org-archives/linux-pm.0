From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/2] power: supply: ltc2941-battery-gauge: Add support
 for LTC2942
Date: Mon, 12 Jun 2017 20:07:41 +0200
Message-ID: <20170612180741.indbu2qkt6hz7ji4@lenoch>
References: <20170612150226.woxfdi4lharq5gtq@lenoch>
 <20170612150453.kjsyu5jjsfb7kzoq@lenoch>
 <c854309e-68b0-c1f2-a7f8-3161e38e1579@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:51820 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdFLSHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 14:07:46 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990644AbdFLSHochhNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 20:07:44 +0200
Content-Disposition: inline
In-Reply-To: <c854309e-68b0-c1f2-a7f8-3161e38e1579@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Mon, Jun 12, 2017 at 06:29:54PM +0200, Mike Looijmans wrote:
> ﻿On 12-6-2017 17:04, Ladislav Michl wrote:
> > LTC2942 is pin compatible with LTC2941 providing additional
> > informations about battery voltage and temperature. It can
> > be runtime detected using bit A7 in the Status register.
> 
> Runtime detection is always nice. I'd suggest adding "ltc2942" to the device
> name list, since having to specify "ltc2941" when the chip is in fact an
> "ltc2942" looks a bit strange.

It is not that strange after the one who would otherwise blindly type ltc2942
reads the datasheet ;-)

> Again, no strong preference, whatever the maintainers think is best is fine
> with me also.

What about adding something like this?

diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
index a9d7aa60558b..0d065d54d294 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
@@ -1,9 +1,10 @@
-binding for LTC2941 and LTC2943 battery gauges
+binding for LTC2941, LTC2942 and LTC2943 battery gauges
 
-Both the LTC2941 and LTC2943 measure battery capacity.
-The LTC2943 is compatible with the LTC2941, it adds voltage and
-temperature monitoring, and uses a slightly different conversion
-formula for the charge counter.
+All chips measure battery capacity.
+The LTC2942 is pin compatible with the LTC2941, it adds voltage and
+temperature monitoring, and is runtime detected. LTC2943 is software
+compatible, uses a slightly different conversion formula for the
+charge counter and adds voltage, current and temperature monitoring.
 
 Required properties:
 - compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also
