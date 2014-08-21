From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 11/11] clk: rockchip: add restart handler
Date: Wed, 20 Aug 2014 21:15:10 -0700
Message-ID: <CAD=FV=U+WbodSLyQVQieiKkWNTBROCktJLgR9B8eOWZhGWYxgg@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
	<1408495538-27480-12-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1408495538-27480-12-git-send-email-linux@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>
Cc: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jonas Jensen <jonas.jensen@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tomasz Figa <t.figa@samsung.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-kernel@vger.
List-Id: linux-pm@vger.kernel.org

Guenter / Heiko,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wro=
te:
> From: Heiko St=C3=BCbner <heiko@sntech.de>
>
> Add infrastructure to write the correct value to the restart register=
 and
> register the restart notifier for both rk3188 (including rk3066) and =
rk3288.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v7: Added patch to series.
>
>  drivers/clk/rockchip/clk-rk3188.c |  2 ++
>  drivers/clk/rockchip/clk-rk3288.c |  2 ++
>  drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  4 files changed, 30 insertions(+)

This patch doesn't apply cleanly with the in-flight (clk: rockchip:
protect critical clocks from getting disabled) patch from Heiko.  It's
trivial to resolve and unclear which will land first, so I think it's
fine...

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>

(FYI: all patches tested by me were tested on rk3288-evb)
