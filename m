From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 14 Oct 2014 07:42:59 -0400
Message-ID: <543D0C43.3070701@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com> <5437C535.3070707@redhat.com> <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com> <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t> <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com> <1412947425.13463.37.camel@x200t> <CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com> <1412949926.13463.47.camel@x200t> <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35958 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061AbaJNLnO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Oct 2014 07:43:14 -0400
In-Reply-To: <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/14/2014 02:58 AM, Viresh Kumar wrote:
> On 10 October 2014 19:35, Robert Sch=C3=B6ne <robert.schoene@tu-dresd=
en.de> wrote:
>> @all:
>> I have to leave now and will not be available for a week.
>>
>> @Viresh:
>> The line you are looking for is 2c8 (260h+68h, length check passed).
>> Here it is with the surrounding instructions:
>=20
> Thanks..
>=20
> I now understand most of the races you and Prarit have reported.
> Finally I was able to get my multi-cluster board up and could test th=
is
> myself :)
>=20
> So you need to try my cpufreq/governor-fixes-v4 branch to confirm if
> this fixes your issues or not.
>=20
> @Prarit: As Robert probably isn't around this week, would it be possi=
ble for
> you to test this stuff ?

Hi Viresh,

I've been running both my test and Robert's test for about 5 mins.  In =
Robert's
case I don't see any problems ... in my case I do occasionally get a sy=
stem
panic because of the sysfs access race I described in the other thread =
(cpu 1
holds a sysfs file open, while cpu 2 changes the governor ...)

I do have some concerns about the nature of this patchset; I feel it is=
 more of
a band-aid approach to the whole cpufreq mechanism.  Having said that, =
I haven't
offered an alternative yet so I can't really object too loudly :)

I'll do a more formal review when you post to the list.

P.

>=20
> I will send this as a patchset so that people can review and comment.
>=20
> --
> viresh
>=20
