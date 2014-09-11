From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 6/8] drivers: cpuidle: CPU idle ARM64 driver
Date: Thu, 11 Sep 2014 11:32:48 +0200
Message-ID: <54116C40.3080700@linaro.org>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com> <1409585324-3678-7-git-send-email-lorenzo.pieralisi@arm.com> <20140903173740.GJ1824@e102568-lin.cambridge.arm.com> <20140904160320.GB22354@arm.com> <20140904172909.GA14822@e102568-lin.cambridge.arm.com> <20140905092120.GG13515@arm.com> <20140905153457.GA26306@e102568-lin.cambridge.arm.com> <54115D16.30206@linaro.org> <20140911085727.GA25773@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140911085727.GA25773-7AyDDHkRsp3ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ashwin Chaugule <ashwin.chaugule-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Geoff Levand <geoff-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Steph
List-Id: linux-pm@vger.kernel.org

On 09/11/2014 10:57 AM, Lorenzo Pieralisi wrote:
> On Thu, Sep 11, 2014 at 09:28:06AM +0100, Daniel Lezcano wrote:
>> On 09/05/2014 05:34 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Sep 05, 2014 at 10:21:20AM +0100, Will Deacon wrote:
>>>> On Thu, Sep 04, 2014 at 06:29:10PM +0100, Lorenzo Pieralisi wrote:
>>>>> On Thu, Sep 04, 2014 at 05:03:20PM +0100, Catalin Marinas wrote:
>>>>>> On Wed, Sep 03, 2014 at 06:37:40PM +0100, Lorenzo Pieralisi wrot=
e:
>>>>>>> This patch should be ready to go too, is it ok if I split the s=
eries
>>>>>>> in arm64 arch specific patches (will ask Catalin to pull) and C=
PUidle ones
>>>>>>> (inclusive of DT bindings and !!this patch!!) and send two sepa=
rate pull
>>>>>>> requests ?
>>>>>>
>>>>>> If Daniel/Rafael don't have any objection, I can take the whole =
series
>>>>>> through the arm64 tree (it seems that patches have been already =
acked by
>>>>>> Daniel).
>>>>>
>>>>> Thanks a lot Catalin. Since this one is a brand new CPUidle drive=
r and it
>>>>> follows a different pattern from arm legacy drivers I would like =
to get
>>>>> Daniel's ack on this patch too before pushing it. For the records=
 I have
>>>>> just added two pr_err to signal driver probing error, ultraminor =
changes
>>>>> that do not justify a repost.
>>>>>
>>>>> If Samsung guys do not manifest themselves I would drop patch 8 f=
rom
>>>>> the series till it gets tested and its patch dependency queued to=
o.
>>>>
>>>> The last patch also has a dependency, as you mentioned to Daniel. =
I think
>>>> we can certainly merge the arm64 parts, and if Daniel doesn't obje=
ct, then
>>>> we can take the driver stuff too but leaving the exynos bits out (=
i.e. drop
>>>> the last patch).
>>>>
>>>> Anyway, if you could repost with the acks you've collected and rea=
rrange it
>>>> so the arm64 patches are first in the series, that would be great.
>>>
>>> I can repost it with the acks and rearrange the patches, but for th=
e
>>> pull request I have to know what code can be merged, since there ar=
e
>>> some arm64 patches (PSCI and CPUidle arm64 back-end) that are stric=
tly
>>> tied to the arm64 CPUidle driver, so I *have* to know if the arm64
>>> CPUidle driver (this patch) can get merged and that requires an ack=
=2E
>>>
>>> If I do not hear from Samsung guys I will drop patch 8.
>>
>> Well I would prefer to have this patch merged (Cc'ing Tomasz).
>
> Ok, but:
>
> a) I only compile tested it
> b) There is a dts patch dependency for patch 8 to apply cleanly and i=
t
>     hasn't been acked (I can't really do it since I can't test it)
>
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/2=
74179.html
>
> So, what should we do ? Tomasz ?
>
>>> I will wait till Monday (ie -rc4) and repost, I hope that's accepta=
ble.
>>
>> There is a procedure to solve this branch dependency.
>>
>> 1. Create a patchset with only the changes in drivers/cpuidle (+ mis=
c dt
>> stuff)
>>
>> 2. Send the patchset to me.
>
> Ok. I will do it straight away.
>
>> 3. I create a branch with these patches (which will be merged in my
>> cpuidle next branch)
>> 4. Merge this branch to a new branch (based on 3.17-rcX) and put on =
top
>> of that your changes for ARM[64]
>>
>> 5. Send the PR to Catalin and Arnd (one for each branch or one for b=
oth
>> arch)
>
> There is no ARM code in my series. So to sum it up:
>
> a) I send a pull request to Catalin for arm64 patches on top of the b=
ranch
>     you are creating with my patches
 >
> b) You take care of merging the CPUidle related patches through your
>     tree
>
> Is the above what you meant ?

Right, that allows to share a branch across the trees and resolve the=20
dependencies when a patchset is touching different subsystems.

I realize the dependency is inverted regarding what I proposed=20
initially, so it is up to Catalin to create the branch and I will share=
=20
it with him.

> I will send you an mbox for CPUidle related patches straight away (we=
ll,
> as soon as I know what to do with patch 8).

You can send me the patches 6,7,8. I will create the branch with only=20
the 2 first patches and re-integrate the patch 8 in the my cpuidle next=
=20
branch if the Samsung guys give their ack later.

Thanks

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
