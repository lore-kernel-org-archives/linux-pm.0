From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v3 00/11]  power: supply: bq275xx: implement individual
 chip revision support
Date: Mon, 9 Jan 2017 09:23:03 +0100
Message-ID: <20170109082303.GA26301@pali>
References: <1482369743-79764-1-git-send-email-chris@lapa.com.au>
 <1483922865-96321-1-git-send-email-chris@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33232 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbdAIIXK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 03:23:10 -0500
Content-Disposition: inline
In-Reply-To: <1483922865-96321-1-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: afd@ti.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 09 January 2017 11:47:34 Chris Lapa wrote:
> From: Chris Lapa <chris@lapa.com.au>
> 
> This patch series separates out support for each revision chip in
> the bq27500, bq27510 and bq27520 family. Each revision has enough
> register address changes to justify individual register mappings.
> 
> The series also cleans up the large overtemp if statement to
> improve readability and adds devicetree documentation for all
> the support bq27xxx series chips.
> 
> I had a chance to test the deprecated bq27500/10/20 support which still
> behaves the same. I also tested the new specific bq27510g3 support
> on a custom board I have here and it worked correctly.
> 
> Chris Lapa (11):
>   power: supplies: bq275xx: move overtemp tests to a switch statement.
>   power: supplies: bq275xx: rename BQ27500 allow for deprecation in
>     future.
>   power: supplies: bq275xx: adds specific support for bq27500/1
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27510-g1
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27510-g2
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27510-g3
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27520-g1
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27520-g2
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27520-g3
>     revision.
>   power: supplies: bq275xx: adds specific support for bq27520-g4
>     revision.
>   power: supplies: bq27xxx: adds device tree binding documentation.
> 
>  .../devicetree/bindings/power/supply/bq27xxx.txt   |  36 +++
>  drivers/power/supply/bq27xxx_battery.c             | 348 ++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c         |  22 +-
>  include/linux/power/bq27xxx_battery.h              |  10 +-
>  4 files changed, 407 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt

Much better now! You can add my Acked-by.

-- 
Pali Rohár
pali.rohar@gmail.com
