From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 22 Apr 2014 12:27:17 +0100
Message-ID: <20140422112717.GA21613@lee--X1>
References: <534DB213.7080802@semaphore.gr>
 <5355A349.50908@semaphore.gr>
 <20140422071541.GA17657@lee--X1>
 <6612075.PRZcWcuj98@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6612075.PRZcWcuj98@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Stratos Karafotis <stratosk@semaphore.gr>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Apr 2014, Rafael J. Wysocki wrote:

> On Tuesday, April 22, 2014 08:15:41 AM Lee Jones wrote:
> > > The cpufreq core now supports the cpufreq_for_each_entry macro he=
lper
> > > for iteration over the cpufreq_frequency_table, so use it.
> > >=20
> > > It should have no functional changes.
> >=20
> > > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> > > ---
> >=20
> > It would be good to have a changelog which describes the difference=
s
> > between the versions, so we can keep track.
> >=20
> > >  drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------
> > >  1 file changed, 8 insertions(+), 11 deletions(-)
> >=20
> > So it looks like I already applied v2 of this patch to my tree. Wha=
t
> > changed in v3 and v4? Should I remove that patch from MFD and apply
> > this one instead?
>=20
> The reason why v4 was sent is because I asked for it.
>=20
> And if you applied [5/8] without [1/8], it won't work, because the ma=
cro is
> introduced by that patch.

That's right, which is why I mailed you about it:

  > > > Applied untested by me.
  > >
  > > Wouldn't build. Let it go via Rafael.
  >
  > Rafael, would you mind creating a branch from this patch set that w=
e
  > can both pull from please?

> If that's the case, please drop [5/8] and let me handle the entire se=
ries.

I'm happy for you to apply the series and send me a pull-request for
either a) the entire series or b) just the patches which touch MFD and
any subsequent decencies. Or I can apply them and send you one.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
