From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] video / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Mon, 08 Dec 2014 20:06:30 +0900
Message-ID: <000901d012d7$0509a090$0f1ce1b0$%han@samsung.com>
References: <19160360.7uJRUqlDQg@vostro.rjw.lan> <548584CC.7010603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <548584CC.7010603@ti.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Monday, December 08, 2014 8:00 PM, Tomi Valkeinen wrote
> 
> On 06/12/14 04:36, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> > selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> > depending on CONFIG_PM_RUNTIME may now be changed to depend on
> > CONFIG_PM.
> >
> > The alternative of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME may be
> > replaced with CONFIG_PM too.
> >
> > Make these changes in 2 files under drivers/video/.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> > PM_SLEEP is selected) which is only in linux-next at the moment (via the
> > linux-pm tree).
> >
> > Please let me know if it is OK to take this one into linux-pm.
> 
> Does not seem to conflict with fbdev changes, so:
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

For drivers/video/fbdev/s3c-fb.c,

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
>  Tomi
> 
