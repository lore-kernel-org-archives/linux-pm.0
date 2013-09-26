From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 16/21] cpuidle: avoid unnecessary kzalloc/free of struct
 cpuidle_device_kobj
Date: Thu, 26 Sep 2013 10:30:03 +0200
Message-ID: <5243F08B.4090907@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<fb67ff6fa01bde06aeab43c4a02da2923615e6ef.1379779777.git.viresh.kumar@linaro.org>	<52435FE2.20805@linaro.org> <CAKohpokT12boxnnUJ=5Bd8tRh5VKvidd+kxQ6tF+pp1SLcgb4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokT12boxnnUJ=5Bd8tRh5VKvidd+kxQ6tF+pp1SLcgb4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/26/2013 08:05 AM, Viresh Kumar wrote:
> On 26 September 2013 03:42, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>>> We always need to allocate struct cpuidle_device_kobj for all CPUs =
and so there
>>> is no real need to have a pointer to it inside struct cpuidle_devic=
e.
>>>
>>> This patch makes a object instance of struct cpuidle_device_kobj in=
side struct
>>> cpuidle_device instead of a pointer.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> nack, it was made in purpose for kobject_init_and_add.
>>
>> see commit 728ce22b696f9f1404a74d7b2279a65933553a1b
>
> Ahh.. sorry for missing that one :(
>
> Now that I understand why it was introduced, I am thinking if
> we can make hotplug path a bit fast? By not freeing sysfs stuff
> and only hiding it for time being? And so we wouldn't be required
> to do unnecessary initialisations while coming back?
>
> Would that be worth it?

Yes if it possible.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
