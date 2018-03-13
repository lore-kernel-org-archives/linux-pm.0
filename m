From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
Date: Tue, 13 Mar 2018 11:23:18 -0700
Message-ID: <CAE-0n52k7FijaRsAAuYM0xXvfyJ2g+coz9WFPNyGij6uC8_8Lg@mail.gmail.com>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
 <20180307050624.GR23018@vireshk-i7>
 <20180308201438.GA10589@jcrouse-lnx.qualcomm.com>
 <20180309034332.GO6842@vireshk-i7>
 <20180309160355.GC10589@jcrouse-lnx.qualcomm.com>
 <20180312055254.GY6842@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180312055254.GY6842@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-pm@vger.kernel.org, sboyd@kernel.org, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, vireshk@kernel.org, freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 11, 2018 at 10:52 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-03-18, 09:03, Jordan Crouse wrote:
>> I don't think we are understanding each other. The GMU is a separate
>> microcontroller. It is given a magic number (actually a combination of magic
>> numbers) that it then uses to directly interact with the other hardware to make
>> the vote. The only responsibility that the CPU has is to construct that magic
>> number (once, at init) and send it across when asked.
>>
>> Looking at the sdhc code from the testing tree it makes perfect sense
>> that you have a device that needs to eventually do a RPMh vote from the CPU and
>> so the 'required-opp' and performance state come together to do the right thing.
>> This is good code.
>>
>> None of this is true for the GPU. The CPU never votes for the GPU so there
>> isn't any need to connect it to the power domain drivers. Even if you did
>> there isn't any current mechanism for the rpmpd driver to pass the right magic
>> number to the GPU driver which is what it really needs.
>>
>> I suppose that instead of using 'qcom,arc-level' we could use 'qcom-corner' but
>> then thats just a naming dispute. We still need a way for the GPU to query the
>> magic values.
>
> Okay, I get it. You can't (shouldn't) use genpd stuff here. I would still like
> you guys (You/Rajendra/Stephen) to conclude if qcom-corner and qcom,arc-level
> are eventually same values and we should use same property for them.
>

It sounds like it's qcom,{corner,level} from Jordan's description. In
my mind 'level' and 'corner' are the same but they got a name change
with the new RPM interface. Then another number space was introduced
with the new RPM interface, 'arc-level', which represents the numbers
that the hardware deals with. It may be that DT doesn't ever care to
express the 'arc-level', because cmd db hides the numberspace by
requiring software to translate the software 'level' to the hardware
'arc-level'. So the whole thing may be a moot point and we can decide
to use qcom,level everywhere because it's the future.
