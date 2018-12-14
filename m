From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: isp1704: switch to gpiod API
Date: Fri, 14 Dec 2018 22:56:28 +0100
Message-ID: <CACRpkdaEXJqpzmbnJpxkZewwCwLbekwwn1QnANOXP5pgnHfU8w@mail.gmail.com>
References: <20181213013858.23996-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213013858.23996-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 2:39 AM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> This migrates isp1704 driver from old GPIO API to new descriptor
> based GPIO API and drops useless platform data as a side-effect.
>
> Migration is simple, since all mainline users are DT based and
> DT API does not change. Out of tree users of the platform data
> need to migrate to gpiod_lookup_table as described here:
>
> Documentation/driver-api/gpio/board.rst
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Excellent work!

Yours,
Linus Walleij
