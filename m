From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH v2] makedumpfile: exclude pages that are logically
 offline
Date: Mon, 11 Mar 2019 16:40:30 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03569C9C@BPXM09GP.gisp.nec.co.jp>
References: <20181122100627.5189-1-david@redhat.com>
 <20181122100938.5567-1-david@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03561800@BPXM09GP.gisp.nec.co.jp>
 <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7c9d6d5c-d6cf-00a7-7f23-bf28cbb382af@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Hildenbrand <david@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, kexec-ml <kexec@lists.infradead.org>, "pv-drivers@vmware.com" <pv-drivers@vmware.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
List-Id: linux-pm@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gT24gMjcuMTEuMTggMTc6MzIsIEthenVoaXRv
IEhhZ2lvIHdyb3RlOg0KPiA+PiBMaW51eCBtYXJrcyBwYWdlcyB0aGF0IGFyZSBsb2dpY2FsbHkg
b2ZmbGluZSB2aWEgYSBwYWdlIGZsYWcgKG1hcCBjb3VudCkuDQo+ID4+IFN1Y2ggcGFnZXMgZS5n
LiBpbmNsdWRlIHBhZ2VzIGluZmF0ZWQgYXMgcGFydCBvZiBhIGJhbGxvb24gZHJpdmVyIG9yDQo+
ID4+IHBhZ2VzIHRoYXQgd2VyZSBub3QgYWN0dWFsbHkgb25saW5lZCB3aGVuIG9ubGluaW5nIHRo
ZSB3aG9sZSBzZWN0aW9uLg0KPiA+Pg0KPiA+PiBXaGlsZSB0aGUgaHlwZXJ2aXNvciB1c3VhbGx5
IGFsbG93cyB0byByZWFkIHN1Y2ggaW5mbGF0ZWQgbWVtb3J5LCB3ZQ0KPiA+PiBiYXNpY2FsbHkg
cmVhZCBhbmQgZHVtcCBkYXRhIHRoYXQgaXMgY29tcGxldGVseSBpcnJlbGV2YW50LiBBbHNvLCB0
aGlzDQo+ID4+IG1pZ2h0IHJlc3VsdCBpbiBxdWl0ZSBzb21lIG92ZXJoZWFkIGluIHRoZSBoeXBl
cnZpc29yLiBJbiBhZGRpdGlvbiwNCj4gPj4gd2Ugc2F3IHNvbWUgcHJvYmxlbXMgdW5kZXIgSHlw
ZXItViwgd2hlcmVieSB3ZSBjYW4gY3Jhc2ggdGhlIGtlcm5lbCBieQ0KPiA+PiBkdW1waW5nLCB3
aGVuIHJlYWRpbmcgbWVtb3J5IG9mIGEgcGFydGlhbGx5IG9ubGluZWQgbWVtb3J5IHNlZ21lbnQN
Cj4gPj4gKGZvciBtZW1vcnkgYWRkZWQgYnkgdGhlIEh5cGVyLVYgYmFsbG9vbiBkcml2ZXIpLg0K
PiA+Pg0KPiA+PiBUaGVyZWZvcmUsIGRvbid0IHJlYWQgYW5kIGR1bXAgcGFnZXMgdGhhdCBhcmUg
bWFya2VkIGFzIGJlaW5nIGxvZ2ljYWxseQ0KPiA+PiBvZmZsaW5lLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4gPg0KPiA+
IFRoYW5rcyBmb3IgdGhlIHYyIHVwZGF0ZS4NCj4gPiBJJ20gZ29pbmcgdG8gbWVyZ2UgdGhpcyBw
YXRjaCBhZnRlciB0aGUga2VybmVsIHBhdGNoZXMgYXJlIG1lcmdlZA0KPiA+IGFuZCBpdCB0ZXN0
cyBmaW5lIHdpdGggdGhlIGtlcm5lbC4NCj4gPg0KPiA+IEthenUNCj4gDQo+IEhpIEthenUsDQo+
IA0KPiB0aGUgcGF0Y2hlcyBhcmUgbm93IHVwc3RyZWFtLiBUaGFua3MhDQoNClRlc3RlZCBPSyBh
dCBteSBlbmQsIHRvby4gQXBwbGllZCB0byB0aGUgZGV2ZWwgYnJhbmNoLg0KDQogICAgT2ZmbGlu
ZSBwYWdlcyAgICAgICAgICAgOiAweDAwMDAwMDAwMDAwMDI0MDANCg0KVGhhbmsgeW91IQ0KS2F6
dQ0KDQo+IA0KPiAtLQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KDQo=
