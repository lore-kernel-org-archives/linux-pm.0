From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Thu, 2 Jun 2016 17:08:17 +0200
Message-ID: <CAJZ5v0hF5vk_KPCu0xrRA3mzRBGqW4wtPODkCRk47_n5h_y7jw@mail.gmail.com>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 2, 2016 at 4:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> This series fixes all cpufreq drivers that provide a 'target_index'
> callback or in other words, which provide a freq-table to cpufreq core,
> to make sure they *only* use the 'index' argument to ->target_index()
> with the policy->freq_table.
>
> This change allows us to remove the (duplicate) sorted-freq-table, which
> was added by following series:
>
> [PATCH V2 0/2] cpufreq: Use sorted frequency tables

Which I'm not going to apply.

If this series depended on that one, please rework it.

Thanks,
Rafael
