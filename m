Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830727BF7C;
	Fri, 13 Feb 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964216; cv=none; b=sqxizZSIWio5l500/M+fETWl5a6cPfZfahLLhb7QKeImzOrDUvOYHDYWAHNwcfBwQfHDcROzI8iLWymx3Fer4lYvUKA+0ef8FRtZXVgk1DWGF6Db2p+kKvcVQj6uvkO46SCpfSsFPf1O/HsWHv2xsl7kz6svjypGY1rX4ClkSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964216; c=relaxed/simple;
	bh=wV7DAzzqNuCCfLN5M5sE1fU0bi1iDDxhi3lmyRlyVUA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K+2L66n1vbuD2Xvefa/VBDiJ0wTy1kI0CVUFhTn2ykvZHbiEKc9R1SlR2PKHLx5rc55sqRIfcmupAVXcFxJOdZ5zacnpgGFJbHui3YqNZngkbAOO6cODimr/RUQ1cJIpsMqDO0CP1M6XZ8SGkJAgt8AJuFmxQ55QfFd7DcEclG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=JuV+mcgb; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="JuV+mcgb"
Received: from mail.crpt.ru ([192.168.60.4])
	by mail.crpt.ru  with ESMTPS id 61D6THmr005781-61D6THmt005781
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Fri, 13 Feb 2026 09:29:17 +0300
Received: from EX2.crpt.local (192.168.60.4) by ex2.crpt.local (192.168.60.4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Feb
 2026 09:29:16 +0300
Received: from EX2.crpt.local ([192.168.60.4]) by EX2.crpt.local
 ([192.168.60.4]) with mapi id 15.01.2507.044; Fri, 13 Feb 2026 09:29:16 +0300
From: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
	<a.vatoropin@crpt.ru>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ajay Thomas
	<ajay.thomas.david.rajamanickam@intel.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH] powercap: intel_rapl: use unsigned arithmetic in time window
 computation
Thread-Topic: [PATCH] powercap: intel_rapl: use unsigned arithmetic in time
 window computation
Thread-Index: AQHcnLITgGace02fqUu09hbfrEIEfA==
Date: Fri, 13 Feb 2026 06:29:16 +0000
Message-ID: <20260213062542.169365-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX2.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/12/2026 10:40:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2E4A1E7A9BB804996CBB031253A8987@crpt.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLVxYWC48UVlRWFhYWVxaSFlRSAlGHgkcBxoHGAEGKAsaGBxGGh1IWUhZX0gaCQ4JDQQoAw0aBg0ERgcaD0hYSFpIWVpIWVFaRlleUEZeWEZcSFBIWEhYSF1IWEhYSFhIXFhICQIJEUYcAAcFCRtGDAkeAQxGGgkCCQUJBgELAwkFKAEGHA0ERgsHBUhYSFpRSAIJCwcKRgIdBkYYCQYoBAEGHRBGAQYcDQRGCwcFSFhIWlBIBAEGHRBFAw0aBg0EKB4PDRpGAw0aBg0ERgcaD0hYSFpQSAQeC0UYGgcCDQscKAQBBh0QHA0bHAEGD0YHGg9IWEhZX0gaCQ4JDQQoAw0aBg0ERgcaD0hY
X-FEAS-Client-IP: 192.168.60.4
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=wV7DAzzqNuCCfLN5M5sE1fU0bi1iDDxhi3lmyRlyVUA=;
 b=JuV+mcgbnaq2toX2ekMlgl00Ln+BIqOpMHmI34HGVvFixqeg5COrjPt/Pb3PCw9O1M9KFPVyABc5
	d1anSOFCH3yZ4J6IygwWKWAUCfKx/uOFTvznFFJMNDpbVhwTHD//v94Dt0tz+VcUBeYER1Q2++iU
	4XKtadULpTSZ6BQW42fWGroOii5KEHVviDAlYZnwmH4zCJLnMSi8eI6BuoswaQyeMyr4lguzJjZc
	00IZTK40FpiJkLPNUo+BlLvd6YogWqAXbR+jEFXzvQDZRvkci5GCXnoXefktoA0lNC+3cPNWBpf3
	dfO/W2Id5jvWnPws2tYPPd2Majy4R7YM1U1kLQ==

RnJvbTogQW5kcmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCg0KSW4gcmFwbF9j
b21wdXRlX3RpbWVfd2luZG93X2NvcmUoKSB0aGUgdGltZSB3aW5kb3cgaXMgY2FsY3VsYXRlZCB1
c2luZyB0aGUNCnZhcmlhYmxlICJ5Ii4gVGhpcyB2YXJpYWJsZSBpcyBsaW1pdGVkIGJ5IHRoZSBt
YXNrIDB4MUYsIGhvd2V2ZXLCoHRoZQ0KcmVzdWx0IG9mIHRoZSBjb3JuZXItY2FzZSBleHByZXNz
aW9uICgxIDw8IDB4MUYpIGlzIDB4ODAwMDAwMDAgb2Ygc2lnbmVkDQppbnRlZ2VyIHR5cGUuIEFj
dHVhbGx5IGl0J3MgdW5kZWZpbmVkIGluIHN0YW5kYXJkIEMgbGFuZ3VhZ2UgYnV0IHRoZQ0Ka2Vy
bmVsIGlzIGNvbXBpbGVkIHdpdGggLWZuby1zdHJpY3Qtb3ZlcmZsb3cgKC1md3JhcHYpIGZsYWcg
d2hpY2ggZG9lcyB0aGUNCnRyaWNrLg0KDQpFdmVudHVhbGx5IHRoZSB1bmV4cGVjdGVkIHNpZ24g
ZXh0ZW5zaW9uIGlzIHBvc3NpYmxlIHdoZW4gdGhlIHJlc3VsdCBvZg0KdHlwZSBpbnQgaXMgZXhw
YW5kZWQgdG8gdTY0LCBsaWtlIDB4ODAwMDAwMDAgLT4gMHhGRkZGRkZGRjgwMDAwMDAwIHdoaWNo
DQpsZWFkcyB0byBpbmNvcnJlY3QgYXJpdGhtZXRpYy4NCg0KQXZvaWQgc2lnbiBleHRlbnNpb24g
YnkgY2FzdGluZyB0aGUgbGVmdCBvcGVyYW5kIG9mIHRoZSBzaGlmdCB0byB0aGUNCnVuc2lnbmVk
IHR5cGUgYmVmb3JlIHBlcmZvcm1pbmcgdGhlIHNoaWZ0Lg0KDQpGb3VuZCBieSBMaW51eCBWZXJp
ZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KDQpGaXhlczog
M2MyYzA4NDU0Y2U5ICgicG93ZXJjYXAgLyBSQVBMOiBoYW5kbGUgYXRvbSBhbmQgY29yZSBkaWZm
ZXJlbmNlcyIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFZhdG9yb3BpbiA8YS52YXRvcm9waW5AY3JwdC5ydT4NCi0tLQ0KIGRyaXZlcnMvcG93ZXJj
YXAvaW50ZWxfcmFwbF9jb21tb24uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcG93ZXJjYXAvaW50
ZWxfcmFwbF9jb21tb24uYyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxfcmFwbF9jb21tb24uYw0K
aW5kZXggM2ZmNmRhM2JmNGU2Li4wZjJkM2QxYTAwYzUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3Bv
d2VyY2FwL2ludGVsX3JhcGxfY29tbW9uLmMNCisrKyBiL2RyaXZlcnMvcG93ZXJjYXAvaW50ZWxf
cmFwbF9jb21tb24uYw0KQEAgLTExMDcsNyArMTEwNyw3IEBAIHN0YXRpYyB1NjQgcmFwbF9jb21w
dXRlX3RpbWVfd2luZG93X2NvcmUoc3RydWN0IHJhcGxfZG9tYWluICpyZCwgdTY0IHZhbHVlLA0K
IAlpZiAoIXRvX3Jhdykgew0KIAkJZiA9ICh2YWx1ZSAmIDB4NjApID4+IDU7DQogCQl5ID0gdmFs
dWUgJiAweDFmOw0KLQkJdmFsdWUgPSAoMSA8PCB5KSAqICg0ICsgZikgKiByZC0+dGltZV91bml0
IC8gNDsNCisJCXZhbHVlID0gKDFVIDw8IHkpICogKDQgKyBmKSAqIHJkLT50aW1lX3VuaXQgLyA0
Ow0KIAl9IGVsc2Ugew0KIAkJaWYgKHZhbHVlIDwgcmQtPnRpbWVfdW5pdCkNCiAJCQlyZXR1cm4g
MDsNCi0tIA0KMi40My4wDQo=
