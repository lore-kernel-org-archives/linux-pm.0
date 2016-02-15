From: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 22:29:20 +0000
Message-ID: <CAFEAcA9Xy2L+edFAdUCpZFiO5NLGyrQPTQ6DgmuScbwEty-nzg@mail.gmail.com>
References: <20160215170527.GA24453@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20160215170527.GA24453@roeck-us.net>
Sender: linux-next-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 15 February 2016 at 17:05, Guenter Roeck <linux@roeck-us.net> wrote:
> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
> timers with utilization update callbacks' with next-20160215. An example
> crash log and bisect results are attached below.
>
> Please let me know if there is anything I can do to help tracking down
> the problem.
>
> Thanks,
> Guenter
>
> ---
>
> Building arm:beagle:multi_v7_defconfig:omap3-beagle ... running ..... failed (crashed)
> ------------
> qemu log:

You're using the QEMU beagle board emulation? Can I ask which
QEMU you're using (qemu-linaro?). If the OMAP3 emulation is still
actively useful to people I might have another stab at getting
it into upstream QEMU some day...

thanks
-- PMM
