From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 5/8] mfd: db8500-prcmu: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 22 Apr 2014 12:29:13 +0100
Message-ID: <20140422112913.GB21613@lee--X1>
References: <535635d0.8908b40a.6c36.ffffaaa9SMTPIN_ADDED_MISSING@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:52894 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbaDVL3a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Apr 2014 07:29:30 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so3081255wib.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2014 04:29:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <535635d0.8908b40a.6c36.ffffaaa9SMTPIN_ADDED_MISSING@mx.google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, " linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org

> > > The cpufreq core now supports the cpufreq_for_each_entry macro he=
lper=20
> > > for iteration over the cpufreq_frequency_table, so use it.=20
> > >=20
> > > It should have no functional changes.=20
> >
> > > Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>=20
> > > ---=20
> >
> > It would be good to have a changelog which describes the difference=
s=20
> > between the versions, so we can keep track.=20
> >
> > >=C2=A0 drivers/mfd/db8500-prcmu.c | 19 ++++++++-----------=20
> > >=C2=A0 1 file changed, 8 insertions(+), 11 deletions(-)=20
> >
> > So it looks like I already applied v2 of this patch to my tree. Wha=
t=20
> > changed in v3 and v4? Should I remove that patch from MFD and apply=
=20
> > this one instead?
>=20
> I'm sorry for the confusion.
> I sent v3 only for patches 1/8 and 3/8.
> So, I was asked by Rafael to resend the entire series as v4
> in order to be clear which is the latest version in each patch.
> Unfortunately, I omit the change log :(
>=20
> The specific patch (5/8) is unchanged since v2.
>=20
> I'm sorry for the inconvenience.

That's okay, thanks for clarifying.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
