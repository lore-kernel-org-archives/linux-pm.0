From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v6 3/7] iio: Add support for DA9150 GPADC
Date: Tue, 27 Jan 2015 16:15:37 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB529E60@SW-EX-MBX01.diasemi.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <ae9b56cc8cd15bd72ea1b721ae02b1dde8632dbf.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <54BFCE97.4050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54BFCE97.4050007-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gSmFudWFyeSAyMSwgMjAxNSAxNjowNywgVmFya2EgQmhhZHJhbSB3cm90ZToNCg0KPiBPbiBX
ZWRuZXNkYXkgMjEgSmFudWFyeSAyMDE1IDA5OjE2IFBNLCBBZGFtIFRob21zb24gd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIERBOTE1MCBDaGFyZ2VyICYgRnVlbC1HYXVn
ZSBJQyBHUEFEQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5U
aG9tc29uLk9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEhhcnRtdXQg
S25hYWNrIDxrbmFhY2suaEBnbXguZGU+DQo+ID4gQWNrZWQtYnk6IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+DQo+IA0KPiAoLi4uKQ0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgZGE5MTUwX2dwYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3Qg
ZGE5MTUwICpkYTkxNTAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2LT5wYXJlbnQpOw0KPiA+ICsJc3Ry
dWN0IGRhOTE1MF9ncGFkYyAqZ3BhZGM7DQo+ID4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
Ow0KPiA+ICsJaW50IGlycSwgcmV0Ow0KPiA+ICsNCj4gPiArCWluZGlvX2RldiA9IGRldm1faWlv
X2RldmljZV9hbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmdwYWRjKSk7DQo+IA0KPiAgIFlvdSBj
YW4gZGlyZWN0bHkgdXNlICpkZXYqIGluc3RlYWQgb2YgKiZwZGV2LT5kZXYqDQoNClllcyBhZ3Jl
ZWQuIENhbiBmb2xsb3cgdXAgd2l0aCBjaGFuZ2UgZm9yIHRoaXMgYXMgaXQncyBub3QgdXJnZW50
IGFuZCB3b3VsZA0KcmF0aGVyIGxlYXZlIGN1cnJlbnQgcGF0Y2ggc2V0IGFzIGlzLg0K
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
