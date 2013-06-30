From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sun, 30 Jun 2013 16:22:34 +0200
Message-ID: <8029836.CFiJCXmRQ0@vostro.rjw.lan>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51CF1E53.6060902@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, June 29, 2013 07:50:11 PM Toralf F=C3=B6rster wrote:
> The latest bisect attempt gave :
>=20
> commit a66b2e503fc79fff6632d02ef5a0ee47c1d2553d
> Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Date:   Wed May 15 21:47:17 2013 +0200
>=20
>     cpufreq: Preserve sysfs files across suspend/resume
>=20
>     The file permissions of cpufreq per-cpu sysfs files are not prese=
rved
>     across suspend/resume because we internally go through the CPU
>     Hotplug path which reinitializes the file permissions on CPU onli=
ne.
>=20
>     But the user is not supposed to know that we are using CPU hotplu=
g
>     internally within suspend/resume (IOW, the kernel should not sile=
ntly
>     wreck the user-set file permissions across a suspend cycle).
>     Therefore, we need to preserve the file permissions as they are
>     across suspend/resume.
>=20
>     The simplest way to achieve that is to just not touch the sysfs f=
iles
>     at all - ie., just ignore the CPU hotplug notifications in the
>     suspend/resume path (_FROZEN) in the cpufreq hotplug callback.
>=20
>     Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
>     Reported-by: Durgadoss R <durgadoss.r@intel.com>
>     Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com=
>
>     Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
>=20
>=20
> To get a more reliable bisect result I had to start BOINC before (4
> childs each with nice -19 started)

Well, to be honest, I'm not really sure how the above commit can cause =
the
problem you're seeing to happen ...

Srivatsa, Viresh, any ideas?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
