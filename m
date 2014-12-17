From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
Date: Wed, 17 Dec 2014 10:01:39 -0600
Message-ID: <CAGo_u6oO+Tou2XSVr3dxn94hV0HTdYMZWz-XKK_aydwusaRBvg@mail.gmail.com>
References: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
	<2757282.fj6z18fAYb@vostro.rjw.lan>
	<7h1to0iw76.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <7h1to0iw76.fsf@deeprootsystems.com>
Sender: stable-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org, Linaro Kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Olof Johansson <olof@lixom.net>, arnd.bergmann@linaro.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 15, 2014 at 12:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
>> On Monday, December 15, 2014 09:48:19 AM Viresh Kumar wrote:
>>> CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
>>> ("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'") and some
>>> defconfigs are still using it instead of the new one.
>>>
>>> Use the renamed CONFIG_CPUFREQ_DT generic driver.
>>>
>>> Cc: <stable@vger.kernel.org>        # 3.18
>>> Reported-by: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> OK, so who should be applying this?
>>
>
> Normally, we take these defconfig changes through the arm-soc tree, and
> I think that should continue, otherwise we'll be bound to have conflicts.
>
> Note all the pull requests for this merge window are already sent, but
> I'll queue this up in arm-soc/fixes so it can make it during the
> v3.19-rc cycle.

Any chance of the following being queued for the .19 window or do we
wait to go through Tony?
https://patchwork.kernel.org/patch/5484401/
