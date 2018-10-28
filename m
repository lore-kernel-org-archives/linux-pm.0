From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage
 regulators
Date: Sun, 28 Oct 2018 15:58:25 +0300
Message-ID: <bd3a57ee-6131-22bb-1954-3d97bba5276a@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
 <20181021205501.23943-2-digetx@gmail.com>
 <20181022053636.ag62j3rj3vovbz53@vireshk-i7>
 <e4027793-9436-413d-2a7b-34cf519218c3@gmail.com>
 <20181022113224.b5fiebgy2aap66nd@vireshk-i7>
 <29f893be-feed-c4c5-8468-51f7228dd468@gmail.com>
 <20181024064123.lbpbeervghp35fe7@vireshk-i7>
 <ba782346-6ac0-7bf3-e187-00d2634b145b@gmail.com>
 <1540568255.2245.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540568255.2245.11.camel@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/26/18 6:37 PM, Lucas Stach wrote:
> Am Freitag, den 26.10.2018, 15:03 +0300 schrieb Dmitry Osipenko:
> [...]
>>> On the other hand, the tegra20 cpufreq driver is common across a lot of boards.
>>> What will happen if the DT for some of the boards isn't correct and missed the
>>> necessary regulator node ?
>>
>> AFAIK, there is assumption that bootloader should setup regulators in
>> a way that kernel could work properly at max clock rates. Otherwise
>> things won't work.
> 
> This isn't true. The assumption is that the bootloader sets up the
> regulators such that stable operation at the CPU speed used by the
> bootloader is guaranteed.
> 
> Often the bootloader doesn't know about specific SKUs, so drives things
> at a rate/voltage that is safe across all SKUs [1], in which case the
> bootloader is totally unaware of the voltage needed to run the CPU at
> highest possible clock frequency.
> 
> Regards,
> Lucas
> 
> [1] http://git.denx.de/?p=u-boot.git;a=commit;h=2364e151e432b4ccf32dc9e6147121253d4ff86d
> 

Oh, okay. Thank you for pointing at [1], though the assumption is true for T20. 

I agree that it's better not to rely on configuration left from bootloader in general.
