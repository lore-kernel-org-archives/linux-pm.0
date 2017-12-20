From: Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/3 v6] battery: Add the battery
 hooking API
Date: Wed, 20 Dec 2017 13:58:09 -0800
Message-ID: <20171220215809.GB14966@fury>
References: <20171215165654.GA6209@thinkpad>
 <CAJZ5v0icKSOsxFTRonW8xEt7=oXBvCsO84FMx4ECQHTYd0_SGw@mail.gmail.com>
 <CALgTWSuWoj6ecfNZmpn68uGV4m+Rz2adAWrw-Ng-7rU75SVtHQ@mail.gmail.com>
 <20171220211617.GA14667@fury>
 <CALgTWSvEg3EfjSJqAp5nRuxRceBpg92=x3FPFEW9PThBmizQEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALgTWSvEg3EfjSJqAp5nRuxRceBpg92=x3FPFEW9PThBmizQEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBEZWMgMjAsIDIwMTcgYXQgMTA6MjM6MzBQTSArMDEwMCwgT2duamVuIEdhbGnEhyB3
cm90ZToKPiBPbiAyMC8xMi8yMDE3LCBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+
IHdyb3RlOgo+ID4gT24gV2VkLCBEZWMgMjAsIDIwMTcgYXQgMDM6MzA6MThQTSArMDEwMCwgT2du
amVuIEdhbGnEhyB3cm90ZToKPiA+PiBPbiAxOC8xMi8yMDE3LCBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4+ID4gQWxzbywgd2hhdCBpZiBzb21lb25lIGF0
dGVtcHRzIHRvIGFkZCBhIGhvb2sgd2hlbiB0aGUgQUNQSSBiYXR0ZXJ5Cj4gPgo+ID4+ID4gbW9k
dWxlIGlzIG5vdCBsb2FkZWQ/ICBXaWxsIHRoYXQgc3RpbGwgd29yaz8KPiA+Pgo+ID4+IFRoZSBt
b2R1bGUgdGhhdCByZXF1ZXN0cyB0aGUgaG9va3Mgd2lsbCBmYWlsIHRvIGxvYWQgd2l0aCB0aGUg
Zm9sbG93aW5nCj4gPj4KPiA+PiA+IFsgIDE0OS4yNTkxMjddIHRoaW5rcGFkX2FjcGk6IFVua25v
d24gc3ltYm9sIGJhdHRlcnlfaG9va19yZWdpc3RlciAoZXJyCj4gPj4gPiAwKQo+ID4+ID4gWyAg
MTQ5LjI1OTE1OF0gdGhpbmtwYWRfYWNwaTogVW5rbm93biBzeW1ib2wgYmF0dGVyeV9ob29rX3Vu
cmVnaXN0ZXIKPiA+PiA+IChlcnIgMCkKPiA+Cj4gPiBXaWxsIGEgc3luY2hyb25vdXMgcmVxdWVz
dF9tb2R1bGUoKSBhZGRyZXNzIHRoaXMgY29uY2Vybj8KPiA+Cj4gCj4gSSBkb24ndCBrbm93LCB0
aGF0IGNoZWNrIHNlZW1zIGxpa2UgYSBwcmUtbG9hZCBjaGVjay4gTGlrZSBtZXRhZGF0YQo+IGNo
ZWNraW5nIGFib3V0Cj4gdGhlIG1vZHVsZS4gbW9kcHJvYmUgaGFuZGxlcyB0aGUgbW9kdWxlIGxv
YWRpbmcganVzdCBmaW5lLgoKUmVhZCB0byBxdWljayB0cnlpbmcgdG8gY2F0Y2ggdXAgYW5kIG1p
c3VuZGVyc3Rvb2QgdGhlIHByb2JsZW0uIFBsZWFzZQpkaXNyZWdhcmQuCgotLSAKRGFycmVuIEhh
cnQKVk13YXJlIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQ2hlY2sgb3V0IHRoZSB2aWJyYW50IHRlY2ggY29tbXVuaXR5IG9uIG9uZSBvZiB0aGUg
d29ybGQncyBtb3N0CmVuZ2FnaW5nIHRlY2ggc2l0ZXMsIFNsYXNoZG90Lm9yZyEgaHR0cDovL3Nk
bS5saW5rL3NsYXNoZG90Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlibS1hY3BpLWRldmVsIG1haWxpbmcgbGlzdAppYm0tYWNwaS1kZXZlbEBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vaWJtLWFjcGktZGV2ZWwK
