From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be smp
	?
Date: Fri, 15 Apr 2011 12:33:12 -0400
Message-ID: <BANLkTikaymG-5-YoTnG2SPJCnBtXPpfHBQ__15909.1273825199$1302885351$gmane$org@mail.gmail.com>
References: <BANLkTinj3y+-VhzFAPz8Gzb5vAbtUFU6Aw@mail.gmail.com>
	<Pine.LNX.4.44L0.1104131757430.2005-100000@iolanthe.rowland.org>
	<20110415162938.GA11454@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110415162938.GA11454@atrey.karlin.mff.cuni.cz>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gRnJpLCBBcHIgMTUsIDIwMTEgYXQgMTI6MjksIFBhdmVsIE1hY2hlayB3cm90ZToKPj4gPiA+
IEkgYmVsaWV2ZSB0aGUgY29kZSBpcyBjb3JyZWN0IGFzIGlzLgo+PiA+Cj4+ID4gdGhhdCBpc250
IHdoYXQgdGhlIGNvZGUgLyBkb2N1bWVudGF0aW9uIHNheXMuIMKgdW5sZXNzIGknbSByZWFkaW5n
IHRoZW0KPj4gPiB3cm9uZywgYm90aCBzZWVtIHRvIGluZGljYXRlIHRoYXQgdGhlIHByb3Bvc2Vk
IHBhdGNoIGlzIHdoYXQgd2UKPj4gPiBhY3R1YWxseSB3YW50Lgo+Pgo+PiBUaGUgZXhpc3Rpbmcg
Y29kZSBpcyBjb3JyZWN0IGJ1dCBpdCBpc24ndCBvcHRpbWFsLgo+Pgo+PiB3bWIoKSBhbmQgcm1i
KCkgYXJlIGhlYXZ5LWR1dHkgb3BlcmF0aW9ucywgYW5kIHlvdSBkb24ndCB3YW50IHRvIGNhbGwK
Pj4gdGhlbSB3aGVuIHRoZXkgYXJlbid0IG5lZWRlZC4gwqBUaGF0J3MgZXhhY3RseSB3aGF0IHNt
cF93bWIoKSBhbmQKPj4gc21wX3JtYigpIGFyZSBmb3IgLS0gdGhleSBjYWxsIHdtYigpIGFuZCBy
bWIoKSwgYnV0IG9ubHkgaW4gU01QCj4+IGtlcm5lbHMuCj4+Cj4+IFVubGVzcyB5b3UgbmVlZCB0
byBzeW5jaHJvbml6ZSB3aXRoIGFub3RoZXIgcHJvY2Vzc29yIChub3QgbmVjZXNzYXJpbHkKPj4g
YSBDUFUsIGl0IGNvdWxkIGJlIHNvbWV0aGluZyBlbWJlZGRlZCB3aXRoaW4gYSBkZXZpY2UpLCB5
b3Ugc2hvdWxkCj4+IGFsd2F5cyB1c2Ugc21wX3dtYigpIGFuZCBzbXBfcm1iKCkgcmF0aGVyIHRo
YW4gd21iKCkgYW5kIHJtYigpLgo+Cj4gTWF5YmU7IGJ1dCB0aGlzIGNvZGUgaXMgbm90IHBlcmZv
cm1hbmNlIGNyaXRpY2FsIGFuZCBJIGJlbGlldmUgYmVpbmcKPiBvYnZpb3VzIGhlcmUgaXMgYmV0
dGVyLi4uCgppc250IGl0IHRob3VnaCA/ICBlc3BlY2lhbGx5IHdoZW4gd2UgdGFsayBhYm91dCBz
dXNwZW5kaW5nL3Jlc3VtaW5nIG9uCmVtYmVkZGVkIHN5c3RlbXMgdG8gZ2V0IG1vcmUgc2F2aW5n
cyBvdmVyIGp1c3QgY3B1IGlkbGUgPyAgd2Ugd2FudAp0aGF0IGxhdGVuY3kgdG8gYmUgYXMgbG93
IGFzIHBvc3NpYmxlLgotbWlrZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXBt
