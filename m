From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 17:34:57 +1000
Message-ID: <20100527173457.167bdd87__22410.1459062242$1274973987$gmane$org@notabene.brown>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<201005252344.37639.rjw@sisk.pl>
	<AANLkTimL5rU5lALezEZVCwdcZL85tVahhsTibdpq9s-Y@mail.gmail.com>
	<1274863342.5882.4850.camel@twins>
	<20100526112303.3fef15a4@schatten.dmk.lab>
	<1274866402.5882.5051.camel@twins>
	<AANLkTil9ZtMFxTfE6ITiFNOl4S1k3Lvdp5BPgGX7LJhw@mail.gmail.com>
	<1274868384.5882.5169.camel@twins>
	<AANLkTimHGpRAZklIwXu6wEbA3coKXJvCVLxj2twerkCw@mail.gmail.com>
	<1274869262.5882.5222.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274869262.5882.5222.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-doc@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andi Kleen <ak@linux.intel.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, tytso@mit.edu, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyNiBNYXkgMjAxMCAxMjoyMTowMiArMDIwMApQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgoKPiBPbiBXZWQsIDIwMTAtMDUtMjYgYXQgMDM6MTcgLTA3
MDAsIEFydmUgSGrDuG5uZXbDpWcgd3JvdGU6Cj4gPiA+IFdpdGggYSBzaW5nbGUgc3VzcGVuZCBt
YW5hZ2VyIHByb2Nlc3MgdGhhdCBtYW5hZ2VzIHRoZSBzdXNwZW5kIHN0YXRlIHlvdQo+ID4gPiBj
YW4gYWNoaWV2ZSB0aGUgc2FtZSBnb2FsLgo+ID4gPgo+ID4gCj4gPiBZZXMgd2UgZG9uJ3QgbmVl
ZCB0aGUgL2RldiBpbnRlcmZhY2UsIGJ1dCBpdCBpcyB1c2VmdWwuIFdpdGhvdXQgaXQgYW55Cj4g
PiBwcm9ncmFtIHRoYXQgbmVlZHMgdG8gYmxvY2sgc3VzcGVuZCBoYXMgdG8gbWFrZSBhIGJsb2Nr
aW5nIGlwYyBjYWxsCj4gPiBpbnRvIHRoZSBzdXNwZW5kIG1hbmFnZXIgcHJvY2Vzcy4gQW5kcm9p
ZCBhbHJlYWR5IGRvZXMgdGhpcyBmb3IgamF2YQo+ID4gY29kZSwgYnV0IHN5c3RlbSBwcm9jZXNz
ZXMgd3JpdHRlbiBpbiBDIGJsb2NrIHN1c3BlbmQgZGlyZWN0bHkgd2l0aAo+ID4gdGhlIGtlcm5l
bCBzaW5jZSB0aGV5IGNhbm5vdCB1c2UgdGhlIGphdmEgQVBJcy4gCj4gCj4gU28gcHJvdmlkZSBh
IEMgaW50ZXJmYWNlIHRvIGl0IGFzIHdlbGw/Cj4gCj4gU3VyZWx5IHlvdSBjYW4gaGF2ZSB0aGUg
amF2YSB0aGluZyBoYXZlIGEgdW5peCBzb2NrZXQgb3Igc29tZXRoaW5nIGEgQwo+IGFwcCBjYW4g
dGFsayB0by4gVGhhdCBzaG91bGRuJ3QgYmUgaGFyZCBhdCBhbGwuCj4gCj4gT3IgbWFrZSB0aGUg
c3VzcGVuZCBtYW5hZ2VyIGEgQyBwcm9nbGV0IGFuZCBwcm92aWRlIGEgSk5JIGludGVyZmFjZSwg
b3IKPiB3aGF0ZXZlci4KCkkgZmFpbCB0byB1bmRlcnN0YW5kIHRoZSBtb2Rlcm4gZmFzY2luYXRp
b24gd2l0aCBjb21wbGV4IElQQyBtZWNoYW5pc21zLgoKSWYgeW91IGhhdmUgYSB1c2Vyc3BhY2Ug
cHJvY2VzcyB0aGF0IGluaXRpYXRlcyBzdXNwZW5kcywgYW5kIHlvdSB3YW50IG90aGVyCnVzZXIt
c3BhY2UgcHJvY2Vzc2VzIHRvIGJlIGFibGUgdG8gYmxvY2sgdGhhdCBzdXNwZW5kLCB0aGVuIEkg
d291bGQgc3VnZ2VzdAp0aGUgdXNlIG9mIGEgbG9jay1maWxlLiAgL3Zhci9ydW4vc3VzcGVuZC9i
bG9ja2VkIG1heWJlLgoKVG8gYmxvY2sgc3VzcGVuZCwgeW91IG9wZW4gdGhlIGZpbGUgYW5kIGdl
dCBhIHJlYWQgbG9jay4KVG8gaW5pdGlhdGUgYSBzdXNwZW5kIHlvdSB0YWtlIGEgd3JpdGUtbG9j
ayAoYmxvY2tpbmcgaWYgbmVjZXNzYXJ5KSwgdGhlbgphc2sgdGhlIGtlcm5lbCB0byBzdXNwZW5k
LgpUbyByZXN0cmljdCBhY2Nlc3MgdG8gcGFydGljdWxhciB1c2VycyB5b3UgdXNlIHBlcm1pc3Np
b25zIC0gZWl0aGVyIGdyb3VwCmJhc2VkIG9yIEFDTHMgKG9yIGJvdGgpLgpUaGlzIGlzIGFsbCBl
YXN5IHRvIGRvIGZyb20gQyBvciBweXRob24gb3IgcGVybCBvciBwcmVzdW1hYmx5IGV2ZW4gamF2
YS4uCihJIHVzZSB0aGlzIG1lY2hhbmlzbSBvbiBteSBGcmVlcnVubmVyIGFuZCBldmVuIGhhdmUg
c2hlbGwgc2NyaXB0cyB0aGF0CmhhcHBpbHkgcHJldmVudCBzdXNwZW5kKS4KCk5laWxCcm93bgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBt
YWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
