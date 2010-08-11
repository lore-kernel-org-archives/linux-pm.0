From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 22:25:04 +0300
Message-ID: <AANLkTing0RpAoYstVs1G5v-eZ0q6qGjrGiphUvBdOsaS__40282.4076045819$1281554755$gmane$org@mail.gmail.com>
References: <AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100810044541.GA2817@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCBBdWcgMTAsIDIwMTAgYXQgNzo0NSBBTSwgUGF1bCBFLiBNY0tlbm5leQo8cGF1bG1j
a0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+IE9uIE1vbiwgQXVnIDA5LCAyMDEwIGF0IDA4
OjE4OjIyUE0gKzAxMDAsIEFsYW4gQ294IHdyb3RlOgo+PiBZb3UgYXJlIHRpZ2h0bHkgbGlua2lu
ZyBzdXNwZW5kIGJsb2NrZXJzIHdpdGggQW5kcm9pZC4gSWYgdGhleSB3ZXJlIGEKPj4gc2Vuc2li
bGUgZ2VuZXJhbCBzb2x1dGlvbiB0aGV5IHdvdWxkIGJlIGdlbmVyaWMgbm90IHRpZWQgY2xvc2Vs
eSB0bwo+PiBBbmRyb2lkCj4KPiBBbmRyb2lkIGlzIGNlcnRhaW5seSB3aGVyZSBzdXNwZW5kIGJs
b2NrZXJzIG9yaWdpbmF0ZWQsIGFuZCBpcyB0byB0aGUgYmVzdAo+IG9mIG15IGtub3dsZWRnZSBp
cyBzdGlsbCB0aGUgb25seSBwbGF0Zm9ybSB0aGF0IHVzZXMgdGhlbS4gwqBCdXQgdGhlcmUgaXMK
PiBhIGZpcnN0IHVzZXIgb2YgZXZlcnkgbmV3IG1lY2hhbmlzbSwgYW5kIGZvciBzb21lIHRpbWUg
dGhhdCBmaXJzdCB1c2VyCj4gd2lsbCBieSBkZWZpbml0aW9uIGJlIHRoZSBvbmx5IHVzZXIgb2Yg
dGhhdCBtZWNoYW5pc20uIMKgU28gdGhlIGZhY3QKPiB0aGF0IEFuZHJvaWQgaXMgbW9zdCBwcm9i
YWJseSB0aGUgb25seSB1c2VyIG9mIHN1c3BlbmQgYmxvY2tlcnMgZG9lcwo+IG5vdCBwcm92ZSBh
bnl0aGluZyBhYm91dCB3aGV0aGVyIG9yIG5vdCBzdXNwZW5kIGJsb2NrZXJzIGFyZSBzZW5zaWJs
ZS4KCk5vLCBpdCdzIHRoZSBmYWN0IHRoYXQgKm5vYm9keSogZWxzZSBoYXMgc2FpZDogaGV5LCB0
aGF0IGxvb2tzIGxpa2UgYQpnb29kIGlkZWEsIHdlIHNob3VsZCB1c2UgdGhhdCBpbiBvdXIgbW9i
aWxlIHBsYXRmb3JtIChvciBhbnkKcGxhdGZvcm0pLgoKLS0gCkZlbGlwZSBDb250cmVyYXMKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFp
bGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
