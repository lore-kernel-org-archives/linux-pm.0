From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date: Tue, 27 Nov 2018 20:05:39 +0200
Message-ID: <bfed1f52-1544-8491-9f0f-b46c2787b45e@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Krishna Sitaraman <ksitaraman@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 9/26/18 17:42, Georgi Djakov wrote:
> Hi Rob,
> 
> Thanks for the comments!
> 
> On 09/25/2018 09:02 PM, Rob Herring wrote:
>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>> This binding is intended to represent the relations between the interconnect
>>> controllers (providers) and consumer device nodes. It will allow creating links
>>> between consumers and interconnect paths (exposed by interconnect providers).
>>
>> As I mentioned in person, I want to see other SoC families using this
>> before accepting. They don't have to be ready for upstream, but WIP
>> patches or even just a "yes, this works for us and we're going to use
>> this binding on X".

Patches for the iMX7ULP platform are already available [1]. Thanks 
Alexandre Bailon!

The interconnect API seems to be also a good fit for Nvidia SoCs. There 
is an ongoing discussion about implementing an interconnect provider 
driver for Tegra [2]. Thanks Thierry and Krishna!

In addition of the above, i also checked privately with a few other SoC 
maintainers and made them aware of these patches. Some are not ready for 
upstream yet, but the feedback was positive and i expect more SoCs to 
make use of this in the future.

BR,
Georgi

[1] https://lkml.org/lkml/2018/11/17/368
[2] https://marc.info/?t=154056181900001&r=1&w=2


> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
> currently using this binding, there is ongoing work from at least two
> other vendors that would be using this same binding. I will check on
> what is their progress so far.
> 
>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>> more generically how this fits into OPP binding which seems to be never
>> ending extended...
> 
> I see this as a further step. It could be OPP binding which include
> bandwidth values or some separate DT property. Jordan has already
> proposed something, do you have any initial comments on that?
> 
> BR,
> Georgi
> 
