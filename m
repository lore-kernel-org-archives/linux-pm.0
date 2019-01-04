From: Stephen Boyd <sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Fri, 04 Jan 2019 12:59:02 -0800
Message-ID: <154663554289.15366.16011609839106849298@swboyd.mtv.corp.google.com>
References: <20181212211848.26768-1-jcrouse@codeaurora.org>
 <20181219044901.x76bd5vdsznhhrmz@vireshk-i7>
 <CAL_JsqLs69=nr=2J_48N3VtD0qNRnxAgDU8uMRwY_Qqp6Dzs_Q@mail.gmail.com>
 <CAD=FV=VMMYKoW4RU_TTjLdyrNcWZU-Gyou9b6qynKFX9wDn5Mw@mail.gmail.com>
 <CAD=FV=Utko6B6OycYpef3OQAF1v-rthcdgAKMm0GLxRM4=ummg@mail.gmail.com>
 <CAL_Jsq+U8Vj4+w6jA+B3_CyG8N==ABbw31nm+LE=6pwXEopApw@mail.gmail.com>
 <154534136449.79149.14097954220921296509@swboyd.mtv.corp.google.com>
 <7e310416-78d3-b7e5-5013-0bcc8bfd0351@codeaurora.org>
 <154604698217.179992.9966831118584978893@swboyd.mtv.corp.google.com>
 <dcb3e046-d0bd-af68-e42d-1db0db3bf2df@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <dcb3e046-d0bd-af68-e42d-1db0db3bf2df-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

UXVvdGluZyBSYWplbmRyYSBOYXlhayAoMjAxOS0wMS0wMyAwMDo0NTo1MykKPiAKPiBPbiAxMi8y
OS8yMDE4IDY6NTkgQU0sIFN0ZXBoZW4gQm95ZCB3cm90ZToKPiA+PiBTbyBJIGFtIGd1ZXNzaW5n
IHRoZSBjb25jbHVzaW9uIGlzIHRvIHVzZSBhIGZhbGxiYWNrICJvcGVyYXRpbmctcG9pbnRzLXYy
Igo+ID4+IGNvbXBhdGlibGUqb25seSogIHdoZW4gd2UgZG8gaGF2ZSBvcHAtaHogYWxvbmcgd2l0
aCBxY29tLGxldmVsIChhcyBpbiB0aGUKPiA+PiBjYXNlIHdpdGggZ3B1KSBhbmQgbm90IGhhdmUg
YSBmYWxsYmFjayBjb21wYXRpYmxlIGluIGNhc2VzIHdoZW4gd2UgZG9uJ3QKPiA+PiBoYXZlIG9w
cC1oeiAoYXMgaW4gdGhlIGNhc2Ugb2YgcnBtIHBvd2VyIGRvbWFpbnMpPwo+ID4+IFRoYXQgc2Vl
bXMgYSBsaXR0bGUgaW5jb25zaXN0ZW50LCBhbmQgZ2l2ZW4gUm9iIHNhaWQgZWl0aGVyIHdheSBp
cyBmaW5lLAo+ID4+IGp1c3QgZG8gb25lIHdheSBvciB0aGUgb3RoZXIgYW5kIG5vdCBib3RoLCBJ
IGFtIGluY2xpbmVkIHRvIHRoaW5rIHdlIHNob3VsZAo+ID4+IGp1c3QgaGF2ZSBhICJvcGVyYXRp
bmctcG9pbnRzLXYyLXFjb20tbGV2ZWwiIGFuZCBubyBmYWxsYmFjayBjb21wYXRpYmxlLgo+ID4+
IERvZXMgdGhhdCBtYWtlIHNlbnNlPwo+ID4+Cj4gPiBBcmUgeW91IGdvaW5nIHRvIHVwZGF0ZSB0
aGUgc2tpcCB0YWJsZSB0byBub3QgY3JlYXRlIHBsYXRmb3JtIGRldmljZXM/Cj4gPiBPciBpbnRy
b2R1Y2Ugc29tZSBnZW5lcmljIHByb3BlcnR5IHRvIGluZGljYXRlIHRoYXQgdGhpcyBpcyBqdXN0
IGRhdGEKPiA+IGFuZCBub3QgYSBkZXZpY2Ugbm9kZT8KPiAKPiBJcyBhbnkgb2YgaXQgcmVhbGx5
IG5lZWRlZCwgZ2l2ZW4gdGhlIGJpbmRpbmdzIHNwZWNpZnkgdGhhdCB0aGUgT1BQIHRhYmxlCj4g
c2hvdWxkIGFjdHVhbGx5IGJlIGEgY2hpbGQgbm9kZSBvZiB0aGUgZGV2aWNlL3Bvd2VyIGRvbWFp
biBzdXBwb3J0aW5nCj4gaXQ/IEkgZG9uJ3Qgc2VlIHdobyB3b3VsZCBlbmQgdXAgY3JlYXRpbmcg
cGxhdGZvcm0gZGV2aWNlcyBmb3IgdGhlbS4KPiAKCkdvb2QgcG9pbnQuIElmIGl0J3MgYSBjaGls
ZCBub2RlIHRoZW4gYWxtb3N0IGFsbCB0aGUgdGltZSB3ZSB3b24ndCBiZQp0cnlpbmcgdG8gcG9w
dWxhdGUgdGhlIE9QUCBub2RlIGFzIGFub3RoZXIgcGxhdGZvcm0gZGV2aWNlIHNvIHRoaXMgaXNu
J3QKcmVhbGx5IGltcG9ydGFudCB0byBoYW5kbGUgdW50aWwgdGhhdCBoYXBwZW5zLCB3aGljaCBp
cyBwcm9iYWJseSBuZXZlci4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkZyZWVkcmVubyBtYWlsaW5nIGxpc3QKRnJlZWRyZW5vQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Zy
ZWVkcmVubwo=
