From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
Date: Thu, 1 Oct 2015 19:26:29 -0500
Message-ID: <1443745589.5336.185.camel@freescale.com>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <20150811182535.31346.52965@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20150811182535.31346.52965@quantum>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: devicetree@vger.kernel.org, Liberman Igal-B31950 <Igal.Liberman@freescale.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>
List-Id: linux-pm@vger.kernel.org

W1Jlc2VuZGluZyB0byB1cGRhdGVkIGUtbWFpbCBhZGRyZXNzXQoKT24gVHVlLCAyMDE1LTA4LTEx
IGF0IDExOjI1IC0wNzAwLCBNaWNoYWVsIFR1cnF1ZXR0ZSB3cm90ZToKPiBIaSBTY290dCwKPiAK
PiBRdW90aW5nIFNjb3R0IFdvb2QgKDIwMTUtMDYtMTggMTk6NDk6MTApCj4gPiBUaGUgZXhpc3Rp
bmcgZGV2aWNlIHRyZWUgYmluZGluZ3MgYXJlIGVycm9yLXByb25lIGFuZCBpbmZsZXhpYmxlLiAK
PiA+IENvcnJlY3QgdGhlIG1pc3Rha2UgYnkgbW92aW5nIHRoZSBrbm93bGVkZ2UgaW50byB0aGUg
ZHJpdmVyLCB3aGljaAo+ID4gaGFzIG1vcmUgZmxleGliaWxpdHkgaW4gZGVzY3JpYmluZyB0aGUg
cXVpcmtzIG9mIGVhY2ggY2hpcC4gIFRoaXMgbGVhdmVzCj4gPiB0aGUgZGV2aWNlIHRyZWUgdG8g
aXRzIHByb3BlciByb2xlIG9mIGlkZW50aWZ5aW5nIGEgcHJvZ3JhbW1pbmcgaW50ZXJmYWNlCj4g
PiByYXRoZXIgdGhhbiBkZXNjcmliaW5nIGl0cyBpbmRpdmlkdWFsIHJlZ2lzdGVycy4KPiAKPiBT
b3JyeSBmb3Igbm90IHJlc3BvbmRpbmcgdG8gdGhpcyBvbmUgc29vbmVyLiBGZWxsIHRocm91Z2gg
dGhlIGNyYWNrcy4KPiAKPiBBbGwgb2YgdGhlIGNoYW5nZXMgdG8gZHJpdmVzL2Nsay9jbGstcW9y
aXEuYyBsb29rIGdyZWF0IHRvIG1lLiBJIGFzc3VtZQo+IHlvdSBuZWVkIHRvIGtlZXAgYWxsIG9m
IHRoZXNlIHBhdGNoZXMgdG9nZXRoZXIgYW5kIHdhbnQgdG8gdGhlIHRha2UKPiB0aHJvdWdoIHRo
ZSBmcmVlc2NhbGUgdHJlZT8gSWYgc28gZmVlbCBmcmVlIHRvIGFkZCwKPiAKPiBBY2tlZC1ieTog
TWljaGFlbCBUdXJxdWV0dGUgPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPgoKSXMgdGhlIGFjayBz
dGlsbCB2YWxpZCBmb3IgdGhlIHYzIHBhdGNoc2V0PwoKLVNjb3R0Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QK
TGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xp
c3RpbmZvL2xpbnV4cHBjLWRldg==
