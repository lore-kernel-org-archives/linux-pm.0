From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 11/21] cpuidle: replace multiline statements with single
 line in cpuidle_idle_call()
Date: Thu, 26 Sep 2013 09:55:18 +0200
Message-ID: <5243E866.1000909@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<c79ae2ab0a5a3946fcd0e68c855742f06f695f0f.1379779777.git.viresh.kumar@linaro.org>	<52435DA4.3080204@linaro.org> <CAKohpokM2JLyjq3cTw=GMDx8S+_fZU1qxxavKoZ-roC2PXukNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokM2JLyjq3cTw=GMDx8S+_fZU1qxxavKoZ-roC2PXukNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/26/2013 07:51 AM, Viresh Kumar wrote:
> On 26 September 2013 03:33, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> I splitted these lines because they have 81 cols.
>=20
>>> -             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>>> -                                &dev->cpu);
>>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, =
&dev->cpu);
>=20
> This one comes in 80 columns
>=20
>>> -             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>>> -                                &dev->cpu);
>>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &=
dev->cpu);
>=20
> And this one in 79..
>=20
> And so I did this change.. I have checked it again now..

Well I have 81 with Vi and 80 with Emacs :)

May be some tabs converted to spaces ...

Anyway if it fits 80 cols then it is ok.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
