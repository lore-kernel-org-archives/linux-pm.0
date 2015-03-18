From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Wed, 18 Mar 2015 10:31:42 +0100
Message-ID: <CABxcv=nRZiMy3_ynSV81TDTKKCNFXrF6Er7-xU9MavwMaJ=9jA@mail.gmail.com>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
	<CAMAWPa9fUJVjJ8V+93AkHy9DtEmUUnGs4MJDGcsoMdWwGmg5qg@mail.gmail.com>
	<CAJKOXPfyPH7tyce6YB=q4krSP078aJVAmqObg89qCnLrL_Nbhg@mail.gmail.com>
	<20150216105217.79315ffd@amdc2363>
	<54E3A3CD.3020106@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54E3A3CD.3020106@gmx.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: Tobias Jakobi <liquid.acid@gmx.net>, Lukasz Majewski <l.majewski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello Thomas,

On Tue, Feb 17, 2015 at 9:25 PM, Tobias Jakobi <liquid.acid@gmx.net> wrote:
> Hello!
>
> Lukasz Majewski wrote:
>> Hi Krzysztof, Thomas,
>>
>>> 2015-01-08 22:17 GMT+01:00 Kevin Hilman <khilman@kernel.org>:
>>> Hi Thomas,
>>>
>>> Do you plan to continue with this work? It would be very helpful.
>>
>> +1 from me.
>>
>>>
>>> I also wonder if Exynos 4412 could be re-added (without the boost if
>>> these bindings are not ready)?
>>
>> I would prefer to have all platforms converted at once, since it might
>> happen that some parts of the work would get lost.
>
> Joining in as well!
>
> Reviving this patch series would be very much appreciated, especially if
> it moves again into the direction of storing most information into the
> DT (so that one can easily modify it in the board dts).
>
> With best wishes,
> Tobias
>

As others stated, it would be very useful to get this patch-set in but
the current version has some issues as Kevin mentioned.

Are you planning to continue working on this series?

Best regards,
Javier
