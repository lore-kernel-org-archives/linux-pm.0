From: Raju P L S S S N <rplsssn@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: sdm845: Add PSCI cpuidle low power states
Date: Tue, 30 Oct 2018 21:53:55 +0530
Message-ID: <5b62572d-9f45-c0ee-776e-1486a9d40862@codeaurora.org>
References: <1539622953-4188-1-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=XB9diR_n1TB4+wUjVaRf0VAmCMgkSbtuOSNO5pkrQ8zg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
List-Id: linux-pm@vger.kernel.org



On 10/24/2018 12:06 AM, Doug Anderson wrote:
> Hi,
> 
> On Mon, Oct 15, 2018 at 10:02 AM Raju P.L.S.S.S.N
> <rplsssn@codeaurora.org> wrote:
>> +               idle-states {
>> +                       entry-method = "psci";
>> +
>> +                       C0_CPU_SPC: c0_spc {
> 
> nit: all these nodes should have dashes instead of spaces in the node
> names (labels can still have spaces).  AKA:
> 
> C0_CPU_SPC: c0-spc {

Sure. I will change this. (However, from device tree specification v0.2, 
I see that Table 2.1 mentions underscore as valid character for node. 
Please correct me if I'm missing something)

> 
> 
>> +                               compatible = "arm,idle-state";
>> +                               arm,psci-suspend-param = <0x40000003>;
>> +                               entry-latency-us = <350>;
>> +                               exit-latency-us = <461>;
>> +                               min-residency-us = <1890>;
>> +                               local-timer-stop;
>> +                               idle-state-name = "pc";
> 
> It seems weird that the idle state with the node name "spc" has the
> name "pc" and the idle state with the node name "pc" has the name
> "rail pc".  Can this be more consistent or is there a reason why they
> need to be mismatched?

Agree. They are confusing. Will change this.

> 
> Also: AAHTUFSWDKWTM (acronyms are hard to understand for someone who
> doesn't know what they mean).  If you really need to use an the
> acronyms "PC" and "SPC" please document them somewhere.  In the very
> least the commit message, but having a comment in the file is good
> too.  ...or (even better) don't use the acronym and spell out what
> you're talking about.  Please correct me if I'm wrong, but I don't
> think it's obvious what the "PC" and "SPC" idle states mean.

Sure. Will change this.


Thanks for feedback Doug.

> 
> 
> -Doug
> 
