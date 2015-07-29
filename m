From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Thu, 30 Jul 2015 00:40:49 +0200
Message-ID: <1790068.BlHXJRIr9a@vostro.rjw.lan>
References: <55B6F7C3.8040405@intel.com> <15808229.KgKF05ecju@vostro.rjw.lan> <55B8A3F2.8030809@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59304 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752483AbbG2WNw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 18:13:52 -0400
In-Reply-To: <55B8A3F2.8030809@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Wednesday, July 29, 2015 05:59:14 PM Pan Xinhui wrote:
> hi, Rafael
> 	thanks for you reply.
>=20
> On 2015=E5=B9=B407=E6=9C=8829=E6=97=A5 08:18, Rafael J. Wysocki wrote=
:
> > On Tuesday, July 28, 2015 12:53:33 PM Pan Xinhui wrote:
> >> hi, Viresh
> >> 	thanks for your reply :)
> >> On 2015=E5=B9=B407=E6=9C=8828=E6=97=A5 12:29, Viresh Kumar wrote:
> >>> On 28-07-15, 11:32, Pan Xinhui wrote:
> >>>> From: Pan Xinhui <xinhuix.pan@intel.com>
> >>>>
> >>>> Userspace at most time do cpufreq tests very much inconveniently=
=2E
> >>>> Currently they have to echo min and max cpu freq separately like=
 below:
> >>>> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_=
freq
> >>>> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_=
freq
> >>>>
> >>>> Add scaling_freq_range cpufreq attr to support userspace's deman=
d.
> >>>> Therefore it's easier for testers to write readable scripts like=
 below:=20
> >>>> echo 480000-2240000 >
> >>>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range
> >>>
> >>> I don't think this brings any good change, we already have suppor=
t for
> >>> that with min/max freqs and I don't see how scripts can be less
> >>> readable with that.
> >>>
> >> yes, min/max are supported, however it is inconvenient. sometime i=
t's very easy to cause obscure bugs.
> >> For example, some one might write a script like below.
> >> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_fr=
eq
> >> echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_fre=
q
> >> .....//other works
> >> echo 1120000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_f=
req
> >> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_fr=
eq
> >> ...//other works
> >>
> >> But it did not work when we echo 112000 to min-freq, as the curren=
t max freq is smaller than it.
> >> It's hard to figure it out in a big script... we have many such sc=
ripts.
> >=20
> > Fix them, then, pretty please.
> >=20
> of course we will fix them. :)
>=20
> > And adding this attribute is not going to magically fix them, is it=
?
> >=20
> yes, this patch can not fix them without changing the script. BUT I h=
ave another patch which could magically fix them. :)
>=20
> These two attribute files are very tricky. they are related with each=
 other.
> Not like some other attribute file in other part of kernel, for examp=
le, proc/sys/fs/file-max.
> As the file-min is always zero. It's very reasonable to only support =
file-max attribute file.
>=20
> The sequence we echoing value to min/max_freq is very important. Mayb=
e we can also assume they have *state*.
> Just like a developer writes a buf to a file. he should do in this wa=
y below.
> fp =3D fopen(..)
>  =3D> fwrite(...)
>   =3D> fclose(...)
>=20
> The script I mentioned above did not follow the right sequence. when =
script wants to set the min higher, we need set the max first to avoid =
min > max issue...
> So max/min_freq have *state*. just like TCP Three-way handshake, SYN,=
 ACK&SYN, ACK. the sequence(this is so-called state) is very important.

No, this isn't like that.  The rule is simple: whatever is in one of th=
e
attributes needs to be a smaller value than the one from the other attr=
ibute
at any time.  So there is a correlation between them, but the only "sta=
te" is
those numbers written to them previously (which they preserve quite as =
expected).

And the algorithm is: look for what's in min and write a number which i=
s not
less then that to max.  And the other way around.

Again, please fix your scripts and don't litter the kernel with stuff w=
hich
only is needed because user space developers can't get their act togeth=
er.

Case dismissed.

Thanks,
Rafael

