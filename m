From: Brian Swetland <swetland@google.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 18:22:56 -0700
Message-ID: <AANLkTimWqFkDWvGwVGWD94488gs+CXgpB9juwM5G11ud__32752.3699067116$1281059852$gmane$org@mail.gmail.com>
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
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
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

T24gVGh1LCBBdWcgNSwgMjAxMCBhdCA2OjAxIFBNLCAgPGRhdmlkQGxhbmcuaG0+IHdyb3RlOgo+
IE9uIFRodSwgNSBBdWcgMjAxMCwgQnJpYW4gU3dldGxhbmQgd3JvdGU6Cj4+IE9uIFRodSwgQXVn
IDUsIDIwMTAgYXQgNToxNiBQTSwgwqA8ZGF2aWRAbGFuZy5obT4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+
IFNvIGZvciBhbiBtcDMgcGxheWJhY2ssIGRvZXMgYW4gQW5kcm9pZCBzdXNwZW5kIGJldHdlZW4g
ZGF0YSBmZXRjaGVzPwo+Pj4+Cj4+Pj4gSXQgY2FuIGlmIHRoZSBsYXRlbmN5IGlzIGxvbmcgZW5v
dWdoICh3aGljaCBpcyB3aHkgSSBwb2ludCBvdXQgbG93Cj4+Pj4gcG93ZXIgYXVkaW8gd2hpY2gg
aXMgdXN1YWxseSBoaWdoIGxhdGVuY3kpLiDCoEZvciBsb3cgbGF0ZW5jeSAoc3lzdGVtCj4+Pj4g
c291bmRzLCBldGMpIDEwLTI1bXMgYmV0d2VlbiBidWZmZXJzIGl0J3Mgbm90IHByYWN0aWNhbCB0
byBmdWxseQo+Pj4+IHN1c3BlbmQgYnV0IHdlIHdpbGwgZ28gdG8gdGhlIGxvd2VzdCBwb3dlciBz
dGF0ZSBpbiBpZGxlIGlmIHBvc3NpYmxlLgo+Pj4KPj4+IHRoZSBwbGF5YmFjayBpcyBhYmxlIHRv
IGNvbnRpbnVlIGV2ZW4gd2l0aCBhbGwgdGhlIGNsb2NrcyBzdG9wcGVkPyB0aGF0Cj4+PiBzdXJw
cmlzZXMgbWUuIEkgd291bGQgaGF2IGV4cGVjdGVkIGl0IHRvIGJlIGFibGUgdG8gc2xlZXAgd2hp
bGUgcGxheWluZwo+Pj4gYXVkaW8sIGJ1dCBub3QgZG8gYSBmdWxsIHN1c3BlbmQuCj4+Cj4+IE9i
dmlvdXNseSBub3QgYWxsIGNsb2NrcyBhcmUgc3RvcHBlZCAodGhlIERTUCBhbmQgY29kZWMgYXJl
IHBvd2VyZWQKPj4gYW5kIGNsb2NrZWQsIGZvciBleGFtcGxlKSwgYnV0IHllYWggd2UgY2FuIGNs
b2NrIGdhdGUgYW5kIHBvd2VyIGdhdGUKPj4gdGhlIGNwdSBhbmQgbW9zdCBvdGhlciBwZXJpcGhl
cmFscyB3aGlsZSBhdWRpbyBpcyBwbGF5aW5nIG9uIGEgbnVtYmVyCj4+IG9mIEFSTSBTb0MgZGVz
aWducyBhdmFpbGFibGUgdG9kYXkgKGFuZCB0aGUgcGFzdCBmZXcgeWVhcnMpLgo+Cj4gZG9lcyB0
aGlzIHRoZW4gbWVhbiB0aGF0IHlvdSBoYXZlIG11bHRpcGxlIHZhcmlhdGlvbnMgb2Ygc3VzcGVu
ZD8KPgo+IGZvciBleGFtcGxlLCBvbmUgd2hlcmUgdGhlIGF1ZGlvIHN0dWZmIGlzIGxlZnQgcG93
ZXJlZCwgYW5kIG9uZSB3aGVyZSBpdAo+IGlzbid0PwoKV2hpbGUgdGhlIGNwdSAoYW5kIHRoZSBi
dWxrIG9mIHRoZSBzeXN0ZW0pIGlzIHN1c3BlbmRlZCwgaXQncyBub3QKdW5jb21tb24gZm9yIHNv
bWUgcGVyaXBoZXJhbHMgdG8gY29udGludWUgdG8gb3BlcmF0ZSAtLSBmb3IgZXhhbXBsZSBhCmNl
bGx1bGFyIHJhZGlvLCBncHMsIGxvdyBwb3dlciBhdWRpbyBwbGF5YmFjaywgZXRjLiAgRGV0YWls
cyB3aWxsIHZhcnkKZGVwZW5kaW5nIG9uIHRoZSBTb0MgYW5kIGJvYXJkIGRlc2lnbi4gIEl0J3Mg
bm90IHNvIG11Y2ggYSBkaWZmZXJlbnQKc3VzcGVuZCBtb2RlICh0aGUgc3lzdGVtIGlzIHN0aWxs
IHN1c3BlbmRlZCksIGp1c3QgYSBtYXR0ZXIgb2Ygd2hldGhlcgphIHBlcmlwaGVyYWwgY2FuIG9w
ZXJhdGUgaW5kZXBlbmRlbnRseSAoYW5kIGlmIGl0IGlzIGxvd2VyIHBvd2VyIGZvcgppdCB0byBk
byBzbykuCgpCcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXBt
