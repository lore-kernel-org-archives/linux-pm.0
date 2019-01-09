From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after
 cpufreq change
Date: Wed, 9 Jan 2019 11:27:08 +0100
Message-ID: <CAJKOXPcqcyimyUBD5ka60FZCeehqkE=GNH8YYYkgQpJ4=yQ3nw@mail.gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gVHVlLCA4IEphbiAyMDE5IGF0IDIxOjA1LCBQYXdlxYIgQ2htaWVsCjxwYXdlbC5taWtvbGFq
LmNobWllbEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBjb21taXQgcmVwbGFjZXMgcHJpbnRr
IHdpdGggcHJfZGVidWcsIHNvIHdlIGRvbid0IGZsb29kIGtlcm5lbCBsb2cuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBQYXdlxYIgQ2htaWVsIDxwYXdlbC5taWtvbGFqLmNobWllbEBnbWFpbC5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvY3B1ZnJlcS9zNXB2MjEwLWNwdWZyZXEuYyB8IDIgKy0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpBY2tlZC1ieTogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPgoKQmVzdCByZWdhcmRzLApLcnp5c3p0b2YK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1r
ZXJuZWwK
