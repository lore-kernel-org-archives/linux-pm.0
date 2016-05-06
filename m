From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 05/11] pwm: tegra-dfll: Add driver for Tegra DFLL PWM
 controller
Date: Fri, 6 May 2016 17:21:11 -0600
Message-ID: <572D26E7.2060406@wwwdotorg.org>
References: <1461321071-6431-1-git-send-email-pchiu@nvidia.com>
 <1461321071-6431-6-git-send-email-pchiu@nvidia.com>
 <20160422125513.GJ9047@ulmo.ba.sec> <20160506231532.GK3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160506231532.GK3492@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Penny Chiu <pchiu@nvidia.com>, gnurou@gmail.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/06/2016 05:15 PM, Stephen Boyd wrote:
> On 04/22, Thierry Reding wrote:
>> On Fri, Apr 22, 2016 at 06:31:05PM +0800, Penny Chiu wrote:
>>> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
>>> new file mode 100644
>>> index 0000000..bd0d247
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra-dfll-pwm.txt
>>> @@ -0,0 +1,48 @@
>>> +Tegra SoC DFLL PWM controller
>>
>> Stephen, we have in the past used tegra124 in names, even if the IP was
>> already included in tegra114, but we never supported it on Tegra114 and
>> hence couldn't even verify that the binding was valid. Any preference as
>> to the name in this particular case?
>
> You meant Stephen Warren right? I don't care either way.

Sorry, I wasn't really paying attention to patches.

Yes, using "124" seems to make sense; we can always expand the binding 
to cover "114" later if there's any demand.
