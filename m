From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v2] cpuidle: Fix last_residency division
Date: Mon, 27 Jun 2016 08:59:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4E4E87@AcuExch.aculab.com>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <14940457.SEYBmqcunj@wuerfel> <576D595F.9090001@linux.vnet.ibm.com>
 <3748080.8f21OXxXix@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <3748080.8f21OXxXix@wuerfel>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: 'Arnd Bergmann' <arnd@arndb.de>, Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "anton@samba.org" <anton@samba.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubgo+IFNlbnQ6IDI0IEp1bmUgMjAxNiAyMDo0Mwo+IE9uIEZyaWRh
eSwgSnVuZSAyNCwgMjAxNiA5OjMxOjM1IFBNIENFU1QgU2hyZXlhcyBCIFByYWJodSB3cm90ZToK
PiA+ID4gSWYgdGhvc2UgZnVuY3Rpb25zIGFyZSBjYWxsZWQgbGVzcyBvZnRlbiB0aGFuIGNwdWlk
bGVfZW50ZXJfc3RhdGUoKSwKPiA+ID4gd2UgY291bGQganVzdCBtb3ZlIHRoZSBkaXZpc2lvbiB0
aGVyZS4gU2luY2UgdGhlIGRpdmlzb3IgaXMgY29uc3RhbnQsCj4gPiA+IGRvX2RpdigpIGNhbiBj
b252ZXJ0IGl0IGludG8gYSBtdWx0aXBseSBhbmQgc2hpZnQsIG9yIHdlIGNvdWxkIHVzZQo+ID4g
PiB5b3VyIHRoZSBjb2RlIHlvdSBzdWdnZXN0IGFib3ZlLCBvciB1c2UgYSAzMi1iaXQgZGl2aXNp
b24gbW9zdCBvZgo+ID4gPiB0aGUgdGltZToKPiA+ID4KPiA+ID4gICAgICAgaWYgKGRpZmYgPD0g
VUlOVF9NQVgpCj4gPiA+ICAgICAgICAgICAgICAgZGlmZl8zMiA9ICh1MzIpZGlmZiAvIE5TRUNT
X1BFUl9VU0VDOwo+ID4gPiAgICAgICBlbHNlCj4gPiA+ICAgICAgICAgICAgICAgZGlmZl8zMiA9
IGRpdl91NjQoZGlmZiwgTlNFQ1NfUEVSX1VTRUM7Cj4gPiA+Cj4gPiA+IHdoaWNoIGdjYyBpdHNl
bGYgd2lsbCB0dXJuIGludG8gYSBtdWx0aXBsaWNhdGlvbiBvciBzZXJpZXMgb2YKPiA+ID4gc2hp
ZnRzIG9uIENQVXMgb24gd2hpY2ggdGhhdCBpcyBmYXN0ZXIuCj4gPiA+Cj4gPiBJJ20gbm90IHN1
cmUgd2hpY2ggZGl2aXNpb24gbWV0aG9kIG9mIHRoZSB0aHJlZSBzdWdnZXN0ZWQgaGVyZSB0byB1
c2UuCj4gPiBEb2VzIGFueW9uZSBoYXZlIGEgc3Ryb25nIHByZWZlcmVuY2U/Cj4gPgo+IAo+IEl0
IGRlcGVuZHMgb24gaG93IGFjY3VyYXRlIHdlIHdhbnQgaXQgYW5kIGhvdyBsb25nIHdlIGV4cGVj
dAo+IHRoZSB0aW1lcyB0byBiZS4gVGhlIG9wdGltaXphdGlvbiBmb3IgdGhlIDQuMiBzZWNvbmQg
Y3V0b2ZmCj4gZm9yIGRvaW5nIGEgMzItYml0IGRpdmlzaW9uIG9ubHkgbWFrZXMgc2Vuc2UgaWYg
dGhlIG1ham9yaXR5Cj4gb2YgdGhlIHNsZWVwIHRpbWVzIGFyZSBiZWxvdyB0aGF0LgoKSXQgYWxz
byBkZXBlbmRzIGlmIHRoZSBjb2RlIGFjdHVhbGx5IGNhcmVzIGFib3V0IHRoZSBsZW5ndGggb2Yg
J2xvbmcnIHNsZWVwcy4KSSdkIGd1ZXNzIHRoYXQgZm9yIGNwdSBpZGxlIDQuMiBzZWNvbmRzIGlz
ICdhIGxvbmcgdGltZScsIHNvIHRoZSBkaXZfdTY0KCkKcmVzdWx0IGNvdWxkIGJlIHRyZWF0ZWQg
YXMgNC4yIHNlY29uZHMgd2l0aG91dCBjYXVzaW5nIGdyaWVmLgoKQWN0dWFsbHkgdGhlIGNvc3Qg
b2YgYSA2NGJpdCBkaXZpZGUgYWZ0ZXIgYSA0IHNlY29uZCBzbGVlcCB3aWxsIGJlIG5vaXNlLgpP
VE9IIGEgNjRiaXQgZGl2aWRlIGFmdGVyIGEgc2xlZXAgdGhhdCBsYXN0ZWQgYSBmZXcgbnMgd2ls
bCBiZSBzaWduaWZpY2FudC4KCglEYXZpZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhw
cGMtZGV2
