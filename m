From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH v4 2/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Fri, 6 Jan 2017 10:26:15 -0800
Message-ID: <CAGt4E5tALVrQSrib+h3BN=A6umnA4JgWAeUfJew02tGS1kAjdg@mail.gmail.com>
References: <20161220225530.96699-1-code@mmayer.net> <20161220225530.96699-3-code@mmayer.net>
 <20170106041442.GD21926@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170106041442.GD21926@vireshk-i7>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Markus Mayer <code@mmayer.net>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd@arndb.de>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Clock List <linux-clk@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Device Tree List <devicetree@vger.kernel.org>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5 January 2017 at 20:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20-12-16, 14:55, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This CPUfreq driver provides basic frequency scaling for older Broadcom
>> STB SoCs that do not use AVS firmware with DVFS support. There is no
>> support for voltage scaling.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm       |  12 ++
>>  drivers/cpufreq/Makefile          |   1 +
>>  drivers/cpufreq/brcmstb-cpufreq.c | 377 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 390 insertions(+)
>>  create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c
>
> I am fine with this patch as I have already Acked V3 of it. But please fix the
> bindings improvement suggested by Stephen first.

Yes, that is on my list of things to do. I will send an update
hopefully next week.

Thanks,
-Markus
