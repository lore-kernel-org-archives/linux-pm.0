From: stratosk <stratosk@semaphore.gr>
Subject: Re: [PATCH v3 linux-next] cpufreq: ondemand: Calculate gradient of
 CPU load to early increase frequency
Date: Thu, 04 Apr 2013 10:21:55 +0300
Message-ID: <6abgl9p3kyb9lrgptch39iyw.1365060115568@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:37829 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763173Ab3DDHWF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 03:22:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

SSBhZ3JlZSB0aGF0IHdlIHdpbGwgaGF2ZSBmYWxzZSBhbGFybXMgYnV0IHRoaXMgd2lsbCBub3Qg
YmUgYSB0b3RhbCB3YXN0ZSBvZiBwb3dlciBzaW5jZSB0aGUgbG9hZCB3aWxsIGJlIG1vcmUgdGhh
biA1MCAodGhlIGRlZmF1bHQgZ3JhZF91cF90aHJlc2hvbGQgdmFsdWUpLgoKU28sIEkgZG9uJ3Qg
dGhpbmsgdGhlcmUgd2lsbCBiZSAqc2lnbmlmaWNhbnQqIGluY3JlYXNlIGluIHBvd2VyLiBUaG91
Z2gsIEkgZG9uJ3Qga25vdyBhIHdheSB0byBwcm92ZSB0aGlzIHdpdGggbnVtYmVycy4KClRoYW5r
cywKU3RyYXRvcwoKVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz4gd3JvdGU6
Cgo+T24gNCBBcHJpbCAyMDEzIDEyOjE3LCBzdHJhdG9zayA8c3RyYXRvc2tAc2VtYXBob3JlLmdy
PiB3cm90ZToKPj4gV2h5IGRvIHlvdSBzdXNwZWN0IHNpZ25pZmljYW50IGluY3JlYXNlZCBwb3dl
cj8gV2l0aCBvbmRlbWFuZCAgdGhlIENQVSB3aWxsIGdvIGRvd24gdG8gbG93ZXN0IGZyZXEgYXMg
c29vbiBhcyB0aGUgbG9hZCB3aWxsIGRlY3JlYXNlZC4gQW5kIHRoZSBtZWFzdXJlbWVudCBzaG93
cyB0aGF0IHRoZSBDUFUgbG9hZCB3aWxsIGRlY3JlYXNlIGZhc3RlciAoYmVjYXVzZSBvZiBmYXN0
ZXIgY2FsY3VsYXRpb24pLgo+Cj5JIHN1c3BlY3QgaXQgYmVjYXVzZSB3ZSBhcmUgaW5jcmVhc2lu
ZyBmcmVxIGJhc2VkIG9uIHRoZSBhc3N1bXB0aW9uOgo+IklmIGluY3JlYXNlIGluIGxvYWQgZnJv
bSBsYXN0IGNhbGN1bGF0aW9uIGlzIG1vcmUgdGhlbiB0aHJlc2hvbGQsIHRoZW4KPndlIG11c3Qg
dXNlIGhpZ2ggZnJlcSIuLgo+Cj5TbywgdGhpcyByaXNlIGNhbiBiZSBmYWxzZSBhbGFybSBtdWx0
aXBsZSB0aW1lcyBhbmQgd2UgbWlnaHQgbm90IHNlZQo+YSBsb2FkIGluY3JlYXNlIGFmdGVyIG1v
dmluZyB0byBoaWdoIGZyZXEgYW5kIHNvIHdlIGFyZSBydW5uaW5nIGF0Cj5oaWdoL21heCBmcmVx
IHdpdGhvdXQgYW55IG5lZWQgb2YgaXQuIEFuZCBzbyBtb3JlIHBvd2VyLgo=

