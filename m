From: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: Regression due to "PM-runtime: Switch autosuspend over to using hrtimers"
Date: Thu, 7 Feb 2019 10:25:40 +0200
Message-ID: <CAOtvUMdRWjqp0sEZUQU6w6RcDFP26i3Gxzg5zsRvG2ej1LVSFg@mail.gmail.com>
References: <CAOtvUMd-38BL1jJnHQY0J68mmtxW1WBQF2qGqyNpWtwsrwUcYg@mail.gmail.com>
 <CAKfTPtBaKbtfLMjLH1u20+ukhpm6i9qDK-3HiTPizSjKNCnw=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtBaKbtfLMjLH1u20+ukhpm6i9qDK-3HiTPizSjKNCnw=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Ofir Drang <Ofir.Drang@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Thank for the quick response.

On Wed, Feb 6, 2019 at 6:59 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hi Gilad,
>
> On Wed, 6 Feb 2019 at 17:40, Gilad Ben-Yossef <gilad@benyossef.com> wrote=
:
> >
> > Hi all,
> >
> > A regression was spotted in the ccree driver running on Arm 32 bit
> > causing a kernel panic during the crypto API self test phase (panic
> > messages included with this message) happening in the PM resume
> > callback that was not happening before.
> >
> > I've bisected the change that caused this to commit 8234f6734c5d
> > ("PM-runtime: Switch autosuspend over to using hrtimers").
> >
> > I'm still trying to figure out what is going on inside the callback,
> > but as it was not happening before, I thought I'd give you a shout out
> > to make you aware of this.
>
> Are you using autosuspend mode for this device ?
Yes.


> Also this happen in a platform specific function cc_init_hash_sram().
> I can't see anything related to pm runtime and autosuspend in it.

True. However, the function is called from the driver PM resume
callback and before that commit it did not fail.
My guess is that there is something related to the timing the callback
is called, probably some race condition the change exposed.

There is probably nothing for you do until I figure out what is
failing in the internal function.
I just wanted to give the heads up in case someone else runs into a
similar issue with another driver.

> Do you have more details about where this panic happen in the function ?

I'm looking into this right now and will update.

Thanks!
Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
