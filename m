From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 17:22:10 -0700
Message-ID: <AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU__7590.37036118588$1281054324$gmane$org@mail.gmail.com>
References: <alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050832010.25170@asgard.lang.hm>
	<AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<20100805203102.GN2447@linux.vnet.ibm.com>
	<AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgNSwgMjAxMCBhdCA1OjE2IFBNLCAgPGRhdmlkQGxhbmcuaG0+IHdyb3RlOgo+
Pj4KPj4+IFNvIGZvciBhbiBtcDMgcGxheWJhY2ssIGRvZXMgYW4gQW5kcm9pZCBzdXNwZW5kIGJl
dHdlZW4gZGF0YSBmZXRjaGVzPwo+Pgo+PiBJdCBjYW4gaWYgdGhlIGxhdGVuY3kgaXMgbG9uZyBl
bm91Z2ggKHdoaWNoIGlzIHdoeSBJIHBvaW50IG91dCBsb3cKPj4gcG93ZXIgYXVkaW8gd2hpY2gg
aXMgdXN1YWxseSBoaWdoIGxhdGVuY3kpLiDCoEZvciBsb3cgbGF0ZW5jeSAoc3lzdGVtCj4+IHNv
dW5kcywgZXRjKSAxMC0yNW1zIGJldHdlZW4gYnVmZmVycyBpdCdzIG5vdCBwcmFjdGljYWwgdG8g
ZnVsbHkKPj4gc3VzcGVuZCBidXQgd2Ugd2lsbCBnbyB0byB0aGUgbG93ZXN0IHBvd2VyIHN0YXRl
IGluIGlkbGUgaWYgcG9zc2libGUuCj4KPiB0aGUgcGxheWJhY2sgaXMgYWJsZSB0byBjb250aW51
ZSBldmVuIHdpdGggYWxsIHRoZSBjbG9ja3Mgc3RvcHBlZD8gdGhhdAo+IHN1cnByaXNlcyBtZS4g
SSB3b3VsZCBoYXYgZXhwZWN0ZWQgaXQgdG8gYmUgYWJsZSB0byBzbGVlcCB3aGlsZSBwbGF5aW5n
Cj4gYXVkaW8sIGJ1dCBub3QgZG8gYSBmdWxsIHN1c3BlbmQuCgpPYnZpb3VzbHkgbm90IGFsbCBj
bG9ja3MgYXJlIHN0b3BwZWQgKHRoZSBEU1AgYW5kIGNvZGVjIGFyZSBwb3dlcmVkCmFuZCBjbG9j
a2VkLCBmb3IgZXhhbXBsZSksIGJ1dCB5ZWFoIHdlIGNhbiBjbG9jayBnYXRlIGFuZCBwb3dlciBn
YXRlCnRoZSBjcHUgYW5kIG1vc3Qgb3RoZXIgcGVyaXBoZXJhbHMgd2hpbGUgYXVkaW8gaXMgcGxh
eWluZyBvbiBhIG51bWJlcgpvZiBBUk0gU29DIGRlc2lnbnMgYXZhaWxhYmxlIHRvZGF5IChhbmQg
dGhlIHBhc3QgZmV3IHllYXJzKS4KCkJyaWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtcG0=
