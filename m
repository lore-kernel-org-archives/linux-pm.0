From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: Export frequency throttle state of
 the chip through sysfs
Date: Thu, 27 Aug 2015 15:47:04 +0530
Message-ID: <55DEE3A0.1090100@linux.vnet.ibm.com>
References: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1440667890.18333.1.camel@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1440667890.18333.1.camel@ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: linux-pm@vger.kernel.org

CgpPbiAwOC8yNy8yMDE1IDAzOjAxIFBNLCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOgo+IE9uIFRo
dSwgMjAxNS0wOC0yNyBhdCAxNDo0MyArMDUzMCwgU2hpbHBhc3JpIEcgQmhhdCB3cm90ZToKPj4g
Q3JlYXRlIGEgc3lzZnMgJ3Rocm90dGxlJyBhdHRyaWJ1dGUgcGVyLWNoaXAocGVyLW51bWEtbm9k
ZSkgdG8gcmVmbGVjdAo+PiB0aGUgdGhyb3R0bGUgc3RhdGUgb2YgdGhlIGNoaXAuIFRoZSB1c2Vy
c2FwY2UgcHJvZ3JhbXMgY2FuIHBvbGwgb24KPj4gdGhpcyBhdHRyaWJ1dGUgdG8ga2VlcCBhbiBl
eWUgb24gdGhlIHRocm90dGxlIHN0YXRlLiBDdXJyZW50bHkgd2UKPj4gcHJpbnQgYSBsb2cgbWVz
c2FnZSB0byBub3RpZnkgdGhlIHVzZXIgb2YgdGhyb3R0bGluZyBldmVudC4gVGhlCj4+IHBlcmZv
cm1hbmNlLXNlbnNpdGl2ZSBhcHBsaWNhdGlvbnMgY2FuIG1vbml0b3IgdGhlIHRocm90dGxlIHN0
YXRlCj4+IHVzaW5nIHRoaXMgYXR0cmlidXRlLgo+IAo+IFBlcmZvcm1hbmNlIHNlbnNpdGl2ZSBh
cHBsaWNhdGlvbnMgY2FuICpwb2xsKiBvbiBhIHN5c2ZzIGZpbGUsIHdoaWNoIGRvZXMgYQo+IGxv
b3Agb3ZlciBhbGwgY2hpcHMgYW5kIHBvdGVudGlhbGx5IHNwYW1zIHRoZSBjb25zb2xlIHdpdGgg
cHJfY3JpdCgpIG1lc3NhZ2VzID8KPiAKPiBUaGF0IGRvZXMgbm90IHNvdW5kIGxpa2UgYSByZWNp
cGUgZm9yIHN1Y2Nlc3MuCgpPa2F5LgoKPiAKPiBXaGF0IHByb2JsZW0gYXJlIHdlIGFjdHVhbGx5
IHRyeWluZyB0byBzb2x2ZSBoZXJlPwoKSG93IHRvIGV4cG9ydCB0aGUgdGhyb3R0bGUgaW5mb3Jt
YXRpb24gdG8gdGhlIHVzZXIgc3BhY2UsIHN1Y2ggdGhhdCBpdCBpcwpjb25zdW1hYmxlIGJ5IHRo
ZSBhcHBsaWNhdGlvbnMgKGZvciBleGFtcGxlIHRvIGRpc2NhcmQgdGhlIGJlbmNobWFyayBydW4g
aWYgdGhlCmZyZXF1ZW5jeSB3YXMgdGhyb3R0bGVkKT8KCldlIGFscmVhZHkgcHJpbnQgdGhlIHRo
cm90dGxlIGluZm9ybWF0aW9uIHRvIGNvbnNvbGUuIENhbiB3ZSBleHRlbmQgdGhpcyB0bwpub3Rp
ZnkvYnJvYWRjYXN0IGFzIGFuIGV2ZW50IHRvIHRoZSBhcHBsaWNhdGlvbnM/CgpUaGFua3MgYW5k
IFJlZ2FyZHMsClNoaWxwYQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3ps
YWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
