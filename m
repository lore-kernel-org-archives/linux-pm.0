From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix checkpatch warnings
Date: Wed, 30 Apr 2014 00:39:11 +0200
Message-ID: <4780344.RfsAca3Qz3@vostro.rjw.lan>
References: <5356DB92.1060600@semaphore.gr> <2606012.9SjvfKiI5Z@vostro.rjw.lan> <5357C5E0.1070207@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61905 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756294AbaD2WWm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 18:22:42 -0400
In-Reply-To: <5357C5E0.1070207@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday, April 23, 2014 04:53:36 PM Stratos Karafotis wrote:
> On 23/04/2014 01:37 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> > On Wednesday, April 23, 2014 12:13:54 AM Stratos Karafotis wrote:
> >> Fix the following checkpatch warnings:
> >=20
> > In addition to comments from Viresh, I have a general one.
> >=20
> > Some of the checkpatch.pl warnings are not worth fixing at all ->
> >=20
> >> - WARNING: Prefer pr_err(... to printk(KERN_ERR ...
> >> - WARNING: Prefer pr_info(... to printk(KERN_INFO ...
> >> - WARNING: Prefer pr_warn(... to printk(KERN_WARNING ...
> >> - WARNING: quoted string split across lines
> >> - WARNING: line over 80 characters
> >=20
> > -> and the "line over 80 characters" ones are outright wrong in man=
y cases,
> > so please don't "fix" them.
> >=20
>=20
> Hi Rafael,
>=20
> Thanks for your comments!
>=20
> Could you please clarify if you want me to drop the entire patch or
> send it only with the changes about the last warning found ("no space=
s
> at the start of a line)?
>=20
> Also, I would like to take the opportunity and ask a question. :)
>=20
> Reading the code, sometimes, I find some minor formatting issues.
> Like the checkpatch warnings or unnecessary parentheses and braces.
>=20
> For example the line bellow:
> 		if ((freq < policy->min) || (freq > policy->max))
>=20
> I know that this is not actually an issue and a patch with such chang=
es
> is (somehow) a noise for the maintainers. But, should it be "fixed" o=
r not?

It should be cleaned up generally, so if you have the time and you're w=
illing
to do such things, please do them.

That said things like lines in excess of 80 characters may stay as they=
 are.

Thanks!


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
