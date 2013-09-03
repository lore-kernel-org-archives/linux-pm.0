From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Query-CPUIdle]: Not much activity in C0 state
Date: Tue, 03 Sep 2013 15:32:56 +0200
Message-ID: <5225E508.2060407@linaro.org>
References: <CAKohpo=OuYK7vhoG6a4REd-XuGMP63NTKhd8TWJmKo1R6rDp7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=OuYK7vhoG6a4REd-XuGMP63NTKhd8TWJmKo1R6rDp7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Suresh.Srinivasan@arm.com, Amit Kucheria <amit.kucheria@linaro.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

On 08/27/2013 12:23 PM, Viresh Kumar wrote:
> Hi Guys,
>=20
> I was trying to run following on my thinkpad:
>=20
> watch -n1 cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage
>=20
> I can see lots of activities on State 1-4, but not much on state 0..
> I thought we should enter this state as soon as we come out to
> non-idle state.. And so this count must be changing quite rapidly.
>=20
> Is this a bug?

Hi Viresh,

the menu governor tries always to stick to C1 (state1) as default state=
,
look at the menu_select function. The state0 (not C0 but 'poll') will
happen when the next timer event is less than 5us, this occurs rarely.
You can easily spot it by doing while $(true); usleep 2; done

The poll state is x86 specific where the cpu detects the 'rep nop'
instructions to do some power saving.

Hope that helps

  -- Daniel



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
