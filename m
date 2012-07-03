From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: linux-next : cpuidle - could you add my tree please
Date: Tue, 03 Jul 2012 14:56:58 +0200
Message-ID: <4FF2EC1A.7020702@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <201207022149.36629.rjw@sisk.pl> <4FF21D48.50301@linaro.org> <201207031059.13758.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <201207031059.13758.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, linux-next@vger.kernel.org, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rob Lee <rob.lee@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/03/2012 10:59 AM, Rafael J. Wysocki wrote:
> On Tuesday, July 03, 2012, Daniel Lezcano wrote:
>> On 07/02/2012 09:49 PM, Rafael J. Wysocki wrote:
>>> On Monday, July 02, 2012, Daniel Lezcano wrote:
>>>>
>>>> On 07/02/2012 11:09 AM, Linus Walleij wrote:
>>>>> On Mon, Jun 25, 2012 at 3:27 PM, Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>>> we discussed last week to put in place a tree grouping the cpuid=
le
>>>>>> modifications [1]. Is it possible to add the tree ?
>>>>>>
>>>>>> git://git.linaro.org/people/dlezcano/cpuidle-next.git #cpuidle-n=
ext
>>>>>
>>>>> Thanks for doing this.
>>>>>
>>>>> Since MAINTAINERS is lacking a listed maintainer for cpuidle,
>>>>> are you also going to add yourself as maintainer and list this
>>>>> tree in that file, or is this a one-time exercise?
>>>>
>>>> I will be glad to do that if Len and Rafael agree on that.
>>>
>>> Len Brown has been a cpuidle maintainer for some time now.  Moreove=
r,
>>> he's been taking patches, but Linus refused to pull his entire tree=
 during the
>>> last merge window (as you probably know).  I honestly don't think t=
his is
>>> a good enough reason for replacing him as a cpuidle maintainer by f=
orce.
>>>
>>> So, you should ask Len whether or not he's willing to pass the cpui=
dle
>>> maintenance to someone else.
>>
>> No, no. You are misunderstanding what I am proposing. I don't want t=
o
>> replace Len I just want to act as a "proxy". I understand a maintain=
er
>> can be busy and could not have enough time to take care of the subsy=
stem
>> is maintaining during a period because he's too busy for that.
>> Trust me, I fully understand that :)
>>
>> As there are a lot of modifications of cpuidle, I am proposing to ta=
ke
>> the patches when they are acked-by, to create a consolidated tree,
>> providing a better integration for cpuidle, a wider testing, prevent=
ing
>> conflicts and facilitating Len's work if he agrees to pull from this=
 tree.
>>
>> If that makes sense to add myself to the MAINTAINER file as a
>> co-maintainer (understand: send to me also the patches, so I can tak=
e
>> care of them if Len does not respond), I am ok with that.
>>
>> It is just about helping :)
>=20
> Cool. :-)
>=20
> So do you have a branch in the cpuidle-next.git tree that isn't going=
 to
> be rebased?

No. I am following Linus tree and adding the patches on top of it.

>>> I know that Len hasn't been responsive recently, but I also know th=
at he
>>> _does_ respond to inquiries sent directly to him.
>>
>> Do you mean to its intel address ?
>=20
> Yes, CCing the Len's Intel address won't hurt I think.

Ok, I will ping him and give him the pointers to the discussion we had.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
