From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: mark genpd_poweron as __maybe_unused
Date: Mon, 1 Feb 2016 14:57:36 +0100
Message-ID: <CAPDyKFpHBgaQEz6kYvhV=2pLPLAtVxQjbnqL4CPv0vyvHZbHWA@mail.gmail.com>
References: <3864075.BdhPDUQ9fB@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3864075.BdhPDUQ9fB@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 1 February 2016 at 11:38, Arnd Bergmann <arnd@arndb.de> wrote:
> The rework of the power domain code has made the genpd_poweron()
> function local to the file it's defined in, and the only remaining
> caller is conditionally compiled based on CONFIG_PM_GENERIC_DOMAINS_OF,
> so we get a warning when that is disabled:
>
> drivers/base/power/domain.c:234:12: error: 'genpd_poweron' defined but not used [-Werror=unused-function]
>
> This adds a __maybe_unused annotation to the function so gcc can
> figure out by itself that it should silently remove the definition
> in this case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ea823c7cbffa ("PM / Domains: Remove pm_genpd_poweron() API")

Arnd,

Thanks for fixing and reporting!

Looking a bit closer to the genpd code in this reagrds, made me
realize that I think there's a better approach to fix this.
Instead of going into the details for how, I decided to send a
separate patch. You are on cc.

"[PATCH] PM / Domains: Silence compiler warning for an unused function".

Kind regards
Uffe
