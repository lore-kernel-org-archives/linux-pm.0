Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359863;
	b=ORTXaZrdQPnAkkKiLQOP2CyJ7pcttFlrwm/OlA8iUvawWEaOhIyVKmuK1hOl6mPQD7FK
	 Q5Z5GtAi3+2Fq/Od6sUYzE7PiFhlB1cuzOw4kCEQyaxjZ4Vox3jROBWqqbmAMbgl3OKAe
	 ksQVup+vU1bes+5ZFJnahW/O0zpr1f9up4/6YHY//YbmfvyJ2qGREeptyhTKrnMtlJyqk
	 ITcnsWQ2bt3sCHKVOUm9iMZLmoqFdVyaU7Tvs/hYXkjsgGc6/+HRZcKfcS0FjbsR1dYzD
	 AGiGLsHlWTY2mN6WZoBN0DbamrtPr3hVStv1yw5RnV1xg9VeLBX8Eiwb87kwA3lAwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359863;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=lM7X7fxngXPk+eDICso8sUtsp/OwQONHWclMf0C8lHc=;
	b=tuRGHWWfbYSWDGHoGCyPJAfzNOcP9cPHlJeArLkJ02V9dkdlx1YJ9Zgyv1TRupdWw693
	 VEm8bjEjVqWixKkzJycbJZ5t2VkNGR0q5pMkdv2uFxEWgz0qhvZAHNO59Br4Gueg/gDOJ
	 cIeMiieWBx9D8o+ZBxSrPx/8YZlP4uOfjgYmJpKdRjndPLulJDSxocdUSWf5nSy5/Ads3
	 kv3EfaZRlFHQfvKkUP5+TBMhGW8+muZnBvXw577JmXohlHSmnSSzcVUZPN9ZeEJ9mdKv6
	 TuO3LTNDu8YD9hOxWQJ5eEqPRb93BDednACb4YwXLP5n5KcvixZDbqBQDwVKAmFkHuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b="Vt/70HQd";
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35164606A31C;
	Wed, 11 Nov 2026 01:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35164606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=Vt/70HQd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794359806;
	bh=lM7X7fxngXPk+eDICso8sUtsp/OwQONHWclMf0C8lHc=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=Vt/70HQdVY+paZcPt1cDcawCd1TkEK6nCXrWfiD4DpmQISy/xcMds3zmrUv/CSBYr
	 c3LKaCYBHBdUORt9eWfpbsTZq62h18ZFJS3hlVUbEo0Dz9jPKuU+vW8aKxdqzxxW9F
	 UoHezvI3o2a/mt3HrM636+01tkk5jOnzbMiw1FQo=
X-QQ-mid: esmtpgz14t1794359799teb8f1d41
X-QQ-Originating-IP: +kWDJtfHflgoOFufqb5Vc65dmmJeFNZ5FXCZp5/CqWE=
Received: from = ( [183.48.246.46])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Nov 2026 09:16:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16278285784164575929
EX-QQ-RecipientCnt: 11
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=11646ab292b69992658ecbc426bd320fb3756d48584897919a6b53c3f3eb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 11 Nov 2026 01:16:36 +0000
Message-Id: <DMRZGMGRLD4S.KT6VEU28902E@linux.spacemit.com>
Cc: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>, "Andi Shyti"
 <andi.shyti@kernel.org>, "Sebastian Reichel" <sre@kernel.org>, "Yixun Lan"
 <dlan@kernel.org>, "open list:I2C SUBSYSTEM HOST DRIVERS"
 <linux-i2c@vger.kernel.org>, "open list" <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, "open
 list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, "open
 list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Aurelien Jarno" <aurelien@aurel32.net>, "Anand Moon"
 <linux.amoon@gmail.com>
X-Mailer: aerc 0.21.0-reader-ipc4
References: <20261110061429.2036-1-linux.amoon@gmail.com>
 <20261110061429.2036-2-linux.amoon@gmail.com>
 <avOL1mCkI4YSaDeO@aurel32.net>
In-Reply-To: <avOL1mCkI4YSaDeO@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NL3fB1gebWXoD6SwPos3DavG4+/U/Hq9X0DSCCB6vebTon8xktnh62yd
	qvB+PSzAM/40yzcvXSvzLfrXAeCUQpiAShEBkdXJCo9Ff/fcYYUWVxFa6ovCSU1DKcy2Vgf
	ElJV+07G3N+wk2fxX8Mo/Z6J9Eg997xRJahsJLxXK3O5Hgf40xRoP1MwEuuDcoNWZ1IpxNC
	Cpl16bep2gosSlEUYaQ62tcBqVxS0n9PAY766kRtpBuTiBpzaarTYLImQ2o2W+cmFKGdAXj
	Y1ipN8rN8TBskpkQqlDk+wTRmuKopyQ1IAHdRm/nS0qqePu0i5bZ3ZcRYKTJyPQOiJ1JWLK
	WFhG6/HjrDmRFl7XoQR0AH8yfLAB6Qgv+Owq6cvEfTrid9/oP/kFLH6lKD15KHaoFeYBrSA
	hzFjBNRF8ExFolTiq9+N7EM4/yDw1cjr7HlIBWMh0frH+hlR7/T4yQJznZVnVZfTLVxfgcE
	3pobZ6wcze93ErX2joI1FAg8eiZUpUgq9gGxJ/PYd6gU83vmzcrdhGjeo6le6IbfSI50Lsp
	yvJbNnqHuw0KSSDfaNpIOqtLNamM2E0IwJbSvJHe2m3OA1Lrzg+LvBhyitA8Zyry13Qvgth
	P7RhZ4oD6Vf5mn43N7ucLLppXgwTVnqoaa6o02BjouqC11D/TWVo2V6MZHUYATkx8wYR4yk
	aaYhEOY4qBJB7XP9/DkH8Jkh54+LXGhE0bO0zKD3w4BQHlvy/8if9Wn2jEacqw+sYTi5uOd
	L7EkqdnrwH0mp1xQ2F1i2CIW5CjPiMtzKrcYXxmVdxlcYBDxBqLCfJB2oYGCbDAOIzUwFt8
	8nqMW4aG0fO5fqJ3wkAGZybOX1C0SpADqJPw//SsusYIIEkRtA1ok8gKOJh6jrgtYUUmWAM
	/2+HhXaFy2o7QKnza2hmJiEL5J9Jh08PLWSvXjSPuayBFVIVAf1kByEN66Ycvh31lBE9imc
	H7z4jaNC6XaxNQFHueFFBeVXz8Ms1O1fIph7B1DVdStft9tSFJ5P28Vks4A9nZfM7Vy9FRI
	OQqUqMIQB4DEo6fgPlQrx/9DQLPsfS1unLaMleCv+jHPdvsewqnyRvQSGPScmMFTH/ScEpk
	ETLXVJ4KBuJfucAXJfhJkmYsDc65Slla4/YKekAG28QbYbU+IgEgpI0rEx4bq3bntYJpv+n
	NO9hwc904o+qMkp1Ypm+SvtBDkzr6RVDYzrL
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

--11646ab292b69992658ecbc426bd320fb3756d48584897919a6b53c3f3eb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Aurelien,

On Tue Nov 10, 2026 at 9:25 PM GMT, Aurelien Jarno wrote:
> Hi Anand,
>
> On 2026-11-10 11:44, Anand Moon wrote:
>> The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
>> to access the PMIC. However, these handlers run in an atomic notifier
>> context (specifically within an rcu_read_lock() critical section), while
>> the I2C-backed regmap uses a sleepable mutex.
>>=20
>> This triggers a "WARNING: suspicious RCU usage" warning due to an illega=
l
>> context switch in the RCU read-side critical section during shutdown on =
the
>> Banana Pi BPI-F3:
>>=20
>> [  563.803475] WARNING: suspicious RCU usage
>> [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
>> [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in =
RCU read-side critical section!
>> ...
>> [  563.841445] locks held by shutdown/1: 2, last CPU#0:
>> [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:=
4}, at: __do_sys_reboot+0x230/0x29e
>> [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: at=
omic_notifier_call_chain+0x4a/0x1c2
>>=20
>> Replace the regmap operations with atomic I2C transfers to avoid sleepin=
g
>> in an atomic context. Preserve unrelated register bits through
>> read-modify-write operations and check for atomic I2C support before
>> registering the handlers.
>>=20
>> Obtain the I2C client from the parent device and verify that the adapter
>> supports atomic transfers before registering the handlers.
>>=20
>> Tested on the Banana Pi BPI-F3 (SpacemiT K1).
>
> While the patch looks correct, I am not sure this is the correct=20
> approach, as opposed to the one proposed by Troy [1].
>
> Indeed bypassing regmap and using i2c atomic transfers needs to be done=
=20
> by all affected drivers. For instance the VisionFive 2 board, which use=
=20
> an axp15060 PMIC is also affected by this issue. And the corresponding=20
> driver is shared between architectures, which make this kind of change=20
> more difficult.
>
> For the BPI-F3, note that with OpenSBI 1.9, the reboot is handled=20
> through the SBI SRST extension, preventing this issue to happen. On the=
=20
> long term, I am not sure we should keep this driver.
>
That only covers restart. The SBI restart handler is registered at
priority 192 and runs before the P1 one at SYS_OFF_PRIO_DEFAULT. Power
off is the other way around: sbi_srst_power_off() goes through
register_platform_power_off(), i.e. SYS_OFF_PRIO_PLATFORM, so the P1
power-off handler still runs first and still hits this on shutdown,
even with OpenSBI 1.9.

So until this driver goes away, BPI-F3 still needs the arch fix [1]
for power-off.

Link: https://lore.kernel.org/linux-riscv/20261104-v7-0-rc1-rv-dis-int-befo=
re-restart-v5-1-956ec09c900d@linux.dev/ [1]


--=20
Troy Mitchell


--11646ab292b69992658ecbc426bd320fb3756d48584897919a6b53c3f3eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavPB9CEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9XhQEA+/SZQ0K1nCjc
8q38r5D4Ar8hTMv6yyEbHYBA2OMfpHUBAP1Swga5o1WjexDHDtlaytztw5gGTAjg
LybIUoMHS0wE
=4Yt0
-----END PGP SIGNATURE-----

--11646ab292b69992658ecbc426bd320fb3756d48584897919a6b53c3f3eb--
