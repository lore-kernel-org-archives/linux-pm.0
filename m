From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/3] power: supply: ltc2941-battery-gauge: Add LTC2944
 support
Date: Mon, 17 Jul 2017 14:42:03 -0500
Message-ID: <20170717194203.we3rjftj7m6ojxgq@rob-hp-laptop>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
 <20170716093532.w6sqqtadwnbroj3i@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34611 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdGQTmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jul 2017 15:42:05 -0400
Content-Disposition: inline
In-Reply-To: <20170716093532.w6sqqtadwnbroj3i@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>, Dragos Bogdan <dragos.bogdan@analog.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Sun, Jul 16, 2017 at 11:35:32AM +0200, Ladislav Michl wrote:
> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> LTC2944 is compatible with LTC2943, but uses different
> voltage and current computing constants.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  - v2: fixed voltage and current conversion
>  - v3: skipped
>  - v4: skipped
>  - v5: fixed voltage conversion overflow, rebased on LTC2942 patchset
>  - v6: fix missing break in the switch statement
> 
>  .../devicetree/bindings/power/supply/ltc2941.txt   | 12 +++++-----

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/power/supply/ltc2941-battery-gauge.c       | 27 ++++++++++++++++++----
>  2 files changed, 28 insertions(+), 11 deletions(-)
