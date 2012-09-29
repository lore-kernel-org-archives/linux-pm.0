From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 5/6] ACPI: Introduce ACPI I2C controller
 enumeration driver
Date: Sat, 29 Sep 2012 13:37:53 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B90926322C16F@SHSMSX101.ccr.corp.intel.com>
References: <1348818032.10877.325.camel@rui.sh.intel.com>
	<20120928135401.6781d134@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120928135401.6781d134@pyramind.ukuu.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>, LKML <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Dirk Brandewie <dirk.brandewie@gmail.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxhbiBDb3ggW21haWx0
bzphbGFuQGx4b3JndWsudWt1dS5vcmcudWtdDQo+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI4
LCAyMDEyIDg6NTQgUE0NCj4gVG86IFpoYW5nLCBSdWkNCj4gQ2M6IExLTUw7IGxpbnV4LXBtOyBs
aW51eC1pMmM7IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBMZW4sIEJyb3duOw0KPiBSYWZh
ZWwgSi4gV3lzb2NraTsgR3JhbnQgTGlrZWx5OyBEaXJrIEJyYW5kZXdpZQ0KPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCA1LzZdIEFDUEk6IEludHJvZHVjZSBBQ1BJIEkyQyBjb250cm9sbGVyDQo+
IGVudW1lcmF0aW9uIGRyaXZlcg0KPiBJbXBvcnRhbmNlOiBIaWdoDQo+IA0KPiBPbiBGcmksIDI4
IFNlcCAyMDEyIDE1OjQwOjMyICswODAwDQo+IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGludGVsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+ID5Gcm9tIDYwNzdhNjJmMjg2NTIwMWFiNjcyN2NhN2Q2MjhlZTVl
NDNhYTU3ZTEgTW9uIFNlcCAxNyAwMDowMDowMA0KPiA+ID4yMDAxDQo+ID4gRnJvbTogWmhhbmcg
UnVpIDxydWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IERhdGU6IEZyaSwgMjQgQXVnIDIwMTIgMTU6
MTg6MjUgKzA4MDANCj4gPiBTdWJqZWN0OiBbUkZDIFBBVENIIDUvNl0gQUNQSTogSW50cm9kdWNl
IEFDUEkgSTJDIGNvbnRyb2xsZXINCj4gPiBlbnVtZXJhdGlvbiAgZHJpdmVyDQo+ID4NCj4gPiBU
aGlzIGRyaXZlciBpcyBhYmxlIHRvDQo+ID4gMSkgZW51bWVyYXRlIEkyQyBjb250cm9sbGVyIHZp
YSBBQ1BJIG5hbWVzcGFjZQ0KPiA+ICAgIGFuZCByZWdpc3RlciBpdCBhcyBhIHBsYXRmb3JtIGRl
dmljZS4NCj4gPiAyKSBlbnVtZXJhdGUgSTJDIHNsYXZlIGRldmljZXMgdmlhIEFDUEkgbmFtZXNw
YWNlLg0KPiANCj4gV2lsbCB0aGlzIGFsc28gdHJpZ2dlciBhbmQgd29yayB3aXRoIHRoZSBBQ1BJ
NCBiYXNlZCBkZXZpY2VzIHRoYXQgc2VlbQ0KPiB0byBoYXZlIEnCskMgdGFibGVzIHRoYXQgTGlu
dXggY3VycmVudGx5IGRvZXNuJ3QgdW5kZXJzdGFuZCAoZXEgc29tZQ0KPiBHTUE2MDAvT2FrdHJh
aWwgcGxhdGZvcm1zKSA/DQoNCkknbSBub3QgYXdhcmUgb2YgdGhpcy4gSSB0aGluayB0aGUgYW5z
d2VyIGlzIHByb2JhYmx5ICJObyINCmJlY2F1c2UgdGhlc2UgUE5QaWRzIGFyZSBwcmV0dHkgbmV3
Lg0KQnV0IHdlIGNhbiBjaGVjayBGQURULnJldmlzaW9uIHRvIG1ha2UgdGhlIGRyaXZlciB3b3Jr
DQpvbiBBQ1BJNSBwbGF0Zm9ybXMgb25seS4NCg0KVGhhbmtzLA0KcnVpDQoNCg==
