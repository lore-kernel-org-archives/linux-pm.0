From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v12.4 0/7] bq27xxx_battery partial series
Date: Wed, 5 Apr 2017 11:54:25 -0700
Message-ID: <CAKvHMgQ4LASGx87mfvtTA_zVQo4Ssc_R8SptZpb=Fxrx6g38Yg@mail.gmail.com>
References: <20170404085706.32592-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36160 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbdDESy0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Apr 2017 14:54:26 -0400
Received: by mail-it0-f68.google.com with SMTP id a140so2249556ita.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Apr 2017 11:54:26 -0700 (PDT)
In-Reply-To: <20170404085706.32592-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org

Hi Andrew, any other feedback on this 12.4 series?

On Tue, Apr 4, 2017 at 1:56 AM, Liam Breck <liam@networkimprov.net> wrote:
> Latest changes:
>
> Devicetree docs mention relevant battery node fields.
>
> Clean up patch "Flag identical register maps..."
>
> ^.^ - I can has test?
>
>   power: bq27xxx_battery: Add bulk transfer bus methods
>   power: bq27xxx_battery: Add chip data memory read/write support
>   power: bq27xxx_battery: Add power_supply_battery_info support
>   power: bq27xxx_battery: Enable chip data memory update for certain chips
>   devicetree: power: bq27xxx: Add monitored-battery documentation
>   power: bq27xxx_battery: Flag identical register maps when in debug mode
>   power: bq27xxx_battery: Remove duplicate register arrays
>
>  .../devicetree/bindings/power/supply/bq27xxx.txt   |  31 +-
>  drivers/power/supply/bq27xxx_battery.c             | 704 +++++++++++++++++----
>  drivers/power/supply/bq27xxx_battery_i2c.c         |  98 ++-
>  include/linux/power/bq27xxx_battery.h              |  26 +-
>  4 files changed, 710 insertions(+), 149 deletions(-)
>
> --
> 2.9.3
>
