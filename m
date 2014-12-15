From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
Date: Mon, 15 Dec 2014 20:12:04 +0530
Message-ID: <CAKohponppyX2qOZvUm12jO5qQYw9=SAUcDqq4CBSdE73ZQo41g@mail.gmail.com>
References: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
	<2757282.fj6z18fAYb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <2757282.fj6z18fAYb@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "olof@lixom.net" <olof@lixom.net>, "# 3.13.x" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 December 2014 at 20:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Monday, December 15, 2014 09:48:19 AM Viresh Kumar wrote:
>> CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
>> ("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'") and some
>> defconfigs are still using it instead of the new one.
>>
>> Use the renamed CONFIG_CPUFREQ_DT generic driver.
>>
>> Cc: <stable@vger.kernel.org>        # 3.18
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> OK, so who should be applying this?

I think you can take it..
@Arnd: Any objections ?
