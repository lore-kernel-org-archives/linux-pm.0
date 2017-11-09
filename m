From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: fix power-off when
 powered by bootloader
Date: Thu, 9 Nov 2017 11:42:46 +0100
Message-ID: <CAK8P3a2eYi0bajPmmfjOJWOE76_-A-oDLOKObWyijY_95FEXqw@mail.gmail.com>
References: <1509723804-21114-1-git-send-email-narmstrong@baylibre.com> <7hshdoi8b4.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hshdoi8b4.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: arm-soc <arm@kernel.org>, Carlo Caione <carlo@caione.org>, linux-pm@vger.kernel.org, "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 9, 2017 at 1:50 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Arnd, Olof,
>
> Neil Armstrong <narmstrong@baylibre.com> writes:
>
>> In the case the VPU power domain has been powered on by the bootloader
>> and no driver are attached to this power domain, the genpd will power it
>> off after a certain amount of time, but the clocks hasn't been enabled
>> by the kernel itself and the power-off will trigger some faults.
>> This patch enable the clocks to have a coherent state for an eventual
>> poweroff and switches to the pm_domain_always_on_gov governor.
>>
>> Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> This fixes a patch that's currently in arm-soc next/drivers (or
> amlogic/drivers-2 to be precise.)
>
> If it's not too late, please feel free to apply directly.  If not, I
> will queue up for v4.15-rc fixes cycle.

Applied to next/drivers, thanks!

      Arnd
