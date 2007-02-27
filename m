From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Tue, 27 Feb 2007 15:25:45 +0200
Message-ID: <200702271525.48645.ismail@pardus.org.tr>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070226220152.GA29575@stusta.de>
	<200702271450.19080.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702271450.19080.caglar@pardus.org.tr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: caglar@pardus.org.tr
Cc: Tejun Heo <htejun@gmail.com>, Arkadiusz Miskiewicz <arekm@maven.pl>, "Antonino A. Daplas" <adaplas@gmail.com>, linux-pm@lists.osdl.org, Marcel Holtmann <marcel@holtmann.org>, linux-ide@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Jean-Luc Coulon <jean.luc.coulon@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-usb-devel@lists.sourceforge.net, Andrew Nelless <andrew@nelless.net>, jgarzik@pobox.com, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Fabio Comolli <fabio.comolli@gmail.com>, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Markus
List-Id: linux-pm@vger.kernel.org

T24gVHVlc2RheSAyNyBGZWJydWFyeSAyMDA3IDE0OjUwOjE3IFMuw4dhxJ9sYXIgT251ciB3cm90
ZToKPiAyNyDFnnViIDIwMDcgU2FsIHRhcmloaW5kZSwgQWRyaWFuIEJ1bmsgxZ91bmxhcsSxIHlh
em3EscWfdMSxOgo+ID4gVGhpcyBlbWFpbCBsaXN0cyBzb21lIGtub3duIHJlZ3Jlc3Npb25zIGlu
IDIuNi4yMS1yYzEgY29tcGFyZWQgdG8gMi42LjIwCj4gPiB0aGF0IGFyZSBub3QgeWV0IGZpeGVk
IGluIExpbnVzJyB0cmVlLgo+ID4KPiA+IElmIHlvdSBmaW5kIHlvdXIgbmFtZSBpbiB0aGUgQ2Mg
aGVhZGVyLCB5b3UgYXJlIGVpdGhlciBzdWJtaXR0ZXIgb2Ygb25lCj4gPiBvZiB0aGUgYnVncywg
bWFpbnRhaW5lciBvZiBhbiBhZmZlY3RlY3RlZCBzdWJzeXN0ZW0gb3IgZHJpdmVyLCBhIHBhdGNo
Cj4gPiBvZiB5b3UgY2F1c2VkIGEgYnJlYWthZ2Ugb3IgSSdtIGNvbnNpZGVyaW5nIHlvdSBpbiBh
bnkgb3RoZXIgd2F5IHBvc3NpYmx5Cj4gPiBpbnZvbHZlZCB3aXRoIG9uZSBvciBtb3JlIG9mIHRo
ZXNlIGlzc3Vlcy4KPgo+IC4uLgo+Cj4gPiBTdWJqZWN0ICAgIDogQUNQSSB1cGRhdGUgYnJlYWtz
IGtwb3dlcnNhdmUKPiA+IFJlZmVyZW5jZXMgOiBodHRwOi8vbGttbC5vcmcvbGttbC8yMDA3LzIv
MTAvNwo+ID4gU3VibWl0dGVyICA6IElzbWFpbCBEw7ZubWV6IDxpc21haWxAcGFyZHVzLm9yZy50
cj4KPiA+ICAgICAgICAgICAgICBGYWJpbyBDb21vbGxpIDxmYWJpby5jb21vbGxpQGdtYWlsLmNv
bT4KPiA+IFN0YXR1cyAgICAgOiB1bmtub3duCj4KPiBUaGF0IHJlZ3Jlc3Npb24gZml4ZWQgYnkg
YzJiNjcwNWI3NWQ5YzdhZmY5OGE0NjAyYTMyMjMwNjM5ZTEwODkxYyBhY2NvcmRpbmcKPiB0byDE
sHNtYWlsIFsxXQo+Cj4gWzFdIGh0dHA6Ly9sa21sLm9yZy9sa21sLzIwMDcvMi8xMy8xMDUKCk5v
dCBxdWl0ZSwgbXkgbGFwdG9wIGRpZWQgdGhlIHNhbWUgZGF5LiBTbyBJIGNhbid0IGRvIGFueSBy
ZWxpYWJsZSB0ZXN0LiBBbHNvIApGYWJpbyBzZWVtcyB0byByZXByb2R1Y2UgaXQgd2l0aCAyLjYu
MjEtcmMxLgoKUmVnYXJkcywKaXNtYWlsCgoKLS0gCkluIEdvZCBXZSBUcnVzdCBPdGhlcnMgV2Ug
TW9uaXRvcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLm9zZGwub3JnCmh0dHBzOi8vbGlz
dHMub3NkbC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQo=
