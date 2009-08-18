From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Tue, 18 Aug 2009 15:16:33 +0800
Message-ID: <1250579793.5351.79.camel__18733.9013246403$1250579948$gmane$org@rzhang-dt>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCAyMDA5LTA4LTE3IGF0IDA4OjE1ICswODAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBXZWRuZXNkYXkgMTIgQXVndXN0IDIwMDksIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3Rl
Ogo+ID4gSGksCj4gPiAKPiA+IFRoZSBmb2xsb3dpbmcgcGF0Y2hlcyBpbnRyb2R1Y2UgYSBtZWNo
YW5pc20gYWxsb3dpbmcgdXMgdG8gZXhlY3V0ZSBkZXZpY2UKPiA+IGRyaXZlcnMnIHN1c3BlbmQg
YW5kIHJlc3VtZSBjYWxsYmFja3MgYXN5bmNocm9ub3VzbHkgZHVyaW5nIHN5c3RlbSBzbGVlcAo+
ID4gdHJhbnNpdGlvbnMsIHN1Y2ggYXMgc3VzcGVuZCB0byBSQU0uICBUaGUgaWRlYSBpcyBleHBs
YWluZWQgaW4gdGhlIFsxLzFdIHBhdGNoCj4gPiBtZXNzYWdlLgo+IAo+IENoYW5nZXM6Cj4gCj4g
KiBBZGRlZCBbMS83XSB0aGF0IGZpeGVzIGtlcm5lbGRvYyBjb21tZW50cyBpbiBkcml2ZXJzL2Jh
c2UvcG93ZXIvbWFpbi5jCj4gICAodGhpcyBpcyBhIDIuNi4zMiBjYW5kaWRhdGUpLgo+IAo+ICog
QWRkZWQgWzIvN10gYWRkaW5nIGEgZnJhbWV3b3JrIGZvciByZXByZXNlbnRpbmcgUE0gbGluayAo
aWRlYSBkZXNjcmliZWQKPiAgIGluIHRoZSBwYXRjaCBtZXNzYWdlKS4KPiAKPiAqIFszLzddIGlz
IHRoZSBhc3luYyByZXN1bWUgcGF0Y2ggKGlkZWEgZGVzY3JpYmVkIGluIHRoZSBwYXRjaCBtZXNz
YWdlKS4KPiAKPiAqIFs0LzddIGlzIHRoZSBhc3luYyBzdXNwZW5kIHBhdGNoLgo+IAo+ICogWzUv
N10gLSBbNy83XSBzZXQgYXN5bmNfc3VzcGVuZCBmb3IgZGV2aWNlcyBpbiBhIGZldyBzZWxlY3Rl
ZCBzdWJzeXN0ZW1zLgo+IAo+IFRoZSBwYXRjaGVzIGhhdmUgYmVlbiB0ZXN0ZWQgb24gSFAgbng2
MzI1Lgo+IApJIHRyaWVkIHRoaXMgcGF0Y2ggc2V0IGFuZCBpdCBkb2VzIHdvcmsuIDopCkJ1dCB1
bmZvcnR1bmF0ZWx5IGl0IGRvZXNuJ3Qgc2F2ZSB0b28gbXVjaCB0aW1lLgoKSSBzdGlsbCB0aGlu
ayB0aGF0IHRoZSBjaGlsZCBkZXZpY2Ugc2hvdWxkIGluaGVyaXQgaXRzIHBhcmVudCdzCmFzeW5j
X3N1c3BlbmQgZmxhZyB0byBkbyB0aGUgYXN5bmNocm9ub3VzIHJlc3VtZSBtb3JlIGVmZmljaWVu
dGx5LgoKb3IgYXQgbGVhc3Qgd2Ugc2hvdWxkIHByb3ZpZGUgc3VjaCBhbiBpbnRlcmZhY2UKaW4g
77u/ZHJpdmVycy9iYXNlL3Bvd2VyL2NvbW1vbi5jLCBzbyB0aGF0IGRldmljZSBjYW4gdGVsbCB0
aGUgZGV2aWNlIGNvcmUKdG8gaW5oZXJpdCB0aGlzIGZsYWcgaWYgdGhlcmUgaXMgbm8gb2ZmLXRy
ZWUgZGVwZW5kZW5jeS4KCnRoYW5rcywKcnVpCgo+IFRoYW5rcywKPiBSYWZhZWwKPiAKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxp
bmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
