From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Thu, 3 Jan 2019 14:15:53 +0530
Message-ID: <dcb3e046-d0bd-af68-e42d-1db0db3bf2df@codeaurora.org>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <154515840025.238328.5075439774176447808@swboyd.mtv.corp.google.com>
 <CAD=FV=XeFYmOJx9Wxy7hLQwSq1GoF84eQ93Y4KgrO1JM-g9ZiA@mail.gmail.com>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
 <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
 <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <154604698217.179992.9966831118584978893-n1Xw8LXHxjTHt/MElyovVYaSKrA+ACpX0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Ck9uIDEyLzI5LzIwMTggNjo1OSBBTSwgU3RlcGhlbiBCb3lkIHdyb3RlOgo+PiBTbyBJIGFtIGd1
ZXNzaW5nIHRoZSBjb25jbHVzaW9uIGlzIHRvIHVzZSBhIGZhbGxiYWNrICJvcGVyYXRpbmctcG9p
bnRzLXYyIgo+PiBjb21wYXRpYmxlKm9ubHkqICB3aGVuIHdlIGRvIGhhdmUgb3BwLWh6IGFsb25n
IHdpdGggcWNvbSxsZXZlbCAoYXMgaW4gdGhlCj4+IGNhc2Ugd2l0aCBncHUpIGFuZCBub3QgaGF2
ZSBhIGZhbGxiYWNrIGNvbXBhdGlibGUgaW4gY2FzZXMgd2hlbiB3ZSBkb24ndAo+PiBoYXZlIG9w
cC1oeiAoYXMgaW4gdGhlIGNhc2Ugb2YgcnBtIHBvd2VyIGRvbWFpbnMpPwo+PiBUaGF0IHNlZW1z
IGEgbGl0dGxlIGluY29uc2lzdGVudCwgYW5kIGdpdmVuIFJvYiBzYWlkIGVpdGhlciB3YXkgaXMg
ZmluZSwKPj4ganVzdCBkbyBvbmUgd2F5IG9yIHRoZSBvdGhlciBhbmQgbm90IGJvdGgsIEkgYW0g
aW5jbGluZWQgdG8gdGhpbmsgd2Ugc2hvdWxkCj4+IGp1c3QgaGF2ZSBhICJvcGVyYXRpbmctcG9p
bnRzLXYyLXFjb20tbGV2ZWwiIGFuZCBubyBmYWxsYmFjayBjb21wYXRpYmxlLgo+PiBEb2VzIHRo
YXQgbWFrZSBzZW5zZT8KPj4KPiBBcmUgeW91IGdvaW5nIHRvIHVwZGF0ZSB0aGUgc2tpcCB0YWJs
ZSB0byBub3QgY3JlYXRlIHBsYXRmb3JtIGRldmljZXM/Cj4gT3IgaW50cm9kdWNlIHNvbWUgZ2Vu
ZXJpYyBwcm9wZXJ0eSB0byBpbmRpY2F0ZSB0aGF0IHRoaXMgaXMganVzdCBkYXRhCj4gYW5kIG5v
dCBhIGRldmljZSBub2RlPwoKSXMgYW55IG9mIGl0IHJlYWxseSBuZWVkZWQsIGdpdmVuIHRoZSBi
aW5kaW5ncyBzcGVjaWZ5IHRoYXQgdGhlIE9QUCB0YWJsZQpzaG91bGQgYWN0dWFsbHkgYmUgYSBj
aGlsZCBub2RlIG9mIHRoZSBkZXZpY2UvcG93ZXIgZG9tYWluIHN1cHBvcnRpbmcKaXQ/IEkgZG9u
J3Qgc2VlIHdobyB3b3VsZCBlbmQgdXAgY3JlYXRpbmcgcGxhdGZvcm0gZGV2aWNlcyBmb3IgdGhl
bS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyZWVk
cmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ZyZWVkcmVubwo=
