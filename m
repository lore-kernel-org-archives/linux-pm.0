From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 08/14] power: max17042_battery: Add support for the
 TECHNOLOGY attribute
Date: Sat, 15 Apr 2017 12:33:07 +0200
Message-ID: <20170415103307.2hvb6gd25gzjg5wn@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35019 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdDOKdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:33:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id l44so14904102wrc.2
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:33:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-8-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:53PM +0200, Hans de Goede wrote:
> The max17042 is intended for Li-Ion or Li-Po batteries, add a TECHNOLOGY
> attribute to reflect this. Note this is hardcoded to Li-Ion as there is
> no way to tell the difference, and Lithium-Ion Polymer batteries are
> a sub-family of Lithium-Ion so Li-Ion technically is correct for both.
> 
> Using Li-Ion for both is already done by many drivers and is much
> better then not providing any technology info at all.
> 
> Suggested-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes for v2:
> -Improved commit msg
> -Added Suggested-by: Wolfgang Wiedmeyer
> ---
>  drivers/power/supply/max17042_battery.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
