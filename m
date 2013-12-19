From: bilhuang <bilhuang@nvidia.com>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Thu, 19 Dec 2013 13:57:33 +0800
Message-ID: <52B28ACD.5080204@nvidia.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com>	<CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>	<52B02D04.4050905@nvidia.com>	<CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>	<52B187F5.7020105@nvidia.com>	<CAKohpokwhYC4FGnhpZPOGuJ2AM_7vygNk+3S+VpA_eXAexQX7g@mail.gmail.com>	<52B28397.5010808@nvidia.com> <CAKohpo=fJTLrN6myq5b9FTSro1m9oN3ep-aMu-3iv0J-S6TpdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=fJTLrN6myq5b9FTSro1m9oN3ep-aMu-3iv0J-S6TpdQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/19/2013 01:29 PM, Viresh Kumar wrote:
> On 19 December 2013 10:56, bilhuang <bilhuang@nvidia.com> wrote:
>> I'm not sure virtual regulator for CPU is a good idea, in addition to that,
>> we don't have a single SoC OPP table, we need several which are speedo-id
>> and process-id dependant, but generic cpufreq-cpu0 is assuming there is only
>> one statically
>
> Can't that be handled via DT ?
I don't think it can be handled via DT unless we separate DTB according 
to different CPU speedo/process-id but that is not a good idea.
>
>> for some SoC the frequency table is not fixed, they are
>> created at runtime combining our fast and slow CPU frequency table and dvfs
>> table. So I'm really not sure is it worth adding so many tweaks in order to
>> use the generic cpufreq-cpu0 driver.
>
> Hmm, maybe I got confused because I don't have a clear picture in my mind.
> It might be better to go ahead with your implementation for now and after
> everything is set, we can choose to use cpufreq-cpu0 if it is worth it.
>
This makes more sense to me, thanks.
> --
> viresh
>

