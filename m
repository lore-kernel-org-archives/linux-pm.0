From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Wed, 18 Dec 2013 19:33:09 +0800
Message-ID: <52B187F5.7020105@nvidia.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com>	<CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>	<52B02D04.4050905@nvidia.com> <CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/18/2013 07:11 PM, Viresh Kumar wrote:
> On 17 December 2013 16:22, bilhuang <bilhuang@nvidia.com> wrote:
>> Tegra20 DVFS is a little bit complicated due to the fact that we can't scale
>> VDD_CPU directly, there are constraints or relationship to other power rails
>> so I don't think it is a good idea to use generic cpufreq-cpu0 driver if
>> we're going to support voltage scaling.
>
> But why can't we handle that in a CPU specific regulator code?
>
cpufreq-cpu0 driver will call regulator_set_voltage_tol() directly 
according to the pre-defined OPP freq/volt pairs, the regulator drivers 
could be shared by other SoC so is not suitable to handle this, or do I 
misunderstand?
