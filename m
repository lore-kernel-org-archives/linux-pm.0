From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
 power
Date: Tue, 21 Feb 2017 10:38:54 +0000
Message-ID: <69ab75a1-2e04-19e2-d1ad-12ca1cfc7625@arm.com>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 20/02/17 20:33, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds support for using non-PMIC wake-up sources on the
> Renesas R-Car Gen3 (H3 or M3-W) Salvator-X development boards.
> 
> Nothing in the PSCI specification requires the SoC to remain powered and
> to support wake-up sources when suspended using SYSTEM_SUSPEND.
> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
> power to the SoC, the only possibly wake-up sources are thus the ones
> connected to the PMIC.
> 

OK, but I don't see any issue with that. That's exactly how it works on
ARM Juno platform. The SoC is powered down.

> To allow other wake-up sources, this patch series documents and adds
> support for an "arm,psci-system-suspend-is-power-down" DT property, so

NACK, you don't need any such properties.

> Linux uses a different suspend method when other wake-up sources (e.g.
> wake on LAN, UART or GPIO) are enabled.  Hence the user no longer has to
> manually restrict "mem" suspend to "s2idle" or "shallow" states using:
> 

Have you explored suspend-to-idle instead ? It looks like thats exactly
what you are doing in this patch set. You also get low latency for free
as it just enters the deepest idle state on all CPUs instead of
hotplugging out all the secondaries.

-- 
Regards,
Sudeep
