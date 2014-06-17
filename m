From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Tue, 17 Jun 2014 10:15:50 -0600
Message-ID: <53A069B6.6070902@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53A03186.3040703@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@linaro.org>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

On 06/17/2014 06:16 AM, Tomeu Vizoso wrote:
> On 06/16/2014 10:02 PM, Stephen Warren wrote:
>> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:

>> This binding looks quite anaemic vs.
>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
>> would expect that this binding needs all the EMC register data from the
>> tegra20-emc binding too. Can the two bindings be identical?
> 
> There's even less stuff needed right now, as all what ultimately the EMC
> driver does is call clk_set_rate on the EMC clock. As the T124 EMC
> driver gains more features, they should get more similar.

IIRC, even changing the EMC clock rate requires modifying the memory
controller's programming (e.g. delays/taps/tuning etc.). That's exactly
what the more complex stuff in the nvidia,tegra20-emc.txt is all about.
I not convinced that a driver that just modifies the clock rate without
adjusting the EMC programming will work reliably.

>>> +#ifdef CONFIG_TEGRA124_EMC
>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
>>> long rate);
>>> +void tegra124_emc_set_floor(unsigned long freq);
>>> +void tegra124_emc_set_ceiling(unsigned long freq);
>>> +#else
>>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned
>>> long rate)
>>> +{ return -ENODEV; }
>>> +void tegra124_emc_set_floor(unsigned long freq)
>>> +{ return; }
>>> +void tegra124_emc_set_ceiling(unsigned long freq)
>>> +{ return; }
>>> +#endif
>>
>> I'll repeat what I said off-list so that we can have the whole
>> conversation on the list:
>>
>> That looks like a custom Tegra-specific API. I think it'd be much better
>> to integrate this into the common clock framework as a standard clock
>> constraints API. There are other use-cases for clock constraints besides
>> EMC scaling (e.g. some in audio on Tegra, and I'm sure many on other
>> SoCs too).
> 
> Yes, I wrote a bit in the cover letter about our requirements and how
> they map to the CCF. Could you please comment on that?

My comments remain the same. I believe this is something that belongs in
the clock driver, or at the least, some API that takes a struct clock as
its parameter, so that drivers can use the existing DT clock lookup
mechanism.
