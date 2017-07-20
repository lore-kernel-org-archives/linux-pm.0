From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v4 2/2] thermal: uniphier: add UniPhier thermal driver
Date: Fri, 21 Jul 2017 01:08:59 +0900
Message-ID: <CAK7LNASKqwWY4gorRZLd0GPXymm2WNdxuZr_OOs6g7uzaKSCMQ@mail.gmail.com>
References: <1499392475-17304-1-git-send-email-hayashi.kunihiko@socionext.com> <1499392475-17304-3-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57247 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933887AbdGTQJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 12:09:15 -0400
In-Reply-To: <1499392475-17304-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>

2017-07-07 10:54 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add a thermal driver for on-chip PVT (Process, Voltage and Temperature)
> monitoring unit implemented on UniPhier SoCs. This driver supports
> temperature monitoring and alert function.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>


Sparse reports several warnings.


  CHECK   drivers/thermal/uniphier_thermal.c
drivers/thermal/uniphier_thermal.c:276:52: warning: incorrect type in
argument 1 (different base types)
drivers/thermal/uniphier_thermal.c:276:52:    expected restricted
__be32 const [usertype] *cell
drivers/thermal/uniphier_thermal.c:276:52:    got unsigned int const
[usertype] *[assigned] calib
drivers/thermal/uniphier_thermal.c:277:58: warning: incorrect type in
argument 1 (different base types)
drivers/thermal/uniphier_thermal.c:277:58:    expected restricted
__be32 const [usertype] *cell
drivers/thermal/uniphier_thermal.c:277:58:    got unsigned int const
[usertype] *
drivers/thermal/uniphier_thermal.c:136:9: warning: cast truncates bits
from constant value (fffffffff becomes ffffffff)
drivers/thermal/uniphier_thermal.c:141:9: warning: cast truncates bits
from constant value (7ffffffff becomes ffffffff)
drivers/thermal/uniphier_thermal.c:153:9: warning: cast truncates bits
from constant value (ffffffffff0001 becomes ffff0001)
drivers/thermal/uniphier_thermal.c:170:9: warning: cast truncates bits
from constant value (7ffffffffff becomes ffffffff)
drivers/thermal/uniphier_thermal.c:185:9: warning: cast truncates bits
from constant value (7ffffffffff becomes ffffffff)





-- 
Best Regards
Masahiro Yamada
