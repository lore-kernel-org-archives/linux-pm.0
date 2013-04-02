From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 1/2] cpuidle: Add idle enter/exit time stamp for notifying
 current idle state.
Date: Tue, 02 Apr 2013 09:34:57 +0200
Message-ID: <515A8A21.6070509@linaro.org>
References: <1364804657-16590-1-git-send-email-jonghwa3.lee@samsung.com> <1364804657-16590-2-git-send-email-jonghwa3.lee@samsung.com> <515A65DB.8070803@linaro.org> <515A77FC.70008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <515A77FC.70008@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, sw0312.kim@samsung.com, m.szyprowski@samsung.com
List-Id: linux-pm@vger.kernel.org

On 04/02/2013 08:17 AM, jonghwa3.lee@samsung.com wrote:
> On 2013=EB=85=84 04=EC=9B=94 02=EC=9D=BC 14:00, Daniel Lezcano wrote:
>=20
>> On 04/01/2013 10:24 AM, Jonghwa Lee wrote:
>>> This patch adds idle state time stamp to cpuidle device structure t=
o
>>> notify its current idle state. If last enter time is newer than las=
t
>>> exit time, then it means that the core is in idle now.
>>>
>>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>>> ---
>>
>> The patch description does not explain what problem you want to solv=
e,
>> how to solve it and the patch itself shows nothing.
>>
>> Could you elaborate ?
>=20
>=20
> I'm sorry for lacking description. I supplement more.
>=20
> This patch does add time-stamp for idle enter/exit only nothing more.
> The reason why I needed them is that I wanted to know current cpu idl=
e
> state. It is hard to know whether cpu is in idle or not now.

Did you looked at:

include/linux/sched.h:extern int idle_cpu(int cpu);

?

> When I check the cpuidle state usage, sometimes the information is wr=
ong.
> Because it is updated only when the cpu exits the idle state. So whil=
e the
> cpu is idling, the cpuidle state usage holds past one. Therefore I pu=
t
> the time-stamp for cpuidle enter/exit for checking current idling and
> calculating idle state usage correctly.
>=20
> I just make this patch temporary for my cpufreq governor work. So, it=
 just
> use time-stamp for all idle state together. After RFC working, I have=
 a plan
> to update this patch to use timestamp for each idle state.

I suggest you look at the enter_idle / exit_idle function and make your
governor to subscribe to the IDLE_START/EXIT notifiers.

arch/x86/kernel/process.c

These are defined for the x86 architecture, maybe worth to add it to
another architecture.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

