From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 07/10] clk: rockchip: set clk-ddr to GET_RATE_NOCACHE.
Date: Tue, 15 May 2018 13:41:56 -0700
Message-ID: <152641691632.237094.11483387696003404182@swboyd.mtv.corp.google.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-8-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180514211610.26618-8-enric.balletbo@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, David Airlie <airlied@linux.ie>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Heiko Stuebner <heiko@sntech.de>, Kyungmin Park <kyungmin.park@samsung.com>, Michael Turquette <mturquette@baylibre.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Rob Herring <robh+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>, Will Deacon <will.deacon@arm.com>
Cc: Lin Huang <hl@rock-chips.com>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, kernel@collabora.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBFbnJpYyBCYWxsZXRibyBpIFNlcnJhICgyMDE4LTA1LTE0IDE0OjE2OjA3KQo+IEZy
b206IERlcmVrIEJhc2Vob3JlIDxkYmFzZWhvcmVAY2hyb21pdW0ub3JnPgo+IAo+IFRoaXMgYWRk
cyB0aGUgZmxhZyB0byB0aGUgY2xrLWRkciBpbiByb2NrY2hpcCB0byBub3QgdXNlIHRoZSBjYWNo
ZWQKPiByYXRlIGZvciBnZXRfcmF0ZS4gVGhpcyBpcyB0byBoYW5kbGUgdGltZW91dCBlcnJvciBj
b25kaXRpb25zIGluIFNNQwo+IGZvciB0aGUgc2V0IHJhdGUgZnVuY3Rpb24uCgpXZSBuZWVkIHNv
bWUgbW9yZSBpbmZvcm1hdGlvbiBoZXJlLiBXaHkgZG9lcyB0aW1lb3V0IGVycm9yIGNvbmRpdGlv
biBpbgpzZXRfcmF0ZSgpIG1hdHRlciBmb3IgZ2V0X3JhdGUoKT8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
