From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/8] cpufreq: tegra186: don't pass GFP_DMA32 to
 dma_alloc_coherent
Date: Sat, 13 Oct 2018 17:17:00 +0200
Message-ID: <20181013151707.32210-2-hch@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

VGhlIERNQSBBUEkgZG9lcyBpdHMgb3duIHpvbmUgZGVjaXNpb25zIGJhc2VkIG9uIHRoZSBjb2hl
cmVudF9kbWFfbWFzay4KClNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgotLS0KIGRyaXZlcnMvY3B1ZnJlcS90ZWdyYTE4Ni1jcHVmcmVxLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2NwdWZyZXEvdGVncmExODYtY3B1ZnJlcS5jIGIvZHJpdmVycy9jcHVmcmVxL3RlZ3Jh
MTg2LWNwdWZyZXEuYwppbmRleCAxZjU5OTY2NTczYWEuLmYxZTA5MDIyYjgxOSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jcHVmcmVxL3RlZ3JhMTg2LWNwdWZyZXEuYworKysgYi9kcml2ZXJzL2NwdWZy
ZXEvdGVncmExODYtY3B1ZnJlcS5jCkBAIC0xMjEsNyArMTIxLDcgQEAgc3RhdGljIHN0cnVjdCBj
cHVmcmVxX2ZyZXF1ZW5jeV90YWJsZSAqaW5pdF92aGludF90YWJsZSgKIAl2b2lkICp2aXJ0Owog
CiAJdmlydCA9IGRtYV9hbGxvY19jb2hlcmVudChicG1wLT5kZXYsIHNpemVvZigqZGF0YSksICZw
aHlzLAotCQkJCSAgR0ZQX0tFUk5FTCB8IEdGUF9ETUEzMik7CisJCQkJICBHRlBfS0VSTkVMKTsK
IAlpZiAoIXZpcnQpCiAJCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwogCi0tIAoyLjE5LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBt
YWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
