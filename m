From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: Re: 2.6.33-rc3-git3: Reported regressions from 2.6.32
Date: Mon, 11 Jan 2010 08:00:37 -0800
Message-ID: <43e72e891001110800h283b534aj1d60f83266fa215a__8755.48225963048$1263225808$gmane$org@mail.gmail.com>
References: <wnS54-l8PVO.A.TlF.oMlSLB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <wnS54-l8PVO.A.TlF.oMlSLB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Adrian Bunk <bunk@kernel.org>, DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gU3VuLCBKYW4gMTAsIDIwMTAgYXQgMjoyNyBQTSwgUmFmYWVsIEouIFd5c29ja2kgPHJqd0Bz
aXNrLnBsPiB3cm90ZToKPiBUaGlzIG1lc3NhZ2UgY29udGFpbnMgYSBsaXN0IG9mIHNvbWUgcmVn
cmVzc2lvbnMgZnJvbSAyLjYuMzIsIGZvciB3aGljaCB0aGVyZQo+IGFyZSBubyBmaXhlcyBpbiB0
aGUgbWFpbmxpbmUgSSBrbm93IG9mLiDCoElmIGFueSBvZiB0aGVtIGhhdmUgYmVlbiBmaXhlZCBh
bHJlYWR5LAo+IHBsZWFzZSBsZXQgbWUga25vdy4KPgo+IElmIHlvdSBrbm93IG9mIGFueSBvdGhl
ciB1bnJlc29sdmVkIHJlZ3Jlc3Npb25zIGZyb20gMi42LjMyLCBwbGVhc2UgbGV0IG1lIGtub3cK
PiBlaXRoZXIgYW5kIEknbGwgYWRkIHRoZW0gdG8gdGhlIGxpc3QuIMKgQWxzbywgcGxlYXNlIGxl
dCBtZSBrbm93IGlmIGFueSBvZiB0aGUKPiBlbnRyaWVzIGJlbG93IGFyZSBpbnZhbGlkLgo+Cj4g
RWFjaCBlbnRyeSBmcm9tIHRoZSBsaXN0IHdpbGwgYmUgc2VudCBhZGRpdGlvbmFsbHkgaW4gYW4g
YXV0b21hdGljIHJlcGx5IHRvCj4gdGhpcyBtZXNzYWdlIHdpdGggQ0NzIHRvIHRoZSBwZW9wbGUg
aW52b2x2ZWQgaW4gcmVwb3J0aW5nIGFuZCBoYW5kbGluZyB0aGUKPiBpc3N1ZS4KPgoKT2YgdGhl
c2Ugb25seSB0aGUgb25lIGJlbG93IHdhcyB3aXJlbGVzcywgd2hpY2ggaXMgYWN0dWFsbHkgZml4
ZWQgbm93LgpOb3QgYmFkLCByYzMgYW5kIG5vIHdpcmVsZXNzIHJlZ3Jlc3Npb25zIHlldC4KCj4g
QnVnLUVudHJ5IMKgIMKgIMKgIDogaHR0cDovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTE0ODc0Cj4gU3ViamVjdCDCoCDCoCDCoCDCoCA6IEF0aDVrIHJlZ3Jlc3Npb24gd2l0
aCBjb21taXQgOGJmM2Q3OWJjNDAxY2E0MTdjY2Y5ZmMwNzZkMzI5NWQxYTcxZGJmNQo+IFN1Ym1p
dHRlciDCoCDCoCDCoCA6IEpvc2h1YSBDb3Zpbmd0b24gPGpvc2h1YWNvdkBnb29nbGVtYWlsLmNv
bT4KPiBEYXRlIMKgIMKgIMKgIMKgIMKgIMKgOiAyMDA5LTEyLTI1IDAwOjQ5ICgxNyBkYXlzIG9s
ZCkKPiBIYW5kbGVkLUJ5IMKgIMKgIMKgOiBMdWlzIFIuIFJvZHJpZ3VleiA8bWNncm9mQGdtYWls
LmNvbT4KPiBQYXRjaCDCoCDCoCDCoCDCoCDCoCA6IGh0dHA6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L2F0dGFjaG1lbnQuY2dpP2lkPTI0MzM1CgogIEx1aXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
