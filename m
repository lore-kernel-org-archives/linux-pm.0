Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970672;
	b=y9YgWQrmvvtbQ4hXI3j/eBTSKIw9r1ym8bYmgs2WNHx9iSvjtFFq1QCqMpl534oe4MPF
	 eKCFtYte+3oHiWJgjzfjlnt+G+A6B3VQTVz26j2lZttW0leNIkjfZezSYv0ZLAYOfH7q8
	 P2gDlDDqN+6nhsFR4rsu8h0xAIxVLzTDQR35Njyb5RyMWnNRlYyVaUzMgAcRDm9LdB6d1
	 edwCo+grOHlJ0RwWOTJJDgUU8rP7eldwc9fcMjmUe5vmS3AOCpt2fSqnoVoiuV4TdEkXo
	 NwgWVRQh6OxhDGPWACqybMvsngfAhKrqYpq+MbckgoyFtt8S3YrNx2iYnJeZ2+QcZgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Message-ID:Subject:To:Cc:In-Reply-To:References:MIME-Version:
	 Date:Content-Type:Content-Transfer-Encoding;
	bh=bO2RWsrTZU9/8/kLKqxB4AnDL75UPDOIFIHs0b1+ZVs=;
	b=P+7cjuzbStSGWX4XtLbR3xBtMGbSrZHiQOlxPmjgfKnZCWXUaiLOqw8jPz/QD24TMeDV
	 wfpau2eX6EtVMwL/85mAIG+xndxwCe3gUhdqNZwNl8EYQWSP5slQS72oL7pWR8d3E2OHy
	 syDcLf2tVuTcS9rzkcLdebwbMep0ryuzzSAqlTYwl1k5LyFYW3yvVxWJ2VkXTMgfrUVPP
	 26n9Dx18wuEVWrmDz7iENRtnnnvTf0fd+blJ80sumOXaDH0nM5RV/5uoEzMY7PMlFRlsK
	 nRTjhT5/gWUeyDhHrKkvsE0bSjPlbQVs43EOIXzbemKW4ULjs+JzH9Br7xRgUZTFNow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bp2g527/";
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCAA606A337
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 02:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCAA606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bp2g527/
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so727770c88.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 18:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794970671; x=1795575471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:cc:to:subject:message-id:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bO2RWsrTZU9/8/kLKqxB4AnDL75UPDOIFIHs0b1+ZVs=;
        b=bp2g527/ARbDwTJJQ6GrosRpfFohK/WyRrzMxTKTetMG+BYP7QN9BV6t6W0A5ERLEH
         eI3YKVNWz39t1JQ3DohuDz2PlpJv7YGg3y9b9852AnnC6S/ezbeTWOWZd8dsF5rCAM7i
         tATIN/lUIAq52xeF5ohr/xtI386yiTqCAlXTSEgSf6h/7NKvNHRRidJ8In3hpIyVhu0g
         ZSqrGqk61+a6gnvHPxlGXJnxFUW20HhpVoe2APUn2JTUBWCg4LqcVdmENOaQLoMoxFIY
         bo0kWCm8rCJbDT3hsgv3yl0ZG5A7fZDOgF540hGAbJO9x3ZkjQJTAnizil5FXPmcbmzS
         Ancw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794970672; x=1795575472;
        h=content-transfer-encoding:content-type:date:mime-version:references
         :in-reply-to:cc:to:subject:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bO2RWsrTZU9/8/kLKqxB4AnDL75UPDOIFIHs0b1+ZVs=;
        b=kkGCdM8EhRUW97salJseN3c9nwx74HRiIm9caGnxbnH7n/IW3sXvcGmOytohdPZ8DE
         4WpSnv9kUaXuA1R2eStzIUsP8NhFTPP/jRD69qTKziN68qHfy3FC7Jv225YHGHVZTp1f
         Eb87CaEkxFlmU4Rfg5VDExtQ0x2dN0p3wakyWiwwYpY3bfY8YPmnKPCdK3HT6kw+W7kt
         Uq2MEfZvQV6A/OeQRxhWBkFjBb1etMTqmPfA1Oc0naj6T8dkQkfKdxymAbsink4Fs+ZV
         HFXW0sgdvIo2/BXqdTHFYsPHuectnnhJpDO/yx9V6FxueMnCNZK7l/2uZqlKKrHua3rw
         XLlg==
X-Forwarded-Encrypted: i=1; AL+hErHo5jT2hBt+8AdsVFZY7AF4TEPCE4E6vHz7Q6/kYby7Xm/mnSLs8UNHB/vHb3vCEYilofg/0t+oeQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8spDYZ+6yL2IAy+pk1p5wWyJoDajD51ifodbmZKtwdWK+3bBTL
	ucXeNzLs/UuF6vMq4qFHaszLfIwY9XLaJBamIFW6DmguPlK1zTstF+3jmMiQ6l4EmzI=
X-Gm-Gg: AYBFou1FMpqMNqpOhLYi5z1u7zFKYc/0G2gRhHdCDbimjo1tZw+eLcC1pCDboCjkBUO
	dOGVMJuLpYgmtmJHYvVqdd7vzz7gPfDbO7LDi5p0BxeOIf2eHVP9FlbhXxLjHvWwol3oDVECxOg
	iXM+bwypSBsRe/TU/lnSqcnGT9dNBfKP9HyRdBePXiioM8d9+vY2yA60JV+45DCoZ5xtEaWOkp/
	XouUeePzdnpWSXl+P0kp8sAYrGDT6WFP6lLXYnyHf96s4Di8b1P4D0pE+XS33fE2eTrygh/5bST
	sWChIfgo9DuhmmmrKfne01EyXy2prisYtWTmcf0CPQcu/e0sm7KHGuzQviZ6MzXHLGcVRWKRR+A
	SzKX4U0QBWGkvjbrtxU/nq8WM5RH/NQD6JsyBloxmkbokblQhJMV0RWH/D/rEuKRNNOSAkQqNVJ
	rvWDzxmwxj0tNmfTGRlFCkpsIwULsZtciGT0i4yacNdf9SInuCMQxFiwUp/OoYTUlnlSZwzfUUY
	tI2tSOo1KV1YiLd/5zcpDmRj0TZZdXZvjD8OBUcKDOS81E8LKZ9NBYw7MFo8//JHyxpQNM9WEMZ
	QVWez3gUCCxyiqsi0xkSNsKgFGDC0A67XA46zGsURnzKia9T/kxl19g0CTpvdHWIdN8k45xAc60
	UUOtJkO70M+tgGj1XnibvqVlTBpZ+
X-Received: by 2002:a05:701b:2718:b0:1b2:6a1d:bf58 with SMTP id a92af1059eb24-1b543d4b410mr1535044c88.38.1794970671342;
        Tue, 17 Nov 2026 18:57:51 -0800 (PST)
Received: from [127.0.0.1] (ip68-107-67-45.sd.sd.cox.net. [68.107.67.45])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5446f589esm2621578c88.1.2026.11.17.18.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:57:50 -0800 (PST)
From: jasmeet.bhatia.us@gmail.com
Message-ID: <b66f68b5220ddcadddb41340d3ea3388@gmail.com>
Subject: Re: [PATCH v1 0/2] efi/tpm: Preserve event log without changing x86
 E820
To: ilias.apalodimas@linaro.org
Cc: ardb@kernel.org, rafael@kernel.org, pavel@ucw.cz, linux-efi@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
References: <cover.1788259938.git.jasmeet.bhatia.us@gmail.com>
 <a9e23066-aa75-44be-ac3b-9a15f4cf6047@app.fastmail.com>
 <DL6NCV1KQ9F9.6K6XZQCS4AF3@gmail.com>
 <c3ca811b-a6eb-4f4d-bbb2-4feef02e3db2@app.fastmail.com>
 <CAC_iWjL9jDsRaU7kEemYfwk292Nxa49cK0Rq=81pC=FWNRDhvg@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 02:57:49 +0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ard and Ilias,

I wanted to follow up on this discussion after a couple of months.=20
My bad at being slow, at keep this discussion moving.

Has there been any more considerations with the preferred approach,=20
regarding the EFI TPM event log reference and kexec?=20

This issue is still relevant to Framework 16 owners and the temporary
fix has been confirmed to work for other users despite not being a=20
proper fix to this issue.

I'm always happy to prepare and test any patches once we decide what=20
direction we want to move forward towards!

I appreciate you time and patience!

Thanks

Jazz

On Mon Sep 7, 2026 at 8:57 AM -07:00, Ilias Apalodimas wrote:
> Hi Ard,
>=20
> On Fri, 4 Sept 2026 at 19:39, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> >
> >
> > On Fri, 4 Sep 2026, at 17:45, Jasmeet (Jazz) Bhatia wrote:
> > > On Thu Sep 3, 2026 at 7:18 AM PDT, Ard Biesheuvel wrote:
> > >> Hi Jazz,
> > >>
> > >> On Tue, 1 Sep 2026, at 13:34, Jasmeet (Jazz) Bhatia wrote:
> > >>> The EFI stub currently allocates the TPM event log as
> > >>> EFI_ACPI_RECLAIM_MEMORY. On x86, this becomes an ACPI data entry
> > >>> in the E820 map.
> > >>>
> > >>> On a Framework Laptop 16 (AMD Ryzen AI 300 Series), the EFI allocat=
or
> > >>> can place this allocation at different physical addresses across bo=
ots.
> > >>> Since x86 hibernation validates architecture-specific data from
> > >>> the firmware E820 map, this causes an otherwise valid hibernation i=
mage
> > >>> to be rejected on resume with the following error:
> > >>>
> > >>>   Hibernate inconsistent memory map detected!
> > >>>   PM: hibernation: Image mismatch: architecture specific data
> > >>>
> > >>> Allocating the event log as EFI_LOADER_DATA avoids changing the E820
> > >>> map, but doing that alone would regress the kexec corruption issue =
fixed
> > >>> by commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for e=
vent
> > >>> log to avoid corruption").
> > >>>
> > >>
> > >> As I replied in the other thread, I am not convinced preserving the =
TPM
> > >> event log across a kexec makes sense to begin with. This is the firm=
ware's
> > >> view of the state of the TPM PCRs when it handed over the system to =
the
> > >> first OS.
>=20
> It doesn't make sense imho. The only thing you prove is that you
> kexeced from a 'previous good OS', but without knowledge of what that
> OS did before kexecing.
>=20
> > >>
> > >> If the first OS boots, loads a kexec kernel and then boots it without
> > >> measuring any of that into the TPM, the TPM event log will match the
> > >> TPM state, but this is meaningless because of the missing measuremen=
ts,
> > >> and the attestation chain is broken.
> > >>
> > >> If the first OS does perform TPM measurements, it would need to reco=
rd
> > >> them into a log and pass that on to the kexec'ed in some implementat=
ion
> > >> specific way - it cannot use the existing TPM event log for that.
>=20
> Hrmm, that might be problematic. The EventLog needs to illustrate the
> state of the TPM PCRs. IOW replaying the EventLog in memory should
> match the current TPM PCRs. But that also means we'll have to teach
> kexec how to properly extend the PCRs and update the EventLog.
>=20
> > >>
> > >> TL;DR perhaps we should just discard the TPM event log reference from
> > >> the EFI config tables after consuming it. Or add a special case to t=
he
> > >> kexec code to disregard it.
>=20
> I can't decide what's best here. IIRC we don't expose the final event
> log config table in systab right? So we won't break any user-space app
> that depends on it.  We just copy it in
> /sys/kernel/security/tpm0/binary_bios_measurements. In that case
> getting rid of it would work.
>=20
> Cheers
> /Ilias
>=20
> > > Ok, honestly that makes a lot of sense I see what you are saying and I
> > > tend to agree. I'm treating the copied event log at something that
> > > survives kexec in this patch because of the corruption fix so I'll lo=
ok
> > > at dropping that LINUX_EFI_TPM_EVENT_LOG_GUID reference and rewrite t=
his
> > > patch. Hopefully, that will avoid that x86 E820 instability as well.
> > >
> > > Appreciate the guidance!
> >
> > Please don't send any patches yet - I'd like to get some input from oth=
er
> > folks as well.
> >

