From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of qcom_cpufreq_kryo_probe()
Date: Wed, 20 Feb 2019 13:30:38 +0100
Message-ID: <CAK8P3a3Qkrx75K6sTQqhn0MZmOQ5O6x-FRH_2MkCkZf2OehZfQ@mail.gmail.com>
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 20, 2019 at 12:14 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> 256"), we have started getting following compilation warning:
>
> qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>
> Fix that by dynamically allocating opp_tables and freeing it later.
>
> Compile tested only.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me, thanks for the fix!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
