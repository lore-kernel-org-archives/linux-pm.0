From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5] pm: move pm notifiers into suspend.h
Date: Thu, 23 Jun 2011 14:04:11 +0200
Message-ID: <201106231404.12311.rjw__18829.2399318472$1308830961$gmane$org@sisk.pl>
References: <1308724522-32461-1-git-send-email-amwang@redhat.com>
	<201106222149.28252.rjw@sisk.pl> <4E02C93A.7010601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E02C93A.7010601@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cong Wang <amwang@redhat.com>
Cc: Len Brown <len.brown@intel.com>, Philip Rakity <prakity@marvell.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, akpm@linux-foundation.org, Chris Ball <cjb@laptop.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-pm@vger.kernel.org

T24gVGh1cnNkYXksIEp1bmUgMjMsIDIwMTEsIENvbmcgV2FuZyB3cm90ZToKPiDkuo4gMjAxMeW5
tDA25pyIMjPml6UgMDM6NDksIFJhZmFlbCBKLiBXeXNvY2tpIOWGmemBkzoKPiA+PiArI2lmZGVm
IENPTkZJR19QTQo+ID4+ID4gICsjaW5jbHVkZTxsaW51eC9zdXNwZW5kLmg+Cj4gPj4gPiAgKyNl
bmRpZgo+ID4gSSBkb24ndCB0aGluayB0aGUgI2lmZGVmIGluIG5lY2Vzc2FyeS4gIEFueSBkZXBl
bmRlbmNpZXMgb24gQ09ORklHX1BNCj4gPiAob3IgQ09ORklHX1NVU1BFTkQgZXRjLikgc2hvdWxk
IGJlIHRha2VuIGNhcmUgb2YgaW5zaWRlIG9mIHN1c3BlbmQuaC4KPiA+IFRoaXMgZmlsZSBzaG91
bGQgYmUgZml4ZWQgaWYgdGhleSBhcmVuJ3QuCj4gPgo+IAo+IE9rLCBwbGVhc2UgY2hlY2sgdGhl
IHVwZGF0ZWQgdmVyc2lvbiBiZWxvdy4KClRoYXQncyBmaW5lIGJ5IG1lLiAgUGxlYXNlIGZlZWwg
ZnJlZSB0byBhZGQgbXkgQUNLIHRvIHRoZSBwYXRjaC4KClRoYW5rcywKUmFmYWVsCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcg
bGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
