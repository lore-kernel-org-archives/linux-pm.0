Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379526;
	b=1haMehnw+/+KMICw7h5VSghHFEJ8XITIgvl1II2BXMlVhclOLhE5qFSAPrY64Ry4Ugku
	 ESnJpHPEeOE7JlfM+UdlxgEZB44yjcoevvMUEoVn5mNMfPj/pFqbTDPITutAORfV/80si
	 2Fc1pZDfkBC3M8XXD0a9EqLq39zfyh3xJryb6iwc9n5ALfMduBZI7nx2I6KO4cDUB4/j9
	 ziWed4cExXa8SkhykG2si0+kfaEV22ql9DO5YLeBifsNQjIdlDB8ab60DPf+P9WDrpjqR
	 LoApF85UPomGPZWJiZ9wPqpLWtZ509vBxQt8RpqJNBS+mR2HXrUiOy4LjkmuiCOdIOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379526;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:User-Agent:
	 MIME-Version;
	bh=RtkirHt5/YD+oe8OAJwr919Zv1gSNk+o54maeN1QaGY=;
	b=uOy3WB0lCx2PqR3x1P9hIOedLqOfbwsbDklzBNaQTRUwAvvVPa8QsaZEqOBmekkodvJ5
	 w/DN2Q0ezimToSYbcibUh/uizbTIbP8G4qpZEpxz9aySKpXt1A6tRZl07/ACKxOXRCtW6
	 fBS2qkYxtzY3aQXVYiGYUjIAYHUDJAqhxt6REY3UwboaHXDnVdCFEU1YmeTyWoOYYVVob
	 FSQpKeIGMlZN/sLQYECuOiTYvp+sbImtymLUg3KXFKtd3bKjZHhXFdTGSQbDpXXw6pnor
	 ZaSpErITek2xrtGnw4/sfpapabREIO42gjorZIYXxDm5lveVOyiusZayETsb3taLF9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P5KmmLHZ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943A606A31D;
	Fri, 30 Oct 2026 16:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4943A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P5KmmLHZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793379525; x=1824915525;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version;
  bh=fbKI7GsRK4tsem/uOS4eN5gWm8zfQ5EaLrohyMugku4=;
  b=P5KmmLHZVUZ1+0Ryz+5lCr2smX2BY1cfLIv/sA3EmxS/6US0tlzobeIY
   QDeDli8FgsFvtPsIa3RlYrKkKtzKrqtPFrxBzTmd26sO67AUeDCPSf3WQ
   Htvksor+i2xo3TvA5dc9xLVrIYrBTClS1O87ECKq+YzXjsPs3Q68NwFY5
   li8bYR8GIE9yrTN4btNoMMyEFn90QPV7pO9go9vkLWJ7YprGkFi26aeLL
   jhQj9XyUNqjHaF/sGh1q3kGLBii8mKgZMN/qm19zi/ZWoB5ylQgjm8ug0
   CRKdmDHTIAjwSvqoS//8MANlRB3kwB3pSuA/bzKfH+L1w29g7z9ZjhR6T
   g==;
X-CSE-ConnectionGUID: hw23RWDqS56mIZ1A3A6Uxg==
X-CSE-MsgGUID: bac4jdt9QkuMj4PZPrYW8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2173103"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208,223";a="2173103"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:58:40 -0700
X-CSE-ConnectionGUID: op7+zwtNReK/rp7PG0N3Sg==
X-CSE-MsgGUID: UCU7dhWMQqqBEvJR4wiK6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208,223";a="5611956"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 09:58:40 -0700
Message-ID: <e98e2aeef6414b4159509ecdee78c5347b516d9a.camel@linux.intel.com>
Subject: Re: platform_profile: power-saver lost on Panther Lake when SoC
 Power Slider and dell-pc are both bound (low-power vs quiet)
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: verazimmerman1987 <verazimmerman1987@proton.me>, "rafael@kernel.org"
	 <rafael@kernel.org>
Cc: "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, 
 "rui.zhang@intel.com"	 <rui.zhang@intel.com>, "superm1@kernel.org"
 <superm1@kernel.org>,  "lsanche@lyndeno.ca"	 <lsanche@lyndeno.ca>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
 "linux-acpi@vger.kernel.org"	 <linux-acpi@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org"	 <platform-driver-x86@vger.kernel.org>
Date: Fri, 30 Oct 2026 09:58:39 -0700
In-Reply-To: <UPfoGdnS1R04q8uekSMTyes9PbDuvsGeBE42zHmsjD2xIdfPYx7ejdcpZhrxWFq6uwoMvClHTuHbrwaCh3yxD0Rw7OarNABC4dZsDra44mk=@proton.me>
References: 
	<UPfoGdnS1R04q8uekSMTyes9PbDuvsGeBE42zHmsjD2xIdfPYx7ejdcpZhrxWFq6uwoMvClHTuHbrwaCh3yxD0Rw7OarNABC4dZsDra44mk=@proton.me>
Content-Type: multipart/mixed; boundary="=-XKdDHd9Tfa/sZgQ8zD89"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-XKdDHd9Tfa/sZgQ8zD89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vera,

Please test the attached patch.

I need with first and last name with email address to add Reported-by
and Tested-by.

Thanks,
Srinivas

On Fri, 2026-10-16 at 17:10 +0000, verazimmerman1987 wrote:
> Hi,
>=20
> On a Dell XPS 14 (2026, Panther Lake, Core Ultra X7 358H) two
> platform
> profile handlers are registered, and their choices have no common
> low-power option, so the legacy /sys/firmware/acpi/platform_profile
> interface exposes only "balanced performance". As a result
> power-profiles-daemon cannot select a low-power firmware mode in
> power-saver.
>=20
> Handlers:
>=20
> =C2=A0 platform-profile-0=C2=A0 name: SoC Power Slider
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices: low-power b=
alanced performance
> =C2=A0 platform-profile-1=C2=A0 name: dell-pc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 choices: cool quiet =
balanced performance
>=20
> =C2=A0 /sys/firmware/acpi/platform_profile_choices: balanced performance
>=20
> Effect: power-saver in power-profiles-daemon leaves both handlers at
> "balanced". The Dell firmware stays in its "optimized" mode, so
> thermald --adaptive keeps applying the optimized DTT table (PL1
> 19-25 W) instead of the quiet/cool tables (PL1 15-19 W, lower skin
> temperature targets). Setting the handlers individually
> (dell-pc=3Dquiet, SoC slider=3Dlow-power) works and thermald picks the
> "quiet" target, but the legacy file then reports "custom" and
> power-profiles-daemon falls back to "balanced", so there is no
> consistent way to use it.
>=20
> This looks like the same class of problem as amd-pmf + asus-wmi,
> which was solved by adding "quiet" as a hidden choice in amd-pmf
> (commit 44e94fece517, "platform/x86/amd: pmf: Add 'quiet' to hidden
> choices"). Would a similar hidden "quiet" (and perhaps "cool") choice
> for the Intel SoC Power Slider, mapped to its low-power setting, be
> acceptable? I'm happy to test patches.
>=20
> System:
> =C2=A0 Kernel: 7.2.9-arch1-1
> =C2=A0 DMI: Dell Inc. XPS 14 DA14260, BIOS 1.11.0
> =C2=A0 power-profiles-daemon: 0.30-1
> =C2=A0 thermald: 2:2.5.13-1
>=20
> Thanks,
> Vera

--=-XKdDHd9Tfa/sZgQ8zD89
Content-Disposition: attachment;
	filename*0=0001-thermal-intel-int340x-Add-quiet-to-hidden-choices-of.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-thermal-intel-int340x-Add-quiet-to-hidden-choices-of.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA0YzhiZjk0ZDRmYTdkODA4ZWU5ZWJkNDVkNTM4OGExMmI4Y2JlNTc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogRnJpLCAzMCBPY3QgMjAyNiAwOTo0ODozNyAtMDcw
MApTdWJqZWN0OiBbUEFUQ0hdIHRoZXJtYWw6IGludGVsOiBpbnQzNDB4OiBBZGQgJ3F1aWV0JyB0
byBoaWRkZW4gY2hvaWNlcyBvZiBTb0MKIHBvd2VyIHNsaWRlcgoKT24gUGFudGhlciBMYWtlIHN5
c3RlbXMsIHRoZSBTb0MgUG93ZXIgU2xpZGVyIHJlZ2lzdGVycyBhIHBsYXRmb3JtCnByb2ZpbGUg
aGFuZGxlciBhbG9uZ3NpZGUgdGhlIHZlbmRvciBwbGF0Zm9ybSBwcm9maWxlIGRyaXZlci4gVGhl
IHR3bwpoYW5kbGVycyBzaGFyZSBubyBsb3ctcG93ZXIgY2hvaWNlLCBzbyB0aGUgbGVnYWN5Ci9z
eXMvZmlybXdhcmUvYWNwaS9wbGF0Zm9ybV9wcm9maWxlIGludGVyZmFjZSwgd2hpY2ggb25seSBl
eHBvc2VzIHRoZQppbnRlcnNlY3Rpb24gb2YgYWxsIGhhbmRsZXJzJyBjaG9pY2VzLCBvZmZlcnMg
b25seSAiYmFsYW5jZWQKcGVyZm9ybWFuY2UiLgoKRm9yIGV4YW1wbGUsIG9uIEFTVVMgR1U2MDZB
VyAoYWxzbyByZXBvcnRlZCBvbiBHVTYwNkFYKToKCiAgU29DIFBvd2VyIFNsaWRlcjogbG93LXBv
d2VyIGJhbGFuY2VkIHBlcmZvcm1hbmNlCiAgYXN1cy13bWk6ICAgICAgICAgcXVpZXQgYmFsYW5j
ZWQgcGVyZm9ybWFuY2UKCmFuZCBvbiBEZWxsIFhQUyAxNCAoMjAyNiwgQ29yZSBVbHRyYSBYNyAz
NThIKToKCiAgU29DIFBvd2VyIFNsaWRlcjogbG93LXBvd2VyIGJhbGFuY2VkIHBlcmZvcm1hbmNl
CiAgZGVsbC1wYzogICAgICAgICAgY29vbCBxdWlldCBiYWxhbmNlZCBwZXJmb3JtYW5jZQoKQXMg
YSByZXN1bHQsIHRoZSBRdWlldCBtb2RlIGNhbid0IGJlIHNlbGVjdGVkIHRocm91Z2ggYXN1c2N0
bCBvciB0aGUgRm4Ka2V5IG9uIEFTVVMgc3lzdGVtcy4gcG93ZXItcHJvZmlsZXMtZGFlbW9uIGNh
bid0IHNlbGVjdCBhIGxvdy1wb3dlcgpmaXJtd2FyZSBtb2RlIGluIHBvd2VyLXNhdmVyIGVpdGhl
ci4KCkZvbGxvdyB0aGUgc2FtZSBhcHByb2FjaCBhcyBjb21taXQgNDRlOTRmZWNlNTE3ICgicGxh
dGZvcm0veDg2L2FtZDogcG1mOgpBZGQgJ3F1aWV0JyB0byBoaWRkZW4gY2hvaWNlcyIpIGFuZCBh
ZGQgJ3F1aWV0JyBhcyBhIGhpZGRlbiBjaG9pY2UgdGhhdAptYXBzIHRvIHRoZSBzYW1lIHNsaWRl
ciB2YWx1ZSBhcyAnbG93LXBvd2VyJy4gV2l0aCB0aGlzLCB0aGUgbGVnYWN5CmNob2ljZXMgYmVj
b21lICJxdWlldCBiYWxhbmNlZCBwZXJmb3JtYW5jZSIgb24gYm90aCBzeXN0ZW1zLgoKVW5saWtl
IGFtZC1wbWYsIHRoaXMgZHJpdmVyIGRlcml2ZXMgdGhlIGN1cnJlbnQgcHJvZmlsZSBmcm9tIHRo
ZQpoYXJkd2FyZSBzbGlkZXIgdmFsdWUuIFNvIHJlbWVtYmVyIHRoZSBsYXN0IHJlcXVlc3RlZCBw
cm9maWxlLCBzbyB0aGF0CidxdWlldCcgaXMgcmVwb3J0ZWQgYmFjay4gT3RoZXJ3aXNlIHRoZSBs
ZWdhY3kgaW50ZXJmYWNlIHdvdWxkIHNob3cKImN1c3RvbSIuCgpGaXhlczogMGQ1MGY0ZDZlYzVh
ICgidGhlcm1hbDogaW50ZWw6IGludDM0MHg6IEFkZCBzdXBwb3J0IGZvciBwb3dlciBzbGlkZXIi
KQpDbG9zZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9PcGVuR2FtaW5nQ29sbGVjdGl2ZS9hc3VzY3Rs
L2lzc3Vlcy8zODcKU2lnbmVkLW9mZi1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMu
cGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+Ci0tLQogLi4uL3Byb2Nlc3Nvcl90aGVybWFsX3Nv
Y19zbGlkZXIuYyAgICAgICAgICAgIHwgMTkgKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW50
ZWwvaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX3NvY19zbGlkZXIuYyBiL2RyaXZl
cnMvdGhlcm1hbC9pbnRlbC9pbnQzNDB4X3RoZXJtYWwvcHJvY2Vzc29yX3RoZXJtYWxfc29jX3Ns
aWRlci5jCmluZGV4IDkxZjI5MTYyNzEzMi4uZGFhMjZmZjQ3MjNjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3Byb2Nlc3Nvcl90aGVybWFsX3NvY19z
bGlkZXIuYworKysgYi9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50MzQweF90aGVybWFsL3Byb2Nl
c3Nvcl90aGVybWFsX3NvY19zbGlkZXIuYwpAQCAtMTMyLDExICsxMzIsMTggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBrZXJuZWxfcGFyYW1fb3BzIHNsaWRlcl9vZmZzZXRfb3BzID0gewogbW9kdWxl
X3BhcmFtX2NiKHNsaWRlcl9vZmZzZXQsICZzbGlkZXJfb2Zmc2V0X29wcywgTlVMTCwgMDY0NCk7
CiBNT0RVTEVfUEFSTV9ERVNDKHNsaWRlcl9vZmZzZXQsICJTZXQgc2xpZGVyIG9mZnNldCIpOwog
CisvKgorICogTGFzdCBwcm9maWxlIHJlcXVlc3RlZCB2aWEgcGxhdGZvcm0gcHJvZmlsZS4gVXNl
ZCB0byByZXBvcnQgYmFjayAicXVpZXQiCisgKiBoaWRkZW4gY2hvaWNlLCB3aGljaCBtYXBzIHRv
IHRoZSBzYW1lIHNsaWRlciB2YWx1ZSBhcyAibG93LXBvd2VyIi4KKyAqLworc3RhdGljIGVudW0g
cGxhdGZvcm1fcHJvZmlsZV9vcHRpb24gc2xpZGVyX2N1cl9wcm9maWxlID0gUExBVEZPUk1fUFJP
RklMRV9CQUxBTkNFRDsKKwogLyogQ29udmVydCBmcm9tIHBsYXRmb3JtIHBvd2VyIHByb2ZpbGUg
b3B0aW9uIHRvIFNvQyBzbGlkZXIgdmFsdWUgKi8KIHN0YXRpYyBpbnQgY29udmVydF9wcm9maWxl
X3RvX3Bvd2VyX3NsaWRlcihlbnVtIHBsYXRmb3JtX3Byb2ZpbGVfb3B0aW9uIHByb2ZpbGUpCiB7
CiAJc3dpdGNoIChwcm9maWxlKSB7CiAJY2FzZSBQTEFURk9STV9QUk9GSUxFX0xPV19QT1dFUjoK
KwljYXNlIFBMQVRGT1JNX1BST0ZJTEVfUVVJRVQ6CiAJCXJldHVybiBzbGlkZXJfdmFsdWVzW1NP
Q19QT1dFUl9TTElERVJfUE9XRVJTQVZFXTsKIAljYXNlIFBMQVRGT1JNX1BST0ZJTEVfQkFMQU5D
RUQ6CiAJCXJldHVybiBzbGlkZXJfdmFsdWVzW1NPQ19QT1dFUl9TTElERVJfQkFMQU5DRV07CkBA
IC0yMTYsNiArMjIzLDcgQEAgc3RhdGljIGludCBwb3dlcl9zbGlkZXJfcGxhdGZvcm1fcHJvZmls
ZV9zZXQoc3RydWN0IGRldmljZSAqZGV2LAogCQlyZXR1cm4gc2xpZGVyOwogCiAJc2V0X3NvY19w
b3dlcl9wcm9maWxlKHByb2NfcHJpdiwgc2xpZGVyKTsKKwlzbGlkZXJfY3VyX3Byb2ZpbGUgPSBw
cm9maWxlOwogCiAJcmV0dXJuIDA7CiB9CkBAIC0yMzgsNiArMjQ2LDkgQEAgc3RhdGljIGludCBw
b3dlcl9zbGlkZXJfcGxhdGZvcm1fcHJvZmlsZV9nZXQoc3RydWN0IGRldmljZSAqZGV2LAogCWlm
IChyZXQgPCAwKQogCQlyZXR1cm4gcmV0OwogCisJaWYgKHJldCA9PSBQTEFURk9STV9QUk9GSUxF
X0xPV19QT1dFUiAmJiBzbGlkZXJfY3VyX3Byb2ZpbGUgPT0gUExBVEZPUk1fUFJPRklMRV9RVUlF
VCkKKwkJcmV0ID0gUExBVEZPUk1fUFJPRklMRV9RVUlFVDsKKwogCSpwcm9maWxlID0gcmV0Owog
CiAJcmV0dXJuIDA7CkBAIC0yNTIsOCArMjYzLDE2IEBAIHN0YXRpYyBpbnQgcG93ZXJfc2xpZGVy
X3BsYXRmb3JtX3Byb2ZpbGVfcHJvYmUodm9pZCAqZHJ2ZGF0YSwgdW5zaWduZWQgbG9uZyAqY2hv
CiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgcG93ZXJfc2xpZGVyX3BsYXRmb3JtX3Byb2Zp
bGVfaGlkZGVuX2Nob2ljZXModm9pZCAqZHJ2ZGF0YSwgdW5zaWduZWQgbG9uZyAqY2hvaWNlcykK
K3sKKwlzZXRfYml0KFBMQVRGT1JNX1BST0ZJTEVfUVVJRVQsIGNob2ljZXMpOworCisJcmV0dXJu
IDA7Cit9CisKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGxhdGZvcm1fcHJvZmlsZV9vcHMgcG93ZXJf
c2xpZGVyX3BsYXRmb3JtX3Byb2ZpbGVfb3BzID0gewogCS5wcm9iZSA9IHBvd2VyX3NsaWRlcl9w
bGF0Zm9ybV9wcm9maWxlX3Byb2JlLAorCS5oaWRkZW5fY2hvaWNlcyA9IHBvd2VyX3NsaWRlcl9w
bGF0Zm9ybV9wcm9maWxlX2hpZGRlbl9jaG9pY2VzLAogCS5wcm9maWxlX2dldCA9IHBvd2VyX3Ns
aWRlcl9wbGF0Zm9ybV9wcm9maWxlX2dldCwKIAkucHJvZmlsZV9zZXQgPSBwb3dlcl9zbGlkZXJf
cGxhdGZvcm1fcHJvZmlsZV9zZXQsCiB9OwotLSAKMi41Ni4wCgo=


--=-XKdDHd9Tfa/sZgQ8zD89--
