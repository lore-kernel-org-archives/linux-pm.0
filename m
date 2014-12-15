From: Yadwinder Singh Brar <yadi.brar@samsung.com>
Subject: RE: 3.18: lockdep problems in cpufreq
Date: Mon, 15 Dec 2014 20:24:05 +0530
Message-ID: <003501d01876$fbc53f80$f34fbe80$%brar@samsung.com>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <7573578.UE8ufgjWuX@vostro.rjw.lan>
 <CAKohpok6ieJYgusMh+WFCQT8d5_QVgGczmQyD79UPz4hdYU1Dg@mail.gmail.com>
 <002f01d0186b$2700b730$75022590$%brar@samsung.com>
 <20141215134636.GI11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34187 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbaLOOw7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 09:52:59 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGM0061EPC8FR20@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 15 Dec 2014 23:52:57 +0900 (KST)
In-reply-to: <20141215134636.GI11285@n2100.arm.linux.org.uk>
Content-language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 'Eduardo Valentin' <edubezval@gmail.com>



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, December 15, 2014 7:17 PM
> To: Yadwinder Singh Brar
> Cc: 'Viresh Kumar'; 'Rafael J. Wysocki'; linux-arm-
> kernel@lists.infradead.org; linux-pm@vger.kernel.org; 'Eduardo
> Valentin'
> Subject: Re: 3.18: lockdep problems in cpufreq
>=20
> On Mon, Dec 15, 2014 at 06:58:41PM +0530, Yadwinder Singh Brar wrote:
> > Unfortunately, I didn=E2=80=99t get any such warning though I teste=
d patch
> > enabling CONFIG_PROVE_LOCKING before posting. It seems Russell is
> > trying to load imx_thermal as module and parallely Changing cpufreq
> > governor from userspace, which was not my test case.
>=20
> No.  Yes, imx_thermal is a module, which is loaded by udev very early
> in the userspace boot.  Later on, in the rc.local, I poke the governo=
r
> from userspace.
>=20
> This is evidenced by the bluetooth modules being loaded after
> imx_thermal:
>=20
> Module                  Size  Used by
> bnep                   10574  2
> rfcomm                 33720  0
> bluetooth             293598  10 bnep,rfcomm
> nfsd                   90264  0
> exportfs                3988  1 nfsd
> hid_cypress             1763  0
> snd_soc_fsl_spdif       9753  2
> imx_pcm_dma             1137  1 snd_soc_fsl_spdif
> imx_sdma               12885  2
> imx2_wdt                3248  0
> imx_thermal             5386  0
> snd_soc_imx_spdif       1877  0
>=20
> and the timestamp on the bluetooth message:
>=20
> [   25.503739] Bluetooth: Core ver 2.19
>=20
> vs the timestamp on the lockdep message:
>=20
> [   29.499195] [ INFO: possible circular locking dependency detected =
]
>=20
> My rc.local does this:
>=20
>     # Configure cpufreq
>     echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
>     echo performance >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
>=20
> > Anyways, after analyzing log and code,I think problem is not in
> > cpufreq_thermal_notifier which was modified in patch as stated abov=
e.
> > Actual problem is in __cpufreq_cooling_register which is
> unnecessarily
> > calling cpufreq_register_notifier() inside section protected by
> > cooling_cpufreq_lock.
> > Because cpufreq_policy_notifier_list).rwsem is already held by
> > store_scaling_governor when __cpufreq_cooling_register is trying to
> > cpufreq_policy_notifier_list while holding cooling_cpufreq_lock.
> >
> > So I think following can fix the problem:
> >
> > diff --git a/drivers/thermal/cpu_cooling.c
> > b/drivers/thermal/cpu_cooling.c index ad09e51..622ea40 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -484,15 +484,15 @@ __cpufreq_cooling_register(struct device_node
> *np,
> >         cpufreq_dev->cpufreq_state =3D 0;
> >         mutex_lock(&cooling_cpufreq_lock);
> >
> > -       /* Register the notifier for first cpufreq cooling device *=
/
> > -       if (cpufreq_dev_count =3D=3D 0)
> > -
> cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > -                                         CPUFREQ_POLICY_NOTIFIER);
> >         cpufreq_dev_count++;
> >         list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> >
> >         mutex_unlock(&cooling_cpufreq_lock);
> >
> > +       /* Register the notifier for first cpufreq cooling device *=
/
> > +       if (cpufreq_dev_count =3D=3D 0)
> > +
> cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> > +                                         CPUFREQ_POLICY_NOTIFIER);
>=20
> No, sorry, this patch is worse.
>=20

Actually it was not patch :P , just moved cpufreq_register_notifier()
out of locking, as it is(C&P) to explain my point.

> 1. cpufreq_register_notifier() will never be called, even on the firs=
t
>    caller to this code: at the point where it's tested for zero, it
> will
>    be incremented to one by the previous code.
>=20
> 2. What happens if two threads come here?
>=20
>    The first thread succeeds in grabbing cooling_cpufreq_lock.  The
> second
>    thread stalls waiting for cooling_cpufreq_lock to be released.
>=20
>    The first thread increments cpufreq_dev_count, adds to the list, a=
nd
> then
>    releases the lock.  At this point, control may be passed to the
> second
>    thread (since mutex_unlock() will wake it up.)  The second thread
> gets
>    into the critical region, and increments cpufreq_dev_count again.
>=20
>    By the time the first thread runs, cpufreq_dev_count may be two at
> this
>    point.

Yes, may be.

>=20
> Unfortunately, you do need some kind of synchronisation here.  If it'=
s
> not important when cpufreq_register_notifier() gets called, maybe thi=
s
> can work:
>=20
> 	bool register;
>=20
> 	mutex_lock(&cooling_cpufreq_lock);
> 	register =3D cpufreq_dev_count++ =3D=3D 0;
> 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> 	mutex_unlock(&cooling_cpufreq_lock);
>=20
> 	if (register)

register may be 0 in scenario you stated above in second point.
So this approach will not work.
=20
> 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> 					  CPUFREQ_POLICY_NOTIFIER);
>=20
> However, I suspect that may well be buggy if we have a cleanup path
> which unregisters the notifier when cpufreq_dev_count is decremented =
to
> zero...
> which we seem to have in cpufreq_cooling_unregister().
>=20
> The answer may well be to have finer grained locking here:
>=20
> - one lock to protect cpufreq_dev_list, which is only ever taken when
>   adding or removing entries from it
>=20
> - a second lock to protect cpufreq_dev_count and the calls to
>   cpufreq_register_notifier() and cpufreq_unregister_notifier()
>=20
> and you would /never/ take either of those two locks inside each othe=
r.
> In other words:
>=20
> 	mutex_lock(&cooling_list_lock);
> 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> 	mutex_unlock(&cooling_list_lock);
>=20
> 	mutex_lock(&cooling_cpufreq_lock);
> 	if (cpufreq_dev_count++ =3D=3D 0)
> 		cpufreq_register_notifier(&thermal_cpufreq_notifier_block,
> 					  CPUFREQ_POLICY_NOTIFIER);
> 	mutex_unlock(&cooling_cpufreq_lock);
>=20
> and similar in the cleanup path.  The notifier itself would only ever
> take the cooling_list_lock.
>=20

I agree with this approach, if its fine for others also, I can implemen=
t
and post patch.

Thanks,
Yadwinder

> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.

