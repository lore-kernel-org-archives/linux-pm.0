Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795852556;
	b=nZM5R9FsJtGjrGY2N/RH76y/JiS/A5rA2psJlDLzJqgGMp0NYtZk6Ejkp14HpJrOODRi
	 8PLWkxoyMcYuazrpQh56aIHP6xUjzl/BEaq9EIVYu8sI935wNf1FZge+47XY4TeswjTjv
	 gcxYnRZHkf1DHdT+u2d8zUZ0KdhIvZ3Q2jfaEEUJTYZA/eAAX3hqx07Z6e8uttDBi7jgB
	 KfdxBcNBFS9miX3HPdi2o36aTkrdSPD+vqguo6xUpCgrOznArnmKdZzjr/I7CC66TrHUf
	 Lb7KmpOD6KUUdBzskMZhI928Zqwo8Rdec2CSLcm+ksCoM09saGhWZGOJfvQDIZL+jZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852556;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dXhSrhTCvGfWRS4IWrNSO8kJLBdbYn9Ccrnm72Ng16o=;
	b=zwZKU4KNCgMRvIUh4aaFeUvkS90dDX5sp+7pAdx+DWztXits0EEG11IUDnrl+YFoj0yP
	 MvAvOIbofwjkV+uNwkHyEANyoRmd7dq3RZIz5UYKAX0/5+YO7y9LVz+KpXRmMeXubrpyd
	 MEfCYWvRDSOTyQtkQru3ZMRj4CrwKD2a9x3H78TXbKmHpSC1YKrVoyzewCiI09jPQCOZ5
	 gaZrnAco6Ql+uF3A72eDUX4eAmyX2sljUyx+8G07F1Q+oVA+IHHq7Izpu/8gYHi6IiZfU
	 CGOqCKFOtICwzwPHsM5qKQYTag0Wx4MpB5YYKXoSLKxm/1I1zo1+aXmqwTW4i0Zix9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G16AKc2M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38DB606A321
	for <linux-pm@vger.kernel.org>; Sat, 28 Nov 2026 07:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E38DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G16AKc2M
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so10721143a12.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 23:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795852554; cv=none;
        d=google.com; s=arc-20260327;
        b=kVYch630N0jpHmQUILx1K50V1eBQwv1b9V5/jXJ3/r5Nfls4ZtxosePbFkrYPVKHgn
         6X/FPLdgaqS1hWMqh+dcGC8JQ55cSEswncZiGogBHMdNPCmmFWLvLHw/zmcfC4ZpKXFM
         Mqlu/S4MF9K3um3m+bO9UcbSROeAnNWw6ptoONjvQUg+KIzdIlnq/Ry1tesSt6Y68i1v
         0RBuzoi41c/qgyl80qSupaaWq7e9latkPeOkG3DVw7y8PUXi1TaT+CyjI8k+75DG6DaK
         +RLX4waoyRMw5VrQzq47C8If0DI+qQnj0S2m0rXLsl2Xz7iQsKlMxtWJzK063Y3gO358
         9pPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dXhSrhTCvGfWRS4IWrNSO8kJLBdbYn9Ccrnm72Ng16o=;
        fh=Ss4aB56eYz91D9geGMghTr7WDrXeHzI7QSWy9iDXdEY=;
        b=IiN6iyMlv7iZgnHJNb4NSyDLFm8EAEUzw+UQoQE8kkSH70MjRQUpq5Z3lsLP+4bWLs
         irvqPv3RB9KAMgAz0ZG61vhuHzuKkk+MqHzpa3RTZgEy2IxXPEcV5ohkBg3MTBDVxpuI
         ScZo/9Aiw8CYOqpQ3DMtj6WqqSf9le1nJPd5BtibDAfM1bYViefmpxnF9ooKGBirjkRW
         FiAzVLtaw4k+L055QUgfxQcQcsd9fiyxtkn32vQyndREUI2m6S2mUr6tR81zOIIMIi7j
         //FqcEvNcKU+LSwUzfLQZ7F33ld5jIr2c8pizozcx2QAx5G5ZrP4TNUZT+1KFtcxHrdu
         yv2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795852554; x=1796457354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXhSrhTCvGfWRS4IWrNSO8kJLBdbYn9Ccrnm72Ng16o=;
        b=G16AKc2MqtJLC5sOeXj53zbvpIoszrOtaHuFaxL08yqwxaxvl/BR69XzqEIL7iJJsU
         Kac96cxCJ5J82WDJI+nj4s+maqXMq+p9uc8lewbumfKGjyZmZLD0ZdoG/0jyL036veXC
         lOYfF7UY068W1iUw901eTBiXOWlHG+cLnuB8+DNmPwxP3Z8XtJy50BIg+rWMYKiz7v7a
         /KrzxyggwXgXCFNxO0P77KShkoC0yz7hmEFIzKEZqZARtDNih+HZTJMZ0nZkZ00huS10
         e77dDUsW4nFsh00JE/bm2B/03Z7IxBYs8rjZsj5vdzj3kJ8k1HzZk/Nkp1CXarCGxWx8
         c3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852554; x=1796457354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXhSrhTCvGfWRS4IWrNSO8kJLBdbYn9Ccrnm72Ng16o=;
        b=GapzIUNsR2Cp5QKAzjwarGplqO2YQkA75wPouvDYcboVvZsH7gOf1T+zzp0RTpTgEA
         usA3mYrPoAySFh6J9rC56qAxxpKPHIpTfcNb0Yh1g4dj2zgsWcCXOYQpgsZnRaplGbQR
         6vv3fWgdRcZYDhXsWsS9SubQBIILmQTePwcs7mWRDBUZ0TeRRQPiOribXvLTiyd6mXhr
         8RFPM578PWBSejMud985pbl3O8DC4i37uGnYezp1hXC6AKdGI/sqr5gffeSG4gmMiokc
         jxP5wiFrNGvTeCO4PKeQBa9V1rlim6WGeC8rmHpZ885zw0oXZSAm31hLGBeOGnM24ldM
         Hwbg==
X-Forwarded-Encrypted: i=1; AL+hErG8WCTB3fvgy+inb9PvVEUcbnZryBoSVo+wE7803LU663KMyDIQstrV9Jjo+eVajllYmKzU8qgTBw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9wUzhZ63i3VqcciDLECIzLEstqMjhTgPVEYkk0bY8TLO6AUt+Y
	fkXKxDSLzti56nUMEGrRsNzh0SLYlNvv438QwRwydi7FiqjDEEzzsdiGwdMx8tSt0cBQV+yPjpJ
	OcpVqMPC1eMDOGQrD1Mhj6Pn4nSquvkE=
X-Gm-Gg: AZFdTZe7kfzhONksA8oITBYU9FM1XEPVQzaR/Z60eFRKhtCHbWG8Mt7XbhQZt9PLSb+
	RvqwFx50UIwTfidhEU17aBvPvCMwEoWwZrLVebUNK86F76Apza1MWzKPuIfRd+qoHQx+rJI2qiT
	XOEsbQMxe7ksn856hTxlUlNzEoVer8ioD4fB/fhRxz2uyJhNHM6dPn5TyVn4hsNvy5unpktY8QT
	GYhM0ZxLQ8tAJhvHePnRUbVwVgOWdz9GtYq7A34PjsxmIkghqa09JRswmS22niK8Q5FAgMaxJL2
	XDlLkVsM5XU3ijZ/UyFD8LLm+5pEVQKZ9SHGugzXZ21VGmkaQ2/LfuHM8hzl6VhMYB8uvzLCIcI
	qlx9PBn05ALPaN9YQrqHZg3bzXR2/XF7bizFzE8J5af5tPTS7Kpfz3TNXJiApRnI2MyX4Vg==
X-Received: by 2002:a05:6402:617:b0:6bb:7b26:d01a with SMTP id
 4fb4d7f45d1cf-6bb7b26d542mr3131536a12.11.1795852554038; Fri, 27 Nov 2026
 23:55:54 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHRsBfbYF3wocif+a0FRyBBkhcL+FtKF2qm=ne0jgLCzL8cH9w@mail.gmail.com>
 <20261126064837.GK191152@black.igk.intel.com>
In-Reply-To: <20261126064837.GK191152@black.igk.intel.com>
From: Marco Sousa <marcomsousa@gmail.com>
Date: Sat, 28 Nov 2026 08:55:43 +0100
X-Gm-Features: Aa3M54qVCZFzqsln3X3EFb6qatltE77kahQwCRZkEP5b7Rdkr7RdfwKSk37SX6o
Message-ID: <CAHRsBfYO6pLC4Lu80u+Z2arEhEmAWx21_xe7PzGq5Twh9OP8nw@mail.gmail.com>
Subject: Re: [BUG] AMD Strix Point USB4 (1022:150a): mid-s2idle pciehp hot-add
 causes D3cold->D0 failure and hard hang
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, westeri@kernel.org, bhelgaas@google.com, 
	lukas@wunner.de, rafael@kernel.org, superm1@kernel.org, 
	Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika,

Thanks for the quick reply!

1. BIOS version:
   Confirmed, UM5606WA.321 (built 2025-10-14, published 2025-11-20 on
ASUS Support) is the latest official BIOS for the ASUS Zenbook S 16
UM5606WA.

2. ACPI dump & _DSD check:
   I captured an acpidump (MSDM stripped) and extracted the relevant
   INTGPPC_ SSDT ASL blocks and attached both to Bug 222327:
     https://bugzilla.kernel.org/show_bug.cgi?id=3D222327

   Quick summary of what is in SSDT "INTGPPC_" for GPP0 (0000:00:01.1)
   and NHI0 (0000:c6:00.5):
   - \_SB.PCI0.GPP0 (and GPP1) has all four _DSD UUIDs:
     * fdf06fad-f744-4451-bb64-ecd792215b10:
FundamentalDeviceResetTriggeredOnD3ToD0 =3D 1
     * 6211e2c0-58a3-4af3-90e1-927a4e0c55a4: HotPlugSupportInD3 =3D 1
     * efcc06cc-73ac-4bc3-bff0-76143807c389: ExternalFacingPort =3D 1, UID =
=3D 0
     * daffd814-6eba-4d8c-8a91-bc9bbf4aa301: usb4-host-interface =3D
\_SB.PCI0.GPPC.NHI0, usb4-port-number =3D 1
     * _S0W returns \P4D3 (0x04 / D3cold), _PRW returns {0x1A, 0x04},
       _PR0/_PR3 =3D PWRS (dummy PW3S flag).
   - \_SB.PCI0.GPPC.XHC3.RHUB.PRT2 (and XHC4) also has usb4-host-interface
     pointing to NHI0 (and NHI1).
   - \_SB.PCI0.GPPC.NHI0 (and NHI1) has NO _DSD block at all; _S0W returns
     \G5D3 (0x04), _PRW returns {0x1A, 0x00} (comment says {0x1A, 0x04}),
     and _PS3 calls CpmSendPmeTurnOff(0, 1, 1) + \_SB.ALIB(0x14, 1).
   - \_GPE._L1A exists and emits Notify(..., 0x02) on GPPC, NHI0/1,
     XHC0/3/4, GPP0/1, and SWUS. However, in Linux
     /sys/firmware/acpi/interrupts/gpe1A shows:
       0  EN  enabled  unmasked
     =E2=80=94 GPE 0x1A never fires when tb_tunnel_pci() activates 0:5 <-> =
2:9
     while 0000:00:01.1 is in D3cold.

Mario / Shyam =E2=80=94 could you check the attached acpidump / INTGPPC_
excerpt on Bug 222327 to see if the USB4 power-contract / GPE 0x1A
wake wiring is complete, or if something is missing in ASUS BIOS 321?

Thanks,

-------------------------------------
Marco Sousa

El jue, 26 nov 2026 a las 7:48, Mika Westerberg
(<mika.westerberg@linux.intel.com>) escribi=C3=B3:
>
> Hi,
>
> On Wed, Nov 25, 2026 at 10:40:56PM +0100, Marco Sousa wrote:
> > Hi all,
> > I filed a bug report with full sanitized dmesg logs, lspci topology,
> > controlled A/B test results, and a thunderbolt.dyndbg=3D+p boot log her=
e:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=3D222327
> >
> > Short summary:
> > On an ASUS Zenbook S 16 UM5606WA (AMD Ryzen AI 9 HX 370 / Strix Point,
> > BIOS UM5606WA.321, s2idle-only) docked to an HP Thunderbolt Dock G4
> > (Intel Goshen Ridge 8086:0b26 + igc 8086:5502), reproduced on vanilla
> > 6.18.65-lts and 7.2.4..7.3.6-arch1-1:
> >
> > 1. At boot, tb_acpi_add_link() creates the device link from 0000:00:01.=
1
> >    [1022:150a] (consumer) to 0000:c6:00.5 [1022:151c] (supplier):
> >      [ 5.005536] thunderbolt 0000:c6:00.5: created link from 0000:00:01=
.1
> > 2. Host router reset tears down the firmware PCIe tunnel:
> >      [ 5.008763] thunderbolt 0000:c6:00.5: 0: resetting
> >      [ 5.008813] pcieport 0000:00:01.1: pciehp: Slot(0): Link Down
> >      [ 5.008895] pcieport 0000:00:01.1: pciehp: Slot(0): Card not prese=
nt
> >    0000:00:01.1 then runtime-suspends into D3cold (power resource
> >    \_SB_.PCI0.GPP0.PWRS).
> > 3. After dock authorization, tb_tunnel_pci() activates the PCIe tunnel
> >    cleanly:
> >      [ 9.429077] thunderbolt 0000:c6:00.5: 0:5 <-> 2:9 (PCI): activatin=
g
> >      [ 9.430721] thunderbolt 0000:c6:00.5: PCIe Down path activation co=
mplete
> >      [ 9.432080] thunderbolt 0000:c6:00.5: PCIe Up path activation comp=
lete
> >    Yet 0000:00:01.1 remains asleep in D3cold and never wakes to enumera=
te
> >    0000:01:00.0 / 0000:60:00.0 (igc).
> > 4. On the first s2idle entry, pci_pm_suspend() runtime-resumes
> >    0000:00:01.1 mid-suspend, invoking pciehp_runtime_resume() ->
> >    pciehp_check_presence() concurrently with device_suspend:
> >      pci 0000:01:00.0: PM: parent 0000:00:01.1 should not be sleeping
> >      pcieport 0000:02:0x.0: Unable to change power state from D3cold
> > to D0, device inaccessible
> >      pcieport 0000:02:0x.0: pciehp: Slot #8191 ... /
> > pcie_do_write_cmd: no response from device
> >      igc 0000:60:00.0: PCIe link lost, device now detached
> >    Entering s2idle in this unenumerated/wedged state causes a complete
> >    hard hang requiring a ~30 s power-button EC reset.
> > 5. Controlled A/B proof on 7.3.6: waking 0000:00:01.1 from D3cold once
> >    before suspend (power/control=3Don + lspci, then restoring auto) mak=
es
> >    pciehp immediately see Slot(0): Card present / Link Up, enumerates
> >    0000:01:00.0 + igc, and makes s2idle 100% reliable with full hardwar=
e
> >    S0i3 residency (11-27 s, Last S0i3 Status: Success).
> >
> > Also attached on Bug 222327 is a secondary drivers/thunderbolt/nhi.c:14=
3
> > (ring_interrupt_active) WARNING + Call Trace seen on dock hot-unplug.
> >
> > I have the hardware on my desk and am happy to write and test a patch.
> > Could you advise where the proper fix belongs?
>
> I would start checking if you are running the latest BIOS for this machin=
e?
> This pretty much sounds like that something is mising on the BIOS side. T=
he
> AMD guys that are in Cc: hopefully can help to check if the "power
> contract" _DSD is in place. It looks like it from the above but better to
> check.
