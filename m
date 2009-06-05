From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 02/07] dma: rework dw_dmac
	suspend_late()/resume_early()
Date: Fri, 5 Jun 2009 10:45:28 +0200
Message-ID: <20090605104528.7824f137__22487.2268889614$1244245767$gmane$org@hskinnemoen-d830>
References: <20090605075436.14756.80501.sendpatchset@rx1.opensource.se>
	<20090605075455.14756.13684.sendpatchset@rx1.opensource.se>
	<20090605101816.6bbe496e@hskinnemoen-d830>
	<aec7e5c30906050134u1bcfc326p15691d90b6902d68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906050134u1bcfc326p15691d90b6902d68@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: ben-linux@fluff.org, anemo@mba.ocn.ne.jp, gregkh@suse.de, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

TWFnbnVzIERhbW0gd3JvdGU6Cj4gT24gRnJpLCBKdW4gNSwgMjAwOSBhdCA1OjE4IFBNLCBIYWF2
YXJkCj4gU2tpbm5lbW9lbjxoYWF2YXJkLnNraW5uZW1vZW5AYXRtZWwuY29tPiB3cm90ZToKPiA+
IE1hZ251cyBEYW1tIHdyb3RlOgo+ID4+ICtzdGF0aWMgc3RydWN0IGRldl9wbV9vcHMgZHdfZGV2
X3BtX29wcyA9IHsKPiA+PiArIMKgIMKgIC5zdXNwZW5kX25vaXJxID0gZHdfc3VzcGVuZF9ub2ly
cSwKPiA+PiArIMKgIMKgIC5yZXN1bWVfbm9pcnEgPSBkd19yZXN1bWVfbm9pcnEsCj4gPj4gK307
Cj4gPgo+ID4gQ2FuIHRoaXMgYmUgY29uc3Q/Cj4gCj4gSG0sIGFkZGluZyBjb25zdCBnZW5lcmF0
ZXMgYSB3YXJuaW5nIGZvciBtZS4gQXQgb24gU3VwZXJIIHdpdGgKPiBnY2MtNC4zLjMgKFNvdXJj
ZXJ5IEcrKyBMaXRlIDQuMy0xNDMpOgo+IAo+IFttb2RpZmllZCBkZXZfcG1fb3BzIHRvIGNvbnN0
IGluIHNoX2tleXNjLmNdCj4gCj4gICBDQyAgICAgIGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvc2hf
a2V5c2Mubwo+IGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvc2hfa2V5c2MuYzoyOTk6IHdhcm5pbmc6
IGluaXRpYWxpemF0aW9uCj4gZGlzY2FyZHMgcXVhbGlmaWVycyBmcm9tIHBvaW50ZXIgdGFyZ2V0
IHR5cGUKCk9rLCBpdCBsb29rcyBsaWtlIHRoZSAucG0gZmllbGQgaW4gc3RydWN0IGRldmljZV9k
cml2ZXIgaXMgbm90IGNvbnN0LgpDaGFuZ2luZyB0aGF0IHdpbGwgaW50cm9kdWNlIGxvdHMgb2Yg
d2FybmluZ3MgZWxzZXdoZXJlLCBzbyBpdCdzCnByb2JhYmx5IGJldHRlciB0byBsZWF2ZSBpdCBh
bG9uZS4KClNvIEkgZ3Vlc3MgdGhlIGFuc3dlciBpcyBubywgaXQgY2FuJ3QgYmUgY29uc3QuCgpI
YWF2YXJkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
cG0=
