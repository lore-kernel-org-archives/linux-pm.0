Received: from 9.mo565.mail-out.ovh.net (9.mo565.mail-out.ovh.net [46.105.77.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0D48F02F
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.77.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013362; cv=none; b=WpCT4zHyoPrndAi3G+1XPShb2PCT8p/jeHmpEqr+yK2sjpPdGyo8T1RBamvrjf/qLOMyiAI0IsjNerZ+nlWdUebSW0Up0KrhkloLUZfp9377L06KjD7c0viLqWlEKa6aSHGe2lFbKBXhKBYwJQOPbHWnhdpqetTt2OyFdLkwNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013362; c=relaxed/simple;
	bh=cNlHbUUPuaFROlOfwDCsCR/krd8jiV//A2riBEZb9uY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=P8eZpXC/fFNSD6PnFMQrFIvwfBqHQ/iDJR6eqvvQxkvGhv56uQBB2SPRwv8ivpKv8q7oY98kI+7wDHTimOiBT2HiMoMVhUagiXJzVM2QNs8ofRLcNj5vWaKI6JqHPSx0jVjhGXvqY9yzUcUnxLRtDC6bL/8s4kn33eWlfZCXueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com; spf=pass smtp.mailfrom=trinity-net.com; dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b=C0F6xWsZ; arc=none smtp.client-ip=46.105.77.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trinity-net.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trinity-net.com header.i=@trinity-net.com header.b="C0F6xWsZ"
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo565.mail-out.ovh.net (Postfix) with ESMTPS id 4hpVz44v6yz63W1;
	Mon, 21 Sep 2026 17:46:40 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <lihuisong@huawei.com>; Mon, 21 Sep 2026 17:46:40 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.54])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hpVz43BNwz1xvB;
	Mon, 21 Sep 2026 17:46:40 +0000 (UTC)
Received: from mailstore7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.1.8.7])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTP id 4D00F8E1BC7;
	Mon, 21 Sep 2026 17:46:39 +0000 (UTC)
Date: Mon, 21 Sep 2026 17:46:39 +0000 (UTC)
From: Support TRINITY <support@trinity-net.com>
To: 
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, 
	regressions <regressions@lists.linux.dev>, 
	linux-acpi <linux-acpi@vger.kernel.org>, 
	linux-pm <linux-pm@vger.kernel.org>, 
	xen-devel <xen-devel@lists.xenproject.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Huisong Li <lihuisong@huawei.com>
Message-ID: <750088883.289173062.1790012799166.JavaMail.zimbra@trinity-net.com>
In-Reply-To: <arFe7-xa3HtCUOHs@mail-itl>
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com> <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com> <arFe7-xa3HtCUOHs@mail-itl>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Authenticated-User: support@trinity-net.com
Thread-Topic: ACPI processor/cpuidle change in 6.18.52 breaks bare-metal Xen dom0 boot
Thread-Index: JJ5MX6sCvA3YfJ8XBKw+R8eVLKlrew==
x-ovh-tracer-id: 7890306548001371756
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGzUGnqSG7fSU4vc1J/EOhw0keWUraYqIl+GujdRSX+o6s5CmvuG878t9CnLVy/dOzT9c5Wno/vmvzTE/kpj9cKFal6oOeRUTJpeBxtdOzcq9ArTwZAOopcvTsus+hI48lwvR3/EDxL6AeT8kaXBVqATYCWxGtk2M4D939oYnPD0pN5JlAtuqbP42lvWE7s6c/6uagGp5/KZRwC3MdpS+FYNYare6+Y+GgWSCsajU2GnorlsO9l4ZWxu2YnIl90kkMpGO3Op8wnuKxiUxFHjVrX5JpUJ7/JwTFTmlf2t0B0mPW0wl6h4V5KlF4kBWDyp1l6z7z7n9Yq7FHAzmhgxPtdooQgzZwd95jedm/YQsNjk8+dbr6uUBQVomff0zO1BOc0MEz8gOTVxkZ+odwEPj0YilwjJvhGJnDR/ElIfHhNho44wLpbNjVnQptFUBgp7spYHcFNV9CAiIMrXSLLbUf+njlMYFfUBwFnBTg/n5rDYat1rGgqDwJcy3qi4zqIOQ8VJc6toExjaHjhRHuXb52y4Yry5V5rPcm4GF6V7vH+hNwymq2qkAUdnUEoFTOTnw8Tw79SBOxgBQNHbZj+AIfqsYIj6YbkWYCFSUzOSyPX5T8ZszCFXBv1gEzOeTYJ1G5eMjdkHPdEE0n+W8KzkUqsh8xM3C840MQJE1V9Ci5GdA
DKIM-Signature: a=rsa-sha256; bh=eEs26H6jLMUFSrdB4SPeZDbYEEF2DnyaqQKffkYXWGQ=;
 c=relaxed/relaxed; d=trinity-net.com; h=From; s=ovhmo-selector-1;
 t=1790012801; v=1;
 b=C0F6xWsZon2nfRwJgLBZ3xh/yqLzy9xne1B/f+hbh7D2sH3MowiOWITJOdecH/SZZtQm5gMX
 jjZ6CvKtOpUNsHzkrapCHgSwX4TxIi0erF16qw+yOcHFuebM3VVKN+snKyqRw/AzZy06CqiFaNh
 jBYYryK2zor8ATmCl6ANR4JRbrRXrxSie/hNA9X5eFObEKFYgMFQwD53cmQeyPmNHtposqhwW3k
 lnlAlcVU3l8FcXoyDI0E0mYCX2nt3Ero4ut1xHvqkJ3/jM8iOd835+eJ75Vsu5lf/0tVjGrcxnp
 rmPHi95aXuUVYv9a6WIQuBYoABsYnhs5IesMFLuNbWKfQ==

Hello,

Thank you, this matches what I see on the affected Alpine Xen dom0
systems.

I also tested Linux 6.18.52 with processor=3Dnocst on the Linux kernel

Result: it still fails with the same black screen before dom0 userspace
and networking come up.

Marek's trace looks consistent with the failure mode I isolated: the
crash happens from acpi_processor_power_init() while registering the
cpuidle device.

The working patch I tested is not a plain full revert of 6.18.52 ACPI
processor changes. It restores only the previous ACPI idle driver
registration lifecycle, where the ACPI idle driver is registered from
acpi_processor_power_init() before the first per-CPU cpuidle device is
registered, and unregistered from acpi_processor_power_exit() after the
last one is removed.

Compared with my first ACPI-only test revert, the refined patch keeps the
unrelated 6.18.52 safety/error-handling changes, including the _LPI
bounds checks and the cpufreq notifier cleanup on
acpi_processor_driver_init() failure.

So yes, it is very close to a targeted revert of commit 13ebeef6a1b9
("ACPI: processor: idle: Optimize ACPI idle driver registration"), but it
is intentionally narrowed to the idle registration lifecycle instead of
reverting all surrounding ACPI processor changes.

I agree that this points to a missing ordering/lifetime check rather than
a storage, Xenbus, IOMMU, APIC, networking, or initramfs issue.

I have not tested Linux 6.18.53 yet. Based on the 6.18.53 changelog, I
did not see any ACPI processor/cpuidle change that appears to address
this regression.

Given Marek's additional data point that Linux 7.3-rc3 works fine, this
looks more likely to be a stable/backport regression in 6.18.52 than a
current mainline regression.

I had already started a 7.3-rc4 build locally before seeing Marek's
reply, so I can still report that result if useful, but it may be less
important now than identifying the missing dependency or ordering check
around commit 13ebeef6a1b9 in the 6.18 stable backport.

Regards,
Tony


-----Message original-----
De: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.com>
=C3=A0: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Cc: Support TRINITY <support@trinity-net.com>; regressions <regressions@lis=
ts.linux.dev>; linux-acpi <linux-acpi@vger.kernel.org>; linux-pm <linux-pm@=
vger.kernel.org>; xen-devel <xen-devel@lists.xenproject.org>; linux-kernel =
<linux-kernel@vger.kernel.org>; Huisong Li <lihuisong@huawei.com>
Envoy=C3=A9: lundi 21 septembre 2026 18:44 CEST
Sujet : Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks ba=
re-metal Xen dom0 boot


On Mon, Sep 21, 2026 at 05:26:55PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Sun, Sep 20, 2026 at 5:48=E2=80=AFPM Support TRINITY <support@trinity-=
net.com> wrote:
> >
> > Hello,
> >
> > I am reporting a bare-metal Xen dom0 boot regression seen with Linux 6.=
18.52.
> >
> > On affected systems, Linux 6.18.51 boots successfully as Xen dom0 on ba=
re metal, while Linux 6.18.52 consistently black-screens before dom0 usersp=
ace/networking comes up.
> >
> > #regzbot introduced: v6.18.51..v6.18.52
> > #regzbot title: ACPI processor/cpuidle lifecycle change breaks bare-met=
al Xen dom0 boot
> > #regzbot link: https://gitlab.alpinelinux.org/alpine/aports/-/work_item=
s/18447
> >
> > Tested results:
> >
> > Linux 6.18.51-r0, Xen dom0, bare metal: boots
> > Linux 6.18.52-r0, Xen dom0, bare metal: black screen before userspace/n=
etwork
>=20
> I'm wondering what's special about Xen dom0 bare metal.
>=20
> Does adding processor=3Dnocst to the kernel command line help, by any cha=
nce?

It does not.

> The patch is essentially a revert of commit 13ebeef6a1b9 ("ACPI:
> processor: idle: Optimize ACPI idle driver registration") which I'd
> rather not do without knowing what exactly is going on.
>=20
> At this point it looks like a missing check somewhere or similar, so
> it would be good to find out where exactly it crashes.

I can reproduce the crash, I get this:

[    3.525669] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[    3.525677] #PF: supervisor read access in kernel mode
[    3.525681] #PF: error_code(0x0000) - not-present page
[    3.525685] PGD 0 P4D 0=20
[    3.525688] Oops: Oops: 0000 [#1] SMP NOPTI
[    3.525693] CPU: 0 UID: 0 PID: 21 Comm: cpuhp/0 Not tainted 6.18.52-1.qu=
bes.23.fc41.x86_64 #1 PREEMPT(full)=20
[    3.525700] Hardware name: Micro-Star International Co., Ltd. MS-7E06/PR=
O Z790-P WIFI (MS-7E06), BIOS Dasharo (coreboot+UEFI) v0.9.1 01/17/2024
[    3.525706] RIP: e030:cpuidle_register_device+0xd2/0x350
[    3.525714] Code: 00 00 8b 55 04 49 89 c5 49 89 d4 81 fa ff 1f 00 00 0f =
87 68 02 00 00 48 8b 04 d5 c0 a0 19 82 48 83 3c 18 00 0f 85 ad 48 12 ff <49=
> 8b 7d 08 48 89 14 24 e8 31 73 30 ff 84 c0 0f 84 72 01 00 00 41
[    3.525723] RSP: e02b:ffffc90040133db8 EFLAGS: 00010246
[    3.525727] RAX: ffff888235f5c000 RBX: ffffffff834d4d40 RCX: 00000000000=
00000
[    3.525732] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffff888101c=
39c00
[    3.525736] RBP: ffff888101c39c00 R08: 4ec4ec4ec4ec4ec5 R09: ffff888101c=
39c00
[    3.525740] R10: ffffc90040133df8 R11: 0000000000000000 R12: 00000000000=
00000
[    3.525744] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff834=
d4d40
[    3.525752] FS:  0000000000000000(0000) GS:ffff888235f5c000(0000) knlGS:=
0000000000000000
[    3.525757] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.525761] CR2: 0000000000000008 CR3: 000000000242c000 CR4: 00000000000=
50660
[    3.525768] Call Trace:
[    3.525771]  <TASK>
[    3.525775]  acpi_processor_power_init+0xde/0x150
[    3.525782]  ? __pfx_acpi_soft_cpu_online+0x10/0x10
[    3.525787]  acpi_soft_cpu_online+0x123/0x170
[    3.525792]  cpuhp_invoke_callback+0x134/0x470
[    3.525797]  ? __pfx_smpboot_thread_fn+0x10/0x10
[    3.525802]  cpuhp_thread_fun+0xa2/0x170
[    3.525806]  smpboot_thread_fn+0xf3/0x220
[    3.525810]  kthread+0xfc/0x240
[    3.525814]  ? __pfx_kthread+0x10/0x10
[    3.525818]  ? __pfx_kthread+0x10/0x10
[    3.525822]  ret_from_fork+0x158/0x170
[    3.525827]  ? __pfx_kthread+0x10/0x10
[    3.525830]  ret_from_fork_asm+0x1a/0x30
[    3.525835]  </TASK>
[    3.525837] Modules linked in:
[    3.525842] CR2: 0000000000000008
[    3.525845] ---[ end trace 0000000000000000 ]---
[    3.525849] RIP: e030:cpuidle_register_device+0xd2/0x350
[    3.525854] Code: 00 00 8b 55 04 49 89 c5 49 89 d4 81 fa ff 1f 00 00 0f =
87 68 02 00 00 48 8b 04 d5 c0 a0 19 82 48 83 3c 18 00 0f 85 ad 48 12 ff <49=
> 8b 7d 08 48 89 14 24 e8 31 73 30 ff 84 c0 0f 84 72 01 00 00 41
[    3.525862] RSP: e02b:ffffc90040133db8 EFLAGS: 00010246
[    3.525866] RAX: ffff888235f5c000 RBX: ffffffff834d4d40 RCX: 00000000000=
00000
[    3.525870] RDX: 0000000000000000 RSI: 0000000000000007 RDI: ffff888101c=
39c00
[    3.525874] RBP: ffff888101c39c00 R08: 4ec4ec4ec4ec4ec5 R09: ffff888101c=
39c00
[    3.525878] R10: ffffc90040133df8 R11: 0000000000000000 R12: 00000000000=
00000
[    3.525882] R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff834=
d4d40
[    3.525889] FS:  0000000000000000(0000) GS:ffff888235f5c000(0000) knlGS:=
0000000000000000
[    3.525894] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.525898] CR2: 0000000000000008 CR3: 000000000242c000 CR4: 00000000000=
50660
[    3.525904] Kernel panic - not syncing: Fatal exception
[    3.525931] Kernel Offset: disabled

And I have also another data point: Linux 7.2.6 is _not_ affected. And
similarly, Linux 7.3-rc3 works fine (haven't tried -rc4 yet).

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
