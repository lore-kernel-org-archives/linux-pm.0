From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 7/8] arm64: dts: rk3399: Add dfi and dmc nodes.
Date: Thu, 09 Aug 2018 16:41:22 -0600
Message-ID: <5b6cc314.1c69fb81.96ced.16f7@mx.google.com>
References: <20180730081124.30698-1-enric.balletbo@collabora.com>
 <20180730081124.30698-8-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180730081124.30698-8-enric.balletbo@collabora.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: enric.balletbo@collabora.com
Cc: Mark Rutland <mark.rutland@arm.com>, Douglas Anderson <dianders@chromium.org>, David Airlie <airlied@linux.ie>, Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Klaus Goger <klaus.goger@theobroma-systems.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, kernel@collabora.com, linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, Brian Norris <briannorris@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, Nickey Yang <nickey.yang@rock-chips.com>, Jacob Chen <jacob-chen@iotwrt.com>, devicetree@vger.kernel.org, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>, Mark Yao <markyao0591@gmail.com>, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>, Kyungmin Park <kyungmin.park@samsung.com>, robin.murphy@arm.com
List-Id: linux-pm@vger.kernel.org

SGksIHRoaXMgaXMgYW4gYXV0b21hdGVkIGVtYWlsIGZyb20gUm9iJ3MgKGV4cGVyaW1lbnRhbCkg
cmV2aWV3IGJvdC4gSQpmb3VuZCBhIGNvdXBsZSBvZiBjb21tb24gcHJvYmxlbXMgd2l0aCB5b3Vy
IHBhdGNoLiBQbGVhc2Ugc2VlIGJlbG93LgoKT24gTW9uLCAzMCBKdWwgMjAxOCAxMDoxMToyMyAr
MDIwMCwgRW5yaWMgQmFsbGV0Ym8gaSBTZXJyYSB3cm90ZToKPiBGcm9tOiBMaW4gSHVhbmcgPGhs
QHJvY2stY2hpcHMuY29tPgo+IAo+IFRoZXNlIGFyZSByZXF1aXJlZCB0byBzdXBwb3J0IEREUiBE
VkZTIG9uIHJrMzM5OSBwbGF0Zm9ybS4gVGhlIHBhdGNoIGFsc28KPiBpbnRyb2R1Y2VzIHR3byBu
ZXcgZmlsZXMgKHJrMzM5OS1kcmFtLmggYW5kIHJrMzM5OS1kcmFtLWRlZmF1bHQtdGltaW5nKQo+
IHdpdGggZGVmYXVsdCBEUkFNIHNldHRpbmdzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IExpbiBIdWFu
ZyA8aGxAcm9jay1jaGlwcy5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRW5yaWMgQmFsbGV0Ym8gaSBT
ZXJyYSA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT4KClRoZSBwcmVmZXJyZWQgc3ViamVj
dCBwcmVmaXggaXMgImR0LWJpbmRpbmdzOiA8YmluZGluZyBkaXI+OiAuLi4iLgoKPiAtLS0KPiAK
PiBDaGFuZ2VzIGluIHYxOgo+IC0gW1JGQyA4LzEwXSBNb3ZlIHJrMzM5OS1kcmFtLmggdG8gZHQt
aW5jbHVkZXMuCj4gLSBbUkZDIDgvMTBdIFB1dCBzZHJhbSBkZWZhdWx0IHZhbHVlcyB1bmRlciB0
aGUgZG1jIG5vZGUuCj4gLSBbUkZDIDgvMTBdIFJlbW92ZWQgcmszMzk5LWRyYW0tZGVmYXVsdC10
aW1pbmcuZHRzCj4gCj4gIC4uLi9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktb3AxLW9wcC5kdHNp
ICAgICB8IDI5ICsrKysrKysrCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszMzk5
LmR0c2kgICAgICB8IDQ5ICsrKysrKysrKysrKysKPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dl
ci9yazMzOTktZHJhbS5oICAgICAgIHwgNzMgKysrKysrKysrKysrKysrKysrKwo+ICAzIGZpbGVz
IGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2R0LWJpbmRpbmdzL3Bvd2VyL3JrMzM5OS1kcmFtLmgKPiAKCkRUIGJpbmRpbmdzIChpbmNsdWRp
bmcgYmluZGluZyBoZWFkZXJzKSBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaC4gU2VlCkRvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zdWJtaXR0aW5nLXBhdGNoZXMudHh0LgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1h
aWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
