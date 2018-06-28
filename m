From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: ab8500: stop using getnstimeofday64()
Date: Thu, 28 Jun 2018 16:14:45 +0200
Message-ID: <CACRpkdYjXeb=XzdbKDGrt+fp5arkWuH_GS9FAkygqsovtjw70g@mail.gmail.com>
References: <20180618142352.3556062-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180618142352.3556062-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 18, 2018 at 4:23 PM Arnd Bergmann <arnd@arndb.de> wrote:

> getnstimeofday64() is deprecated in favor of the ktime_get() family.
>
> The direct replacement would be ktime_get_real_ts64(), but we only need
> the seconds value, and it seems better to use boottime than real time
> to avoid unexpected behavior with a concurrent settimeofday().
>
> ktime_get_seconds() might also work, but it seems better to use
> boottime than monotonic time since I assume that the charging
> process continues during suspend.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
