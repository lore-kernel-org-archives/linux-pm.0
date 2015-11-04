From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
Date: Wed, 4 Nov 2015 16:45:15 -0600
Message-ID: <1446677115.12676.26.camel@freescale.com>
References: <1442996938-47147-1-git-send-email-hongtao.jia@freescale.com>
 <1443132592.32298.56.camel@freescale.com>
 <BLUPR03MB14997B46CC6AFC247EDC340E1420@BLUPR03MB149.namprd03.prod.outlook.com>
 <20151104192444.GA14127@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20151104192444.GA14127@localhost.localdomain>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Hongtao Jia <hongtao.jia@freescale.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDE1LTExLTA0IGF0IDExOjI0IC0wODAwLCBFZHVhcmRvIFZhbGVudGluIHdyb3Rl
Ogo+IE9uIEZyaSwgU2VwIDI1LCAyMDE1IGF0IDAzOjA5OjQyQU0gKzAwMDAsIEhvbmd0YW8gSmlh
IHdyb3RlOgo+ID4gCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiA+IEZyb206
IFdvb2QgU2NvdHQtQjA3NDIxCj4gPiA+IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDI1LCAyMDE1
IDY6MTAgQU0KPiA+ID4gVG86IEppYSBIb25ndGFvLUIzODk1MQo+ID4gPiBDYzogZWR1YmV6dmFs
QGdtYWlsLmNvbTsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eHBwYy0KPiA+ID4gZGV2
QGxpc3RzLm96bGFicy5vcmcKPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWM10gdGhlcm1hbDog
cW9yaXE6IEFkZCB0aGVybWFsIG1hbmFnZW1lbnQgc3VwcG9ydAo+ID4gPiAKPiA+ID4gT24gV2Vk
LCAyMDE1LTA5LTIzIGF0IDE2OjI4ICswODAwLCBKaWEgSG9uZ3RhbyB3cm90ZToKPiA+ID4gPiBU
aGlzIGRyaXZlciBhZGQgdGhlcm1hbCBtYW5hZ2VtZW50IHN1cHBvcnQgYnkgZW5hYmxpbmcgVE1V
IChUaGVybWFsCj4gPiA+ID4gTW9uaXRvcmluZyBVbml0KSBvbiBRb3JJUSBwbGF0Zm9ybS4KPiA+
ID4gPiAKPiA+ID4gPiBJdCdzIGJhc2VkIG9uIHRoZXJtYWwgb2YgZnJhbWV3b3JrOgo+ID4gPiA+
IC0gVHJpcCBwb2ludHMgZGVmaW5lZCBpbiBkZXZpY2UgdHJlZS4KPiA+ID4gPiAtIENwdWZyZXEg
YXMgY29vbGluZyBkZXZpY2UgcmVnaXN0ZXJlZCBpbiBxb3JpcSBjcHVmcmVxIGRyaXZlci4KPiA+
ID4gCj4gPiA+IEkgZG9uJ3Qgc2VlIGFueSBjb29saW5nIGRldmljZSByZWdpc3RlcmVkIGluIHRo
ZSBxb3JpcSBjcHVmcmVxIGRyaXZlci4KPiA+ID4gSXMgdGhpcyBkZXBlbmRlbnQgb24gc29tZSBv
dGhlciBwYXRjaD8KPiA+IAo+ID4gSXQncyBub3QgZGVwZW5kIG9uIGFueSBwYXRjaC4gQnV0IEkg
c2F3IHlvdXIgcGF0Y2ggYmVsb3c6Cj4gPiBbUEFUQ0ggdjMgNS81XSBjcHVmcmVxOiBxb3JpcTog
RG9uJ3QgbG9vayBhdCBjbG9jayBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzCj4gPiBTbyBJIGhvbGQg
bXkgcGF0Y2ggd2FpdGluZyBmb3IgeW91ciBwYXRjaCBtZXJnZWQgb3IgdGhlcmUgd2lsbCBiZSAK
PiA+IGNvbmZsaWN0Lgo+ID4gCj4gPiBJIGNvdWxkIHNlbmQgaXQgb3V0IHRvbyBpZiB5b3UgYXJl
IGZpbmUgd2l0aCBpdC4KPiAKPiBXb3VsZCB5b3UgZ3V5cyBiZW5lZml0IG9mIGNwdWZyZXEtY3B1
MD8KCklmIHlvdSBtZWFuIGNwdWZyZXEtZHQsIG5vLCBhcyBJIGV4cGxhaW5lZCBpbiAKaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMTUvOS8xOC82OTkKCi1TY290dAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApM
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlz
dGluZm8vbGludXhwcGMtZGV2
