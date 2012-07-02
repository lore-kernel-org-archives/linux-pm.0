From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: linux-next : cpuidle - could you add my tree please
Date: Tue, 03 Jul 2012 00:14:32 +0200
Message-ID: <4FF21D48.50301@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <CACRpkdYaLweX-4YkWotuFFWoqEjOLKoNCsurCxxWNfq7QznPnw@mail.gmail.com> <4FF19947.3040608@linaro.org> <201207022149.36629.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <201207022149.36629.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Amit Kucheria <amit.kucheria@linaro.org>, linux-next@vger.kernel.org, Colin Cross <ccross@android.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rob Lee <rob.lee@linaro.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/02/2012 09:49 PM, Rafael J. Wysocki wrote:
> On Monday, July 02, 2012, Daniel Lezcano wrote:
>>
>> On 07/02/2012 11:09 AM, Linus Walleij wrote:
>>> On Mon, Jun 25, 2012 at 3:27 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>
>>>> we discussed last week to put in place a tree grouping the cpuidle
>>>> modifications [1]. Is it possible to add the tree ?
>>>>
>>>> git://git.linaro.org/people/dlezcano/cpuidle-next.git #cpuidle-nex=
t
>>>
>>> Thanks for doing this.
>>>
>>> Since MAINTAINERS is lacking a listed maintainer for cpuidle,
>>> are you also going to add yourself as maintainer and list this
>>> tree in that file, or is this a one-time exercise?
>>
>> I will be glad to do that if Len and Rafael agree on that.
>=20
> Len Brown has been a cpuidle maintainer for some time now.  Moreover,
> he's been taking patches, but Linus refused to pull his entire tree d=
uring the
> last merge window (as you probably know).  I honestly don't think thi=
s is
> a good enough reason for replacing him as a cpuidle maintainer by for=
ce.
>=20
> So, you should ask Len whether or not he's willing to pass the cpuidl=
e
> maintenance to someone else.

No, no. You are misunderstanding what I am proposing. I don't want to
replace Len I just want to act as a "proxy". I understand a maintainer
can be busy and could not have enough time to take care of the subsyste=
m
is maintaining during a period because he's too busy for that.
Trust me, I fully understand that :)

As there are a lot of modifications of cpuidle, I am proposing to take
the patches when they are acked-by, to create a consolidated tree,
providing a better integration for cpuidle, a wider testing, preventing
conflicts and facilitating Len's work if he agrees to pull from this tr=
ee.

If that makes sense to add myself to the MAINTAINER file as a
co-maintainer (understand: send to me also the patches, so I can take
care of them if Len does not respond), I am ok with that.

It is just about helping :)

> I know that Len hasn't been responsive recently, but I also know that=
 he
> _does_ respond to inquiries sent directly to him.

Do you mean to its intel address ?

Thanks
  -- Daniel

> --
> To unsubscribe from this list: send the line "unsubscribe linux-next"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
