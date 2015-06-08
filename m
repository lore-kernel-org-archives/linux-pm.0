From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC 0/7] qcom: Add support for tsens driver
Date: Mon, 08 Jun 2015 09:05:10 -0700
Message-ID: <7hy4juw5hl.fsf@deeprootsystems.com>
References: <1429796773-7151-1-git-send-email-rnayak@codeaurora.org>
	<7hvbf1y974.fsf@deeprootsystems.com> <55751A27.6030306@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <55751A27.6030306@codeaurora.org> (Rajendra Nayak's message of
	"Mon, 08 Jun 2015 09:59:27 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, javi.merino@arm.com, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Hi Kevin,
>
>> Curious how are you testing this?  with which thermal governor?
>
> I have been mostly testing this with step wise on the db410c target
> board.
>
>>
>> I'm experimenting with the new thermal power_allocator governor
>> currently in linux-next, and was hoping to use this to test it, but I'm
>> noticing it doesn't work with the power_allocator governor.
>>
>> The first thing is that the power_allator goveror expects each thermal
>> zone to have a sustainable-power property in the DT, which this series
>> doesn't provide.  Hacking some dummy values in there to see what happens
>> next, I then hit the "thermal zone cpu-thermal0 has wrong trip setup for
>> power allocator" error from the power_allocator driver.
>
> Right, the RFC I posted wasn't tested with IPA and hence does not have
> some of the additional properties in DT which IPA expects.
> The wrong trip setup error that you are seeing is because IPA expects
> 2 passive trip points, a "switch on" trip point and a "desired
> temperature" trip point and the dts I posted with the RFC had
> just one passive trip point.
>
> I am in the process of testing this with IPA myself (on db410c mainly,
> but will also test on db8074 and IFC6410/6540 as well) and will repost
> in a few days with updated dts entries and a few other minor fixes
> to the driver itself. Let me know what target board you are
> interested to get this working on and I will make sure I test on it
> before I repost.

Great, thanks!

I tried on qcom-apq8064-ifc6410 and qcom-msm8974-sony-xperia-honami, and
would have also tried qcom-apq8084-ifc6540 but saw that Lina mentioned
there was missing support for 8084.

Kevin
