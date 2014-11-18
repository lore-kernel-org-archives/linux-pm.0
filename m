From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is selected
Date: Mon, 17 Nov 2014 19:52:37 -0800
Message-ID: <7h61edyxkq.fsf@deeprootsystems.com>
References: <1415917702-6742-1-git-send-email-khilman@kernel.org>
	<6465990.KKns6W8hQE@vostro.rjw.lan>
	<7hioid3cqx.fsf@deeprootsystems.com>
	<1452958.d0yJE5gVgq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452958.d0yJE5gVgq@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Tue, 18 Nov 2014 01:39:06 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, linaro-kernel <linaro-kernel@lists.linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The number of and dependencies between high-level power management
> Kconfig options make life much harder than necessary.  Several
> conbinations of them have to be tested and supported, even though
> some of those combinations are very rarely used in practice (it
> they are used in practice at all).  Moreover, the fact that we
> have separate independent Kconfig options for runtime PM and
> system suspend is a serious obscacle for integration between
> the two frameworks.
>
> To overcome these difficulties, always select PM_RUNTIME if PM_SLEEP
> is set.  Among other things, this will allow system suspend callbacks
> provided by bus types and device drivers to rely on the runtime PM
> framework regardless of the kernel configuration.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> As a follow up.
>
> Note that we won't need the patch making genpd select PM_RUNTIME with this,
> because genpd already depends on PM.
>
> Thoughts, comments?

Acked-by: Kevin Hilman <khilman@linaro.org>

...with dancing and singing in the streets (or more my speed: a
celebratory beer.) 

Kevin
