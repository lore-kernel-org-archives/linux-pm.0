From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 14/16] power: supply: axp288_fuel_gauge: Optimize get_current()
Date: Wed, 27 Dec 2017 11:16:40 +0800
Message-ID: <CAGb2v67KU6Z1Vmyx4iT78wjCLQXCNZXRx1W7TYzrPeEAdxwxFQ@mail.gmail.com>
References: <20171226125914.10235-1-hdegoede@redhat.com> <20171226125914.10235-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:39640 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdL0DRF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Dec 2017 22:17:05 -0500
Received: from mail-wr0-f176.google.com (mail-wr0-f176.google.com [209.85.128.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: b93043)
        by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 0C35627BE5
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2017 11:17:04 +0800 (CST)
Received: by mail-wr0-f176.google.com with SMTP id w107so9957059wrb.9
        for <linux-pm@vger.kernel.org>; Tue, 26 Dec 2017 19:17:03 -0800 (PST)
In-Reply-To: <20171226125914.10235-14-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Tue, Dec 26, 2017 at 8:59 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> First check the discharge current, and when that is non 0 use that without
> also checking the charge current (which will be 0 then). This makes
> get_current() do only 1 i2c read instead of 2 when on battery.
>
> This is esp. important given the pmic i2c bus mutex stuff used on boards
> with an axp288 because the SoC's own punit also may access the axp288,
> which makes i2c accesses more expensive then normal.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
