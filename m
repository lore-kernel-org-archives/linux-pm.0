From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 01:16:23 -0700
Message-ID: <AANLkTiky_4yCx5RQkK5eums7vcQPy2uSMyd41hQ2MA-6__41585.6973537759$1275898740$gmane$org@mail.gmail.com>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
	<20100606192405.GA7559@infradead.org>
	<AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
	<20100607080357.GB15851@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100607080357.GB15851@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBKdW4gNywgMjAxMCBhdCAxOjAzIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+IE9uIFN1biwgSnVuIDA2LCAyMDEwIGF0IDEyOjU4OjEwUE0g
LTA3MDAsIEJyaWFuIFN3ZXRsYW5kIHdyb3RlOgo+PiBUaGUgZ3JvdXAgSUQgc3R1ZmYgd29ya3Mg
aW5jcmVkaWJseSB3ZWxsIGZvciBnYXRpbmcgZGV2aWNlIGFjY2VzcyAtLQo+PiB3ZSBlbnN1cmUg
dGhhdCBkZXZpY2VzIHRoYXQgbmVlZCBhY2Nlc3MgZnJvbSB2YXJpb3VzIHByb2Nlc3NlcyBlbmQg
dXAKPj4gd2l0aCBwZXJtcyBsaWtlIDA2NjAgcm9vdCBhdWRpbyAoc2F5IGZvciBhIHJhdyBhdWRp
byBpbnRlcmZhY2UpLCBhbmQKPj4gdGhlbiB3ZSBhc3N1cmUgdGhhdCBwcm9jZXNzZXMgd2hpY2gg
aGF2ZSB0aGUgIm1heSB1c2UgYXVkaW8gaGFyZHdhcmUiCj4+IHBlcm1pc3Npb24gYXJlIGV4ZWN1
dGVkIHdpdGggYXVkaW8gYXMgYW4gYWRkaXRpb25hbCBncm91cC4gwqBXZSBlbmRlZAo+PiB1cCB1
c2luZyB0aGUgc2FtZSBtb2RlbCB0byBjb250cm9sIHNvY2tldCwgcmF3IHNvY2tldCwgYW5kIGJ0
IHNvY2tldAo+PiBhY2Nlc3MgYmVjYXVzZSBhdCB0aGUgdGltZSB3ZSBjb3VsZCBub3QgZmluZCBh
IHJlYXNvbmFibGUgd2F5IHRvIGdyYW50Cj4+IG9yIGV4Y2x1ZGUgc3VjaCBwZXJtaXNzaW9ucyBv
biBhIHByb2Nlc3MgYnkgcHJvY2VzcyBiYXNpcy4KPj4gTWFpbnRhaW5pbmcgYWJvdXQgMjAtMzAg
bGluZXMgb2YgZGlmZnMgdG8gbWFrZSB0aGF0IHdvcmsgd2FzIG5vdCBhIGJhZAo+PiB0cmFkZW9m
ZiAoYW5kIHdlIGRvbid0IGV4cGVjdCB0aG9zZSBwYXRjaGVzIHRvIGdvIHVwc3RyZWFtKS4gwqBJ
Zgo+PiB0aGVyZSdzIGEgd2F5IHRvIGFjY29tcGxpc2ggdGhpcyB3aXRob3V0IHBhdGNoaW5nIHRo
ZSBrZXJuZWwsIHdlJ3JlCj4+IGFsbCBlYXJzLgo+Cj4gSSdkIGhhdmUgdG8gdGFrZSBhIGxvb2sg
YWdhaW4gb24gaG93IHRoaXMgaXMgaW1wbGVtZW50ZWQgaW4gZGV0YWlscy4KPiBJZiBpdCdzIGp1
c3Qgb3ZlcnJpZGluZyB0aGUgY2FwYWJpbGl0aWVzIGl0J3MgcmVhbGx5IGhhcmQgdG8gZG8gaW4K
PiB0aGUgY3VycmVudCBtb2RlbCBhcyB0aGUgY2FwYWJpbGl0aWVzIGFyZW4ndCBmaW5lIGdyYWlu
ZWQgZW5vdWdoCj4gY3VycmVudGx5LCBldmVuIHdpdGggdGhlIGV4aXN0aW5nIHBlci1maWxlIGFu
ZCBwZXItcHJvY2VzcyBjYXBhYmlsaXRpZXMuCj4gSWYgaXQncyBtb3N0bHkgb3ZlcnJpZGluZyBy
ZWd1bGFyIHVuaXggZmlsZSBwZXJtaXNzaW9ucyBpdCdzIGVhc2lseQo+IGRvYWJsZSB3aXRoIEFD
THMsIG9yIGluIGZhY3QganVzdCB3aXRoIGdyb3VwIG93bmVyc2hpcCBhdCB0aGUgZmlsZXN5c3Rl
bQo+IGxldmVsLCB3aXRob3V0IGtlcm5lbCBoYWNrcy4KCkZvciBkZXZpY2Ugbm9kZXMsIHdlIGp1
c3QgdXNlIGdyb3VwIG93bmVyc2hpcCBhbmQgaXQgd29ya3MgZmluZSB3aXRoCm5vIGtlcm5lbCBt
b2RpZmljYXRpb25zLiAgRm9yIHRoZSAiY2FuIGNyZWF0ZSBzb2NrZXQiLCAiY2FuIGNyZWF0ZSBi
dApzb2NrZXQiLCBhbmQgImNhbiBjcmVhdGUgcmF3IHNvY2tldCIgcGVybWlzc2lvbnMgd2UgZW5k
ZWQgdXAgdGhyb3dpbmcKdG9nZXRoZXIgYSBwYXRjaCB0eWluZyB0aG9zZSBvcGVyYXRpb25zIHRv
IGJlaW5nIGluIHRoZSBhcHByb3ByaWF0ZQpncm91cC4gIE9idmlvdXNseSBhIGhhY2ssIGJ1dCBp
dCB3YXMgdGhlIG1vc3Qgc3RyYWlnaHRmb3J3YXJkIHNvbHV0aW9uCndlIGNvdWxkIGZpbmQgYXQg
dGhlIHRpbWUuCgpCcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXBt
