From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 11 Jun 2015 14:30:05 +0200
Message-ID: <CACRpkdaZgBR5rHwrEYqcm5K4w3y8MXG8a0k=Y+oQY+jukHfuyw@mail.gmail.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <CACRpkdasLwMfEHGMRd1X3K_DU7NMPreE8TMwqqDTg8k9wj=wJQ@mail.gmail.com>
 <CAAObsKCP-C+TY8Wkk6bQzxZeGYL9X01trtjxfaYp--ZnH07C+w@mail.gmail.com>
 <CACRpkdZuSj+S2x1yz6n5PgcRK=3ZCcq_To124b2Y+Oj54aydpg@mail.gmail.com>
 <5577F533.1060007@ahsoftware.de>
 <CACRpkdYF5K7ckGbgvZc6qRzGFJTQ4WqXdu_7Tcqczn2LkFbn3A@mail.gmail.com>
 <5579602F.1070801@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <5579602F.1070801@ahsoftware.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, open@wandq.ahsoftware, dmaengine@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "list@wandq.ahsoftware:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Grant Likely <grant.likely@linaro.org>, Dan Williams <dan.j.williams@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-usb@vger.kernel.org" <linux-i2c@vger.>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBKdW4gMTEsIDIwMTUgYXQgMTI6MTcgUE0sIEFsZXhhbmRlciBIb2xsZXIgPGhvbGxl
ckBhaHNvZnR3YXJlLmRlPiB3cm90ZToKPiBBbSAxMS4wNi4yMDE1IHVtIDEwOjEyIHNjaHJpZWIg
TGludXMgV2FsbGVpajoKPj4gT24gV2VkLCBKdW4gMTAsIDIwMTUgYXQgMTA6MjggQU0sIEFsZXhh
bmRlciBIb2xsZXIgPGhvbGxlckBhaHNvZnR3YXJlLmRlPgo+PiB3cm90ZToKCj4+PiBZb3Ugd291
bGQgZW5kIHVwIHdpdGggdGhlIHNhbWUgcHJvYmxlbSBvZiBkZWFkbG9ja3MgYXMgY3VycmVudGx5
LCBhbmQgeW91Cj4+PiB3b3VsZCBzdGlsbCBuZWVkIHNvbWV0aGluZyB1Z2x5IGxpa2UgdGhlIGRl
ZmVyZWQgcHJvYmUgYnJ1dGZvcmNlIHRvIGF2b2lkCj4+PiB0aGVtLgo+Pgo+Pgo+PiBTb3JyeSBJ
IGRvbid0IGdldCB0aGF0LiBDYXJlIHRvIGVsYWJvcmF0ZSBvbiB3aHk/Cj4KPgo+IEJlY2F1c2Ug
bG9hZGluZy9pbml0aWFsaXppbmcgb24gZGVtYW5kIGRvZXNuJ3QgZ2l2ZSB5b3UgYW55IHNvbHZl
ZCBvcmRlciBvZgo+IGRyaXZlcnMgdG8gaW5pdGlhbGl6ZS4gQW5kIGl0IGNhbid0IGJlY2F1c2Ug
aXQgaGFzIG5vIGlkZWEgYWJvdXQgdGhlCj4gcmVxdWlyZW1lbnRzIG9mIG90aGVyIGRyaXZlcnMu
IFRoZSByZWFzb24gd2h5IGl0IG1pZ2h0IHdvcmsgYmV0dGVyIGluIHRoZQo+IGNhc2Ugb2YgdGhl
IHRlZ3JhIGlzIHRoYXQgaXQgbWlnaHQgZ2l2ZSB5b3UgYW5vdGhlciBpbml0aWFsaXphdGlvbiBv
cmRlcgo+IHRoYW4gdGhlIG9uZSB3aGljaCBpcyBjdXJyZW50bHkgY2hvb3Nlbiwgd2hpY2gsIGJ5
IGx1Y2ssIG1pZ2h0IGJlIGEgYmV0dGVyCj4gb25lLgo+Cj4gQnV0IG1heWJlIEkgbWlzc2VkIHNv
bWV0aGluZywgSSBoYXZlbid0IGxvb2tlZCBhdCB0aGUgcGF0Y2hlcyBhdCBhbGwuIEJ1dAo+IGp1
c3QgbG9hZGluZyBvbiBkZW1hbmQsIGNhbid0IG1hZ2ljYWxseSBnaXZlIHlvdSBhIHdvcmtpbmcg
b3JkZXIgb2YgZHJpdmVycwo+IHRvIGluaXRpYWxpemUuIEUuZy4gaG93IGRvIHlvdSBjaG9vc2Ug
dGhlIGZpcnN0IGRyaXZlciB0byBpbml0aWFsaXplPwoKU28gdGhlIGN1cnJlbnQgcGF0Y2ggc2V0
IGludHJvZHVjZXMgZGVwZW5kZW5jaWVzIChqdXN0IGZvciBkZXZpY2UgdHJlZSkKYW5kIFRvbWV1
IGlzIHdvcmtpbmcgb24gYSBtb3JlIGdlbmVyaWMgZGVwZW5kZW5jeSBhcHByb2FjaCBmb3IKYW55
IEhXIGRlc2NyaXB0aW9uLgoKVGhlIGZpcnN0IGRyaXZlciB0byBpbml0aWFsaXplIHdpbGwgYmUg
YXMgdXN1YWwgdGhlIGZpcnN0IG9uZSBpbiB0aGUgbGlzdCBmb3IKdGhhdCBpbml0bGV2ZWwsIHRo
ZW4gd2Fsa2luZyB1cCB0aGUgaW5pdGlsZXZlbHMuCgpIb3dldmVyIGlmIGFueSBkcml2ZXIgcnVu
cyBpbnRvIGEgcmVzb3VyY2Ugcm9hZGJsb2NrIGl0IHdpbGwgcG9zdHBvbmUKYW5kIHdhaXQgZm9y
IGRlcGVuZGVuY2llcyB0byBwcm9iZSBmaXJzdC4KCkNlcnRhaW5seSBpdCBpcyBwb3NzaWJsZSB0
byBjcmVhdGUgZGVhZGxvY2tzIGluIHRoaXMgc2NlbmFyaW8sIGJ1dCB0aGUKc2NvcGUgaXMgbm90
IHRvIGNyZWF0ZSBhbiB1YnJlYWthYmxlIHN5c3RlbS4KCllvdXJzLApMaW51cyBXYWxsZWlqCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
