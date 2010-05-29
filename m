From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 08:11:58 -0700
Message-ID: <AANLkTim7LMG0kcYwmcL9AcdR5-GgcCyb2ZagJhGyt2_e__24510.3016183295$1275146050$gmane$org@mail.gmail.com>
References: <AANLkTimyLsldXoZ_egjybwS9kE_OcxsOuZwC0F-C2HjY@mail.gmail.com>
	<Pine.LNX.4.44L0.1005291056490.31946-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005291056490.31946-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

T24gU2F0LCBNYXkgMjksIDIwMTAgYXQgODowMyBBTSwgQWxhbiBTdGVybiA8c3Rlcm5Acm93bGFu
ZC5oYXJ2YXJkLmVkdT4gd3JvdGU6Cj4gT24gU2F0LCAyOSBNYXkgMjAxMCwgQnJpYW4gU3dldGxh
bmQgd3JvdGU6Cj4+IE9uIFNhdCwgTWF5IDI5LCAyMDEwIGF0IDc6MTAgQU0sIEFsYW4gU3Rlcm4g
PHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+IHdyb3RlOgo+PiA+IElmIG5vIHN1Y2ggY29uc3Ry
YWludHMgYXJlIGFjdGl2ZSwgdGhlIFFvUy1iYXNlZCBzdXNwZW5kIGJsb2NrcyBpbiBhbgo+PiA+
IGludGVycnVwdGlibGUgd2FpdCB1bnRpbCB0aGUgbnVtYmVyIG9mIGFjdGl2ZSBRT1NfRVZFTlRV
QUxMWQo+PiA+IGNvbnN0cmFpbnRzIGRyb3BzIHRvIDAuIMKgV2hlbiB0aGF0IGhhcHBlbnMsIGl0
IGNhcnJpZXMgb3V0IGEgbm9ybWFsCj4+ID4gc3VzcGVuZC10by1SQU0gLS0gZXhjZXB0IHRoYXQg
aXQgY2hlY2tzIGFsb25nIHRoZSB3YXkgdG8gbWFrZSBzdXJlIHRoYXQKPj4gPiBubyBuZXcgUW9T
IGNvbnN0cmFpbnRzIGFyZSBhY3RpdmF0ZWQgd2hpbGUgdGhlIHN1c3BlbmQgaXMgaW4gcHJvZ3Jl
c3MuCj4+ID4gSWYgdGhleSBhcmUsIHRoZSBQTSBjb3JlIGJhY2tzIG91dCBhbmQgZmFpbHMgdGhl
IFFvUy1iYXNlZCBzdXNwZW5kLgo+Pgo+PiBUaGUgaXNzdWUgd2l0aCB0aGlzIGFwcHJvYWNoIGlz
IHRoYXQgaWYgdXNlcnNwYWNlIHdhbnRzIHRvIHN1c3BlbmQKPj4gd2hpbGUgYSBkcml2ZXIgaXMg
aG9sZGluZyBhIFFPU19FVkVOVFVBTExZIGNvbnN0cmFpbnQsIGl0J3MgYmFzaWNhbGx5Cj4+IGdv
aW5nIHRvIHNwaW4gY29uc3RhbnRseSB3cml0aW5nICJxb3MiIGFuZCBmYWlsaW5nLgo+Cj4gTm8s
IG5vLiDCoElmIHVzZXJzcGFjZSB3YW50cyB0byBzdXNwZW5kIHdoaWxlIGEgZHJpdmVyIGlzIGhv
bGRpbmcgYQo+IFFPU19FVkVOVFVBTExZIGNvbnN0cmFpbnQsIHRoZSB1c2VyIHByb2Nlc3MgYmxv
Y2tzIGluIGFuIGludGVycnVwdGlibGUKPiB3YWl0IHN0YXRlIGFzIGRlc2NyaWJlZCBpbiB0aGUg
Zmlyc3QgcGFyYWdyYXBoIGFib3ZlLgoKT29wcyAtLSBJIG1pc3JlYWQgdGhlIGZpcnN0IHBhcmFn
cmFwaC4gIFRoZSBiZWhhdmlvciB5b3UgZGVzY3JpYmVkIGlzCmluZGVlZCB3aGF0IEkgd291bGQg
d2FudC4KCkJyaWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtcG0=
