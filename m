Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449765;
	b=YQlDackJQFcBsyIQJ0q3jWGb7v2jAXXexfh75Y5Knib7XJVvD2B7KePZRV7NYul9B5K/
	 VDzeBW4mCwip2eK25YftovCqWjMlFKBl5MWMTNK83NmTF8LoqD2T1VbPsNqO/S6kpo5Zu
	 Kc2WmwOhiyDbefMhoLNAkAL4iwS1oKzs/VglQNqDxUSVSCe1lFVZrDq6Q6KWTWGbRIHf9
	 KZqlwo9N3DNzTI3c7Ura23ISyM3aP86gDnTLDamIWYuh5dtjjbeVXRv9iOWx94arnJsUj
	 DV/H6dtSI12ssNkCoPdLT2Povckvv6WguN3WXILIHjn6FYKbe5e1HmGBl4w92wBIQbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449765;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 DKIM-Signature;
	bh=qyrsc8FcIcO9n5vy1ztB9zISI0TN10UCyMD09N2OTP8=;
	b=e+Q2A0s9FL7rtMEs4G5049M/HRIMK3reFAuNEewC2TMYx1nzEb6UQsxntBFaIcygthrt
	 TnancaaHCretvSIb2R8KncaixbyAgaSb7RrySB/HAZafYAtmE5gPAVvqx+LsZBHIoXZ0t
	 xmO1aKtCZfLgKgKz5f4/T430DemWesQG2fFyL4npWcw6iSnKYzPeeH2MZaY0B8tjh9bCR
	 CenqmTjlm8RSc/Cx2tJwO46JdybJHmnpWtKGbEla9VPuHIKlgjv9YXZbYh5OPjHE7O7fa
	 e1+2ithv5UbhsUh5x3Q86xRDRtPwXZ+iQN+HsnUj8ikzqwqpMWxtfU3XBQ+e3musTkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ayoGq9rY;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (unknown [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A1F94606A321;
	Thu, 12 Nov 2026 02:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1F94606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=ayoGq9rY
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.48
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zhongqiu.han@oss.qualcomm.com"
	<zhongqiu.han@oss.qualcomm.com>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIIHY1IDAvMl0gY3B1?=
 =?utf-8?B?ZnJlcTogYWNwaS1jcHVmcmVxOiBmaXggUC1zdGF0ZSBpbmRleCBtaXNtYXRj?=
 =?utf-8?Q?h_between_perf->states[]_and_freq=5Ftable[]?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSCB2NSAwLzJdIGNwdWZyZXE6IGFj?=
 =?utf-8?B?cGktY3B1ZnJlcTogZml4IFAtc3RhdGUgaW5kZXggbWlzbWF0Y2ggYmV0d2Vl?=
 =?utf-8?Q?n_perf->states[]_and_freq=5Ftable[]?=
Thread-Index: AQHdbh5EiSuYkXz8G0u3sHHXQ74/gbcnOhmAgAKA9eA=
Date: Thu, 12 Nov 2026 02:15:52 +0000
Message-ID: <f2a529c1b4884478a0b4a8d2b470911c@baidu.com>
References: <20261106184008.1728-1-lirongqing@baidu.com>
 <CAJZ5v0gHXCKvvHPXevx4U5WSVsS91Z3WuiMCwiYSQzQBEB5jNw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gHXCKvvHPXevx4U5WSVsS91Z3WuiMCwiYSQzQBEB5jNw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794449755;
	bh=qyrsc8FcIcO9n5vy1ztB9zISI0TN10UCyMD09N2OTP8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ayoGq9rYHAu5wTQHxSvAVBHoHyq/rupfBgyYX1mr34/feR+B+N+4vn2DjqQP3Doqs
	 tlMrslZUyaFpurRechvmVcngNwkoa36OhvN6dDzxuzOsngEtZlhDcLsSvgkqSntQoY
	 EVCkxzkcaOY7I+Amzl0fPGGBdfrCNZ3zRV01v6VRzsufv6zi66917UEtmAfDtaRCvB
	 Ss3Vlh0U8pSpRnzCPZmICZQo1B7jS45qFQ8ogywKw5yxUT476xCedXGM3T7Jn7V8cD
	 3cQ5Mdo8j/JAhg5gwhXRDRZthCcM8muPKIElM3YKyWVu+xFMq+YWylm58cm8oODWX5
	 tnaoiUhYtD/Ag==

PiA+IFBhdGNoIDEvMiBpcyB1bmNoYW5nZWQgZnJvbSB2NCBhbmQgZml4ZXMgdGhlIGNhY2hlZCBm
cmVxdWVuY3kgdXNlZCBieQ0KPiA+IGdldF9jdXJfZnJlcV9vbl9jcHUoKSB0byBkZXRlY3QgYSBm
aXJtd2FyZSBmcmVxdWVuY3kgY2hhbmdlIGJlaGluZCB0aGUNCj4gPiBPUydzIGJhY2suDQo+ID4N
Cj4gPiBQYXRjaCAyLzIgaXMgbmV3IGluIHY1LiAgQXMgUmFmYWVsIHBvaW50ZWQgb3V0LCBTYXNo
aWtvIG9ic2VydmVkIHRoYXQNCj4gPiB0aGUgZXh0cmFjdF9tc3IoKSBmYWxsYmFjayBpbnRlcmZl
cmVzIHdpdGggMS8yIGFuZCBjYW4gcmVuZGVyIGl0DQo+ID4gaW5lZmZlY3RpdmU6IHdoZW4gdGhl
IHN0YXR1cyByZWFkIGZyb20gdGhlIGhhcmR3YXJlIG1hdGNoZXMgbm8NCj4gPiBmcmVxX3RhYmxl
IGVudHJ5LCBleHRyYWN0X21zcigpIHJldHVybnMgZnJlcV90YWJsZVswXS5mcmVxdWVuY3kNCj4g
PiBpbnN0ZWFkIG9mIHJlcG9ydGluZyB0aGUgc3RhdHVzIGFzIHVua25vd24uICBJZiB0aGUgT1Mg
aXMgYWxyZWFkeSBhdA0KPiA+IHRoZSBQLXN0YXRlIGNvcnJlc3BvbmRpbmcgdG8gZnJlcV90YWJs
ZVswXSwgYSBmaXJtd2FyZSBzd2l0Y2ggdG8gYQ0KPiA+IGZpbHRlcmVkLW91dCBQLXN0YXRlIHRo
ZW4gY29tcGFyZXMgZXF1YWwgdG8gdGhlIGNhY2hlZCBmcmVxdWVuY3ksDQo+ID4gZGF0YS0+cmVz
dW1lIGlzIGxlZnQgY2xlYXIgYW5kIHRoZSBuZXh0IC0+dGFyZ2V0KCkgY2FsbCBkb2VzIG5vdA0K
PiA+IHJld3JpdGUgdGhlIGNvbnRyb2wgcmVnaXN0ZXIuICBTbyAxLzIgYWxvbmUgZG9lcyBub3Qg
bWFrZSB0aGUNCj4gPiBkZXRlY3Rpb24gd29yayBpbiB0aGF0IGNhc2UsIGFuZCB0aGUgdHdvIHBh
dGNoZXMgYXJlIHBvc3RlZCB0b2dldGhlcg0KPiA+IHJhdGhlciB0aGFuIHNlcGFyYXRlbHkgYXMg
SSBoYWQgc3VnZ2VzdGVkIGVhcmxpZXIuDQo+ID4NCj4gPiB2NDogaHR0cHM6Ly9sa21sLml1LmVk
dS8yNjA5LjEvMDczNjkuaHRtbA0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2NDoNCj4gPiAgLSBE
cm9wICJjcHVmcmVxOiBhY3BpLWNwdWZyZXE6IGZpeCBQLXN0YXRlIGluZGV4IG1pc21hdGNoIGlu
DQo+ID4gICAgZXh0cmFjdF9pbygpIiwgd2hpY2ggaGFzIGJlZW4gYXBwbGllZC4gIFRoaXMgc2Vy
aWVzIGlzIGJhc2VkIG9uIHRvcA0KPiA+ICAgIG9mIGl0Lg0KPiA+ICAtIEFkZCAyLzIgdG8gc3Rv
cCBleHRyYWN0X21zcigpIGZyb20gbWFza2luZyBmaXJtd2FyZSBQLXN0YXRlIGNoYW5nZXMsDQo+
ID4gICAgYXMgcmVwb3J0ZWQgYnkgU2FzaGlrbywgYW5kIG5vdGUgdGhlIGRlcGVuZGVuY3kgaW4g
MS8yJ3MgY2hhbmdlbG9nLg0KPiANCj4gU28gU2FzaGlrbyBoYXMgZmVlZGJhY2sgb24gdGhpcyBv
bmUgbm93Og0KPiANCj4gaHR0cHM6Ly9zYXNoaWtvLmRldi8jL21lc3NhZ2UvMjAyNjExMDYxODQw
MDguMTcyOC0yLWxpcm9uZ3FpbmclNDBiYWlkdS4NCj4gY29tDQoNClRoaXMgZmVlZGJhY2sgaXMg
cmVhc29uYWJsZSwgSSB3aWxsIHNlbmQgbmV3IHZlcnNpb24NCg0KdGhhbmtzDQoNCltMaSxSb25n
cWluZ10gDQoNCg0KPiANCj4gPiAgLSAxLzI6IG5vIGZ1bmN0aW9uYWwgY2hhbmdlOyBjaGFuZ2Vs
b2cgZXh0ZW5kZWQgdG8gc2F5IHRoYXQgaXQgZml4ZXMNCj4gPiAgICBvbmx5IHRoZSBjYWNoZWQg
c2lkZSBvZiB0aGUgY29tcGFyaXNvbiwgYW5kIGEgZHVwbGljYXRlDQo+ID4gICAgU2lnbmVkLW9m
Zi1ieSB3YXMgcmVtb3ZlZC4NCj4gPg0KPiA+IExpIFJvbmdRaW5nICgyKToNCj4gPiAgIGNwdWZy
ZXE6IGFjcGktY3B1ZnJlcTogZml4IFAtc3RhdGUgaW5kZXggbWlzbWF0Y2ggaW4NCj4gPiAgICAg
Z2V0X2N1cl9mcmVxX29uX2NwdSgpDQo+ID4gICBjcHVmcmVxOiBhY3BpLWNwdWZyZXE6IGRvbid0
IG1hc2sgZmlybXdhcmUgUC1zdGF0ZSBjaGFuZ2VzDQo+ID4NCj4gPiAgZHJpdmVycy9jcHVmcmVx
L2FjcGktY3B1ZnJlcS5jIHwgMTEgKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi45LjQNCj4g
Pg0K
