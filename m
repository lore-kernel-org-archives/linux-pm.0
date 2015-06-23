From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Tue, 23 Jun 2015 12:57:36 +0200
Message-ID: <CAMuHMdWCo+U26x9Z5vUu+5ZVSpSOFF1LDO7jkezuXzVR2mC6qA@mail.gmail.com>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
	<7ha8w01qir.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35493 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbFWK5h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 06:57:37 -0400
Received: by oiax193 with SMTP id x193so4092694oia.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 03:57:37 -0700 (PDT)
In-Reply-To: <7ha8w01qir.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 16, 2015 at 1:49 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Genpd's ->runtime_suspend() (assigned to pm_genpd_runtime_suspend())
>> doesn't immediately walk the hierarchy of ->runtime_suspend() callbacks.
>> Instead, pm_genpd_runtime_suspend() calls pm_genpd_poweroff() which
>> postpones that until *all* the devices in the genpd are runtime suspended.
>>
>> When pm_genpd_poweroff() discovers that the last device in the genpd is
>> about to be runtime suspended, it calls __pm_genpd_save_device() for *all*
>> the devices in the genpd sequentially. Furthermore,
>> __pm_genpd_save_device() invokes the ->start() callback, walks the
>> hierarchy of the ->runtime_suspend() callbacks and invokes the ->stop()
>> callback. This causes a "thundering herd" problem.
>>
>> Let's address this issue by having pm_genpd_runtime_suspend() immediately
>> walk the hierarchy of the ->runtime_suspend() callbacks, instead of
>> postponing that to the power off sequence via pm_genpd_poweroff(). If the
>> selected ->runtime_suspend() callback doesn't return an error code, call
>> pm_genpd_poweroff() to see if it's feasible to also power off the PM
>> domain.
>>
>> Adopting this change enables us to simplify parts of the code in genpd,
>> for example the locking mechanism. Additionally, it gives some positive
>> side effects, as described below.
>>
>> i)
>> One device's ->runtime_resume() latency is no longer affected by other
>> devices' latencies in a genpd.
>>
>> The complexity genpd has to support the option to abort the power off
>> sequence suffers from latency issues. More precisely, a device that is
>> requested to be runtime resumed, may end up waiting for
>> __pm_genpd_save_device() to complete its operations for *another* device.
>> That's because pm_genpd_poweroff() can't confirm an abort request while it
>> waits for __pm_genpd_save_device() to return.
>>
>> As this patch removes the intermediate states in pm_genpd_poweroff() while
>> powering off the PM domain, we no longer need the ability to abort that
>> sequence.
>>
>> ii)
>> Make pm_runtime[_status]_suspended() reliable when used with genpd.
>>
>> Until the last device in a genpd becomes idle, pm_genpd_runtime_suspend()
>> will return 0 without actually walking the hierarchy of the
>> ->runtime_suspend() callbacks. However, by returning 0 the runtime PM core
>> considers the device as runtime_suspended, so
>> pm_runtime[_status]_suspended() will return true, even though the device
>> isn't (yet) runtime suspended.
>>
>> After this patch, since pm_genpd_runtime_suspend() immediately walks the
>> hierarchy of the ->runtime_suspend() callbacks,
>> pm_runtime[_status]_suspended() will accurately reflect the status of the
>> device.
>>
>> iii)
>> Enable fine-grained PM through runtime PM callbacks in drivers/subsystems.
>>
>> There are currently cases were drivers/subsystems implements runtime PM
>> callbacks to deploy fine-grained PM (e.g. gate clocks, move pinctrl to
>> power-save state, etc.). While using the genpd, pm_genpd_runtime_suspend()
>> postpones invoking these callbacks until *all* the devices in the genpd
>> are runtime suspended. In essence, one runtime resumed device prevents
>> fine-grained PM for other devices within the same genpd.
>>
>> After this patch, since pm_genpd_runtime_suspend() immediately walks the
>> hierarchy of the ->runtime_suspend() callbacks, fine-grained PM is enabled
>> throughout all the levels of runtime PM callbacks.
>>
>> Unfortunately this patch also comes with a drawback, as described in the
>> summary below.
>>
>> Driver's/subsystem's runtime PM callbacks may be invoked even when the
>> genpd hasn't actually powered off the PM domain, potentially introducing
>> unnecessary latency.
>>
>> However, in most cases, saving/restoring register contexts for devices are
>> typically fast operations or can be optimized in device specific ways
>> (e.g. shadow copies of register contents in memory, device-specific checks
>> to see if context has been lost before restoring context, etc.).
>>
>> Still, in some cases the driver/subsystem may suffer from latency if
>> runtime PM is used in a very fine-grained manner (e.g. for each IO request
>> or xfer). To prevent that extra overhead, the driver/subsystem may deploy
>> the runtime PM autosuspend feature.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> I know Lina has been testing this (or an earlier version) on qcom
> hardware so would be nice to get a tested-by from her, and would also be
> nice to see if Geert has a chance to take this for a spin on his Renesas
> hardware and anyone can take this for a spin on Exynos.

I needed some athletics to make this apply to my current tree, but I did
manage to test it on:
  - sh73a0/kzm9g (SYSC PM Domain/pm-rmobile),
  - r8a7740/armadillo (SYSC PM Domain/pm-rmobile),
  - r8a73a4/ape6evm (SYSC PM Domain/pm-rmobile),
  - r8a7791/koelsch (CPG Clock Domain + SYSC PM Domain/pm-rcar).
I didn't notice any regressions or other oddities.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
