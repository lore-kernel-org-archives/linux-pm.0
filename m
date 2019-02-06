From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v3 7/7] ARM64: dts: marvell: armada-3720-espressobin:
 declare SATA PHY property
Date: Wed, 06 Feb 2019 15:19:41 +0100
Message-ID: <878syt6ltu.fsf@FE-laptop>
References: <20181204192831.12440-1-miquel.raynal@bootlin.com>
 <20181204192831.12440-8-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181204192831.12440-8-miquel.raynal@bootlin.com>
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
ZWwucmF5bmFsQGJvb3RsaW4uY29tPiB3cm90ZToKCj4gVGhlIFNBVEEgbm9kZSBpcyB3aXJlZCB0
byB0aGUgdGhpcmQgUEhZIG9mIHRoZSBDT01QSFkgSVAuCj4KPiBTdWdnZXN0ZWQtYnk6IEdyemVn
b3J6IEphc3pjenlrIDxqYXpAc2VtaWhhbGYuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pcXVlbCBS
YXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+CgpBcHBsaWVkIHRvIG12ZWJ1L2R0NjQK
ClRoYW5rcywKCkdyZWdvcnkKCj4gLS0tCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9h
cm1hZGEtMzcyMC1lc3ByZXNzb2Jpbi5kdHMgfCAyICsrCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwv
YXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxs
L2FybWFkYS0zNzIwLWVzcHJlc3NvYmluLmR0cwo+IGluZGV4IDNhYjI1YWQ0MDJiOS4uZTk0N2Vm
NjFkOTQ2IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEt
MzcyMC1lc3ByZXNzb2Jpbi5kdHMKPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwv
YXJtYWRhLTM3MjAtZXNwcmVzc29iaW4uZHRzCj4gQEAgLTUxLDYgKzUxLDggQEAKPiAgLyogSjYg
Ki8KPiAgJnNhdGEgewo+ICAJc3RhdHVzID0gIm9rYXkiOwo+ICsJcGh5cyA9IDwmY29tcGh5MiAw
PjsKPiArCXBoeS1uYW1lcyA9ICJzYXRhLXBoeSI7Cj4gIH07Cj4gIAo+ICAvKiBKMSAqLwo+IC0t
IAo+IDIuMTkuMQo+CgotLSAKR3JlZ29yeSBDbGVtZW50LCBCb290bGluCkVtYmVkZGVkIExpbnV4
IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcKaHR0cDovL2Jvb3RsaW4uY29tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxp
bmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
