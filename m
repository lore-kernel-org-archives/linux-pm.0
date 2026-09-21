Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F54BA1DD;
	Mon, 21 Sep 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009078; cv=none; b=Igrt/A2ZDI4hRbW+aQaX9+/OT/Q8epUtrFHTL1qhK/IE7UKRldYTgSXE9YnInhz2xTvRXhlX3mGUQkY3ZLlhfj9SHip5GrQ3qAm6kDV18yo/viOjcuOnseeEb02PUyjMhQJMubeuX4/AR7HZRETLSg0kEark1M+aXzmC5OT9TTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009078; c=relaxed/simple;
	bh=QZzmOJOPv/EoQdxGPQOL62qo+b2IzGIc3h5IrZH5pbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STBjewHi+x3KAHSOW3WCuFSMBbdNH+Dpkx437AI7TczZ5GFQ9oF80o82n57rTVMiDPMYnhQkWRP3n3njaHasexGTN3zvh3fli1SZiOz0mARnSd5iQa3oMHjOdTONBlhq5OtVBG9CJpa90073gv3u/gvsZLF14Av9XUghph7ZG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=ETOnTJrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKcMeiVt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="ETOnTJrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKcMeiVt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C92B914000BD;
	Mon, 21 Sep 2026 12:44:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 12:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790009075;
	 x=1790095475; bh=zjivBsa9hsRYHRNcFKFS9TSN3LLieSyZGZ06Ds3oU04=; b=
	ETOnTJrWCFgnFf/C6RW39dzZVGm9alXCueR8hrIYvyhVK8RxNGOJ3OBhs38QifwK
	Gd/b0d8HjsrrNbRIEKPqx/2AZwA8lrpMeqkU9fgFMkFLA1an3zIpHfKWcYIsn0CI
	aKtNx2/7C4QYRxoPxjGafhTx+EInGybRln/BP8LTVlQevCgBsVu5GpS6RIvARYlD
	dFRTcZvm06/nhqQ3uj6a1EBIltNrr7VfTvD1ct1HsppWzC9XyaD3jh2/85aWS5vC
	txPKZ3eIWTWEIne68UlhLAOTEkaXyBUCKK211Mpdcr/Z85aKHUv1AdkFpifKBbjH
	jNIULI84Px6RykN2jLUoHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790009075; x=1790095475; bh=zjivBsa9hsRYHRNcFKFS9TSN3LLieSyZGZ0
	6Ds3oU04=; b=VKcMeiVtck82x1r/UyvCXPeKBPcVIOpbiLym7cqzPvPhJLsdZp1
	9s+QNXETbUNvzxGoGahycJ7vl1NOZ045Vvl+lF58R7PcoLvhGtv9g9lQFTKe0xka
	IL9yBbYA3v8iaW8ZB9xuc9hIc1+XR1N8qYSrCLIhKrNUyrhWPu9X+KyFBMuP0uCm
	9RsBxp6aM4gF/lPyXboPKE8bnOsMI3s7kcF5HKhdkLD2WVzir4SuEXpzeRHjYyy/
	uceQqwtXZWhQKJ2mvaDFAJMtcgStz9u6RGqkfikyY7n/LxaTpDGgIVEPkzI+ES1z
	QU45+tsWIgJiLG6lggy9LF9WgS/CAl/ZStw==
X-ME-Sender: <xms:816xahJ1LXzvp-yUi51Wp_yPlvOBzkMZQGoT40iBcnuMYf6HQYFQgQ>
    <xme:816xaiG6rUwTFXAUUl5CCiPAfcinsSTWArg-r2yZw1WuyNyZl776JOkszTL823t0t
    rDFSHFIzASozQwuI9FCltLtOOCBcmhU4a2QkETLoedAXjomRw>
X-ME-Received: <xmr:816xat8VHnFPJuKWO2gnQin-jdnfpxHhIl7PMeLxLfgGEC8fi8DQMYL5aszSmTrLY5txy0FdhpUAxvEzasxUsAkVtPuTCSQkQXvJ7klAPGo>
X-ME-Proxy-Cause: dmFkZTEeJuUSXcXeoFym2RhUCdnjC1hVcyJNbiXzRJfWYXLtKAJXYGAPCakl5qcp6/SKXs
    MGNNYK1DQXRQ2t//wFMwqiisHDJwLqn7jO49xQPd0WPBSlYe9lDssGROHDQsS8Bk7FlTe6
    0EvM8fIU92OKf3+3Gigm9Qce8DcAbAIPunT5xFIRRF3Ty8X1bTicArUlkdPTZol/UiwrKd
    Hobiz/pIFccJHnBJIevVebKUXyOh1TNjvla/N5w0hybdKG7+G/uRJtzwe5hkpZvwhe8zUR
    2+UHThMzf4dYYKG+me1Y9hzKWbr+1QfhRSj7X745j7VRthIymvfnGMWTNMvihukkwdkZl+
    qHJZYmWrhaTHFuidDeOXKl58oQjIrx8ft2kjCTJdv/Q4FvyJ4tprsGwOBViHTQREvOU+Xe
    a16oR2BSKbPhYqK61AcYux0Y71upCmsQiYMaql4UhguxQE1QfvDkh+iz9MIpgmPqWSiaqn
    bwMcE4vt5kvoLHIkEVw8zx2GdJ3213MnEjFRH4vW4CjcZ6+uSS4YGiDlAlmCsMXxvguEDv
    18N/psr8ZwybdP1rujQDtYLnfDep6bjEx8oioZ/A6UfJ8+mw5/yQpC30VzG4PhYCYqkbk9
    FRaVrq5qGyQEBQTDZpgAPeYS6mPpd6ZgO0JPOPln4Vv9dzAyne0/GJjgpNTg
X-ME-Proxy: <xmx:816xaiJgq853xS5tN-BLCraQiqOkZKbLFnWVYo3D-1TMXudqaXoXpg>
    <xmx:816xart2tdtEtBCWdWYvKd3bB2StsRBrJzqdjkusdlX1AoKswkRamA>
    <xmx:816xapB2H6u-tVayBeTar35szQVWML6bFau1oEinGM6HrePo5mZgNw>
    <xmx:816xajMUUcH--87Ycu2a5W1iaMiwwU_5sxvdhziSshYNCq5DHrJjwg>
    <xmx:816xagAoWBUPSw0s7yC1piPv0zpMXd7gPP4Srdym09Jee9u61TWOtbr9>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 12:44:33 -0400 (EDT)
Date: Mon, 21 Sep 2026 18:44:31 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Support TRINITY <support@trinity-net.com>,
	regressions <regressions@lists.linux.dev>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot
Message-ID: <arFe7-xa3HtCUOHs@mail-itl>
References: <905771062.272724286.1789919301858.JavaMail.zimbra@trinity-net.com>
 <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lth3KI9EydCmQGrl"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gg7kBtEhagR9SYKaPNstPC6aSyP7W4xBjP1r-kzbcH1A@mail.gmail.com>

--Lth3KI9EydCmQGrl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:44:31 +0200
From: Marek =?utf-8?B?PT91dGYtOD9RP01hcmN6eWtvd3NraS1HPUMzPUIzcmVja2k/PQ==?= <marmarek@invisiblethingslab.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Support TRINITY <support@trinity-net.com>,
	regressions <regressions@lists.linux.dev>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	xen-devel <xen-devel@lists.xenproject.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [REGRESSION] ACPI processor/cpuidle change in 6.18.52 breaks
 bare-metal Xen dom0 boot

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

--Lth3KI9EydCmQGrl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmqxXu8ACgkQ24/THMrX
1yxeNAf8CqjSP8UmFu0EwOUBtvbUXkkKyQgSNjKPFIYIh4LYPPhWtXqrWzp3GKn4
1QbwQSmgEPWpJjLi5/zkNGpJ75gPkJbzDCcD82D39fYjcncHWfD2LCh7LHHOM94J
1z+dqF6L6llqEgeKxcFNDX8eWopBznsp5XNv0wVtYAlt9Qdl89FGYg5qsFecbwno
aDEuUVfT46CQ6+6+eY/mNyifgQcNlFnmShIOR0OXjKghsOzNwU+Geyin3/Kylh/g
9adNQ+eNkUod/gidhUZxUS0O2Q3ZDlM2CHnkItGEWj3vu8OTsvUZrBcussfKnPHD
60t/CiN4kdY1vKqB0SqRGgKmVy4d9w==
=n6Pq
-----END PGP SIGNATURE-----

--Lth3KI9EydCmQGrl--
