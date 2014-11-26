From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq-dt: register cooling device after validating cpufreq table
Date: Wed, 26 Nov 2014 23:57:04 +0100
Message-ID: <2967826.8JoVzVls96@vostro.rjw.lan>
References: <b4a56cad08c5ef701cf268881697caabe5229994.1416826729.git.viresh.kumar@linaro.org> <CAKohpo=ZM8QstEOp1A86N2jzDEY5w2FmB7K0rtLPmzg+_iZdMw@mail.gmail.com> <20141126151030.GA3925@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64853 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750793AbaKZWft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 17:35:49 -0500
In-Reply-To: <20141126151030.GA3925@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On Wednesday, November 26, 2014 11:10:32 AM Eduardo Valentin wrote:
> 
> --T4sUOijqQbZv57TR
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> 
> Hello Viresh, Rafael,
> 
> On Wed, Nov 26, 2014 at 11:27:42AM +0530, Viresh Kumar wrote:
> > On 26 November 2014 at 03:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > And what bad things are going to happen if this is not pushed for 3.18?
> >=20
> > This is what Eduardo reported in one of the mails:
> >=20
> > ---
> >=20
> > As an example, I am taking the ti-soc-thermal, but we already have other
> > of-thermal based drivers. Booting with this patch ti-soc-thermal
> > (of-based boot) loads fine, but the cpu_cooling never gets bound to the
> > thermal zone.
> >=20
> > The thing is that the bind may happen before cpufreq-dt code loads the
> > cpufreq driver, and when cpu_cooling is checking what is the max freq,
> > by using cpufreq table, it won't be able to do it, as there is no table.
> >=20
> > While, without the patch, it will use wrong in the binding, but after
> > it gets bound, and cpufreq loads, the max will be used correctly.
> >=20
> > ----
> >=20
> > And so it looked like things aren't going to work smoothly in 3.18
> > and so I thought we should get it in.
> >=20
> 
> The bug exists, it is there for 3.18. But also, as I explained in that
> thread, the current code is able to initialize the of cooling device and
> to register it in its thermal zone. But that works by lucky because we
> do not have the proper return code checks in thermal core.
> 
> > But probably the problem will be worst only after applying Lukasz
> > patchset?
> 
> The bug gets exposed by his patch.
> 
> >=20
> > @Eduardo: Do you want Rafael to apply this for 3.18? or 3.19 will
> > work as well ?
> 
> 
> I believe, for this case, 3.19 is best option. Looks like we have a
> possible API massage coming, so, targetting 3.18 would be rushy. I'd
> rather think of a proper way to fix this, scalable and that makes
> sense to everybody, even if takes extra merge window, than rushing for a
> fix that we may need to revisit it again in near future.

That's my view as well.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
