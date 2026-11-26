Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690241;
	b=SUp2X3WXCdpB5UNyt7qp0b/vKFzN3LHZ6VBp6tkEn3Y4rKQC1NzUwgMlGO8m5xbDkcpU
	 ZrgTycpNdUvmAKiRq1sqUQB6PHw1wsBJzPvyJagahOOO3jRrOj2oo7yEO2jF7denuc2VE
	 CjeY4e/RRqh9bL/6cy2h5gIF4YuHYeo403OOr1ANA81h3rayGZmRjHFsy4QPeZgtWB0hC
	 VQjqm00cR4rGj2o+bQpdLMcO3+lZQntUhBXdMmAqtrSKzWvuRUVR/7OpvgtRpSTngcED/
	 Ds00l9/iJo3KcmQD9m4lWOGOjWNQ9S2b8QJPtdK3LQSMQwTXuWvoBZbzc1xzKA5brsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690241;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Content-Type:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To;
	bh=hHaAICVJRFQV+5hvz8NIKnPlYU9O7jSEUNCaXHXOOJ0=;
	b=orZ109e2NnkhzFN/h4WXXp323UhD/qrk6v9eL8h27tGb0USMcTYs8pRtgA0ajTOvb67R
	 gd6lJnnSW3qQ8+B8pmdUQfO8xWlCHbO/638uuXNIXCQsnETT9+02CsDWVJJaE/SQfgxio
	 1oq9nLhF0s3np+N1O8Hc7TTXmTgXcK5cWNkjvxF8FjXsOKKsZNGs2NxTBuiMVgVpgz5h/
	 +q+fYzcdgXbZdURA4rMxhib1TPxzp2mzx1AjRoZTRj1aYnI2mI02QgDpzTNkT9YwZ+QTE
	 8UOwIMvT2c+8ne0PS7X+b5C6xheWubM/jHGntU/H4Cq5Spu1jFP0oizxcbEn1VrXUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b+i1b+n0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90129606A31E;
	Thu, 26 Nov 2026 10:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90129606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b+i1b+n0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5BD1BA8;
	Thu, 26 Nov 2026 02:50:36 -0800 (PST)
Received: from [10.57.70.67] (unknown [10.57.70.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9C63F86C;
	Thu, 26 Nov 2026 02:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795690239; bh=fWGD5Dldafq7CDVvnA4fh0lMfmOm+tGqV20EXnogxHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b+i1b+n0ngyxMfgdHOsulTM8kCg45tjDTrdIjffOrJniTp6sa7vGz4jWMpBAZc/8h
	 xhakhDHXR1keja7K+cJwzkA5HbT18so8CcIvmfQj4sKNXdoFCV27QOKxZTtUceURlU
	 u74suQyuEsXPGgBdyKu0Hw0yQCqVUvyBi0wd26So=
Content-Type: multipart/mixed; boundary="------------UXZLA3h0BF9bz76QA0I0eRk5"
Message-ID: <2162b02c-642a-446c-973e-ca80607da294@arm.com>
Date: Thu, 26 Nov 2026 10:50:34 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Alexey Klimov <alexey.klimov@linaro.org>, tudor.ambarus@linaro.org
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org,
 daniel.lezcano@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>

This is a multi-part message in MIME format.
--------------UXZLA3h0BF9bz76QA0I0eRk5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/26/26 09:16, Alexey Klimov wrote:
> Hi Christian, Tudor,
> 
> On Wed, 25 Nov 2026 at 17:40, Christian Loehle <christian.loehle@arm.com> wrote:
>>
>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
>> independently of its interrupt mask. Setting it to 0 C limits all three
>> clusters to about 200 MHz while cpufreq reports the requested frequencies.
>> This was found through trial and error while tracking EAS regressions.
> 
> Cpufreq reports the requested frequencies — are these cached values
> being reported?
> Or is this what the kernel gets via the ACPM call?

Requested frequencies are reported. The 200MHz I only deduced from PMU counters.

> 
>> Program slot 7 from the lowest active hot trip so hardware throttling can
>> precede the critical trip's system shutdown. Cache the low/high window and
>> update the hot limit from set_trip_temp(), because the thermal core skips
>> set_trips() when that window is unchanged.
> 
> FWIW, Exynos850 control register for TMU has bits to enabled/disable
> such behaviour (and it probably works).
> Maybe gs101 also has it.
> But it seems that cpufreq scaling feature itself is explicitly enabled.

Thanks for the hint Alexey!
THERM_TRIP_EN is bit12 on Exynos850, clearing that on gs101 still stays on 200MHz
for me. The downstream driver doesn't define it either.
Clearing bit16, i.e. 0x09003 instead of 0x19003 does indeed remove the throttling
even with all zeroes in slot7.
I would probably still go with $SUBJECT, as I'd say the risk of this having unwanted
side effects is lower IMHO, but I'm also happy with either.
See attached patch.
--------------UXZLA3h0BF9bz76QA0I0eRk5
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-thermal-drivers-samsung-acpm-tmu-Disable-hardware-CP.patch"
Content-Disposition: attachment;
 filename*0="0001-thermal-drivers-samsung-acpm-tmu-Disable-hardware-CP.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyY2E1MDBjMGQxYjc2NjI0MTE3MGZiOGE0ZjRiMjAwMmI0MjI1MGNjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9l
aGxlQGFybS5jb20+CkRhdGU6IFRodSwgMjYgTm92IDIwMjYgMTA6NDY6MzQgKzAwMDAKU3Vi
amVjdDogW1BBVENIXSB0aGVybWFsL2RyaXZlcnMvc2Ftc3VuZy9hY3BtLXRtdTogRGlzYWJs
ZSBoYXJkd2FyZSBDUFUKIHRocm90dGxpbmcKCmFjcG1fdG11X3NldF90cmlwcygpIHN1cHBs
aWVzIHR3byB0aHJlc2hvbGRzLCBidXQgdGhlIEFDUE0gY29tbWFuZCB3cml0ZXMKYWxsIGVp
Z2h0IHNsb3RzLCB6ZXJvLWZpbGxpbmcgdGhlIHJlc3QuIE9uIEdTMTAxLCBzbG90IDcgbGlt
aXRzIENQVSBjbG9ja3MKaW5kZXBlbmRlbnRseSBvZiBpdHMgaW50ZXJydXB0IG1hc2suIFNl
dHRpbmcgaXQgdG8gMCBDIGxpbWl0cyBhbGwgdGhyZWUKY2x1c3RlcnMgdG8gMjAwIE1IeiB3
aGlsZSBjcHVmcmVxIHJlcG9ydHMgdGhlIHJlcXVlc3RlZCBmcmVxdWVuY2llcy4KCkNsZWFy
IHRoZSBDUFUgdGhyb3R0bGluZyBlbmFibGUgYml0IGluIENPTlRST0wgYWZ0ZXIgQUNQTSBp
bml0aWFsaXphdGlvbiwKbGVhdmluZyBDUFUgY29vbGluZyBhbmQgY3JpdGljYWwgc2h1dGRv
d24gdG8gdGhlIHRoZXJtYWwgY29yZS4KCkZpeGVzOiA1MGEyYzVkNDA2MmEgKCJ0aGVybWFs
L2RyaXZlcnMvc2Ftc3VuZzogQWRkIEV4eW5vcyBBQ1BNIFRNVSBkcml2ZXIgR1MxMDEiKQpT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gTG9laGxlIDxjaHJpc3RpYW4ubG9laGxlQGFybS5j
b20+Ci0tLQogZHJpdmVycy90aGVybWFsL3NhbXN1bmcvYWNwbS10bXUuYyB8IDEwICsrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90aGVybWFsL3NhbXN1bmcvYWNwbS10bXUuYyBiL2RyaXZlcnMvdGhlcm1hbC9z
YW1zdW5nL2FjcG0tdG11LmMKaW5kZXggNDc5OWVmNTE4YTdhLi5mYTFiZmMwZDEwNzAgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvdGhlcm1hbC9zYW1zdW5nL2FjcG0tdG11LmMKKysrIGIvZHJp
dmVycy90aGVybWFsL3NhbXN1bmcvYWNwbS10bXUuYwpAQCAtMzcsNiArMzcsOCBAQAogI2Rl
ZmluZSBHUzEwMV9DUFVDTDBfU0VOU09SX01BU0sgKEVYWU5PU19UTVVfU0VOU09SKDEpIHwJ
XAogCQkJCSAgRVhZTk9TX1RNVV9TRU5TT1IoMikpCiAKKyNkZWZpbmUgR1MxMDFfUkVHX0NP
TlRST0wJCTB4NTAKKyNkZWZpbmUgR1MxMDFfQ09OVFJPTF9DUFVfVEhST1RUTEVfRU4JQklU
KDE2KQogI2RlZmluZSBHUzEwMV9SRUdfSU5UUEVORChpKQkJKChpKSAqIDB4NTAgKyAweGY4
KQogCiBlbnVtIHsKQEAgLTQ3MCw2ICs0NzIsMTQgQEAgc3RhdGljIGludCBhY3BtX3RtdV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlnb3RvIG91dF9wbV9wdXQ7
CiAJfQogCisJLyogRGlzYWJsZSBzbG90IDcgQ1BVIHRocm90dGxpbmc7IHRoZSB0aGVybWFs
IGNvcmUgbWFuYWdlcyBjb29saW5nLiAqLworCXJldCA9IHJlZ21hcF9jbGVhcl9iaXRzKHJl
Z21hcCwgR1MxMDFfUkVHX0NPTlRST0wsCisJCQkJR1MxMDFfQ09OVFJPTF9DUFVfVEhST1RU
TEVfRU4pOworCWlmIChyZXQpIHsKKwkJcmV0ID0gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwg
IkZhaWxlZCB0byBkaXNhYmxlIENQVSB0aHJvdHRsaW5nXG4iKTsKKwkJZ290byBvdXRfcG1f
cHV0OworCX0KKwogCWZvciAoaSA9IDA7IGkgPCBwcml2LT5udW1fc2Vuc29yczsgaSsrKSB7
CiAJCXN0cnVjdCBhY3BtX3RtdV9zZW5zb3IgKnNlbnNvciA9ICZwcml2LT5zZW5zb3JzW2ld
OwogCQlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkOwotLSAKMi4zNC4xCgo=

--------------UXZLA3h0BF9bz76QA0I0eRk5--
