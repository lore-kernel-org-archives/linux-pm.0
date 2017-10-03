From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: cpuidle: Avoid memleak if init fail
Date: Tue, 3 Oct 2017 15:21:27 +0200
Message-ID: <d785929a-a6af-b803-d34d-a7138102f55f@linaro.org>
References: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1504211076-2331-1-git-send-email-stefan.wahren@i2se.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Leo Yan <leo.yan@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gMzEvMDgvMjAxNyAyMjoyNCwgU3RlZmFuIFdhaHJlbiB3cm90ZToKPiBJbiBjYXNlIHRoZXJl
IGFyZSBubyBEVCBpZGxlIHN0YXRlcyBkZWZpbmVkIG9yCj4gY3B1aWRsZV9yZWdpc3Rlcl9kcml2
ZXIoKSBmYWlscywgdGhlIGNvcHkgb2YgdGhlIGlkbGUgZHJpdmVyIGlzIGxlYWtlZDoKPiAKPiAg
ICAgdW5yZWZlcmVuY2VkIG9iamVjdCAweGVkZTBkYzAwIChzaXplIDEwMjQpOgo+ICAgICBjb21t
ICJzd2FwcGVyLzAiLCBwaWQgMSwgamlmZmllcyA0Mjk0OTM3NDMxIChhZ2UgNzQ0LjUxMHMpCj4g
ICAgIGhleCBkdW1wIChmaXJzdCAzMiBieXRlcyk6Cj4gICAgIDk0IDllIDBiIGMxIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIC4uLi4uLi4uLi4uLi4uLi4KPiAgICAgNTcgNDYg
NDkgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgV0ZJLi4uLi4uLi4uLi4u
Lgo+ICAgICBiYWNrdHJhY2U6Cj4gICAgIFs8YzEyOTVmMDQ+XSBhcm1faWRsZV9pbml0KzB4NDQv
MHgxYWMKPiAgICAgWzxjMDMwMWU2Yz5dIGRvX29uZV9pbml0Y2FsbCsweDNjLzB4MTZjCj4gICAg
IFs8YzEyMDBkNzA+XSBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDExMC8weDFkMAo+ICAgICBbPGMw
Y2IzNjI0Pl0ga2VybmVsX2luaXQrMHg4LzB4MTE0Cj4gICAgIFs8YzAzMDdhOTg+XSByZXRfZnJv
bV9mb3JrKzB4MTQvMHgzYwo+IAo+IFNvIGZpeCB0aGlzIGJ5IGZyZWVpbmcgdGhlIHVucmVnaXN0
ZXJlZCBjb3B5IGluIGVycm9yIGNhc2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFdhaHJl
biA8c3RlZmFuLndhaHJlbkBpMnNlLmNvbT4KPiBGaXhlczogZDUwYTdkOGFjZDc4ICgiQVJNOiBj
cHVpZGxlOiBTdXBwb3J0IGFzeW1tZXRyaWMgaWRsZSBkZWZpbml0aW9uIikKPiAtLS0KCkFja2Vk
LWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4KCgotLSAKIDxo
dHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2Fy
ZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDovL3d3dy5mYWNlYm9vay5jb20v
cGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRlci5jb20vIyEvbGluYXJvb3Jn
PiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5hcm8tYmxvZy8+IEJsb2cKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
