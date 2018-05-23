From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: cpufreq: Introduce QCOM CPUFREQ FW bindings
Date: Wed, 23 May 2018 09:18:23 -0500
Message-ID: <CAL_JsqL7VdSjerOioc5cSOyKAAXJuVnPJqp_WbTtwr11UUxq=A@mail.gmail.com>
References: <1526751291-17873-1-git-send-email-tdas@codeaurora.org>
 <1526751291-17873-2-git-send-email-tdas@codeaurora.org> <20180522193139.GA21623@rob-hp-laptop>
 <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523054846.zn7gftt6aqyibd26@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Amit Nischal <anischal@codeaurora.org>, devicetree@vger.kernel.org, Saravana Kannan <skannan@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 23, 2018 at 12:48 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-05-18, 14:31, Rob Herring wrote:
>> On Sat, May 19, 2018 at 11:04:50PM +0530, Taniya Das wrote:
>> > +           freq-domain-0 {
>> > +                   compatible = "cpufreq";
>> > +                   reg = <0x17d43920 0x4>,
>> > +                        <0x17d43110 0x500>,
>> > +                        <0x17d41000 0x4>;
>> > +                   reg-names = "perf_base", "lut_base", "en_base";
>> > +                   qcom,cpulist = <&CPU0 &CPU1 &CPU2 &CPU3>;
>
> I was thinking, can't we add platform specific properties in the CPU
> nodes ? If yes, then we can point the phandle of fw node from the CPUs
> and this awkward list can go away.

Yes, that's fine. That would be more like OPP binding in that the CPU
points to the OPP table rather than the OPP pointing to the CPUs.

With that, you can get rid of the child nodes completely. Just make
the parent reg property N sets of 3 addresses for N domains.

Rob
