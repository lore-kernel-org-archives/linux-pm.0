From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Wed, 26 May 2010 12:21:02 +0200
Message-ID: <1274869262.5882.5222.camel__38672.4035758109$1274869309$gmane$org@twins>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA1LTI2IGF0IDAzOjE3IC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+ID4gV2l0aCBhIHNpbmdsZSBzdXNwZW5kIG1hbmFnZXIgcHJvY2VzcyB0aGF0IG1hbmFnZXMg
dGhlIHN1c3BlbmQgc3RhdGUgeW91Cj4gPiBjYW4gYWNoaWV2ZSB0aGUgc2FtZSBnb2FsLgo+ID4K
PiAKPiBZZXMgd2UgZG9uJ3QgbmVlZCB0aGUgL2RldiBpbnRlcmZhY2UsIGJ1dCBpdCBpcyB1c2Vm
dWwuIFdpdGhvdXQgaXQgYW55Cj4gcHJvZ3JhbSB0aGF0IG5lZWRzIHRvIGJsb2NrIHN1c3BlbmQg
aGFzIHRvIG1ha2UgYSBibG9ja2luZyBpcGMgY2FsbAo+IGludG8gdGhlIHN1c3BlbmQgbWFuYWdl
ciBwcm9jZXNzLiBBbmRyb2lkIGFscmVhZHkgZG9lcyB0aGlzIGZvciBqYXZhCj4gY29kZSwgYnV0
IHN5c3RlbSBwcm9jZXNzZXMgd3JpdHRlbiBpbiBDIGJsb2NrIHN1c3BlbmQgZGlyZWN0bHkgd2l0
aAo+IHRoZSBrZXJuZWwgc2luY2UgdGhleSBjYW5ub3QgdXNlIHRoZSBqYXZhIEFQSXMuIAoKU28g
cHJvdmlkZSBhIEMgaW50ZXJmYWNlIHRvIGl0IGFzIHdlbGw/CgpTdXJlbHkgeW91IGNhbiBoYXZl
IHRoZSBqYXZhIHRoaW5nIGhhdmUgYSB1bml4IHNvY2tldCBvciBzb21ldGhpbmcgYSBDCmFwcCBj
YW4gdGFsayB0by4gVGhhdCBzaG91bGRuJ3QgYmUgaGFyZCBhdCBhbGwuCgpPciBtYWtlIHRoZSBz
dXNwZW5kIG1hbmFnZXIgYSBDIHByb2dsZXQgYW5kIHByb3ZpZGUgYSBKTkkgaW50ZXJmYWNlLCBv
cgp3aGF0ZXZlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1wbQ==
