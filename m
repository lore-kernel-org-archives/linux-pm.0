From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI sensors
Date: Mon, 14 Sep 2015 17:03:16 +0100
Message-ID: <9hh7fntdm4b.fsf@e105922-lin.cambridge.arm.com>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	<1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	<20150914131448.GC7002@leverpostej>
	<9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	<20150914134949.GE7002@leverpostej>
	<9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
	<20150914144330.GH7002@leverpostej>
	<9hhfv2hdozu.fsf@e105922-lin.cambridge.arm.com>
	<20150914151540.GI7002@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:52911 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751816AbbINQD4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2015 12:03:56 -0400
In-Reply-To: <20150914151540.GI7002@leverpostej> (Mark Rutland's message of
	"Mon, 14 Sep 2015 16:15:40 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Sep 14, 2015 at 04:01:09PM +0100, Punit Agrawal wrote:
>> Mark Rutland <mark.rutland@arm.com> writes:
>> 

[...]

>> 
>> After seeing the mapping already published, I am wondering if there is
>> any value in duplicating the information. If there are no objections,
>> I'll update this patch to add pointers instead.
>
> That's fine by me. The important part is that the value is a raw Sensor
> ID as the FW uses. So long as we state that, the IDs themselves can come
> from whatever documentation is valid for a particular instance.
>
> Thanks for the info!

Sure. I've updated the patch to explain what the valid cell values are
along with a pointer to platform documentation for Juno R0 and R1.

I've also added an example to show usage of the sensors to create a
thermal zone.

I'll post a new version shortly.

Thanks for your having a look.

>
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
