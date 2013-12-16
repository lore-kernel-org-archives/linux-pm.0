From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 1/1] cpufreq: tegra: Re-model Tegra20 cpufreq driver
Date: Mon, 16 Dec 2013 09:58:14 -0700
Message-ID: <52AF3126.6090000@wwwdotorg.org>
References: <1386840835-28751-1-git-send-email-bilhuang@nvidia.com> <52AB967F.9030900@wwwdotorg.org> <52AEDB6A.2080501@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52AEDB6A.2080501-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bilhuang <bilhuang-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12/16/2013 03:52 AM, bilhuang wrote:
> On 12/14/2013 07:21 AM, Stephen Warren wrote:
>> On 12/12/2013 02:33 AM, Bill Huang wrote:
>>> Re-model Tegra20 cpufreq driver as below.
>>>
>>> * Rename tegra-cpufreq.c to tegra20-cpufreq.c since this file supports
>>>    only Tegra20.
>>> * Add probe function so defer probe can be used when we're going to
>>>    support DVFS.
>>> * Create a fake cpufreq platform device with its name being
>>>    "${root_compatible}-cpufreq" so SoC cpufreq driver can bind to it
>>>    accordingly.
>>
>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>
>>> +config ARM_TEGRA20_CPUFREQ
>>> +    bool "NVIDIA TEGRA20"
>>> +    depends on ARM_TEGRA_CPUFREQ && ARCH_TEGRA_2x_SOC
>>> +    default y
>>> +    help
>>> +      This enables Tegra20 cpufreq functionality, it adds
>>> +      Tegra20 CPU frequency ladder and the call back functions
>>> +      to set CPU rate. All the non-SoC dependant codes are
>>> +      controlled by the config ARM_TEGRA20_CPUFREQ.
>>
>> I think that last sentence is no longer true in this patch version. Or,
>> did you mean to write ARM_TEGRA_CPUFREQ rather than ARM_TEGRA20_CPUFREQ?
> 
> Right, should be ARM_TEGRA_CPUFREQ, thanks for catching this.
>>
>>> diff --git a/drivers/cpufreq/tegra-cpufreq.c
>>> b/drivers/cpufreq/tegra-cpufreq.c
>>
>>> +static const char * const tegra_soc_compat[] = {
>>> +    "nvidia,tegra124",
>>> +    "nvidia,tegra114",
>>> +    "nvidia,tegra30",
>>> +    "nvidia,tegra20",
>>> +    NULL
>>>   };
>>
>> That table will need editing for each chip. I wonder if you can do
>> something like always use the very last entry in /compatible. That would
>> assume a particular ordering of the compatible entries, but they should
>> be in the order $board, $soc anyway...
> 
> How do we get subset of a string and making sure it is the last? There
> must be some assumptions here (though they will possibly be true) I
> guess, for example, they should be in the order $board, $soc... and the
> last "nvidia" should be the start of the last compatible id we would
> like to get.

The compatible property is an array of strings, rather than one big
string, so you can just keep getting index 0, 1, 2, ... until you find
there aren't any more entries. I think it's reasonable to assume that
the SoC compatible value must be last, and it should be in practice,
although perhaps that is fragile. If you want, we can leave this as-is
for now, and modify it later if it becomes a problem.
