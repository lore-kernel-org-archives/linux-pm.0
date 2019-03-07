From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] cpufreq: pxa2xx: remove incorrect __init annotation
Date: Thu, 07 Mar 2019 20:19:47 +0100
Message-ID: <87imwu5w6k.fsf@belgarion.home>
References: <20190307102250.1140038-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307102250.1140038-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 7 Mar 2019 11:22:41 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> pxa_cpufreq_init_voltages() is marked __init but usually inlined into
> the non-__init pxa_cpufreq_init() function. When building with clang,
> it can stay as a standalone function in a discarded section, and produce
> this warning:
>
> WARNING: vmlinux.o(.text+0x616a00): Section mismatch in reference from the function pxa_cpufreq_init() to the function .init.text:pxa_cpufreq_init_voltages()
> The function pxa_cpufreq_init() references
> the function __init pxa_cpufreq_init_voltages().
> This is often because pxa_cpufreq_init lacks a __init
> annotation or the annotation of pxa_cpufreq_init_voltages is wrong.
>
> Fixes: 50e77fcd790e ("ARM: pxa: remove __init from cpufreq_driver->init()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
