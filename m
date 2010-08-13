From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 18:28:27 +0300
Message-ID: <AANLkTimGHYZ4ndznJY-vjBb164xMSiGMeoJs=9=baSFi__27531.3711529181$1281713448$gmane$org@mail.gmail.com>
References: <20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100811004223.GH2379@linux.vnet.ibm.com>
	<AANLkTik7Po9OuKC-QBZ=E83J70sU_ewNi+nNWgcjjLXd@mail.gmail.com>
	<20100811221258.GI2516@linux.vnet.ibm.com>
	<AANLkTi=fJjM=uWeV+L66ajM9rhrL0t1OO-C7ThNRdbae@mail.gmail.com>
	<20100812161935.GC2524@linux.vnet.ibm.com>
	<AANLkTi=51cFa0t5ZYj2CMiauuW80ZWTrm1tQkn63Et0F@mail.gmail.com>
	<20100813151451.GC2511@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100813151451.GC2511@linux.vnet.ibm.com>
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

T24gRnJpLCBBdWcgMTMsIDIwMTAgYXQgNjoxNCBQTSwgUGF1bCBFLiBNY0tlbm5leQo8cGF1bG1j
a0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOgo+IE9uIFRodSwgQXVnIDEyLCAyMDEwIGF0IDA4
OjUyOjIyUE0gKzAzMDAsIEZlbGlwZSBDb250cmVyYXMgd3JvdGU6Cj4+IMKgNCkgbm8sIHdlIGNh
bid0IHNheSBhbnl0aGluZyBhYm91dCB3aGF0IG9wcG9ydHVuaXN0aWMgc3VzcGVuZCBtZWFucyBp
biBwcmFjdGljZQo+Cj4gSGVyZSBJIGRpc2FncmVlLiDCoFRoZSBBbmRyb2lkIGZvbGtzIGhhdmUg
dXNlZCBpdCBmb3IgcXVpdGUgc29tZSB0aW1lLgo+IFdlIG1pZ2h0IG5vdCBiZSBhYmxlIHRvIGFw
cGx5IHRoZWlyIGV4cGVyaWVuY2UgZGlyZWN0bHkgdG8gb3RoZXIgc29mdHdhcmUKPiBzdGFja3Ms
IGJ1dCB3ZSBzaG91bGQgbmV2ZXJ0aGVsZXNzIGJlIGFibGUgdG8gbGVhcm4gcXVpdGUgYSBiaXQg
ZnJvbSBpdC4KClNvIHdoZW4gaXQgY29tZXMgdG8gcHJhY3RpY2UgeW91IGFyZSByZWx5aW5nIHNv
bGVseSBvbiB3aGF0IEFuZHJvaWQgcGVvcGxlIHNheS4KCklmIGl0J3MgdHJ1ZSB0aGF0IGl0J3Mg
ZWFzeSB0byBzcG90IHRoZSAiUE0tZHJpdmluZyBhcHBsaWNhdGlvbnMiLAp0aGVuIGl0IHNob3Vs
ZG4ndCBiZSBoYXJkIGZvciBhIGd1eSBmcm9tIHRoZSBBbmRyb2lkIHRlYW0gdG8gYXNzZW1ibGUK
YSBiYXNpYyB0eXBpY2FsIHN5c3RlbSAoWC5vcmcsIGRidXMsIGV0Yy4pIHdpdGggc3VzcGVuZC1i
bG9ja2VycyBpbiBhCmNvdXBsZSBvZiBkYXlzLgoKLS0gCkZlbGlwZSBDb250cmVyYXMKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
