From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Tue, 3 Aug 2010 18:34:47 -0700
Message-ID: <20100803183447.0275c134__43474.3150872693$1280885740$gmane$org@infradead.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
	<AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=a-1hn_oL=i-=RKK9xOur+4mQjTRut+aiXtYkE@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyIEF1ZyAyMDEwIDIxOjU2OjEwIC0wNzAwCkFydmUgSGrDuG5uZXbDpWcgPGFydmVA
YW5kcm9pZC5jb20+IHdyb3RlOgoKPiA+IG5vbi1vYnZpb3VzIGRlcGVuZGVuY2llcy4KPiA+Cj4g
Cj4gVGhlIGRlcGVuZGVuY2llcyBpcyB3aGF0IG1hZGUgdGhpcyBzb2x1dGlvbiB1bmludGVyZXN0
aW5nIHRvIHVzLiBGb3IKPiBpbnN0YW5jZSwgd2UgY3VycmVudGx5IHVzZSBjZ3JvdXAgc2NoZWR1
bGluZyB0byByZWR1Y2UgdGhlIGltcGFjdCBvZgo+IHNvbWUgYmFja2dyb3VuZCB0YXNrcywgYnV0
IHdlIG9jY2FzaW9uYWxseSBzYXcgYSB3YXRjaGRvZyByZXN0YXJ0IG9mCj4gdGhlIHN5c3RlbSBw
cm9jZXNzIHdlcmUgY3JpdGljYWwgc2VydmljZXMgd2VyZSB3YWl0aW5nIG9uIGEga2VybmVsCj4g
bXV0ZXggb3duZWQgYnkgYSBiYWNrZ3JvdW5kIHRhc2sgZm9yIG1vcmUgdGhhbiAyMCBzZWNvbmRz
LiBJZiB3ZSBmcm96ZQo+IGEgY2dyb3VwIGluc3RlYWQsIHdlIHdvdWxkIG5vdCBoaXQgdGhpcyBw
YXJ0aWN1bGFyIHByb2JsZW0gc2luY2UgdGFza3MKPiBjYW5ub3QgYmUgZnJvemVuIHdoaWxlIGV4
ZWN1dGluZyBrZXJuZWwgY29kZSB0aGUgc2FtZSB3YXkgdGhleSBjYW4gYmUKPiBwcmVlbXB0ZWQs
IGJ1dCBub3RoaW5nIHByZXZlbnRzIGEgdGFzayBmcm9tIGJlaW5nIGZyb3plbiB3aGlsZSBob2xk
aW5nCj4gYSB1c2VyLXNwYWNlIHJlc291cmNlLgo+IAoKCm9uZSBvZiB0aGUgc29sdXRpb25zIHdl
J3JlIGxvb2tpbmcgYXQgdG8gc29sdmUgdGhpcyBpcyB0byB1bmZyZWV6ZSB0aGUKY2dyb3VwIG9u
IGEgcmVndWxhciBiYXNpcyAoc2F5LCBldmVyeSAxNSB0byAzMCBzZWNvbmRzKSBicmllZmx5IHRv
IGF2b2lkCnRoaXMga2luZCBvZiBkZWFkbG9jay4uLgoKCgotLSAKQXJqYW4gdmFuIGRlIFZlbiAJ
SW50ZWwgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50cmUKRm9yIGRldmVsb3BtZW50LCBkaXNj
dXNzaW9uIGFuZCB0aXBzIGZvciBwb3dlciBzYXZpbmdzLCAKdmlzaXQgaHR0cDovL3d3dy5sZXNz
d2F0dHMub3JnCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtcG0=
