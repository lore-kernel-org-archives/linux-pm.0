From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date: Mon, 1 Oct 2018 13:56:32 -0700
Message-ID: <1ae0a36a-1178-4db5-1ae9-8f19e561a18b@codeaurora.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926143432.GH10761@jcrouse-lnx.qualcomm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, robdclark@gmail.com
List-Id: linux-pm@vger.kernel.org



On 09/26/2018 07:34 AM, Jordan Crouse wrote:
> On Tue, Sep 25, 2018 at 01:02:15PM -0500, Rob Herring wrote:
>> On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
>>> This binding is intended to represent the relations between the interconnect
>>> controllers (providers) and consumer device nodes. It will allow creating links
>>> between consumers and interconnect paths (exposed by interconnect providers).
>> As I mentioned in person, I want to see other SoC families using this
>> before accepting. They don't have to be ready for upstream, but WIP
>> patches or even just a "yes, this works for us and we're going to use
>> this binding on X".
>>
>> Also, I think the QCom GPU use of this should be fully sorted out. Or
>> more generically how this fits into OPP binding which seems to be never
>> ending extended...
> This is a discussion I wouldn't mind having now.  To jog memories, this is what
> I posted a few weeks ago:
>
> https://patchwork.freedesktop.org/patch/246117/
>
> This seems like the easiest way to me to tie the frequency and the bandwidth
> quota together for GPU devfreq scaling but I'm not married to the format and
> I'll happily go a few rounds on the bikeshed if we can get something we can
> be happy with.
>
> Jordan

Been meaning to send this out for a while, but caught up with other stuff.

That GPU BW patch is very specific to device to device mapping and 
doesn't work well for different use cases (Eg: those that  can calculate 
based on use case, etc).

Interconnect paths have different BW (bandwidth) operating points that 
they can support. For example: 1 GB/s, 1.7 GB/s, 5GB/s, etc. Having a 
mapping from GPU or CPU to those are fine/necessary, but we still need a 
separate BW OPP table for interconnect paths to list what they can 
actually support.

Two different ways we could represent BW OPP tables for interconnect paths:
1.  Represent interconnect paths (CPU to DDR, GPU to DDR, etc) as 
devices and have OPPs for those devices.

2. We can have a "interconnect-opp-tables" DT binding similar to 
"interconnects" and "interconnect-names". So if a device GPU or Video 
decoder or I2C device needs to vote on an interconnect path, they can 
also list the OPP tables that those paths can support.

I know Rob doesn't like (1). But I'm hoping at least (2) is acceptable. 
I'm open to other suggestions too.

Both (1) and (2) need BW OPP tables similar to frequency OPP tables. 
That should be easy to add and Viresh is open to that. I'm open to other 
options too, but the fundamental missing part is how to tie a list of BW 
OPPs to interconnect paths in DT.

Once we have one of the above two options, we can use the required-opps 
field (already present in kernel) for the mapping between GPU to a 
particular BW need (suggested by Viresh during an in person conversation).

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
