From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v7 03/11] arm64: Support restart through restart handler
 call chain
Date: Wed, 20 Aug 2014 21:13:29 -0700
Message-ID: <CAD=FV=VwnbsHSMMH+mMucTL2BnX2mpAOEmpyyH7ta2TFLahbFw@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
	<1408495538-27480-4-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1408495538-27480-4-git-send-email-linux@roeck-us.net>
Sender: linux-doc-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Russell King <linux@arm.linux.org.uk>, Wim Van Sebroeck <wim@iguana.be>, Catalin Marinas <catalin.marinas@arm.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Andrew Morton <akpm@linux-foundation.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Jonas Jensen <jonas.jensen@gmail.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Guenter,

On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> The kernel core now supports a restart handler call chain to restart
> the system. Call it if arm_pm_restart is not set.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v7: No change.
> v6: No change.
> v5: Renamed restart function to do_kernel_restart
> v4: No change.
> v3: Use wrapper function to execute notifier call chain.
> v2: Only call notifier call chain if arm_pm_restart is not set.
>     Do not include linux/watchdog.h.
>
>  arch/arm64/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>
