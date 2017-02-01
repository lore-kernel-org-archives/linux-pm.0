From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 0/2] drm amdgpu/radeon: clean up d3_delay usage
Date: Wed, 01 Feb 2017 10:22:11 -0600
Message-ID: <20170201162020.24314.27094.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@canonical.com>
List-Id: linux-pm@vger.kernel.org

YW1kZ3B1IGRvZXNuJ3QgbmVlZCB0byB0b3VjaCBwZGV2LT5kM19kZWxheSBhdCBhbGwuCgpyYWRl
b24gaGFzIGEgZDNfZGVsYXkgcXVpcmsgZm9yIE1hY0Jvb2sgUHJvLCBidXQgaXQgb25seSBhZmZl
Y3RzCnJhZGVvbl9zd2l0Y2hlcm9vX3NldF9zdGF0ZSgpLiAgSSB0aGluayBpdCBzaG91bGQgYWZm
ZWN0IHdha2V1cHMgZG9uZSBieQp0aGUgUENJIGNvcmUgYXMgd2VsbC4KCkNoYW5nZXMgZnJvbSB2
MSB0byB2MjoKICAtIEZpeCBhY2NpZGVudGFsIHJlbW92YWwgb2YgInsgMCwgMCwgMCwgMCwgMCB9
IiBxdWlyayBsaXN0IHRlcm1pbmF0aW9uCiAgICAodGhhbmtzLCBBbmRyZWFzIEJvbGwhKQogIC0g
QWRkIGFjayBmcm9tIEFsZXggRGV1Y2hlcgotLS0KCkJqb3JuIEhlbGdhYXMgKDIpOgogICAgICBk
cm0vYW1kZ3B1OiByZW1vdmUgdW5uZWNlc3Nhcnkgc2F2ZS9yZXN0b3JlIG9mIHBkZXYtPmQzX2Rl
bGF5CiAgICAgIGRybS9yYWRlb246IG1ha2UgTWFjQm9vayBQcm8gZDNfZGVsYXkgcXVpcmsgbW9y
ZSBnZW5lcmljCgoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8
ICAgIDQgLS0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmMgICAgIHwg
ICAxMSAtLS0tLS0tLS0tLQogZHJpdmVycy9wY2kvcXVpcmtzLmMgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxMyArKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9k
cmktZGV2ZWwK
