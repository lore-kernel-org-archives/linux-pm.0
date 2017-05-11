From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dbx500: add a Kconfig symbol
Date: Thu, 11 May 2017 19:27:40 +0530
Message-ID: <CAKohpo=fYMeeua=CyciRT3Y4CaNzZ533eLZawQYY9AO5GbXNBw@mail.gmail.com>
References: <20170511121258.3521041-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170511121258.3521041-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11 May 2017 at 17:42, Arnd Bergmann <arnd@arndb.de> wrote:
> Moving the cooling code into the cpufreq driver caused a possible build failure
> when the cpu_thermal helper code is a loadable module or disabled:
>
> drivers/cpufreq/dbx500-cpufreq.o: In function `dbx500_cpufreq_ready':
> dbx500-cpufreq.c:(.text.dbx500_cpufreq_ready+0x4): undefined reference to `cpufreq_cooling_register'
>
> This adds the same dependency that we have in other cpufreq drivers,
> forcing the driver to be disabled when we can't possibly link it.
>
> Fixes: 19678ffb9fd6 ("cpufreq: dbx500: Manage cooling device from cpufreq driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 9 +++++++++
>  drivers/cpufreq/Makefile    | 2 +-
>  2 files changed, 10 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
