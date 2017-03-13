From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
Date: Mon, 13 Mar 2017 10:44:48 +0800
Message-ID: <1489373088.5841.15.camel@intel.com>
References: <20170310150218.GW21222@n2100.armlinux.org.uk>
 <CAJZ5v0jGRH_hwvvm9OLsaYgbghqWKOke9PyGNnkvP_ZiMqAxSw@mail.gmail.com>
 <BY2PR21MB00362E60448FD2E00C120FFCCB200@BY2PR21MB0036.namprd21.prod.outlook.com>
 <BY2PR21MB00361C512E03B09DBCE715D3CB200@BY2PR21MB0036.namprd21.prod.outlook.com>
 <20170310234325.GB21222@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170310234325.GB21222@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Matthew Wilcox <mawilcox@microsoft.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

CgpPbiBGcmksIDIwMTctMDMtMTAgYXQgMjM6NDMgKzAwMDAsIFJ1c3NlbGwgS2luZyAtIEFSTSBM
aW51eCB3cm90ZToKPiBPbiBGcmksIE1hciAxMCwgMjAxNyBhdCAwNjozMzoyOFBNICswMDAwLCBN
YXR0aGV3IFdpbGNveCB3cm90ZToKPiA+IAo+ID4gRnJvbSBjZDU0MDFkODE2MzNkNWU0OGUzOWQ2
N2Q0ZTY1MTU2ZTY3NTk1MzdlIE1vbiBTZXAgMTcgMDA6MDA6MDAKPiA+IDIwMDEKPiA+IEZyb206
IE1hdHRoZXcgV2lsY294IDxtYXdpbGNveEBtaWNyb3NvZnQuY29tPgo+ID4gRGF0ZTogRnJpLCAx
MCBNYXIgMjAxNyAxMzoyMjo1MyAtMDUwMAo+ID4gU3ViamVjdDogW1BBVENIXSB0aGVybWFsOiBG
aXggcG90ZW50aWFsIGRlYWRsb2NrIGluIGNwdV9jb29saW5nCj4gPiAKPiA+IEkgZXhwYW5kZWQg
dGhlIHNjb3BlIG9mIGNvb2xpbmdfbGlzdF9sb2NrIGEgbGl0dGxlIHRvbyBmYXI7IGl0IHdhcwo+
ID4gbm90IGp1c3QgY292ZXJpbmcgY3B1ZnJlcV9kZXZfY291bnQsIGl0IHdhcyBhbHNvIGNvdmVy
aW5nIHRoZSBjYWxscwo+ID4gdG8gY3B1ZnJlcV9yZWdpc3Rlcl9ub3RpZmllcigpIGFuZCBjcHVm
cmVxX3VucmVnaXN0ZXJfbm90aWZpZXIoKS4KPiA+IFNpbmNlIGNvb2xpbmdfbGlzdF9sb2NrIGlz
IGFsc28gdXNlZCB3aXRoaW4KPiA+IGNwdWZyZXFfdGhlcm1hbF9ub3RpZmllcigpLAo+ID4gbG9j
a2RlcCByZXBvcnRzIGEgcG90ZW50aWFsIGRlYWRsb2NrLsKgwqBJIGRvbid0IHRoaW5rIHRoYXQn
cwo+ID4gYWN0dWFsbHkKPiA+IHBvc3NpYmxlLCBidXQgaXQncyBlYXN5IGVub3VnaCB0byBtYWtl
IGl0IGltcG9zc2libGUgYnkgdGVzdGluZyB0aGUKPiA+IGNvbmRpdGlvbiB1bmRlciBjb29saW5n
X2xpc3RfbG9jayBhbmQgZHJvcHBpbmcgdGhlIGxvY2sgYmVmb3JlCj4gPiBjYWxsaW5nCj4gPiBj
cHVmcmVxX3JlZ2lzdGVyX25vdGlmaWVyKCkuCj4gPiAKPiA+IEFzIGEgYm9udXMsIEkgbm90aWNl
ZCB0aGF0IGNwdWZyZXFfZGV2X2NvdW50IGlzIG9ubHkgdXNlZCBmb3IgdGhlCj4gPiBwdXJwb3Nl
Cj4gPiBvZiBrbm93aW5nIHdoZXRoZXIgdGhpcyBpcyB0aGUgZmlyc3Qgb3IgbGFzdCBjb29saW5n
IGRldmljZQo+ID4gcmVnaXN0ZXJlZCwKPiA+IGFuZCB3ZSBrbm93IHRoYXQgYW55d2F5IGJlY2F1
c2Ugd2Uga25vdyB3aGV0aGVyIHRoZSBsaXN0Cj4gPiB0cmFuc2l0aW9uZWQKPiA+IGJldHdlZW4g
ZW1wdHkgYW5kIG5vdC1lbXB0eS7CoMKgU28gd2UgY2FuIGRlbGV0ZSB0aGF0IHZhcmlhYmxlIHRv
by4KPiA+IAo+ID4gRml4ZXM6IGFlNjA2MDg5NjIxZWYwMzQ5NDAyY2ZjYmVjYTMzYTgyYWJiZDBm
ZDAKPiA+IFJlcG9ydGVkLWJ5OiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFybWxpbnV4Lm9yZy51az4K
PiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRoZXcgV2lsY294IDxtYXdpbGNveEBtaWNyb3NvZnQuY29t
Pgo+IFRoYW5rcyBNYXR0aGV3LCBhcHBlYXJzIHRvIHNvbHZlIHRoZSBwcm9ibGVtLgo+IAo+IFRl
c3RlZC1ieTogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxpbnV4Lm9yZy51az4KPiAKCnBh
dGNoIGFwcGxpZWQuCgp0aGFua3MsCnJ1aQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
