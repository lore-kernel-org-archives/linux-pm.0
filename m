From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 0/8] Introduce new cpufreq helper macros
Date: Tue, 29 Apr 2014 09:47:47 +0530
Message-ID: <CAKohpok-74uK5k-adxjmEy71=vF8V7MaBwdCD1Vb2ats7FHi_A@mail.gmail.com>
References: <535AC247.3070907@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535AC247.3070907@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, linux-doc@vger.kernel.org, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Sekhar Nori <nsekhar@ti.com>, Samuel Ortiz <samuel@sortiz.org>
List-Id: linux-pm@vger.kernel.org

On 26 April 2014 01:45, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> This patch set introduces two freq_table helper macros which
> can be used for iteration over cpufreq_frequency_table and
> makes the necessary changes to cpufreq core and drivers that
> use such an iteration procedure.
>
> The motivation was a usage of common procedure to iterate over
> cpufreq_frequency_table across all drivers and cpufreq core.
>
> This was tested on a x86_64 platform.
> Most files compiled successfully but unfortunately I was not
> able to compile sh_sir.c pasemi_cpufreq.c and ppc_cbe_cpufreq.c
> due to lack of cross compiler.
>
> Changelog
>
> v4 -> v5
>         - Fix warnings in printk format specifier for 32 bit
>           architectures in freq_table.c, longhaul, pasemi, ppc_cbe

Doesn't look much has changed and so it stays as is:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
