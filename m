From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 5 May 2010 14:37:39 -0700
Message-ID: <z2ta55d774e1005051437heb584584q6afca0b4b254d5d0__42833.448565989$1273096213$gmane$org@mail.gmail.com>
References: <20100505202826.GB7450@linux.intel.com>
	<Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005051705200.1885-100000@iolanthe.rowland.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, markgross@thegnar.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBNYXkgNSwgMjAxMCBhdCAyOjEyIFBNLCBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5k
LmhhcnZhcmQuZWR1PiB3cm90ZToKPj4KPj4gT2gsIGxpa2UgdGVsbCB0aGUgbW9kZW0gdGhhdCB1
c2VyIG1vZGUgaGFzIGhhbmRsZWQgdGhlIHJpbmcgZXZlbnQgYW5kCj4+IGl0cyBvayB0byB1bi1i
bG9jaz8KPgo+IE5vLCB0aGF0J3Mgbm90IGhvdyBpdCB3b3Jrcy4gwqBJdCB3b3VsZCBnbyBsaWtl
IHRoaXM6Cj4KPiDCoCDCoCDCoCDCoFRoZSBtb2RlbSBJUlEgaGFuZGxlciBxdWV1ZXMgaXRzIGV2
ZW50IHRvIHRoZSBpbnB1dCBzdWJzeXN0ZW0uCj4gwqAgwqAgwqAgwqBBcyBpdCBkb2VzIHNvIHRo
ZSBpbnB1dCBzdWJzeXN0ZW0gZW5hYmxlcyBhIHN1c3BlbmQgYmxvY2tlciwKPiDCoCDCoCDCoCDC
oGNhdXNpbmcgdGhlIHN5c3RlbSB0byBzdGF5IGF3YWtlIGFmdGVyIHRoZSBJUlEgaXMgZG9uZS4K
Pgo+IMKgIMKgIMKgIMKgVGhlIHVzZXIgcHJvZ3JhbSBlbmFibGVzIGl0cyBvd24gc3VzcGVuZCBi
bG9ja2VyIGJlZm9yZSByZWFkaW5nCj4gwqAgwqAgwqAgwqB0aGUgaW5wdXQgcXVldWUuIMKgV2hl
biB0aGUgcXVldWUgaXMgZW1wdHksIHRoZSBpbnB1dCBzdWJzeXN0ZW0KPiDCoCDCoCDCoCDCoHJl
bGVhc2VzIGl0cyBzdXNwZW5kIGJsb2NrZXIuCj4KPiDCoCDCoCDCoCDCoFdoZW4gdGhlIHVzZXIg
cHJvZ3JhbSBmaW5pc2hlcyBwcm9jZXNzaW5nIHRoZSBldmVudCwgaXQKPiDCoCDCoCDCoCDCoHJl
bGVhc2VzIGl0cyBzdXNwZW5kIGJsb2NrZXIuIMKgTm93IHRoZSBzeXN0ZW0gY2FuIGdvIGJhY2sg
dG8KPiDCoCDCoCDCoCDCoHNsZWVwLgo+Cj4gQXQgbm8gcG9pbnQgZG9lcyB0aGUgdXNlciBwcm9n
cmFtIGhhdmUgdG8gY29tbXVuaWNhdGUgYW55dGhpbmcgdG8gdGhlCj4gbW9kZW0gZHJpdmVyLCBh
bmQgYXQgbm8gcG9pbnQgZG9lcyBpdCBoYXZlIHRvIGRvIGFueXRoaW5nIG91dCBvZiB0aGUKPiBv
cmRpbmFyeSBleGNlcHQgdG8gZW5hYmxlIGFuZCBkaXNhYmxlIGEgc3VzcGVuZCBibG9ja2VyLgoK
RXhhY3RseSAtLSBhbmQgeW91IGNhbiB1c2UgdGhlIHNhbWUgc3R5bGUgb2Ygb3ZlcmxhcHBpbmcg
c3VzcGVuZApibG9ja2VycyB3aXRoIG90aGVyIGRyaXZlcnMgdGhhbiBpbnB1dCwgaWYgdGhlIGlu
cHV0IGludGVyZmFjZSBpcyBub3QKc3VpdGFibGUgZm9yIHRoZSBwYXJ0aWN1bGFyIGludGVyYWN0
aW9uLgoKQnJpYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1wbQ==
