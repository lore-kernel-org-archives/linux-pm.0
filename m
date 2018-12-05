From: Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 7/8] media: sti/bdisp: don't pass GFP_DMA32 to
 dma_alloc_attrs
Date: Wed, 5 Dec 2018 08:31:29 -0200
Message-ID: <20181205083129.20b6b0be@coco.lan>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-8-hch@lst.de>
 <CA+M3ks5KO-Yr_PEczaENhTfirthFz2gW1uv4bwZe5mjy3-jZyg@mail.gmail.com>
 <20181017072020.GD23407@lst.de>
 <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CA+M3ks5ebGDgFtMS5mSYz38AnyrTMQr8C_JkbFEzp=k+izJjUQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, linux-tegra@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

RW0gVGh1LCAxOCBPY3QgMjAxOCAxNDowMDo0MCArMDIwMApCZW5qYW1pbiBHYWlnbmFyZCA8YmVu
amFtaW4uZ2FpZ25hcmRAbGluYXJvLm9yZz4gZXNjcmV2ZXU6Cgo+IExlIG1lci4gMTcgb2N0LiAy
MDE4IMOgIDA5OjIwLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gYSDDqWNyaXQgOgo+
ID4KPiA+IE9uIE1vbiwgT2N0IDE1LCAyMDE4IGF0IDExOjEyOjU1QU0gKzAyMDAsIEJlbmphbWlu
IEdhaWduYXJkIHdyb3RlOiAgCj4gPiA+IExlIHNhbS4gMTMgb2N0LiAyMDE4IMOgIDE3OjE4LCBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gYSDDqWNyaXQgOiAgCj4gPiA+ID4KPiA+ID4g
PiBUaGUgRE1BIEFQSSBkb2VzIGl0cyBvd24gem9uZSBkZWNpc2lvbnMgYmFzZWQgb24gdGhlIGNv
aGVyZW50X2RtYV9tYXNrLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+ICAKPiA+ID4KPiA+ID4gUmV2aWV3ZWQtYnk6IEJlbmphbWlu
IEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5hcm8ub3JnPiAgCj4gPgo+ID4gQ2FuIHlv
dSBwaWNrIGl0IHVwIHRocm91Z2ggdGhlIG1lZGlhIHRyZWU/ICAKPiAKPiBObyBidXQgTWF1cm9z
IG9yIEhhbnMgKGluIENDKSBjYW4gYWRkIGl0LgoKSSdtIGFkZGluZyBpdC4gU29ycnkgZm9yIHRo
ZSBkZWxheS4gQWxsIHRob3NlIHRyaXBzIGZvciBNUy9LUyBtYWRlCmhhcmRlciB0byBoYW5kbGUg
aXQgZWFybGllci4KClRoYW5rcywKTWF1cm8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vZHJpLWRldmVsCg==
