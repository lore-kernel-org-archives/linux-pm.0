From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Mon, 16 Aug 2010 13:36:56 +0200
Message-ID: <1281958616.17267.2.camel__7325.33899504251$1281958844$gmane$org@thorin>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org> <20100814075000.GB27430@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100814075000.GB27430@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gU2FtLCAyMDEwLTA4LTE0IGF0IDA5OjUwICswMjAwLCBQYXZlbCBNYWNoZWsgd3JvdGU6Cj4g
T24gVGh1IDIwMTAtMDgtMTIgMDg6NTI6NDksIFRlZCBUcydvIHdyb3RlOgo+ID4gT24gVGh1LCBB
dWcgMTIsIDIwMTAgYXQgMDM6Mjg6MDFQTSArMDMwMCwgRmVsaXBlIENvbnRyZXJhcyB3cm90ZToK
PiA+ID4gCj4gPiA+IFRoZSBxdWVzdGlvbiBpcyB3aHkgYXJlIHdlIGFkZGluZyBhIHVzZXItc3Bh
Y2UgQVBJIHRoYXQ6Cj4gPiA+ICAxKSBubyB1c2VyLXNwYWNlIGJlc2lkZSBBbmRyb2lkIGhhcyBl
eHByZXNzZXMgaW50ZXJlc3QgaW4gaW1wbGVtZW50aW5nCj4gPiA+ICAyKSBpcyBkdWJpb3VzIHdo
ZXRoZXIgdGhlIGJlbmVmaXRzIGFyZSB3b3J0aCB0aGUgcGFpbiBmb3Igbm9uLUFuZHJvaWQKPiA+
ID4gdXNlci1zcGFjZQo+ID4gPiAgMykgd2lsbCBiZWNvbWUgbGVzcyBhbmQgbGVzcyBhdHRyYWN0
aXZlIGFzIGR5bmFtaWMgUE0gZ2V0cyBjbG9zZXIgdG8KPiA+ID4gdGhlIHN3ZWV0LXNwb3QsIGFu
ZCB0aGVuIHN1cnBhc3MgaXQKPiA+ID4gIDQpIEFuZHJvaWQgY2FuIGtlZXAgaW4gYSBzZXBhcmF0
ZSB0cmVlIHVudGlsIGl0J3MgY2xlYXIgaW4gdGhlIGxpbnV4Cj4gPiA+IGNvbW11bml0eSB0aGF0
IGl0J3MgdXNlZnVsIChpZiBpdCBldmVyIGhhcHBlbnMpCj4gPiAKPiA+IFNvLCBGZWxpcGUsCj4g
PiAKPiA+IERvIHlvdSBiZWxpZXZlIHlvdSBzcGVhayBmb3IgYWxsIG9mIExLTUw/ClsuLi5dCj4g
QW5kIHllcywgZm9yIHRoZSByZWNvcmQgRmVsaXBlIHNwZWFrcyBmb3IgbWUgcHJldHR5IHdlbGwu
CgpOb3QgdGhhdCBJwrRtIGFzICJ2YWx1YWJsZSIgYXMgdGhlIG90aGVycyBxdW90ZWQgYWJvdmU6
IEkgaGF2ZSB0aGUgc2FtZQppbXByZXNzaW9uLgoKPiBOb3JtYWwgcGF0aCBvZiBtZXJnaW5nIHN0
dWZmIHRvIHRoZSBrZXJuZWwgaXMKPiAKPiAiR29vZ2xlIGRldmVsb3BzIGl0LCB0aGVuIG1vZGlm
aWVzIGl0IHRvIGFkZHJlc3MgdGhlIHJldmlldyBjb21tZW50cywKPiB0aGVuIGl0IGlzIG1lcmdl
ZCwgdGhlbiBpdCBpcyBkZXBsb3llZCIuCj4gCj4gVW5mb3J0dW5hdGVseSB3aGF0IEdvb2dsZSBk
aWQgaGVyZSBpczoKPiAKPiAiR29vZ2xlIGRldmVsb3BzIGl0IGJlaGluZCB0aGUgY2xvc2VkIGRv
b3IsIHRoZW4gZGVwbG95cyBpdC4gV2hlbgo+IGFza2VkIGZvciBjaGFuZ2VzLCBHb29nbGUgZXhw
ZWN0cyBzb21lb25lIGVsc2UgdG8gY3JlYXRlIHN5c3RlbQo+IGNvbXBhdGlibGUgd2l0aCB0aGVp
ciBleGlzdGluZyBzb2x1dGlvbiwgb3IgZWxzZSB0aGVpciBwYXRjaGVzIGJlaW5nCj4gbWVyZ2Vk
LiIKClRoYXQgYmFzaWNhbGx5IHN1bXMgaXQgdXAgYXMgZmFyIGFzIEkgc2VlLgoKCUJlcm5kCi0t
IApCZXJuZCBQZXRyb3ZpdHNjaCAgICAgICAgICAgICAgICAgIEVtYWlsIDogYmVybmRAcGV0cm92
aXRzY2gucHJpdi5hdAogICAgICAgICAgICAgICAgICAgICBMVUdBIDogaHR0cDovL3d3dy5sdWdh
LmF0CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
