From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 6/7] ARM64: dts: marvell: armada-37xx: declare SATA
 clock
Date: Wed, 06 Feb 2019 10:46:32 +0100
Message-ID: <8736p18d1j.fsf@FE-laptop>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <20181204192831.12440-7-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181204192831.12440-7-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

SGkgTWlxdWVsLAogCiBPbiBtYXIuLCBkw6ljLiAwNCAyMDE4LCBNaXF1ZWwgUmF5bmFsIDxtaXF1
ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gVGhlIFNBVEEgSVAgZ2V0IGl0cyBjbG9j
ayBmcm9tIHRoZSBub3J0aC1icmlkZ2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaXF1ZWwgUmF5bmFs
IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPgoKQXBwbGllZCB0byBtdmVidS9kdDY0CgpUaGFu
a3MsCgpHcmVnb3J5Cj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
Mzd4eC5kdHNpIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtMzd4eC5kdHNpIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS0zN3h4LmR0c2kKPiBpbmRleCAwMzZk
NmZkNmM5ZWYuLjY1YmY3NzQ1MTZlYyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L21hcnZlbGwvYXJtYWRhLTM3eHguZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9hcm1hZGEtMzd4eC5kdHNpCj4gQEAgLTM4OSw2ICszODksNyBAQAo+ICAJCQkJY29tcGF0
aWJsZSA9ICJtYXJ2ZWxsLGFybWFkYS0zNzAwLWFoY2kiOwo+ICAJCQkJcmVnID0gPDB4ZTAwMDAg
MHgxNzg+Owo+ICAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDI3IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Owo+ICsJCQkJY2xvY2tzID0gPCZuYl9wZXJpcGhfY2xrIDE+Owo+ICAJCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsKPiAgCQkJfTsKPiAgCj4gLS0gCj4gMi4xOS4xCj4KCi0tIApHcmVnb3J5IENs
ZW1lbnQsIEJvb3RsaW4KRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVlcmluZwpodHRw
Oi8vYm9vdGxpbi5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwK
