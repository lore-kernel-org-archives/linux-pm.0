From: Julien Freche <jfreche@vmware.com>
Subject: Re: [PATCH RFC 0/6] mm/kdump: allow to exclude pages that are
 logically offline
Date: Thu, 15 Nov 2018 01:42:30 +0000
Message-ID: <B6456717-0A6F-4957-A7F2-11599701226A@vmware.com>
References: <20181114211704.6381-1-david@redhat.com>
 <8932E1F4-A5A9-4462-9800-CAC1EF85AC5D@vmware.com>
 <63c5f4b6-828a-764e-f64d-e603dc4b104e@redhat.com>
 <63214D36-14FD-4080-8E35-CF2A392D6507@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63214D36-14FD-4080-8E35-CF2A392D6507@vmware.com>
Content-Language: en-US
Content-ID: <E20FFFB53594D84E87A1E97CF4FFF55A@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>, David Hildenbrand <david@redhat.com>, linux-mm <linux-mm@kvack.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Christian Hansen <chansen3@cisco.com>, Dave Young <dyoung@redhat.com>, David Rientjes <rientjes@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>, Ka
List-Id: linux-pm@vger.kernel.org

Pk9uIDExLzE0LzE4LCAzOjQxIFBNLCAiTmFkYXYgQW1pdCIgPG5hbWl0QHZtd2FyZS5jb20+IHdy
b3RlOg0KPj5Gcm9tOiBEYXZpZCBIaWxkZW5icmFuZA0KPj5TZW50OiBOb3ZlbWJlciAxNCwgMjAx
OCBhdCAxMTowNTozOCBQTSBHTVQNCj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDAvNl0gbW0v
a2R1bXA6IGFsbG93IHRvIGV4Y2x1ZGUgcGFnZXMgdGhhdCBhcmUgbG9naWNhbGx5IG9mZmxpbmUN
Cj4+IA0KPj4gDQo+PiBDYW4geW91IHNoYXJlIGlmIHNvbWV0aGluZyBsaWtlIHRoaXMgaXMgYWxz
byBkZXNpcmVkIGZvciB2bXdhcmUncw0KPj4gaW1wbGVtZW50YXRpb24/IChJIHRhZ2dlZCB0aGlz
IGFzIFJGQyB0byBnZXQgc29tZSBtb3JlIGZlZWRiYWNrKQ0KPj4gDQo+PiBJdCBzaG91bGQgaW4g
dGhlb3J5IGJlIGFzIHNpbXBsZSBhcyBhZGRpbmcgYSBoYW5kZnVsIG9mDQo+PiBfU2V0UGFnZU9m
ZmxpbmUoKS9fQ2xlYXJQYWdlT2ZmbGluZSgpIGF0IHRoZSByaWdodCBzcG90cy4NCj4gICAgDQo+
IFRoYW5rcywgSSB3YXMganVzdCBzdXNwZWN0aW5nIGl0IGlzIHBlcnNvbmFsIDstKQ0KPg0KPiBJ
IHdvdWxkIG9idmlvdXNseSBwcmVmZXIgdGhhdCB5b3VyIGNoYW5nZXMgd291bGQgYmUgZG9uZSBv
biB0b3Agb2YgdGhvc2UNCj4gdGhhdCB3ZXJlIHNraXBwZWQuIFRoaXMgcGF0Y2gtc2V0IHNvdW5k
cyB2ZXJ5IHJlYXNvbmFibGUgdG8gbWUsIGJ1dCBJIHByZWZlcg0KPiB0aGF0IEp1bGllbiAoY2Pi
gJlkKSB3b3VsZCBhbHNvIGdpdmUgaGlzIG9waW5pb24uDQogICAgDQpJIHRoaW5rIHRoaXMgaXMg
ZGVzaXJhYmxlIGZvciBWTXdhcmUncyBpbXBsZW1lbnRhdGlvbiBhbHNvLiBZb3UgYXJlIHJpZ2h0
LA0KZHVtcGluZyBkYXRhIHRoYXQgaXMgbm90IHJlbGV2YW50IGlzIGEgd2FzdGUgOi0pIA0KSSBo
YXZlbid0IGhlYXJkIG9mIGFueSBwYW5pYy9pc3N1ZSBkdWUgdG8gdGhpcyBidXQgdGhhdCdzIHN0
aWxsIGEgZ29vZCBvcHRpbWl6YXRpb24uDQoNCk5hZGF2IG9yIEkgY291bGQgaGVscCB0byB0ZXN0
IHRoYXQgb24gRVNYIGlmIHJlcXVpcmVkLg0KDQpSZWdhcmRzLA0KDQotLSANCkp1bGllbiBGcmVj
aGUNCg0K
