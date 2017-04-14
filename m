From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 08/13] power: max17042_battery: Add support for the
 TECHNOLOGY attribute
Date: Fri, 14 Apr 2017 18:26:32 +0200
Message-ID: <20170414162632.7r3id7lkzbcjp3wj@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-8-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdDNQ0h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:26:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so18557237wmi.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:26:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-8-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:14PM +0200, Hans de Goede wrote:
> The max17042 is intended for LiOn or LiPo batteries, add a TECHNOLOGY
> attribute to reflect this. Note this is hardcoded to LiOn as there is
> no way to tell the difference, this is done by many drivers and is
> better then not providing any technology info at all.

Same as Wolfgang's try:
https://patchwork.kernel.org/patch/9349945/
but with better explanation. :)

Yet still I am not convinced that providing a wrong information (Li-Ion
in case of LiPo battery) is better than not providing any info at all.

Best regards,
Krzysztof
