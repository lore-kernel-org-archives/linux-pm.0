From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2]mmc: remove MMC bus legacy suspend/resume method
Date: Mon, 9 Apr 2012 23:07:23 +0200
Message-ID: <CACRpkdaS8f3KT+f1oPXiRhSoxwVOL5s69mMZCz__6WvtfKY=Ag@mail.gmail.com>
References: <20120405075118.GA29395@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20120405075118.GA29395@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 5, 2012 at 9:51 AM, Chuanxiao Dong <chuanxiao.dong@intel.co=
m> wrote:

> MMC bus is using legacy suspend/resume method, which is not compatibl=
e if
> runtime pm callbacks are used. In this scenario, MMC bus suspend/resu=
me
> callbacks cannot be called when system entering S3. So change to use =
the new
> defined dev_pm_ops for system sleeping mode
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> Changes in v2:
> =A0 =A0 =A0 =A0use SET_SYSTEM_SLEEP_PM_OPS to define sleep callbacks =
as Rafael
> =A0 =A0 =A0 =A0suggested

This looks so much more sane.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
