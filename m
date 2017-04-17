From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Mon, 17 Apr 2017 22:09:56 +0200 (CEST)
Message-ID: <1653958941.84030.1492459796937@email.1und1.de>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
 <20170403154829.29780-2-zajec5@gmail.com>
 <20170407044218.GA12447@localhost.localdomain>
 <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6dd2617d-a8a8-d7a4-53a4-7ebcb274573c@milecki.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, linux-pm@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Jon Mason <jon.mason@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

PiBSYWZhxYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+IGhhdCBhbSAxNC4gQXByaWwgMjAx
NyB1bSAxNDoxNiBnZXNjaHJpZWJlbjoKPiAKPiAKPiBPbiAwNC8wNy8yMDE3IDA2OjQyIEFNLCBF
ZHVhcmRvIFZhbGVudGluIHdyb3RlOgo+ID4gT24gTW9uLCBBcHIgMDMsIDIwMTcgYXQgMDU6NDg6
MjlQTSArMDIwMCwgUmFmYcWCIE1pxYJlY2tpIHdyb3RlOgo+ID4+IEZyb206IFJhZmHFgiBNacWC
ZWNraSA8cmFmYWxAbWlsZWNraS5wbD4KPiA+Pgo+ID4+IE5vcnRoc3RhciBpcyBhIFNvQyBmYW1p
bHkgY29tbW9ubHkgdXNlZCBpbiBob21lIHJvdXRlcnMuIFRoaXMgY29tbWl0Cj4gPj4gYWRkcyBh
IGRyaXZlciBmb3IgY2hlY2tpbmcgQ1BVIHRlbXBlcmF0dXJlLiBBcyBOb3J0aHN0YXIgUGx1cyBz
ZWVtcyB0bwo+ID4+IGFsc28gaGF2ZSB0aGlzIElQIGJsb2NrIHRoaXMgbmV3IHN5bWJvbCBnZXRz
IEFSQ0hfQkNNX0lQUk9DIGRlcGVuZGVuY3kuCj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBSYWZh
xYIgTWnFgmVja2kgPHJhZmFsQG1pbGVja2kucGw+Cj4gPj4gU2lnbmVkLW9mZi1ieTogSm9uIE1h
c29uIDxqb24ubWFzb25AYnJvYWRjb20uY29tPgo+ID4KPiA+IElmIG5vIG9iamVjdGlvbiwgSSBh
bSBhcHBseWluZyB0aGlzIHNlcmllcy4KPiAKPiBDb29sLCBob3BlZnVsbHkgdGhlcmUgYXJlbid0
IGFueSBtb3JlIG9iamVjdGlvbnMgOikgT25jZSBhcHBsaWVkIHNob3VsZCBJCj4gZXhwZWN0IHRo
aXMgaW4KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9l
dmFsZW50aS9saW51eC1zb2MtdGhlcm1hbC5naXQvbG9nLz9oPW5leHQKPiA/Cj4gCj4gVGhhdCB3
b3VsZCBhbGxvdyBtZSB0byBtb3ZlIGJjbTI4MzVfdGhlcm1hbC5jIHRvIHRoZSBicm9hZGNvbSBz
dWJkaXIuCgpUaGFua3MgZm9yIGRvaW5nIHRoaXMuIEJ0dyBOb3J0aHN0YXIgdGhlcm1hbCBkcml2
ZXIgbWlzc2VzIGEgTU9EVUxFX0FVVEhPUi4KClJlZ2FyZHMKU3RlZmFuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
