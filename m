From: "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2 1/7] acpi/cppc: Add macro for CPPC register BUFFER only
 check
Date: Thu, 4 Apr 2019 21:25:47 +0000
Message-ID: <4eae43aeb96e379bbdd9cd2a040fe53c147bd412.1554410643.git.Janakarajan.Natarajan@amd.com>
References: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1554410643.git.Janakarajan.Natarajan@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>
List-Id: linux-pm@vger.kernel.org

Q1BDX1NVUF9CVUZGRVJfT05MWSBlbnN1cmVzIHRoYXQgYW4gZXhwZWN0ZWQgQlVGRkVSIG9ubHkg
cmVnaXN0ZXIgaGFzIGENCnJlZ2lzdGVyIHR5cGUgb2YgQUNQSV9UWVBFX0JVRkZFUiBhbmQgaXMg
bm90IE5VTEwuDQoNClNpZ25lZC1vZmYtYnk6IEphbmFrYXJhamFuIE5hdGFyYWphbiA8SmFuYWth
cmFqYW4uTmF0YXJhamFuQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2FjcGkvY3BwY19hY3BpLmMg
fCA4ICsrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jIGIvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5j
DQppbmRleCBkNDI0NGU3ZDBlMzguLjU2YTA5ZTA1N2M0ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
YWNwaS9jcHBjX2FjcGkuYw0KKysrIGIvZHJpdmVycy9hY3BpL2NwcGNfYWNwaS5jDQpAQCAtMTE1
LDYgKzExNSwxNCBAQCBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGNwY19kZXNjICosIGNw
Y19kZXNjX3B0cik7DQogI2RlZmluZSBDUENfU1VQUE9SVEVEKGNwYykgKChjcGMpLT50eXBlID09
IEFDUElfVFlQRV9JTlRFR0VSID8JCVwNCiAJCQkJISEoY3BjKS0+Y3BjX2VudHJ5LmludF92YWx1
ZSA6CQlcDQogCQkJCSFJU19OVUxMX1JFRygmKGNwYyktPmNwY19lbnRyeS5yZWcpKQ0KKw0KKy8q
DQorICogRXZhbHVhdGVzIHRvIFRydWUgaWYgYW4gb3B0aW9uYWwgY3BjIGZpZWxkIGlzIHN1cHBv
cnRlZCBhbmQgaXMNCisgKiBCVUZGRVIgb25seQ0KKyAqLw0KKyNkZWZpbmUgQ1BDX1NVUF9CVUZG
RVJfT05MWShjcGMpICgoY3BjKS0+dHlwZSA9PSBBQ1BJX1RZUEVfQlVGRkVSICYmCVwNCisJCQkJ
ICAhSVNfTlVMTF9SRUcoJihjcGMpLT5jcGNfZW50cnkucmVnKSkNCisNCiAvKg0KICAqIEFyYml0
cmFyeSBSZXRyaWVzIGluIGNhc2UgdGhlIHJlbW90ZSBwcm9jZXNzb3IgaXMgc2xvdyB0byByZXNw
b25kDQogICogdG8gUENDIGNvbW1hbmRzLiBLZWVwaW5nIGl0IGhpZ2ggZW5vdWdoIHRvIGNvdmVy
IGVtdWxhdG9ycyB3aGVyZQ0KLS0gDQoyLjE3LjENCg0K
