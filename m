From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH 0/3] pm: device parallel resume mechanism
Date: Fri, 19 Dec 2008 18:15:10 +0100
Message-ID: <200812191815.11153.rjw__49104.2790854864$1229707139$gmane$org@sisk.pl>
References: <1229668448.562.88.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1229668448.562.88.camel@rzhang-dt>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, linux-pci@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gRnJpZGF5LCAxOSBvZiBEZWNlbWJlciAyMDA4LCBaaGFuZyBSdWkgd3JvdGU6Cj4gSGksIGFs
bCwKPiAKPiDvu79UaGUgcmVzdW1lIHByb2Nlc3MgY2FuIGJlIHNwbGl0IGludG8gMyBwYXJ0cywg
QklPUyByZXN1bWUgdGltZSwga2VybmVsCj4gcmVzdW1lIHRpbWUgYW5kIFgvYXBwbGljYXRpb24g
cmVzdW1lIHRpbWUuCj4gQW5kIGRldmljZSByZXN1bWUgdGFrZXMgbW9zdCBvZiB0aGUga2VybmVs
IHJlc3VtZSB0aW1lLgo+IHRoaXMgcGF0Y2ggc2V0IGludHJvZHVjZXMgYSBuZXcgbWVjaGFuaXNt
IHRvIHJlc3VtZSBkZXZpY2UgaW4gcGFyYWxsZWwKPiB3aGljaCBjYW4gcmVkdWNlIHRoZSBkZXZp
Y2UgcmVzdW1lIHRpbWUgYSBsb3QuCj4gCj4gSW4gdGhpcyBwcm9wb3NhbCwgc29tZSBkZXZpY2Vz
IGNhbiBjcmVhdGUgaXRzIG93biB3b3JrcXVldWUgZm9yCj4gcGFyYWxsZWwgcmVzdW1lLiBBbmQg
Zm9yIGFsbCB0aGUgb3RoZXIgZGV2aWNlcyB0aGF0IGRlcGVuZHMgb24gdGhpcwo+IGRldmljZSwg
dGhlaXIgcmVzdW1lIG1ldGhvZHMgYXJlIHF1ZXVlZCBpbiB0aGUgc2FtZSB3b3JrcXVldWUuCj4g
QW5kIHdlIGZsdXNoIGFsbCB0aGUgd29ya3F1ZXVlcyBiZWZvcmUgcmVzdW1pbmcgWC9hcHBsaWNh
dGlvbnMuCj4gCj4gQXMgdGhlIGRldmljZXMgdmFyeSBmcm9tIGRpZmZlcmVudCBwbGF0Zm9ybXMu
IGl0J3MgaGFyZCB0byBnaXZlIGFuIGV4YWN0Cj4gbnVtYmVyIG9mIGhvdyBtdWNoIHRpbWUgaXQg
Y2FuIHJlZHVjZS4KPiBIZXJlIGFyZSBzb21lIG9mIG15IHRlc3QgcmVzdWx0czoKPiAxLiBlZWVw
YzkwMSwga2VybmVsIHJlc3VtZSB0aW1lIGNhbiBiZSByZWR1Y2VkIGZyb20gYWJvdXQgMi4xIHNl
Y29uZHMgdG8KPiAxLjYgc2Vjb25kcy4KPiAyLiBhIFNhbnRhUm9zYSB0ZXN0Ym94LCBrZXJuZWwg
cmVzdW1lIHRpbWUgY2FuIGJlIHJlZHVjZWQgZnJvbSBhYm91dAo+IDMuNXMgdG8gMnMuCj4gCj4g
cGxlYXNlIHJldmlldyB0aGlzIHBhdGNoLiBBbnkgY29tbWVudHMgYXJlIHdlbGNvbWUuIDopCgpX
ZWxsLCBnaXZlbiB0aGF0IG91ciBzaW5nbGUtdGhyZWFkIHJlc3VtZSBpcyBub3QgZXhhY3RseSBj
b3JyZWN0LCBJIHRoaW5rCml0J3MgX3dheV8gdG8gZWFybHkgdG8gaW5kcm9kdWNlIHRoaW5ncyBs
aWtlIHRoaXMuCgpUaGFua3MsClJhZmFlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXBt
