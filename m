From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] add support for power off check in suspend
Date: Tue, 8 Jan 2019 12:46:21 +0100
Message-ID: <CAJZ5v0gohGWgpmTx8mzuWdru2M9xbSGoOV=WBxzVo07JZW3G1g@mail.gmail.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: Nicolas.Ferre@microchip.com, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic.Desroches@microchip.com, Russell King - ARM Linux <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 8, 2019 at 11:56 AM <Claudiu.Beznea@microchip.com> wrote:
>
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>
> Hi,
>
> AT91 platforms support a power saving mode where SoC's power is cut off (we call
> it backup mode). The resume is done with the help of bootloaders.

But still the contents of RAM are preserved?

That would require at least the memory controller to be under power AFAICS.

> To be able to
> suspend/resume Linux to/from this mode all the drivers suspend/resume callbacks
> should save/restore the content of all the active registers. We have 2 problems
> we are trying to solve:
> - some of these drivers are shared with other non Microchip SoCs (e.g. macb
>   driver) and we don't want to disturbe other users of corresponding IPs with
>   all the register save/restore operations;
> - the suspend/resume time for the rest of the power saving mode we are using
>   could be improved if we would know in drivers the suspend mode the platform
>   is switched to.
>
> A solution that would have been solve our problems was proposed in [1] but in
> the end it wasn't accepted. It ended up with the introduction of
> pm_suspend_target_state variable that could be used along with the changes in
> this series.
>
> While the discussion of [1] progressed it has been proposed (in [2]) to
> implement a function that would tell if the platform's power would be cut off
> at the end of the suspend procedure.
>
> The patches in this series does as follows:
> 1/3 - add a new member to platform_suspend_ops that will tell if platform's
>       power will be cut off at the end of the suspend procedure; drivers could
>       use it via platform_off_in_suspend()

I would rather avoid doing this if possible.

Thanks,
Rafael
