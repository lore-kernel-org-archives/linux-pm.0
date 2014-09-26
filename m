From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 09:53:14 -0500
Message-ID: <64D76453-2C2D-4469-BE15-85428E38EDC6@codeaurora.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org> <1411516281-58328-2-git-send-email-lina.iyer@linaro.org> <F743E5F0-28C1-4A9D-A27D-73EA70A01B46@codeaurora.org> <20140924172151.GD422@ilina-mac> <4BFC9B4E-A3D0-422E-9B55-0DB9F4B04EE9@codeaurora.org> <20140924192945.GC1004@ilina-mac.local> <20140926144542.GA390@ilina-mac.local>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:35178 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbaIZOxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 10:53:19 -0400
In-Reply-To: <20140926144542.GA390@ilina-mac.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org


On Sep 26, 2014, at 9:45 AM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Wed, Sep 24 2014 at 13:30 -0600, Lina Iyer wrote:
>> On Wed, Sep 24 2014 at 11:53 -0600, Kumar Gala wrote:
>>>=20
>>> On Sep 24, 2014, at 12:21 PM, Lina Iyer <lina.iyer@linaro.org> wrot=
e:
>>>=20
>>>> On Wed, Sep 24 2014 at 10:33 -0600, Kumar Gala wrote:
>>>>>=20
>>>>> On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wro=
te:
>>>>>=20
>>>>> +- qcom,saw2-delays: The SPM delay values that SPM sequences woul=
d refer to.
>>>>>> +	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.
>>>>>=20
>>>>> Didn=92t Stephen asked about splitting this up? Or at least treat=
ing it as an array of 3 values?
>>>>>=20
>>>> Yes he did. My response was similar to the clk-div values, its not
>>>> something you can change without hardware spec documentation.
>>>> And I need to mix the three values up, anyways before I write to t=
he
>>>> register. Splitting it up, doesnt help understanding/configuring t=
he SPM
>>>> any better, so didnt change it.
>>>=20
>>> Hmm, will this value change from SPM to SPM on the same SoC?  I=92m=
 not a fan of allowing random register values to get poked into the HW =
from DT.  While this one case might end up being acceptable, its a terr=
ible practice and not something I want use in the habit of doing.
>>>=20
>> Ah. Tough proposition! The SPM sequence is a bunch of random registe=
r
>> values, which is not open to interpretation without the programming
>> guides. I am not sure how I can use DT for saving all the register d=
ata
>> then.
>>=20
>> I agree its nice to have nice readable parameters in the DT, but, is=
nt
>> the purpose of the DT, the hardware configuration? In an alternate w=
ay
>> to do this, I could put all these register writes into the driver it=
self
>> for each SoC. Ugly as it may be, it would solve the problem. However=
,
>> the device node then just has the compatible string in it and may be
>> some configurable elements. I fail to see the big picture of the use=
 of
>> DT in such a case.
>>=20
>> FWIW, I do understand your stance with DT, and for the most part agr=
ee
>> with it.
>>=20
> Based on our offline discussion, I will make the changes to move thes=
e
> proprietary register values into the driver. I will submit a patch wi=
th
> the changes soon.

Curious, do the command sequences vary SPM to SPM on the same SoC?  I=92=
m guessing the L2 SPM sequence is probably different from the CPU SPM.

Also, stephen pointed out that the SPMs should probably be part of the =
SAW nodes and binding.

thanks

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation

