From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [Freedreno] [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Mon, 22 Oct 2018 08:34:51 -0600
Message-ID: <20181022143450.GE26762@jcrouse-lnx.qualcomm.com>
References: <20181010142905.GB9977@jcrouse-lnx.qualcomm.com>
 <20181010143149.4e3ct3efkuwxa2hw@vireshk-i7>
 <20181010144856.GC9977@jcrouse-lnx.qualcomm.com>
 <20181010145139.nvalsr2ij2lj53dh@vireshk-i7>
 <20181010151006.GD9977@jcrouse-lnx.qualcomm.com>
 <20181011050216.4ba5i3ghh5rbvjbl@vireshk-i7>
 <20181011145456.GG9977@jcrouse-lnx.qualcomm.com>
 <20181015100327.qoojonf46lh6g3sh@vireshk-i7>
 <20181015143444.GA4751@jcrouse-lnx.qualcomm.com>
 <20181022103811.ywvyasnshjtdzjki@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20181022103811.ywvyasnshjtdzjki@vireshk-i7>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org, sboyd@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, bjorn.andersson@linaro.org, vireshk@kernel.org, niklas.cassel@linaro.org, freedreno@lists.freedesktop.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBPY3QgMjIsIDIwMTggYXQgMDQ6MDg6MTFQTSArMDUzMCwgVmlyZXNoIEt1bWFyIHdy
b3RlOgo+IE9uIDE1LTEwLTE4LCAwODozNCwgSm9yZGFuIENyb3VzZSB3cm90ZToKPiA+IEkgYWdy
ZWUgdGhhdCBjb25zaXN0ZW5jeSBpcyBnb29kLiBCdXQgdGhlIEdQVSBpcyBieSBkZXNpZ24gb3V0
c2lkZSBvZiB0aGUKPiA+IGNvbnRyb2wgb2YgdGhlIGdlbnBkIHVuaXZlcnNlIHNvIGl0IGlzIGJ5
IGRlc2lnbiBub3QgdXNpbmcgdGhlIHNhbWUgZmVhdHVyZXMuCj4gPiBJdCB1bmZvcnR1bmF0ZWx5
IGRvZXMgaGFwcGVuIHRvIHVzZSBhIHNpbWlsYXIgbnVtYmVyIGluIGFuIE9QUCBiaW5kaW5nIHRv
Cj4gPiBjb25zdHJ1Y3QgdGhlIGxldmVsIG1hcHBpbmcgYnV0IHNpbmNlIHdlIGNhbid0IHJlYWQg
dGhlIGNtZC1kYiBmcm9tIHRoZSBHTVUKPiA+IHNwYWNlIHRoaXMgaXMgYSBuZWNlc3NhcnkgZXZp
bC4KPiAKPiBXaGVyZSBkbyB5b3UgZGVmaW5lIGhvdyB0byB1c2UgdGhpcyBiaW5kaW5nIGluIGNh
c2Ugb2YgR1BVPyBJIG1lYW4KPiBzb21lIERUIGJpbmRpbmcgZG9jIG11c3QgaGF2ZSBzb21lIGlu
Zm9ybWF0aW9uIHRvIGF2b2lkIGNvbmZ1c2lvbiBhcwo+IGFsbCBvdGhlciB1c2VycyB3aWxsIGhh
dmUgdGhlIHFjb20sbGV2ZWwgdGhpbmcgaW4gdGhlIGdlbnBkJ3MgT1BQCj4gdGFibGUgd2hpY2gg
R1BVIHdpbGwgaGF2ZSBpdCBkaXJlY3RseSB3aXRoaW4gaXRzIE9QUCB0YWJsZS4KCldoZW4gSSBm
aXJzdCBtYWRlIHRoZSBwYXRjaCBJIHdhcyBqdXN0IHVzaW5nIGV4aXN0aW5nIE9QUCBiaW5kaW5n
cyBmb3IgIEdQVQpsZXZlbHMgYXMgdGhlIHdvcmRpbmcgd2FzIGdlbmVyaWMgZW5vdWdoIHRvIGNv
dmVyIGJvdGggY2FzZXMuIEkgd291bGQgYmUgaGFwcHkKdG8gcmV2aXNpdCB0aGF0IGFuZCBpbmRp
Y2F0ZSB0aGF0IHRoZSBPUFAgYmluZGluZ3MgYXBwbHkgdG8gUlBNaCBhbmQgR1BVL0dNVQphcyB3
ZSd2ZSBkaXNjdXNzZWQgaW4gdGhpcyB0aHJlYWQuCgpKb3JkYW4KCi0tIApUaGUgUXVhbGNvbW0g
SW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYSBtZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0s
CmEgTGludXggRm91bmRhdGlvbiBDb2xsYWJvcmF0aXZlIFByb2plY3QKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
