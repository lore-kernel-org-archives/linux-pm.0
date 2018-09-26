From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date: Wed, 26 Sep 2018 18:03:16 +0300
Message-ID: <0fd425c0-733b-825e-69ad-96294e5c911a@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926144830.GB25838@e107155-lin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 09/26/2018 05:48 PM, Sudeep Holla wrote:
> On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
>> Hi Rob,
>>
>> Thanks for the comments!
>>
>> On 09/25/2018 09:02 PM, Rob Herring wrote:
>>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>>> This binding is intended to represent the relations between the interconnect
>>>> controllers (providers) and consumer device nodes. It will allow creating links
>>>> between consumers and interconnect paths (exposed by interconnect providers).
>>>
>>> As I mentioned in person, I want to see other SoC families using this 
>>> before accepting. They don't have to be ready for upstream, but WIP 
>>> patches or even just a "yes, this works for us and we're going to use 
>>> this binding on X".
>>
>> Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
>> currently using this binding, there is ongoing work from at least two
>> other vendors that would be using this same binding. I will check on
>> what is their progress so far.
>>
>>> Also, I think the QCom GPU use of this should be fully sorted out. Or 
>>> more generically how this fits into OPP binding which seems to be never 
>>> ending extended...
>>
>> I see this as a further step. It could be OPP binding which include
>> bandwidth values or some separate DT property. Jordan has already
>> proposed something, do you have any initial comments on that?
> 
> I am curious as how this fits into new systems which have firmware driven
> CPUFreq and other DVFS. I would like to avoid using this in such systems
> and leave it upto the firmware to scale the bus/interconnect based on the
> other components that are connected to it and active.

This can be used with firmware driven systems too. In this case the
interconnect platform driver will not manage the interconnects directly,
but will collect data and provide hints to the firmware. Then the
firmware can take into account these hints and do the scaling.

Thanks,
Georgi
