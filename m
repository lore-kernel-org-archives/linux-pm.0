From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v7 5/7] power: Add support for DA9150 Charger
Date: Mon, 2 Mar 2015 10:58:48 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB53E980@SW-EX-MBX01.diasemi.com>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
 <606cf85a796f8ba8a5548b68e4afa95799efbc95.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
 <54EDBBC1.9080301@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54EDBBC1.9080301-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gRmVicnVhcnkgMjUsIDIwMTUgMTI6MTEsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQoNCj4g
PiArc3RhdGljIGludCBkYTkxNTBfY2hhcmdlcl9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGRhOTE1MF9jaGFyZ2VyICpjaGFyZ2VyID0g
cGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4gKwlpbnQgaXJxOw0KPiA+ICsNCj4gPiAr
CS8qIE1ha2Ugc3VyZSBJUlFzIGFyZSByZWxlYXNlZCBiZWZvcmUgdW5yZWdpc3RlcmluZyBwb3dl
ciBzdXBwbGllcyAqLw0KPiA+ICsJaXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwg
IkNIR19WQlVTIik7DQo+ID4gKwlmcmVlX2lycShpcnEsIGNoYXJnZXIpOw0KPiBJJ2QgdXNlIHlv
dXIgdW5yZWdpc3Rlcl9pcnEgZnVuY3Rpb24gaGVyZSBhcyB3ZWxsLiAgQmV0dGVyIHRoYW4gb3Bl
bg0KPiBjb2RpbmcgdGhlIHNhbWUgdGhpbmcgYWdhaW4uIChtb3JlIG9idmlvdXNseSBjb3JyZWN0
IGFzIHdlbGwgYXMgdGhlDQo+IGVycm9yIGNvbmRpdGlvbiB1bndpbmRpbmcgYWJvdmUgdGhlbiBs
b29rcyBqdXN0IGxpa2Ugd2UgaGF2ZSBoZXJlKS4NCg0KRmFpciBwb2ludC4gV2lsbCB1cGRhdGUg
dGhhdCB3aGVuIEkgc3RhcnQgb24gdGhlIGFkZGl0aW9uYWwgbW9kdWxlcyBJIG5lZWQgdG8NCnN1
Ym1pdC4gVGhhbmtzLg0K
