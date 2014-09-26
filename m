From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 09:07:15 -0600
Message-ID: <20140926150715.GB390@ilina-mac.local>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
 <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
 <F743E5F0-28C1-4A9D-A27D-73EA70A01B46@codeaurora.org>
 <20140924172151.GD422@ilina-mac>
 <4BFC9B4E-A3D0-422E-9B55-0DB9F4B04EE9@codeaurora.org>
 <20140924192945.GC1004@ilina-mac.local>
 <20140926144542.GA390@ilina-mac.local>
 <64D76453-2C2D-4469-BE15-85428E38EDC6@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64D76453-2C2D-4469-BE15-85428E38EDC6@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 26 2014 at 08:53 -0600, Kumar Gala wrote:
>
>On Sep 26, 2014, at 9:45 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> On Wed, Sep 24 2014 at 13:30 -0600, Lina Iyer wrote:
>>> On Wed, Sep 24 2014 at 11:53 -0600, Kumar Gala wrote:
>>>>
>>>> On Sep 24, 2014, at 12:21 PM, Lina Iyer <lina.iyer@linaro.org> wro=
te:
>>>>
>>>>> On Wed, Sep 24 2014 at 10:33 -0600, Kumar Gala wrote:
>>>>>>
>>>>>> On Sep 23, 2014, at 6:51 PM, Lina Iyer <lina.iyer@linaro.org> wr=
ote:
>>>>>>
>>>>>> +- qcom,saw2-delays: The SPM delay values that SPM sequences wou=
ld refer to.
>>>>>>> +	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.
>>>>>>
>>>>>> Didn=E2=80=99t Stephen asked about splitting this up? Or at leas=
t treating it as an array of 3 values?
>>>>>>
>>>>> Yes he did. My response was similar to the clk-div values, its no=
t
>>>>> something you can change without hardware spec documentation.
>>>>> And I need to mix the three values up, anyways before I write to =
the
>>>>> register. Splitting it up, doesnt help understanding/configuring =
the SPM
>>>>> any better, so didnt change it.
>>>>
>>>> Hmm, will this value change from SPM to SPM on the same SoC?  I=E2=
=80=99m not a fan of allowing random register values to get poked into =
the HW from DT.  While this one case might end up being acceptable, its=
 a terrible practice and not something I want use in the habit of doing=
=2E
>>>>
>>> Ah. Tough proposition! The SPM sequence is a bunch of random regist=
er
>>> values, which is not open to interpretation without the programming
>>> guides. I am not sure how I can use DT for saving all the register =
data
>>> then.
>>>
>>> I agree its nice to have nice readable parameters in the DT, but, i=
snt
>>> the purpose of the DT, the hardware configuration? In an alternate =
way
>>> to do this, I could put all these register writes into the driver i=
tself
>>> for each SoC. Ugly as it may be, it would solve the problem. Howeve=
r,
>>> the device node then just has the compatible string in it and may b=
e
>>> some configurable elements. I fail to see the big picture of the us=
e of
>>> DT in such a case.
>>>
>>> FWIW, I do understand your stance with DT, and for the most part ag=
ree
>>> with it.
>>>
>> Based on our offline discussion, I will make the changes to move the=
se
>> proprietary register values into the driver. I will submit a patch w=
ith
>> the changes soon.
>
>Curious, do the command sequences vary SPM to SPM on the same SoC?  I=E2=
=80=99m guessing the L2 SPM sequence is probably different from the CPU=
 SPM.
Not really. CPUs are the mostly the same in an SoC but yes, they may
differ from the L2.

>
>Also, stephen pointed out that the SPMs should probably be part of the=
 SAW nodes and binding.
Well, the SAW nodes are essentially regulator bindings. They have no
bearing on idle part of the SAW functionality.

SPM driver will provide an API to change voltage. SPM used to need to
know the voltage and will need to for 8064, but 8074 onwards, SPM can b=
e
skipped in setting the voltage. It might be a tad bit faster to use SPM
to communicate to the PMIC, though.

=46or 8064, the voltage is turned off when powering down the core and
would need to be restored back to the original value when powering back
on. The value is captured in the PMIC_DATA registers and used by the
SPM sequence.

The SAW regulator information is not related to the SPM functionality
that I am implementing here.
It seems unnecessary to have two varied functionality be bound together
just because we need to shadow the register value. We could find better
ways to do that.

>
>thanks
>
>--=20
>Employee of Qualcomm Innovation Center, Inc.
>Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hos=
ted by The Linux Foundation
>
