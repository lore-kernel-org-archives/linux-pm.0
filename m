From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to dma_alloc_wc
Date: Thu, 18 Oct 2018 13:59:27 +0200
Message-ID: <CA+M3ks5WW9WviTNr3VLHc-ijYLu-fp8XMtAbr3p9cFe3J+n39Q@mail.gmail.com>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
 <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
 <20181017071958.GC23407@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181017071958.GC23407@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

TGUgbWVyLiAxNyBvY3QuIDIwMTggw6AgMDk6MTksIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPiBhIMOpY3JpdCA6Cj4KPiBPbiBUdWUsIE9jdCAxNiwgMjAxOCBhdCAwMjo0MToyM1BNICsw
MjAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToKPiA+IExlIGx1bi4gMTUgb2N0LiAyMDE4IMOg
IDExOjEyLCBCZW5qYW1pbiBHYWlnbmFyZAo+ID4gPGJlbmphbWluLmdhaWduYXJkQGxpbmFyby5v
cmc+IGEgw6ljcml0IDoKPiA+ID4KPiA+ID4gTGUgc2FtLiAxMyBvY3QuIDIwMTggw6AgMTc6MTcs
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiBhIMOpY3JpdCA6Cj4gPiA+ID4KPiA+ID4g
PiBUaGUgRE1BIEFQSSBkb2VzIGl0cyBvd24gem9uZSBkZWNpc2lvbnMgYmFzZWQgb24gdGhlIGNv
aGVyZW50X2RtYV9tYXNrLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4gPiA+Cj4gPiA+IFJldmlld2VkLWJ5OiBCZW5qYW1pbiBH
YWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4KPiA+Cj4gPiBDaHJpc3RvcGgg
ZG8geW91IHBsYW4gdG8gbWVyZ2UgdGhpcyBwYXRjaCBvbiB5b3VyIG93biB0cmVlID8gb3Igd291
bGQKPiA+IGxpa2UgSSBwdXQgaXQgZGlyZWN0bHkgaW4gZHJtLW1pc2MtbmV4dCBicmFuY2ggPwo+
Cj4gUGxlYXNlIHB1bGwgaXQgaW4gdGhyb3VnaCBkcm0tbWlzYy1uZXh0LCB0aGFua3MhCgpBcHBs
aWVkIG9uIGRybS1taXNjLW5leHQsClRoYW5rcywKQmVuamFtaW4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
