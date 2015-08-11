From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] thermal: of: Introduce governor selection in dts
Date: Tue, 11 Aug 2015 10:07:31 +0100
Message-ID: <55C9BB53.1090001@arm.com>
References: <CAM2ehZYXsqCoS9ygXNfPHxt9-b5cFxH_ovrgjvM-BfDO6REcUg@mail.gmail.com> <20150807103121.GC7646@leverpostej> <CAM2ehZYy3SNKhXvF0XyQsoPFab2JqrVq3wLKadPVxBsVG3E7jw@mail.gmail.com> <20150810174723.GC2747@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150810174723.GC2747@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, =?UTF-8?B?IkNodW5nLVlpaCBXYW5nICjnjos=?= =?UTF-8?B?5bSH5oe/KSI=?= <cywang@google.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 10/08/15 18:47, Javi Merino wrote:
> On Mon, Aug 10, 2015 at 09:00:49AM +0100, Chung-Yih Wang (=E7=8E=8B=E5=
=B4=87=E6=87=BF) wrote:
>> This patch was originally introduced when we made power_allocator th=
e
>> default governor where we had issues in binding a thermal zone w/o
>> parameters to. Then we came out this facility for binding a specific
>> governor to a thermal zone in dts instead of the default governor.
>> Javi seems like this idea much.
>
> While I can understand why this is not suitable for devicetree, we
> should have a way in the kernel to configure different governors for
> different thermal zones defined in device tree.  Thermal zones define=
d
> from platform code can choose the thermal governor when they are
> registered.
>
> If this information can't go in device tree, where can we put it? As
> an additional parameter to thermal_zone_of_sensor_register()?
>

Why can't it be via sysfs allowing users to select their choice of
governor ? (like cpuidle/freq or even devfreq I assume)

Regards,
Sudeep
