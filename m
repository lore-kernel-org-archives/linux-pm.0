From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH V2] Cpufreq: Make governor data on nonboot cpus across
 system suspend/resume
Date: Fri, 22 Nov 2013 16:19:23 +0800
Message-ID: <528F138B.1090107@intel.com>
References: <9847309.KdKOG5y1Zx@vostro.rjw.lan> <1384616184-6197-1-git-send-email-tianyu.lan@intel.com> <5288425A.6000501@linaro.org> <528F0C9E.8020409@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <528F0C9E.8020409@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B411=E6=9C=8822=E6=97=A5 15:49, viresh kumar wrote:
> On Sunday 17 November 2013 09:43 AM, viresh kumar wrote:
>> On 16 November 2013 21:06, Lan Tianyu <tianyu.lan@intel.com> wrote:
>=20
>> But I don't really like the solution here. You are handling frozen f=
or EXIT in
>> cpufreq-core and for INIT in governor. That doesn't look like the ri=
ght
>> approach. There are out of tree governors too (I know we don't care =
about them
>> :)), and those also need to adapt with some policy made at cpufreq-c=
ore level.
>>
>> I told you that I had another solution for this problem, pretty simi=
lar to
>> yours. It looked like this:
>=20
> Hi Lan,
>=20

Hi Viresh:

> There is some confusion going on here :)
>=20

I think you also are in the Cc list and replied the mail.:)
https://lkml.org/lkml/2013/11/21/273

> There were few problems in the approach in your patch, which I have m=
entioned
> above, and Rafael agreed to them..

I only saw the out-of-tree governor issue your mentioned but where they
are? How upstream kernel cares them?

>=20
>> But after the PM notifiers patch I even don't want this to go.. I wi=
ll make sure
>> that that patch goes in, in one form or another :)
>=20
> And I was still trying to get a better solution in place of these cha=
nges. And
> was going on the suggestions you gave about calling cpufreq callbacks=
 from
> dpm_{suspend|resume}_noirq() calls.. And I am on my way to get things=
 fixed that
> way. And so we don't actually need this patch anymore (I just saw tha=
t you have
> sent another version of it, probably because Rafael asked? Don't know=
 what
> happened there :))..
>=20
> So, I will try to get something working soon for you and Nishanth..
>=20

--=20
Best regards
Tianyu Lan
