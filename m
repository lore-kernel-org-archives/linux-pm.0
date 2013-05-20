From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] e_powersaver: Fix linker error when ACPI processor is a module
Date: Mon, 20 May 2013 09:48:04 +0530
Message-ID: <CAKohpo=JELHvS0Ar_0LGvjrGBMrxpPSLo3=5pMZfW_6uCozHuw@mail.gmail.com>
References: <1368991675-1711-1-git-send-email-rafalbilski@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1368991675-1711-1-git-send-email-rafalbilski@interia.pl>
Sender: cpufreq-owner@vger.kernel.org
To: Rafal Bilski <rafalbilski@interia.pl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20 May 2013 00:57, Rafal Bilski <rafalbilski@interia.pl> wrote:
> on i386:
> CONFIG_ACPI_PROCESSOR=m
> CONFIG_X86_E_POWERSAVER=y
>
> drivers/built-in.o: In function `eps_cpu_init.part.8':
> e_powersaver.c:(.text.unlikely+0x2243): undefined reference to `acpi_processor_register_performance'
> e_powersaver.c:(.text.unlikely+0x22a2): undefined reference to `acpi_processor_unregister_performance'
> e_powersaver.c:(.text.unlikely+0x246b): undefined reference to `acpi_processor_get_bios_limit'
>
> X86_E_POWERSAVER should also depend on ACPI_PROCESSOR.
>
> Signed-off-by: Rafal Bilski <rafalbilski@interia.pl>
> ---
>  drivers/cpufreq/Kconfig.x86 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
