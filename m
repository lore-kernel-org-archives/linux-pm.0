From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Fri, 14 May 2010 23:08:48 +0200
Message-ID: <201005142308.48386.rjw__19909.2865841978$1273871329$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1273810273-3039-1-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?utf-8?q?Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

T24gRnJpZGF5IDE0IE1heSAyMDEwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3RlOgo+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHMgYSBzdXNwZW5kLWJsb2NrIGFwaSB0aGF0IHByb3ZpZGVzIHRoZSBzYW1l
Cj4gZnVuY3Rpb25hbGl0eSBhcyB0aGUgYW5kcm9pZCB3YWtlbG9jayBhcGkuIFRoaXMgdmVyc2lv
biBoYXMgc29tZQo+IGNoYW5nZXMgZnJvbSwgb3IgcmVxdWVzdGVkIGJ5LCBSYWZhZWwuIFRoZSBt
b3N0IG5vdGFibGUgY2hhbmdlcyBhcmU6Cj4gLSBERUZJTkVfU1VTUEVORF9CTE9DS0VSIGFuZCBz
dXNwZW5kX2Jsb2NrZXJfcmVnaXN0ZXIgaGF2ZSBiZWVuIGFkZGVkCj4gICBmb3Igc3RhdGljYWxs
eSBhbGxvY2F0ZWQgc3VzcGVuZCBibG9ja2Vycy4gCj4gLSBzdXNwZW5kX2Jsb2NrZXJfZGVzdHJv
eSBpcyBub3cgY2FsbGVkIHN1c3BlbmRfYmxvY2tlcl91bnJlZ2lzdGVyCj4gLSBUaGUgdXNlciBz
cGFjZSBtYW5kYXRvcnkgX0lOSVQgaW9jdGwgaGFzIGJlZW4gcmVwbGFjZWQgd2l0aCBhbgo+ICAg
b3B0aW9uYWwgX1NFVF9OQU1FIGlvY3RsLgo+IAo+IEkga2VwdCB0aGUgYWNrIGFuZCByZXZpZXdl
ZCBieSB0YWdzIG9uIHR3byBvZiB0aGUgcGF0Y2hlcyBldmVuIHRob3VnaAo+IHRoZXJlIHdlcmUg
YSBmZXcgY29zbWV0aWMgY2hhbmdlcy4KClRoYW5rcyBmb3IgdGhlIHBhdGNoZXMsIEkgdGhpbmsg
dGhleSBhcmUgaW4gYSBwcmV0dHkgZ29vZCBzaGFwZSBub3cuCgpUaGF0IHNhaWQsIEknZCBsaWtl
IHRoZSBjaGFuZ2Vsb2dzIHRvIGJlIGEgYml0IG1vcmUgZGVzY3JpcHRpdmUsIGF0IGxlYXN0IGZv
cgpwYXRjaCBbMS84XS4gIEkgdGhpbmsgaXQgc2hvdWxkIGV4cGxhaW4gKGluIGEgZmV3IHdvcmRz
KSB3aGF0IHRoZSBwdXJwb3NlIG9mCnRoZSBmZWF0dXJlIGlzIGFuZCB3aGF0IHByb2JsZW1zIGl0
IHNvbHZlcyB0aGF0IGdlbmVyYWxseSBhIGNvbWJpbmF0aW9uIG9mCnJ1bnRpbWUgUE0gYW5kIGNw
dWlkbGUgaXMgbm90IHN1aXRhYmxlIGZvciBpbiB5b3VyIG9waW5pb24uICBJT1csIHdoeSB5b3UK
dGhpbmsgd2UgbmVlZCB0aGF0IGZlYXR1cmUuCgpUaGUgY2hhbmdlbG9nIG9mIHBhdGNoIFsyLzhd
IGFwcGVhcnMgdG8gYmUgb3V0ZGF0ZWQsIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQuCkFsc28sIGl0
IHdvdWxkIGJlIG5pY2UgdG8gZXhwbGFpbiBpbiB0aGUgY2hhbmdlbG9nIHdoYXQgdGhlIGludGVy
ZmFjZSBpcyBuZWVkZWQKZm9yIChpbiB0ZXJtcyBvZiB0aGUgcHJvYmxlbXMgdGhhdCBpdCBoZWxw
cyB0byBoYW5kbGUpLgoKUmFmYWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1wbUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtcG0=
