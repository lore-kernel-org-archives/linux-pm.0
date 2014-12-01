From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
Date: Mon, 01 Dec 2014 13:35:25 +0000
Message-ID: <547C6E9D.2090205@arm.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>	<7885354.QleDlR7NUO@wuerfel> <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33512 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbaLANfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 08:35:30 -0500
In-Reply-To: <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, "olof@lixom.net" <olof@lixom.net>



On 01/12/14 13:29, Viresh Kumar wrote:
> On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
>> Thanks a lot for working on this, we really need to figure it out one day!
>
> :)
>
>> Your patches seem well-implemented, so if everybody thinks the general
>> approach is the best solution, we should do that. From my point of view,
>> there are two things I would do differently:
>>
>> - In the DT binding, I would strongly prefer anything but the root compatible
>>    property as the key for the new platforms. Clearly we have to keep using
>>    it for the backwards-compatibility case, as you do, but I think there
>>    are more appropriate places to put it. Sorting from most favorite to least
>>    favorite, my list would be:
>>          1. a new property in /cpus/
>>          2. a new property each /cpus/cpu@... node.
>
> I did it this way earlier and named it dvfs-method but probably putting this
> into the /cpus/ node is far better. But then Sudeep asked to utilize
> compatible property only..
>
> Are you fine with the name here? "dvfs-method"
>

That's right, I don't like driver specific method in the cpu node as you
initially did. But if it's a property in the chosen node (where we
usually put the Linux specific properties), I am fine with
that as Arnd has illustrated in his patch.

Regards,
Sudeep

