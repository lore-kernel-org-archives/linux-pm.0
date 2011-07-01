From: Kevin Hilman <khilman@ti.com>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 01 Jul 2011 07:46:37 -0700
Message-ID: <874o366otu.fsf__11279.876161325$1309531704$gmane$org@ti.com>
References: <87k4c3dktm.fsf@ti.com> <87vcvmaml6.fsf@ti.com>
	<201107010233.12377.rjw@sisk.pl>
	<BANLkTikLna-jbrNfD2fz_QC1BfrCHpByNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikLna-jbrNfD2fz_QC1BfrCHpByNA@mail.gmail.com> (Ohad
	Ben-Cohen's message of "Fri, 1 Jul 2011 08:57:40 +0300")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-pm@lists.linux-foundation.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T2hhZCBCZW4tQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT4gd3JpdGVzOgoKPiBPbiBGcmksIEp1bCAx
LCAyMDExIGF0IDM6MzMgQU0sIFJhZmFlbCBKLiBXeXNvY2tpIDxyandAc2lzay5wbD4gd3JvdGU6
Cj4+IEluIHRoZW9yeSBpdCBpcyBwb3NzaWJsZSB0aGF0IGEgc3Vic3lzdGVtIChlLmcuIGJ1cyB0
eXBlKSB3aWxsIGVuYWJsZQo+PiBydW50aW1lIFBNIGZvciBkZXZpY2VzIHdpdGhvdXQgZHJpdmVy
cyBhbmQgd2lsbCAoZm9yIGV4YW1wbGUpIHB1dCB0aGVtCj4+IGludG8gbG93IHBvd2VyIHN0YXRl
cyB1bnRpbCB0aGUgZHJpdmVycyBhcmUgbG9hZGVkLiDCoFRoZW4sIGl0IG1ha2VzCj4+IHNlbnNl
IGZvciB0aGUgY29yZSB0byBwcmV2ZW50IHN1Y2ggdHJhbnNpdGlvbnMgZnJvbSByYWNpbmcgd2l0
aCAucHJvYmUoKS4KPj4KPj4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaGFwcGVucyBpbiBwcmFjdGlj
ZSwgdGhvdWdoLAo+Cj4gWWVhaCwgdGhpcyBpcyBleGFjdGx5IHdoYXQgdGhlIFNESU8gc3Vic3lz
dGVtIGlzIGRvaW5nLgoKVGhhbmtzLCB0aGlzIG1ha2VzIHNlbnNlLgoKTWF5YmUgcnVudGltZV9w
bS50eHQgc2hvdWxkIGJlIHVwZGF0ZWQgdG8gZXhwbGFpbiB0aGlzIGFzIHdlbGwuCgpLZXZpbgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1wbSBt
YWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXBt
