From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Thu, 28 Jan 2016 04:14:06 +0000 (GMT)
Message-ID: <987619535.304031453954442569.JavaMail.weblogic@epmlwas09c>
Reply-To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
MIME-version: 1.0
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tyler Baker <tyler.baker-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?utf-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

PiBIaSBUaGllcnJ5LA0KPiANCj4gT24gMjEgSmFudWFyeSAyMDE2IGF0IDAyOjU0LCBUaGllcnJ5
IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBUaHUsIEph
biAyMSwgMjAxNiBhdCAwODo1MjoyNkFNICswMTAwLCBUb21ldSBWaXpvc28gd3JvdGU6DQpbXQ0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBUb21ldSBWaXpvc28gPHRvbWV1LnZpem9zb0Bjb2xsYWJvcmEu
Y29tPg0KPiA+PiBSZXBvcnRlZC1ieTogVHlsZXIgQmFrZXIgPHR5bGVyLmJha2VyQGxpbmFyby5v
cmc+DQpbXQ0KPiA+Pg0KPiA+DQo+ID4gSSBoYWQgbm90aWNlZCBpdCByZWNlbnRseSBidXQgaGFk
bid0IGdvdCBhcm91bmQgdG8gbG9vayBpbnRvIGl0LCB0aGFua3MNCj4gPiBmb3IgZml4aW5nIGl0
Lg0KPiA+DQo+ID4gVGVzdGVkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29t
Pg0KPiA+IEFja2VkLWJ5OiBUaGllcnJ5IFJlZGluZyA8dHJlZGluZ0BudmlkaWEuY29tPg0KPiAN
Cj4gSSBkb24ndCBzZWUgdGhpcyBwYXRjaCBpbiAtbmV4dCB5ZXQsIHNvIEknbSBndWVzcyBpdCBo
YXNuJ3QgYmVlbg0KPiBhcHBsaWVkLiBBbnkgY2hhbmNlIHlvdSBjb3VsZCBwaWNrIGl0IHVwPyBU
aGlzIGlzc3VlIGlzIG5vdw0KPiBtYW5pZmVzdGluZyBpbiBtYWlubGluZSwgYW5kIGNhdXNpbmcg
dG9uIG9mIG5vaXNlIGluIHRoZSBib290IHJlcG9ydHMuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBU
eWxlcg0KDQoNCkhleSwgdGhlIHBhdGNoIGFwcGVhcmVkIGF0IHRoZSBtYWlsaW5nIGxpc3QgYSB3
ZWVrIGFnby4NCkxpbnV4IDQuNS1yYzEgYXBwZWFyZWQgMyBkYXlzIGFnby4NClRoZSBmYXN0ZXN0
IHBvc3NpYmxlIGZvciBtYWlubGluZSBpbmNsdXNpb24gaXMgNC41LXJjMiBvciAzLg0KDQpZb3Ug
Y2Fubm90IHNpbXBseSBleHBlY3QgdGhlIHBhdGNoIHRvIGJlIGluY2x1ZGVkIGluIHRoZSBtYWlp
bmxpbmUgdGhhdCBmYXN0Lg0KDQo=
