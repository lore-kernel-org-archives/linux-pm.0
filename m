From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3 3/3] ARM: tegra: Add Tegra124 ACTMON support
Date: Tue, 09 Dec 2014 15:13:25 +0100
Message-ID: <54870385.9060405@collabora.com>
References: <1417709696-29281-1-git-send-email-tomeu.vizoso@collabora.com> <1417709696-29281-4-git-send-email-tomeu.vizoso@collabora.com> <CAAVeFu+UZyzF6c+MMnXFAKUbDcw6aan13Sg88c9-YbUsbXYKnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFu+UZyzF6c+MMnXFAKUbDcw6aan13Sg88c9-YbUsbXYKnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/09/2014 06:33 AM, Alexandre Courbot wrote:
> On Fri, Dec 5, 2014 at 1:14 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Add device node for the ACTMON block to the Tegra124 device tree.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>>
>> v3:     * Address misc. style issues found by Thierry and Alexander
>>         * Added helpers for register i/o
>>         * Further documented the structs
>>         * Enable the ACTMON after the IRQ handler has been installed
>>         * Disable the ACTMON before removing the IRQ handler
>>         * Add governor in a subsys initcall
>>
>> v2:     * Add operating-points property
>> ---
>>  arch/arm/boot/dts/tegra124.dtsi        |  23 +
>>  drivers/devfreq/Kconfig                |   7 +-
>>  drivers/devfreq/Makefile               |   2 +-
>>  drivers/devfreq/tegra-actmon-devfreq.c | 777 +++++++++++++++++++++++++++++++++
>>  drivers/devfreq/tegra-devfreq.c        | 718 ------------------------------
> 
> In patch 2/3 you create tegra-devfreq.c, to apparently move it to
> tegra-actmon-devfreq.c and (seemingly) add somemore lines to it. This
> makes things difficult to review, and I am almost sure this is a
> naming mistake - could you fix this and resend?

Sorry, I squashed the changes into the wrong commit. Have sent v4 fixing
this.

Cheers,

Tomeu
