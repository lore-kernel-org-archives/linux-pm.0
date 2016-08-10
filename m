From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v5 7/8] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
Date: Wed, 10 Aug 2016 12:39:00 +0800
Message-ID: <201608101247.hUgF749P%fengguang.wu@intel.com>
References: <1470799604-12877-8-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1470799604-12877-8-git-send-email-hl@rock-chips.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Cc: tixy@linaro.org, mark.rutland@arm.com, Lin Huang <hl@rock-chips.com>, typ@rock-chips.com, linux-rockchip@lists.infradead.org, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, myungjoo.ham@samsung.com, kbuild-all@01.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

SGkgTGluLAoKW2F1dG8gYnVpbGQgdGVzdCBXQVJOSU5HIG9uIHY0LjgtcmMxXQpbYWxzbyBidWls
ZCB0ZXN0IFdBUk5JTkcgb24gbmV4dC0yMDE2MDgwOV0KW2Nhbm5vdCBhcHBseSB0byByb2NrY2hp
cC9mb3ItbmV4dCBkZXZmcmVxL2Zvci1yYWZhZWwgbGludXgvbWFzdGVyXQpbaWYgeW91ciBwYXRj
aCBpcyBhcHBsaWVkIHRvIHRoZSB3cm9uZyBnaXQgdHJlZSwgcGxlYXNlIGRyb3AgdXMgYSBub3Rl
IHRvIGhlbHAgaW1wcm92ZSB0aGUgc3lzdGVtXQoKdXJsOiAgICBodHRwczovL2dpdGh1Yi5jb20v
MGRheS1jaS9saW51eC9jb21taXRzL0xpbi1IdWFuZy9yazMzOTktc3VwcG9ydC1kZHItZnJlcXVl
bmN5LXNjYWxpbmcvMjAxNjA4MTAtMTE0NDMzCgoKY29jY2luZWxsZSB3YXJuaW5nczogKG5ldyBv
bmVzIHByZWZpeGVkIGJ5ID4+KQoKPj4gZHJpdmVycy9kZXZmcmVxL3JrMzM5OV9kbWMuYzozOTM6
Mi0zOiBVbm5lZWRlZCBzZW1pY29sb24KClBsZWFzZSByZXZpZXcgYW5kIHBvc3NpYmx5IGZvbGQg
dGhlIGZvbGxvd3VwIHBhdGNoLgoKLS0tCjAtREFZIGtlcm5lbCB0ZXN0IGluZnJhc3RydWN0dXJl
ICAgICAgICAgICAgICAgIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCmh0dHBzOi8vbGlz
dHMuMDEub3JnL3BpcGVybWFpbC9rYnVpbGQtYWxsICAgICAgICAgICAgICAgICAgIEludGVsIENv
cnBvcmF0aW9uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
