From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v4 00/10] Better compatible for the rockchip thermal and
 support RK3368 SoCs
Date: Sat, 14 Nov 2015 14:30:46 +0800
Message-ID: <5646D516.9040404@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <20151112182950.GB4361@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20151112182950.GB4361-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

RWR1YXJkbywKCuWcqCAyMDE15bm0MTHmnIgxM+aXpSAwMjoyOSwgRWR1YXJkbyBWYWxlbnRpbiDl
hpnpgZM6Cj4gT24gTW9uLCBOb3YgMDksIDIwMTUgYXQgMTI6NDg6NTJQTSArMDgwMCwgQ2Flc2Fy
IFdhbmcgd3JvdGU6Cj4+IFRoYW5rIHlvdSBhbGwgZm9yIHByb3ZpZGluZyBpbnB1dHMgYW5kIGNv
bW1lbnRzIG9uIHByZXZpb3VzIHZlcnNpb25zIG9mCj4+IHRoaXMgcGF0Y2hzZXQuCj4+IEVzcGVj
aWFsbHkgdGhhbmtzIHRvIHRoZSAoRWR1YXJkbywgRG1pdHJ5LCBIZWlrbywuLi4uKS4KPj4KPj4g
VGhpcyBzZXJpZXMgcGF0Y2hzIGFyZSB3b3JraW5nIGZvciBSSzMzNjggb24gUm9ja2NoaXAgcGxh
dGZvcm0uCj4gRG8geW91IGhhdmUgYW55IHJlc3VsdHMgb24gZXhpc3Rpbmcgc3VwcG9ydD8gSXMg
dGhlIGRyaXZlciBzdGlsbCBpbiBvbmUKPiBwaWVjZSBmb3IgcmszMjg4PwoKWWVwLiB0aGF0J3Mg
c3RpbGwgaGFwcHkgd29yayBmb3IgcmszMjg4IFNvQ3MuCgokd2hpbGUgdHJ1ZTsgZG8gZ3JlcCAi
IiAvc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lWzEtMl0vdGVtcDsgc2xlZXAgCi41OyBk
b25lCi4uLgovc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMS90ZW1wOjcwODMzCi9zeXMv
Y2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUyL3RlbXA6Njk2MTUKL3N5cy9jbGFzcy90aGVybWFs
L3RoZXJtYWxfem9uZTEvdGVtcDo3MDQxNgovc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25l
Mi90ZW1wOjY4ODQ2Ci9zeXMvY2xhc3MvdGhlcm1hbC90aGVybWFsX3pvbmUxL3RlbXA6NzA0MTYK
L3N5cy9jbGFzcy90aGVybWFsL3RoZXJtYWxfem9uZTIvdGVtcDo3MDgzMwovc3lzL2NsYXNzL3Ro
ZXJtYWwvdGhlcm1hbF96b25lMS90ZW1wOjcwODMzCi9zeXMvY2xhc3MvdGhlcm1hbC90aGVybWFs
X3pvbmUyL3RlbXA6Njk2MTUKL3N5cy9jbGFzcy90aGVybWFsL3RoZXJtYWxfem9uZTEvdGVtcDo3
MTY2Ngovc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMi90ZW1wOjY5NjE1Ci9zeXMvY2xh
c3MvdGhlcm1hbC90aGVybWFsX3pvbmUxL3RlbXA6NzA0MTYKL3N5cy9jbGFzcy90aGVybWFsL3Ro
ZXJtYWxfem9uZTIvdGVtcDo2OTYxNQovc3lzL2NsYXNzL3RoZXJtYWwvdGhlcm1hbF96b25lMS90
ZW1wOjcwODMzCgo+IEkgYW0gcGxhbmluZyB0byBzZW5kIHlvdXIgc2VyaWVzIGluIG5leHQgcmMg
Y3ljbGVzLiBJdCB3b24ndCBhcHBlYXIgaW4KPiBsaW51eC1uZXh0IHVudGlsIG1lcmdlIHdpbmRv
dyBmaW5pc2hlcy4KClRoYW5rcyEKPgo+IEJSLAo+Cj4gRWR1YXJkbyBWYWxlbnRpbgo+Cj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1yb2Nr
Y2hpcCBtYWlsaW5nIGxpc3QKPiBMaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hp
cAoKCi0tIApjYWVzYXIgd2FuZyB8IHNvZnR3YXJlIGVuZ2luZWVyIHwgd3h0QHJvY2stY2hpcC5j
b20KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2Nr
Y2hpcAo=
