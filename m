From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: [v2 PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
Date: Fri, 16 Mar 2018 12:44:08 -0600
Message-ID: <20180316184410.29863-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: freedreno@lists.freedesktop.org
Cc: nm@ti.com, devicetree@vger.kernel.org, rnayak@codeaurora.org, linux-pm@vger.kernel.org, sboyd@kernel.org, linux-arm-msm@vger.kernel.org, dianders@chromium.org, dri-devel@lists.freedesktop.org, vireshk@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

QWRkIERUIG5vZGVzIGZvciB0aGUgc2RtODQ1IEdQVS9HTVUgKGdyYXBoaWNzIG1hbmFnZW1lbnQg
dW5pdCkgYW5kIHRoZSBjb21wYW5pb24KYXJtLXNtbXUtdjIgY29tcGF0aWJsZSBTTU1VLgoKVGhp
cyBidWlsZHMgb24gdGhlIGZvbGxvd2luZyBkZXBlbmRlbmNpZXMgLQpodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3BhdGNoLzEwMjg2MzY5LyAtIGJpbmRpbmdzIGZvciBxY29tLGxldmVsCmh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTAyODE1OTkvIC0gcWNvbSxzbW11LXYy
IGJpbmRpbmdzCgpQbGVhc2UgcmVmZXIgdG8gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Au
b3JnL3Nlcmllcy8zNzQyOC8gZm9yIHRoZSBkcml2ZXIKY29kZS4KClt2MiAtIGNoYW5nZWQgcWNv
bSxhcmMtbGV2ZWwgdG8gcWNvbSxsZXZlbCBmb2xsb3dpbmcgZGlzY3Vzc2lvbiB3aXRoIFZpcmVz
aDsKY2hhbmdlIGdtdSBwaGFuZGxlIHRvIHFjb20sZ211IHBlciBSb2JdCgpKb3JkYW4gQ3JvdXNl
ICgyKToKICBkdC1iaW5kaW5nczogRG9jdW1lbnQgcWNvbSxhZHJlbm8tZ211CiAgYXJtNjQ6IGR0
czogc2RtODQ1OiBBZGQgZ3B1IGFuZCBnbXUgZGV2aWNlIG5vZGVzCgogLi4uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9tc20vZ211LnR4dCAgICAgICAgfCAgNTQgKysrKysrKysrKwogLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tc20vZ3B1LnR4dCAgICAgICAgfCAgMTAgKy0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSAgICAgICAgICAgICAgIHwgMTE5
ICsrKysrKysrKysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxODEgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tc20vZ211LnR4dAoKLS0gCjIuMTYuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
