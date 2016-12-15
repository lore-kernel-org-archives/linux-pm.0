From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3] dt-bindings: power: supply: bq24735: reverse the
 polarity of ac-detect
Date: Thu, 15 Dec 2016 18:50:06 +0100
Message-ID: <c3e87e2b-5d0d-c1ff-8edf-f4a77de31c1e@axentia.se>
References: <1481804479-8711-1-git-send-email-peda@axentia.se>
 <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5f5fe01a-7c7a-58f7-2171-5f6879392ea7@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On 2016-12-15 18:32, Stephen Warren wrote:
> On 12/15/2016 05:21 AM, Peter Rosin wrote:
>> The ACOK pin on the bq24735 is active-high, of course meaning that when
>> AC is OK the pin is high. However, all Tegra dts files have incorrectly
>> specified active-high even though the signal is inverted on the Tegra
>> boards. This has worked since the Linux driver has also inverted the
>> meaning of the GPIO. Fix this situation by simply specifying in the
>> bindings what everybody else agrees on; that the ti,ac-detect-gpios is
>> active on AC adapter absence.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>
>> Hi!
>>
>> This patch is the result of this discussion:
>> http://marc.info/?t=148152531800002
>>
>> I don't like how it changes the one thing that is seems correct, but
>> what to do?
> 
> I haven't followed this thread so hopefully what I say is relevant. My 
> take is:
> 
> If the DT binding is correct or reasonable, keep it.
> 
> If the Tegra DTs contain incorrect content, and never worked correctly 
> in this aspect, then fix them. We do need to maintain DT 
> ABI/compatibility, but I believe only with stuff that actually worked 
> correctly. If the DT has a bug, just fix it.
> 
> That said, if ti,ac-detect-gpios is describing a host GPIO, then it's 
> entirely arbitrary which polarity it should have, i.e. the polarity is 
> not something specified by the bq24735 HW. In that case, feel free to 
> change either the binding to match the DT or the DT to match the 
> binding. Changing the DT to match the binding might still be better 
> since there could be other users you're not aware of, and they might 
> have written their DT correctly, and you don't want to break them.

The bindings are fine.

The Tegra dts files are buggy, but the driver is also buggy, so those
two bugs cancel each other. So, the option is to either introduce
regressions by fixing the two bugs thus creating a flag day where
the kernel and dt needs to match. Or, just document what is going on
and change the bindings even if they are not wrong.

I suggest you read the discussion. We covered all this already, and it
is also in the commit message.

Cheers,
peda
