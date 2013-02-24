From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
Subject: [PATCH] cpufreq: highbank: do not initialize array with a loop
Date: Sun, 24 Feb 2013 14:01:17 -0300
Message-ID: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl, shawn.guo@linaro.org, mark.langsdorf@calxeda.com
Cc: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

QXMgdW5pbml0aWFsaXplZCBhcnJheSBtZW1iZXJzIHdpbGwgYmUgaW5pdGlhbGl6ZWQgdG8gemVy
bywgd2UgY2FuCmF2b2lkIHVzaW5nIGEgZm9yIGxvb3AgYnkgc2V0dGluZyBhIHZhbHVlIHRvIGl0
LgoKU2lnbmVkLW9mZi1ieTogRW1pbGlvIEzDs3BleiA8ZW1pbGlvQGVsb3Blei5jb20uYXI+Ci0t
LQpOb3RlIHRoYXQgSSBkb24ndCBvd24gYW55IGRldmljZSB1c2luZyB0aGlzIGRyaXZlciwgaXQg
aGFzIG9ubHkgYmVlbiBjb21waWxlCnRlc3RlZCwgYnV0IGl0IHNob3VsZG4ndCBjYXVzZSBhbnkg
aXNzdWVzLgoKIGRyaXZlcnMvY3B1ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMgfCA2ICstLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY3B1ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMgYi9kcml2ZXJzL2NwdWZyZXEv
aGlnaGJhbmstY3B1ZnJlcS5jCmluZGV4IDY2ZTNhNzEuLjMwZDRhZTEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvY3B1ZnJlcS9oaWdoYmFuay1jcHVmcmVxLmMKKysrIGIvZHJpdmVycy9jcHVmcmVxL2hp
Z2hiYW5rLWNwdWZyZXEuYwpAQCAtMjgsMTMgKzI4LDkgQEAKIAogc3RhdGljIGludCBoYl92b2x0
YWdlX2NoYW5nZSh1bnNpZ25lZCBpbnQgZnJlcSkKIHsKLQlpbnQgaTsKLQl1MzIgbXNnW0hCX0NQ
VUZSRVFfSVBDX0xFTl07CisJdTMyIG1zZ1tIQl9DUFVGUkVRX0lQQ19MRU5dID0ge0hCX0NQVUZS
RVFfQ0hBTkdFX05PVEV9OwogCi0JbXNnWzBdID0gSEJfQ1BVRlJFUV9DSEFOR0VfTk9URTsKIAlt
c2dbMV0gPSBmcmVxIC8gMTAwMDAwMDsKLQlmb3IgKGkgPSAyOyBpIDwgSEJfQ1BVRlJFUV9JUENf
TEVOOyBpKyspCi0JCW1zZ1tpXSA9IDA7CiAKIAlyZXR1cm4gcGwzMjBfaXBjX3RyYW5zbWl0KG1z
Zyk7CiB9Ci0tIAoxLjguMi5yYzAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
