From: Sricharan R <sricharan@codeaurora.org>
Subject: Re: [PATCH v8 00/15] Krait clocks + Krait CPUfreq
Date: Fri, 2 Mar 2018 19:42:41 +0530
Message-ID: <e133630b-36b2-ed0e-3052-3e2e1c958405@codeaurora.org>
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
 <CACRpkdbu9Kxvuwr-nLHxyEYiTeGK38o7MKCFf-MMjYxwgcJPPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbu9Kxvuwr-nLHxyEYiTeGK38o7MKCFf-MMjYxwgcJPPA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, viresh kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

On 3/1/2018 6:58 PM, Linus Walleij wrote:
> Hi Sricharan,
> 
> thanks for picking up Stephen's patch set and working on this
> clocking business!
> 
> Would you happen to know if the MSM8660/APQ8060 that
> I'm using a bit has the same Krait clocking so I need to augment
> that SoC to use this too (on top of this, naturally, this is a good first
> step)?
> 

After digging a bit for data, looks like the clock controller in msm8660
is called the acpuclk/scplls [1] . So the support for these clocks have
to be added. rpm_pm8901_regulators is in place.

Looks like it is using the same PVS cpufreq table as in Krait. so once
the support for clks is added, the krait cpufreq bindings can be used.
 
[1] https://bitbucket.org/carvsdriver/android_kernel_samsung_msm8660-common/src/0a8b2f30db72e00d6e0b9ad1b9630fe33099ccd0/arch/arm/mach-msm/acpuclock-8x60.c?at=moretz&fileviewer=file-view-default 

> On Tue, Feb 27, 2018 at 3:06 PM, Sricharan R <sricharan@codeaurora.org> wrote:
> 
>>   * Dropped the DT update from the series. Will send separatelyssbi
> 
> Are these available somewhere so I can test the sum total on
> the Nexus 7 and see if I get some graphics? I've been sticking a
> patch from Stephen's series in for some time and it makes the
> MDP graphics works on the 2013 Nexus 7.
> 

ok, Nexus 7 -> apq8064 right ?

Just pushed the data for apq8064 as per latest bindings for reference [1].
Don't have an board to test that data. Also have not added the cpu-supply
as well.

[1] https://github.com/sricharanaz/kernel/commit/464aa4fd5fc642a6b296d5ad438211042496dabb

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
