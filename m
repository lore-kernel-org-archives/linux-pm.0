From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 0/5] Fix a trivial typo and support rk3228/rk3399 SoCs
 for thermal driver.
Date: Sun, 20 Dec 2015 17:15:30 +0800
Message-ID: <567671B2.5060705@rock-chips.com>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
 <20151217200927.GC7999@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20151217200927.GC7999-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

CuWcqCAyMDE15bm0MTLmnIgxOOaXpSAwNDowOSwgRWR1YXJkbyBWYWxlbnRpbiDlhpnpgZM6Cj4g
SGVsbG8sCj4KPiBPbiBUaHUsIERlYyAwMywgMjAxNSBhdCAwNDo0ODozOFBNICswODAwLCBDYWVz
YXIgV2FuZyB3cm90ZToKPj4gVGhpcyBzZXJpZXMgcGFjdGhlcyB0byBzdXBwb3J0IHRoZSBuZXh0
IHNvYyBmb3IgdGhpcyB0aGVybWFsIGRyaXZlci4KPj4gSSBkb24ndCBhZGQgdGhlIGR0cyB0aGVy
bWFsIGRhdGEgc2luY2UgdGhlc2UgU29DcyBoYXZlICpfbm90XyogbGFuZAo+PiBpbiB0aGlzIG1h
aW5saW5lLiBJIGJlbGlldmUgdGhlc2UgU29DcyBkdHMgd2lsbCBsYW5kIGluIHRoaXMgbWFpbmxp
bmUKPj4gbGF0ZWx5LAo+PiB0aGVuIEkgd2lsbCBhZGQgdGhlIHRoZXJtYWwgZGF0YSBmb3IgSGVp
a28uCj4+Cj4+IFRoaXMgc2VyaWVzIHBhdGNoZXMgY2FuIGFwcGx5IGludG8gRWR1YXJkbyBicmFu
Y2guCj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L2V2YWxl
bnRpL2xpbnV4LXNvYy10aGVybWFsLmdpdAo+Pgo+PiBBbHNvLCB0aGlzIHNlcmllcyBwYWN0aGVz
IGhhdmUgYnVpbHQgb24gZ2l0aHViIGJyYW5jaC4KPj4gaHR0cHM6Ly9naXRodWIuY29tL3JvY2tj
aGlwLWxpbnV4L2tlcm5lbC9jb21taXRzL2RldmVsb3A0LjQKPj4KPj4gUEFUQ0hbMS81XToKPj4g
VGhhdCdzIGJpdCB1Z2x5IHR5cG8sIHNvcnJ5IGZvciBzZW5kaW5nIGFnYWluIDooLgo+Pgo+PiBQ
QVRDSFsyLzVdOgo+PiBUbyBmaXggYSBidWlsZCB3YXJuaW5nIGNhbWUgZnJvbSBEYW4gQ2FycGVu
dGVyIHJlcG9ydCBzbWF0Y2ggY2hlY2ssCj4+IFRoYW5rcy4gOikKPj4KPj4gUEFUQ0hbMy81XToK
Pj4gQWRkIHRoZSByazMyMjgvcmszMzk5IFNvQ3MgY29tcGF0aWJsZSBmb3IgZHQtYmluZGluZ3Mu
Cj4+Cj4+IFBBVENIWzQvNV06Cj4+IEFkZCB0aGUgcmszMjI4IFNvQ3MgZm9yIHRoZXJtYWwgZHJp
dmVyLgo+Pgo+PiBQQVRDSFs1LzVdOgo+PiBBZGQgdGhlIHJrMzM5OSBTb0NzIGZvciB0aGVybWFs
IGRyaXZlciBiYXNlZCBvbiBQQVRDSFs0LzVdLgo+IEkgYXBwbGllZCBhbGwgYnV0IDIvNS4KClRo
YW5rcyBFZHVhcmRvLAoKSSBzZW5kIHRoZSBuZXcgcGF0Y2hbMi81XS4KaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC83ODkxMzgxLwoKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0Cj4g
TGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAKCgotLSAKY2Flc2FyIHdhbmcg
fCBzb2Z0d2FyZSBlbmdpbmVlciB8IHd4dEByb2NrLWNoaXAuY29tCgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LXJvY2tjaGlwIG1haWxpbmcg
bGlzdApMaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK
