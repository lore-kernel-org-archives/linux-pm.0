From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: supply: max77693_charger: fix unintentional fall-through
Date: Wed, 18 Jul 2018 08:14:50 +0200
Message-ID: <CAJKOXPc3vss1=gYy+6ej6J2LNz+RtBoHFEN84j18wd0yy_NaDg@mail.gmail.com>
References: <20180717214739.GA19410@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717214739.GA19410@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17 July 2018 at 23:47, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> It seems that a *break* is missing in order to avoid a fall-through.
> Otherwise, the calculation of *data* makes no sense.
>
> Addresses-Coverity-ID: 1271172 ("Missing break in switch")
> Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/power/supply/max77693_charger.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
