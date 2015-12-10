From: "Rajendra Nayak" <rnayak@codeaurora.org>
Subject: Re: [PATCH v4 1/8] thermal: qcom: tsens: Add a skeletal TSENS
 drivers
Date: Thu, 10 Dec 2015 14:58:47 -0000
Message-ID: <5038cad94fdd2a76e33234d814658e7c.squirrel@www.codeaurora.org>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
    <1444383670-32693-2-git-send-email-rnayak@codeaurora.org>
    <20151102203021.GB4469@localhost.localdomain>
    <563AFCE9.8020000@codeaurora.org> <565BF633.7070701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <565BF633.7070701@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org


> []..
>
>>>> +Optional properties:
>>>> +- qcom,sensor-id: List of sensor instances used in a given SoC. A
>>>> TSENS IP can
>>>> +		  have a fixed number of sensors (like 11) but a given SoC can
>>>> +		  use only 5 of these and they might not always the first 5. They
>>>> +		  could be sensors 0, 1, 4, 8 and 9. This property is used to
>>>> +		  describe the subset of the sensors used. If this property is
>>>> +		  missing they are assumed to be the first 'n' sensors numbered
>>>> +		  sequentially in which case the number of sensors defaults to
>>>> +		  the number of slope values.
>>>
>>> Can you please elaborate a bit more on why you could not solve this
>>> using the thermal sensor descriptor id?
>>>
>>>> +
>>>> +Example:
>>>> +tsens: thermal-sensor@900000 {
>>>> +		compatible = "qcom,msm8916-tsens";
>>>> +		nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
>>>> +		nvmem-cell-names = "caldata", "calsel";
>>>> +		qcom,tsens-slopes = <3200 3200 3200 3200 3200>;
>>>
>
>
>>>> +		qcom,sensor-id = <0 1 2 4 5>;
>>>> +		#thermal-sensor-cells = <1>;
>>>
>>> How about if you simply make the sensor driver expose all sensors, then
>>> in the
>>> thermal zone descriptor, you pick which sensor to use using the thermal
>>> sensor
>>> descriptor (quoting the binding again):
>
> Hi Eduardo,
>
> What you suggested would work, except for that the calibration data in
> eeprom would
> be available for only the _subset_ of sensors on the SoC. So the driver in
> some way would
> need to know which exact sensors the eeprom data corresponds to.
>
> If this does not seem like something which needs to be described in DT, I
> can have the
> data embedded into the driver so it gets picked based on the right
> compatibles.

Hey Eduardo, any thoughts on this?

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
