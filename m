From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take two
Date: Mon, 9 Aug 2010 00:34:12 -0700
Message-ID: <AANLkTikd6SvRH_u5hhEfqKRbYnwVpU0PN-NSUEtGyiA9__6661.72219575873$1281339304$gmane$org@mail.gmail.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100804195704.GA23681@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050616340.25170@asgard.lang.hm>
	<20100809072618.GB1586@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100809072618.GB1586@ucw.cz>
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
Cc: david@lang.hm, tytso@mit.edu, peterz@infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBBdWcgOSwgMjAxMCBhdCAxMjoyNiBBTSwgUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cu
Y3o+IHdyb3RlOgo+IEhpIQo+Cj4+ID5JIHNob3VsZCBoYXZlIGFza2VkIHRoaXMgZWFybGllci4u
LiDCoFdoYXQgZXhhY3RseSBhcmUgdGhlIGFwcHMnCj4+ID5jb21wYXRpYmlsaXR5IGNvbnN0cmFp
bnRzPyDCoFNvdXJjZS1sZXZlbCBBUElzPyDCoEJ5dGUtY29kZSBjbGFzcy1saWJyYXJ5Cj4+ID5p
bnZvY2F0aW9ucz8gwqBDL0MrKyBkeW5hbWljIGxpbmtpbmc/IMKgQy9DKysgc3RhdGljIGxpbmtp
bmcgKGluIG90aGVyCj4+ID53b3Jkcywgc3lzY2FsbCk/Cj4+Cj4+IEZvciBKYXZhL0RhbHZpayBh
cHBzLCB0aGUgd2FrZWxvY2sgQVBJIGlzIHBlcnR0eSBoaWdoIGxldmVsIC0tIGl0Cj4+IHRhbGtz
IHRvIGEgc2VydmljZSB2aWEgUlBDIChCaW5kZXIpIHRoYXQgYWN0dWFsbHkgaW50ZXJhY3RzIHdp
dGggdGhlCj4+IGtlcm5lbC4gwqBDaGFuZ2luZyB0aGUgYmFzaWMga2VybmVsPC0+dXNlcnNwYWNl
IGludGVyZmFjZSAod2l0aGluCj4KPiBTdHJhbmdlLiBBcnZlIGNsYWltZWQgdGhhdCBvcGVuL2Ns
b3NlIGlzIHRvbyBzbG93LCBhbmQgZmV3Cj4gbWljcm9zZWNvbmRzIGZhc3RlciBpb2N0bCBpcyBu
ZWVkZWQsIGFuZCBub3cgd2UgbGVhcm4gaXQgYWN0dWFsbHkgdXNlcwo+IFJQQy4KCkZvciB0aGUg
aGlnaCBsZXZlbCBKYXZhIEFQSSwgeWVzLiAgRm9yIGxvd2VyIGxldmVsIHVzZXJzcGFjZSBjb2Rl
LApsaWtlIHRoZSBjb2RlIHRoYXQgcHJvY2Vzc2VzIGtleXByZXNzZXMsIHRoZSBrZXJuZWwgaW50
ZXJmYWNlIGlzIHVzZWQKZGlyZWN0bHkuICBJIHRoaW5rIGFuIG9wZW4vY2xvc2UgcGVyIGtleXBy
ZXNzIHdvdWxkIGJlIGEgYml0CmV4Y2Vzc2l2ZSwgZm9yIGV4YW1wbGUuICBJbiBhbnkgY2FzZSwg
dGhhdCBpZ25vcmVzIHRoZSBmYWN0IHRoYXQgaXQncwp1c2VmdWwgdG8gaGF2ZSBzdGF0aXN0aWNz
LCB3aGljaCBhcmUgdHJpY2t5IHRvIG1haW50YWluIG1lYW5pbmdmdWxseQppZiB5b3UgZGVzdHJv
eSB0aGUgaGFuZGxlIGFmdGVyIHVzZSBldmVyeSB0aW1lIChieSBjbG9zaW5nIHRoZSBmZCkuCgpC
cmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
