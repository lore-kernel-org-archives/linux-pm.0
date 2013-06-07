From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] CPUFreq: ARM Updates for v3.11
Date: Fri, 07 Jun 2013 13:11:51 +0200
Message-ID: <54837539.yBQlA0EhhC@vostro.rjw.lan>
References: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-dev <linaro-dev@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 07, 2013 04:26:36 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/vireshk/linux.git cpufreq-next
> 
> for you to fetch changes up to f13ad5d9829c060fffe5bf45b05cc3c689a2e719:
> 
>   cpufreq: kirkwood: Select CPU_FREQ_TABLE option (2013-06-07 16:21:13 +0530)
> 
> ----------------------------------------------------------------
> Arnd Bergmann (2):
>       cpufreq: SPEAr needs cpufreq table
>       cpufreq: bit.LITTLE needs cpufreq table

That should be big.LITTLE I suppose?

Rafael


> 
> Ezequiel Garcia (1):
>       cpufreq: kirkwood: Select CPU_FREQ_TABLE option
> 
>  drivers/cpufreq/Kconfig.arm | 3 +++
>  1 file changed, 3 insertions(+)
> 
> --
> Viresh
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
