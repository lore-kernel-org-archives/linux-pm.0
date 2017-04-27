From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 09/29] x86: assembly, use DATA_SIMPLE for data
Date: Thu, 27 Apr 2017 14:30:05 +0200
Message-ID: <84fc78c7-3a70-bf74-aa2c-c8b59e2adb3e@suse.cz>
References: <20170421141305.25180-1-jslaby@suse.cz>
 <20170421141305.25180-9-jslaby@suse.cz> <20170427115358.GB23352@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tEgN2to0Id5UTltsC96D9h9GJ0Umk06Be"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36232 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965424AbdD0MaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Apr 2017 08:30:12 -0400
In-Reply-To: <20170427115358.GB23352@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tEgN2to0Id5UTltsC96D9h9GJ0Umk06Be
Content-Type: multipart/mixed; boundary="oCoKR29dNAN1ad892RxwdB4vWe6pwNSlL";
 protected-headers="v1"
From: Jiri Slaby <jslaby@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
 jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org
Message-ID: <84fc78c7-3a70-bf74-aa2c-c8b59e2adb3e@suse.cz>
Subject: Re: [PATCH v3 09/29] x86: assembly, use DATA_SIMPLE for data
References: <20170421141305.25180-1-jslaby@suse.cz>
 <20170421141305.25180-9-jslaby@suse.cz> <20170427115358.GB23352@amd>
In-Reply-To: <20170427115358.GB23352@amd>

--oCoKR29dNAN1ad892RxwdB4vWe6pwNSlL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 04/27/2017, 01:53 PM, Pavel Machek wrote:
>> @@ -91,11 +91,11 @@ ENDPROC(do_suspend_lowlevel)
>> =20
>>  .data
>>  ALIGN
>> -ENTRY(saved_magic)	.long	0
>> -ENTRY(saved_eip)	.long	0
>> +SYM_DATA_SIMPLE(saved_magic, .long 0)
>> +SYM_DATA_SIMPLE_LOCAL(saved_eip, .long 0)
>> =20
>>  # saved registers
>> -saved_idt:	.long	0,0
>> -saved_ldt:	.long	0
>> -saved_tss:	.long	0
>> +SYM_DATA_SIMPLE_LOCAL(saved_idt, .long 0,0)
>> +SYM_DATA_SIMPLE_LOCAL(saved_ldt, .long 0)
>> +SYM_DATA_SIMPLE_LOCAL(saved_tss, .long 0)
>=20
> Do we really need to mark local data like that? It complicates the
> source code a bit...

Not really -- if the preferred way is not to annotate local symbols, I
can indeed remove that.

thanks,
--=20
js
suse labs


--oCoKR29dNAN1ad892RxwdB4vWe6pwNSlL--

--tEgN2to0Id5UTltsC96D9h9GJ0Umk06Be
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCAAtFiEE1pWBVg1LlveO4uo2vSWxBAa0cEkFAlkB5E0PHGpzbGFieUBz
dXNlLmN6AAoJEL0lsQQGtHBJHMQP/R/R4pfB1E2Jkqdi/81SFvm/fpl12lEoevtM
DW6cVtL3yX3FMAWoEXwN3HjwWVAyiAa+4lzfHb8AygdGg8EAttVmUwzbcxwdAgk8
yvW3HKlNkriEKwggIA5rFNhPXKeK4kSe49hNFqILS+DAuzM+M2mkZENKznWcHlpR
7jSoT9z6cplZSq4G5OoXl4YTMZOI9BzRNcSfcU6GeVPqA1ePFivdqg9MY1soQp0f
Aijl6JTfWBCLOZRYD8JLr6FtiF877wlmTybftXjsW/R8d5hECN8YU5m8C4Ddphqv
I4gfImxvfkuyqyAkwMWoA1wE9hPWHCFVni7+0pkQAEC96MfAeAy64ZWqyCiDBvmY
BpUgpiSX7ml7SeN0xABD0N8Os89P6p+oR49ch3hrmsU1DufGereuFxZigiR9iJim
7pf+EXgMp6EMsfgIvEHnGWsh04ukWU8DyAH49orH104a4RYU3bRkm5dzYZENnsa7
hu0UNB+ImgA6pCXNo0wLernZ51D7CIGk/LkQMp5EXNh2lBzFVpyURz7q21uQO4rw
ZxPpkHVnhsBaqDCDc2FWI8x3irqzUfgPsihU9C5A73R4hzp7Wz42Rx5Mv62U8vTN
xB5VnzI1bcgwgseu3MuOptro0vBMSgcoMMYjtrKBC0k+WDPduamgcS2u1Emi6ZDO
ZUxAfr0y
=oD+I
-----END PGP SIGNATURE-----

--tEgN2to0Id5UTltsC96D9h9GJ0Umk06Be--
