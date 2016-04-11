From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Mon, 11 Apr 2016 11:16:18 +0900
Message-ID: <570B08F2.50302@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <CANAwSgQuWBRiRhjd-E-WaSdhe2njE262CEG8uVH83jJDGFJVKA@mail.gmail.com>
 <CAGTfZH2gd5zhr4_JioSXTcpf8Fgu6r_Y9gPOJo-mYGTjAJsFyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55644 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbcDKCQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Apr 2016 22:16:44 -0400
In-reply-to: <CAGTfZH2gd5zhr4_JioSXTcpf8Fgu6r_Y9gPOJo-mYGTjAJsFyg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Markus Reichl <m.reichl@fivetechno.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, "inki.dae@samsung.com" <inki.dae@samsung.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@li>

Hi Anand,

On 2016=EB=85=84 04=EC=9B=94 09=EC=9D=BC 03:24, Chanwoo Choi wrote:
> Hi Anand,
>=20
> On Sat, Apr 9, 2016 at 3:11 AM, Anand Moon <linux.amoon@gmail.com> wr=
ote:
>> Hi Chanwoo,
>>

[snip]

>>>
>>
>> I am observing following deadlock. Both on Odroid U3 and Odroid XU4.
>=20
> Thanks for your test. I'll test it again and fix it.

This possible recursive locking is fixed with following diff:

Thanks for your report. I'll fix it on next patchset[1] (v9).
[1] https://lkml.org/lkml/2016/4/8/14


diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/gover=
nor_passive.c
index 28a9ae32d330..a4b0b02ee797 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -102,7 +102,7 @@ static int update_devfreq_passive(struct devfreq *d=
evfreq, unsigned long freq)
        if (!devfreq->governor)
                return -EINVAL;
=20
-       mutex_lock(&devfreq->lock);
+       mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
=20
        ret =3D devfreq->governor->get_target_freq(devfreq, &freq);
        if (ret < 0)

Best Regards,
Chanwoo Choi

>=20
>>
>> [    7.718372] [ INFO: possible recursive locking detected ]
>> [    7.723747] 4.6.0-rc2-xu4ml #4 Not tainted
>> [    7.727817] ---------------------------------------------
>> [    7.733190] kworker/u16:1/136 is trying to acquire lock:
>> [    7.738476]  (&devfreq->lock){+.+.+.}, at: [<c05be41c>]
>> update_devfreq_passive+0x2c/0x88
>> [    7.746534]
>> [    7.746534] but task is already holding lock:
>> [    7.752339]  (&devfreq->lock){+.+.+.}, at: [<c05bd838>]
>> devfreq_monitor+0x1c/0x78
>> [    7.759791]
>> [    7.759791] other info that might help us debug this:
>> [    7.766291]  Possible unsafe locking scenario:
>> [    7.766291]
>> [    7.766307] usb 5-1: new high-speed USB device number 2 using xhc=
i-hcd
>> [    7.778682]        CPU0
>> [    7.781107]        ----
>> [    7.783533]   lock(&devfreq->lock);
>> [    7.786999]   lock(&devfreq->lock);
>> [    7.790467]
>> [    7.790467]  *** DEADLOCK ***
>> [    7.790467]
>> [    7.796359]  May be due to missing lock nesting notation
>> [    7.796359]
>> [    7.803120] 4 locks held by kworker/u16:1/136:
>> [    7.807537]  #0:  ("%s"("devfreq_wq")){.+.+..}, at: [<c013b41c>]
>> process_one_work+0x13c/0x454
>> [    7.816029]  #1:  ((&(&devfreq->work)->work)){+.+...}, at:
>> [<c013b41c>] process_one_work+0x13c/0x454
>> [    7.825128]  #2:  (&devfreq->lock){+.+.+.}, at: [<c05bd838>]
>> devfreq_monitor+0x1c/0x78
>> [    7.833013]  #3:  (&nh->srcu){......}, at: [<c014309c>]
>> __srcu_notifier_call_chain+0x54/0xe0
>> [    7.841419]
>> [    7.841419] stack backtrace:
>> [    7.845758] CPU: 1 PID: 136 Comm: kworker/u16:1 Not tainted
>> 4.6.0-rc2-xu4ml #4
>> [    7.852946] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [    7.859017] Workqueue: devfreq_wq devfreq_monitor
>> [    7.863717] [<c010eb48>] (unwind_backtrace) from [<c010b884>]
>> (show_stack+0x10/0x14)
>> [    7.871417] [<c010b884>] (show_stack) from [<c037715c>]
>> (dump_stack+0xa4/0xd0)
>> [    7.878613] [<c037715c>] (dump_stack) from [<c017112c>]
>> (__lock_acquire+0x1ce8/0x207c)
>> [    7.886492] [<c017112c>] (__lock_acquire) from [<c0172010>]
>> (lock_acquire+0x90/0xd4)
>> [    7.892726] usb 5-1: New USB device found, idVendor=3D0bda, idPro=
duct=3D8153
>> [    7.892737] usb 5-1: New USB device strings: Mfr=3D1, Product=3D2=
, SerialNumber=3D6
>> [    7.892745] usb 5-1: Product: USB 10/100/1000 LAN
>> [    7.892753] usb 5-1: Manufacturer: Realtek
>> [    7.892761] usb 5-1: SerialNumber: 000001000000
>> [    7.921248] [<c0172010>] (lock_acquire) from [<c075d298>]
>> (mutex_lock_nested+0x78/0x4ec)
>> [    7.929301] [<c075d298>] (mutex_lock_nested) from [<c05be41c>]
>> (update_devfreq_passive+0x2c/0x88)
>> [    7.938138] [<c05be41c>] (update_devfreq_passive) from [<c05be4c0=
>]
>> (devfreq_passive_notifier_call+0x48/0x50)
>> [    7.948016] [<c05be4c0>] (devfreq_passive_notifier_call) from
>> [<c0142d84>] (notifier_call_chain+0x54/0xa4)
>> [    7.957633] [<c0142d84>] (notifier_call_chain) from [<c01430e0>]
>> (__srcu_notifier_call_chain+0x98/0xe0)
>> [    7.966991] [<c01430e0>] (__srcu_notifier_call_chain) from
>> [<c0143140>] (srcu_notifier_call_chain+0x18/0x20)
>> [    7.976783] [<c0143140>] (srcu_notifier_call_chain) from
>> [<c05bd774>] (update_devfreq+0xe4/0x18c)
>> [    7.985622] [<c05bd774>] (update_devfreq) from [<c05bd840>]
>> (devfreq_monitor+0x24/0x78)
>> [    7.993595] [<c05bd840>] (devfreq_monitor) from [<c013b48c>]
>> (process_one_work+0x1ac/0x454)
>> [    8.001913] [<c013b48c>] (process_one_work) from [<c013b784>]
>> (worker_thread+0x50/0x508)
>> [    8.009976] [<c013b784>] (worker_thread) from [<c0141cf4>]
>> (kthread+0xf8/0x110)
>> [    8.017254] [<c0141cf4>] (kthread) from [<c0107750>]
>> (ret_from_fork+0x14/0x24)
>>
>> Best Regards
>> -Anand Moon
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sams=
ung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

