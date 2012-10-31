From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 1/5] driver core / ACPI: Move ACPI support to core
 device and driver types
Date: Wed, 31 Oct 2012 20:03:34 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F19D5B845@ORSMSX108.amr.corp.intel.com>
References: <1421417.rIOjExM5Pt@vostro.rjw.lan>
 <1825320.jYYkSTpTOm@vostro.rjw.lan> <20121031162407.GA318@kroah.com>
 <1587006.fly6qcnVo1@vostro.rjw.lan> <5091719D.9090109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10789 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756957Ab2JaUDg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Oct 2012 16:03:36 -0400
In-Reply-To: <5091719D.9090109@zytor.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Huang, Ying" <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86 list <x86@kernel.org>

T24gMTAvMzEvMjAxMiAxMTo0MiBBTSwgUmFmYWVsIEouIFd5c29ja2kgd3JvdGU6DQo+IEkgd29u
ZGVyIGlmIHRoZSB4ODYgYW5kL29yIGlhNjQgbWFpbnRhaW5lcnMgaGF2ZSBhbnkgcmVzZXJ2YXRp
b25zPw0KDQpDYW4geW91IGVsYWJvcmF0ZSBvbiB0aGUgInRlc3RlZCBieSBtaWthIiB0aGF0IHlv
dSBwdXQgaW50byB0aGUgMC81DQptZXNzYWdlLiBFc3BlY2lhbGx5IHcuci50LiBpYTY0LiBDb21w
aWxlIHRlc3RlZD8gQm9vdCB0ZXN0ZWQ/IFJhbiB3aXRoDQpzb21lIG5ldyBkZXZpY2UgdGhhdCB1
c2VzIHRoZSBBQ1BJIGVudW1lcmF0aW9uIHByb3ZpZGVkIGJ5IHRoaXMgc2VyaWVzPw0KDQpOb3Ro
aW5nIGluIHRoZSBjb25jZXB0IG9yIGNvZGUgc2NhcmVzIG1lIC4uLiBidXQgSSdkIGxpa2UgdG8g
a25vdyB0aGF0IGl0DQphY3R1YWxseSB3b3JrcyA6LSkNCg0KLVRvbnkNCg==
