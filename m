From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH-next v2 2/2] cpufreq: powernv: del_timer_sync when global and
 local pstate are equal
Date: Tue,  3 May 2016 20:49:36 +0530
Message-ID: <1462288776-26721-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

V2hlbiBnbG9iYWwgYW5kIGxvY2FsIHBzdGF0ZSBhcmUgZXF1YWwgaW4gYSBwb3dlcm52X3Rhcmdl
dF9pbmRleCgpIGNhbGwsCndlIGRvbid0IHF1ZXVlIGEgdGltZXIuIEJ1dCB3ZSBtYXkgaGF2ZSB0
aW1lciBhbHJlYWR5IHF1ZXVlZCBmb3IgZnV0dXJlLgpUaGlzIGNvdWxkIGNhdXNlIHRoZSB0aW1l
ciB0byBmaXJlIG9uZSBhZGRpdGlvbmFsIHRpbWUgZm9yIG5vIHVzZS4KClNpZ25lZC1vZmYtYnk6
IEFrc2hheSBBZGlnYSA8YWtzaGF5LmFkaWdhQGxpbnV4LnZuZXQuaWJtLmNvbT4KLS0tClBhdGNo
IGlzIGJhc2VkIG9uIFJhZmFlbCdzIGxpbnV4LW5leHQKIGRyaXZlcnMvY3B1ZnJlcS9wb3dlcm52
LWNwdWZyZXEuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvcG93ZXJudi1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZy
ZXEvcG93ZXJudi1jcHVmcmVxLmMKaW5kZXggMWYwZTIwYy4uNTRjNDUzNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9jcHVmcmVxL3Bvd2VybnYtY3B1ZnJlcS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9w
b3dlcm52LWNwdWZyZXEuYwpAQCAtNjQ3LDYgKzY0Nyw4IEBAIHN0YXRpYyBpbnQgcG93ZXJudl9j
cHVmcmVxX3RhcmdldF9pbmRleChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSwKIAkgKi8K
IAlpZiAoZ3BzdGF0ZV9pZCAhPSBmcmVxX2RhdGEucHN0YXRlX2lkKQogCQlxdWV1ZV9ncHN0YXRl
X3RpbWVyKGdwc3RhdGVzKTsKKwllbHNlCisJCWRlbF90aW1lcl9zeW5jKCZncHN0YXRlcy0+dGlt
ZXIpOwogCiBncHN0YXRlc19kb25lOgogCWZyZXFfZGF0YS5ncHN0YXRlX2lkID0gZ3BzdGF0ZV9p
ZDsKLS0gCjIuNS41CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
