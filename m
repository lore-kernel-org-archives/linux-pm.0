From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Bug: power supply - NULL pointer dereference in bq27x00 driver
Date: Mon, 18 May 2015 11:40:30 +0200
Message-ID: <BA8989FA-6ABE-43D4-A8D5-2949F8AE8B24@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:65186 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbERJlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 05:41:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rodolfo Giometti <giometti@linux.it>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, List for communicating with real GTA04 owners <gta04-owner@goldelico.com>

Hi,
we tried to upgrade from 4.0 to 4.1-rc3 kernel and ran into a NULL poin=
ter problem within the bq27x00 driver.

It appears to be introduced by your patch 297d716f6260cc9421d971b124ca1=
96b957ee458

The problem appears to be that bq27x00_powersupply_init() calls power_s=
upply_register_no_ws() and
sets di->bat *after* return. The old code did pass an uninitialized str=
uct pointer.

Now for reasons I don=92t understand, the power_supply_register_no_ws()=
 appears to call
uevent related stuff which in turn calls bq27x00_battery_get_property()=
 before di->bat
is properly initialized.

I have checked with printk in bq27x00_battery_get_property() that di>ba=
t =3D=3D NULL in this case and
right before we see the segfault.

The old code simply did pass a zeroed struct power_supply and perhaps i=
nitialized its components
during registration.

Returning some -EINVAL if di->bat =3D=3D NULL would likely solve the NU=
LL pointer dereference but
I don=92t know what it does to the uevent and if it restores previous o=
peration.

It could have been that it was for good purpose that power_supply_regis=
ter_no_ws() did not return
by value, but by reference to the di->bat struct:

-	ret =3D power_supply_register_no_ws(di->dev, &di->bat, NULL);
+	di->bat =3D power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);

So that code called within the context of power_supply_register_no_ws()=
 could already
refer to initialized di->bat.


BR and thanks,
Nikolaus Schaller


[   11.879943] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000000c
[   11.888519] pgd =3D c0004000
[   11.891357] [0000000c] *pgd=3D00000000
[   11.895141] Internal error: Oops: 5 [#1] SMP ARM
[   11.899963] Modules linked in: bq27x00_battery w1_bq27000 ov9655 v4l=
2_common omap_hdq snd_soc_omap_mcbsp videodev hmc5843_i2c(C) lis3lv02d_=
i2c snd_soc_omap lis3lv02d itg3200 snd_pcm_dmaengine tsc2007 bmp085_i2c=
 bma150 hmc5843_core(C) media at24 input_polldev leds_tca6507 rtc_twl t=
wl4030_pwrbutton twl4030_keypad twl4030_madc snd_soc_twl4030 twl4030_vi=
bra ehci_omap
[   11.933898] CPU: 0 PID: 1164 Comm: w1_bus_master1 Tainted: G        =
 C      4.1.0-rc3-gta04+ #1086
[   11.943267] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[   11.949829] task: dd2729c0 ti: dd276000 task.ti: dd276000
[   11.955505] PC is at __power_supply_is_supplied_by+0x8/0xc0
[   11.961364] LR is at __power_supply_am_i_supplied+0x18/0x48
[   11.967193] pc : [<c0469f4c>]    lr : [<c046a058>]    psr: a0000013
[   11.967193] sp : dd277bb8  ip : 00000000  fp : c092f82c
[   11.979217] r10: de348000  r9 : dd18cc20  r8 : dd18cc20
[   11.984680] r7 : de5c9420  r6 : de5c9400  r5 : de5c9400  r4 : 000000=
00
[   11.991516] r3 : de5c9648  r2 : 00000000  r1 : 00000000  r0 : de5c94=
00
[   11.998352] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment kernel
[   12.006011] Control: 10c5387d  Table: 9c1b0019  DAC: 00000015
[   12.012054] Process w1_bus_master1 (pid: 1164, stack limit =3D 0xdd2=
76218)
[   12.019073] Stack: (0xdd277bb8 to 0xdd278000)
[   12.023620] 7ba0:                                                   =
    de5c9648 00000000
[   12.032196] 7bc0: de5c9400 c046a040 de5c9420 c046a058 de5c9420 00000=
000 00000000 dd277bf4
[   12.040771] 7be0: 00000000 c0374ebc c05c4268 dd18eec4 dd18cc20 de27f=
ea4 de5c9648 00000000
[   12.049346] 7c00: dd18eee8 00000000 dd277c3c dd18ee10 dd18eec4 bf0d0=
de4 00000000 00000000
[   12.057922] 7c20: dd377000 c092f82c dd18cc20 c0469508 b6db6db7 c046a=
140 dd18cc20 c092f82c
[   12.066467] 7c40: 00000000 dd377000 00000000 00000000 dd18cc00 c046a=
42c dd18cc20 de348000
[   12.075042] 7c60: c046a3b0 de348000 dd18cc28 dd18cc20 de0918c0 c0608=
dd8 00000000 00000000
[   12.083618] 7c80: c07b5bb1 c0371f0c c07b5bb1 c02c72c4 de348000 dd277=
ca8 c07b5bb1 de348000
[   12.092193] 7ca0: de348000 dd18cc28 00000000 c02c7544 00000007 00000=
006 00000000 c0083394
[   12.100769] 7cc0: dd2729c0 dd2f6540 c07b2ae3 dc1f7950 dd18c810 dd18c=
c20 00000000 dd18cc28
[   12.109344] 7ce0: dc1f7950 dd18c810 00000000 00000000 00000000 c0371=
938 dd18cc20 00000000
[   12.117919] 7d00: c0008280 00000080 dd18cc00 dd18cc20 00000000 dc1f7=
950 dd18c810 c0469cd8
[   12.126464] 7d20: bf0d124f dd277d44 1f1c4000 c05ae99c bf0d124f dd18e=
e10 dc1f7950 bf0cc121
[   12.135040] 7d40: 0000001b dd014c50 00000001 bf0d0864 00000000 dd18e=
e10 00000000 00000000
[   12.143615] 7d60: ffffffed dd18c810 bf0d1670 c03752c0 dd18c810 00000=
000 bf0d1670 c0373bd4
[   12.152191] 7d80: 00000007 dd18c810 bf0d1670 c0373ed8 00000000 c0373=
e34 00000000 dd18c810
[   12.160766] 7da0: dd277da8 c037265c de0948d4 dd2f6194 dd18c810 dd18c=
810 dd18c844 dd18c810
[   12.169342] 7dc0: bf0cc160 c0373dbc dd18c810 c0918590 dd18c810 c0373=
294 dd18c810 00000000
[   12.177917] 7de0: dd18c818 c0371940 dd18c810 0000002f dd18c810 00000=
000 dd18c800 00000000
[   12.186492] 7e00: 00000000 bf0cc160 dd0144c0 c03754bc dd014c50 dd18c=
800 dd014c00 00000000
[   12.195037] 7e20: bf0cc160 bf0cc058 dd014c00 dd014c00 bf0cc174 c0466=
3c0 dd014c00 00000000
[   12.203613] 7e40: dd014c50 c0466694 00000000 00000000 dd014c00 dd014=
400 dd277ea0 c0466cfc
[   12.212188] 7e60: dd01444c c00835e8 dd01442c 60000013 dd014450 00000=
000 00000000 00000000
[   12.220764] 7e80: dd01444c dd014400 dd0144a8 0000003d c0466d94 dd014=
44c c0466d94 c0466e10
[   12.229339] 7ea0: 00000001 3d000000 00000001 3d000000 00000001 00000=
000 dd014400 bf0ba0ac
[   12.237915] 7ec0: 00000001 00000000 000000f0 dd014400 dd0147a8 00000=
0f0 000000f0 c0469410
[   12.246490] 7ee0: dd014400 dd01442c dd014470 c04675d0 dd2729c0 dd014=
400 00000000 dd01442c
[   12.255035] 7f00: dd0144c0 c1111c48 000003e8 c046773c 00000000 00000=
000 dd35a980 dd014400
[   12.263610] 7f20: c04676dc 00000000 00000000 c0059838 dfa71c80 00000=
000 00000000 dd014400
[   12.272186] 7f40: 00000000 00000000 dead4ead ffffffff ffffffff c0952=
f54 00000000 00000000
[   12.280761] 7f60: c0759a92 dd277f64 dd277f64 00000000 00000000 dead4=
ead ffffffff ffffffff
[   12.289337] 7f80: c0952f54 00000000 00000000 c0759a92 dd277f90 dd277=
f90 dd277fac dd35a980
[   12.297882] 7fa0: c0059764 00000000 00000000 c000ed50 00000000 00000=
000 00000000 00000000
[   12.306457] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000=
000 00000000 00000000
[   12.315032] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000 9fef6821 9fef6c21
[   12.323608] [<c0469f4c>] (__power_supply_is_supplied_by) from [<c046=
a058>] (__power_supply_am_i_supplied+0x18/0x48)
[   12.334564] [<c046a058>] (__power_supply_am_i_supplied) from [<c0374=
ebc>] (class_for_each_device+0x68/0xa8)
[   12.344787] [<c0374ebc>] (class_for_each_device) from [<bf0d0de4>] (=
bq27x00_battery_get_property+0x19c/0x3a8 [bq27x00_battery])
[   12.356811] [<bf0d0de4>] (bq27x00_battery_get_property [bq27x00_batt=
ery]) from [<c0469508>] (power_supply_get_property+0x1c/0x28)
[   12.369018] [<c0469508>] (power_supply_get_property) from [<c046a140=
>] (power_supply_show_property+0x48/0x1ac)
[   12.379516] [<c046a140>] (power_supply_show_property) from [<c046a42=
c>] (power_supply_uevent+0x7c/0x148)
[   12.389465] [<c046a42c>] (power_supply_uevent) from [<c0371f0c>] (de=
v_uevent+0x174/0x1c0)
[   12.398040] [<c0371f0c>] (dev_uevent) from [<c02c7544>] (kobject_uev=
ent_env+0x184/0x47c)
[   12.406524] [<c02c7544>] (kobject_uevent_env) from [<c0371938>] (dev=
ice_add+0x1fc/0x34c)
[   12.415008] [<c0371938>] (device_add) from [<c0469cd8>] (__power_sup=
ply_register+0x144/0x290)
[   12.423950] [<c0469cd8>] (__power_supply_register) from [<bf0d0864>]=
 (bq27x00_powersupply_init+0x120/0x1c0 [bq27x00_battery])
[   12.435791] [<bf0d0864>] (bq27x00_powersupply_init [bq27x00_battery]=
) from [<c03752c0>] (platform_drv_probe+0x48/0x90)
[   12.447021] [<c03752c0>] (platform_drv_probe) from [<c0373bd4>] (rea=
lly_probe+0xd4/0x238)
[   12.455596] [<c0373bd4>] (really_probe) from [<c0373e34>] (driver_pr=
obe_device+0x30/0x48)
[   12.464141] [<c0373e34>] (driver_probe_device) from [<c037265c>] (bu=
s_for_each_drv+0x4c/0x84)
[   12.473083] [<c037265c>] (bus_for_each_drv) from [<c0373dbc>] (devic=
e_attach+0x60/0x8c)
[   12.481475] [<c0373dbc>] (device_attach) from [<c0373294>] (bus_prob=
e_device+0x28/0xa0)
[   12.489868] [<c0373294>] (bus_probe_device) from [<c0371940>] (devic=
e_add+0x204/0x34c)
[   12.498168] [<c0371940>] (device_add) from [<c03754bc>] (platform_de=
vice_add+0x138/0x1c8)
[   12.506744] [<c03754bc>] (platform_device_add) from [<bf0cc058>] (w1=
_bq27000_add_slave+0x50/0x78 [w1_bq27000])
[   12.517242] [<bf0cc058>] (w1_bq27000_add_slave [w1_bq27000]) from [<=
c04663c0>] (w1_family_notify+0x44/0xc8)
[   12.527465] [<c04663c0>] (w1_family_notify) from [<c0466694>] (__w1_=
attach_slave_device+0xe4/0x154)
[   12.536956] [<c0466694>] (__w1_attach_slave_device) from [<c0466cfc>=
] (w1_attach_slave_device+0x13c/0x1d4)
[   12.547058] [<c0466cfc>] (w1_attach_slave_device) from [<c0466e10>] =
(w1_slave_found+0x7c/0x98)
[   12.556091] [<c0466e10>] (w1_slave_found) from [<bf0ba0ac>] (omap_w1=
_search_bus+0x54/0x5c [omap_hdq])
[   12.565765] [<bf0ba0ac>] (omap_w1_search_bus [omap_hdq]) from [<c046=
9410>] (w1_search_devices+0x3c/0x48)
[   12.575714] [<c0469410>] (w1_search_devices) from [<c04675d0>] (w1_s=
earch_process_cb+0x64/0x108)
[   12.584930] [<c04675d0>] (w1_search_process_cb) from [<c046773c>] (w=
1_process+0x60/0x164)
[   12.593505] [<c046773c>] (w1_process) from [<c0059838>] (kthread+0xd=
4/0xe8)
[   12.600799] [<c0059838>] (kthread) from [<c000ed50>] (ret_from_fork+=
0x14/0x24)
[   12.608367] Code: e12fff33 e8bd8008 e92d40f8 e1a06000 (e591500c)=20
[   12.614929] ---[ end trace 2ba904cc466626a7 ]