From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 7/8] ARM: cpuidle: Register per cpuidle device
Date: Mon, 23 Mar 2015 15:42:01 +0100
Message-ID: <55102639.4000305@linaro.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org> <1426851841-2072-8-git-send-email-daniel.lezcano@linaro.org> <20150321203546.GE22354@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150321203546.GE22354@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 03/21/2015 09:35 PM, Lorenzo Pieralisi wrote:
> On Fri, Mar 20, 2015 at 11:44:00AM +0000, Daniel Lezcano wrote:
>> Some architectures have some cpus which does not support idle states=
=2E
>>
>> Let the underlying low level code to return -ENXIO when it is not
>> possible to set an idle state.
>
> Well, this is getting interesting. We are parsing possible CPUs to
> detect if they have common idle states in DT. If a CPU does not suppo=
rt
> idle states, the cpu node for that CPU should not define any idle
> state.
>
> The approach above will work with my heterogenous system patch, since
> the respective CPUidle driver mask will be created by parsing the DT
> idle states.
>
> http://www.spinics.net/lists/arm-kernel/msg403190.html
>
> In current approach if a "possible " CPU does not have idle states, w=
e do
> not init CPUidle at all.
>
> So, to cut a long story short, what does "a cpu does not support idle
> states" mean ?
>
> Does it mean that firmware defines idle states for that CPU in DT but
> initializing them fail ?
>
> I am fine with this patch, but we need to define -ENXIO return proper=
ly.

Ok, I think that needs more discussion.

I will drop this patch from my patchset as we agreed on the other=20
patches and resubmit.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
