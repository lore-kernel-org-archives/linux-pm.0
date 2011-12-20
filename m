From: =?ISO-8859-1?Q?Jan-Simon_M=F6ller?= <dl9pf@gmx.de>
Subject: [RFC]: [PATCH] Export cpuidle_(un)register_governor
Date: Tue, 20 Dec 2011 17:15:04 +0100
Message-ID: <1c6776e3-0f69-43f9-a19f-298e714232d3@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----0L1IO01HFJX51SCATWDXPP62GXXRDU"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

------0L1IO01HFJX51SCATWDXPP62GXXRDU
Content-Type: multipart/alternative; boundary="----BQL9GJOTX3YRFU0AS2SL1IQUFL55QV"

------BQL9GJOTX3YRFU0AS2SL1IQUFL55QV
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all! 

This patch exports cpuidle_register_governor and cpuidle_unregist=
er_governor 
with EXPORT_SYMBOL_GPL (as the other cpuidle_(un)register_* ).=
 

Reasoning: allow runtime loading of a cpuidle governor (mainly for 
deve=
lopment for now). 

Usually we don't need this as we're using built-ins for=
 the governors - but 
during developments it is really handy to load and un=
load a cpuidle governor 
(together with the cpuidle_sysfs_switch). 

Commen=
ts ? 

Best, 
Jan-Simon
-- 
Sent from my Android phone with K-9 Mail. Pleas=
e excuse my brevity.
------BQL9GJOTX3YRFU0AS2SL1IQUFL55QV
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all!
<br>

<br>
This patch exports cpuidle_register_governor and cpuidle=
_unregister_governor <br>
with EXPORT_SYMBOL_GPL (as the other cpuidle_(un)=
register_* ).
<br>

<br>
Reasoning: allow runtime loading of a cpuidle gove=
rnor (mainly for
<br>
development for now).
<br>

<br>
Usually we don&#39;t=
 need this as we&#39;re using built-ins for the governors - but <br>
during=
 developments it is really handy to load and unload a cpuidle governor <br>=

(together with the cpuidle_sysfs_switch).
<br>

<br>
Comments ?
<br>

<br>=

Best,
<br>
Jan-Simon<br>
-- <br>
Sent from my Android phone with K-9 Mail.=
 Please excuse my brevity.
------BQL9GJOTX3YRFU0AS2SL1IQUFL55QV--

------0L1IO01HFJX51SCATWDXPP62GXXRDU
Content-Type: text/x-patch;
 name="0001-Export-cpuidle_register_governor-and-cpuidle_unregis.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Export-cpuidle_register_governor-and-cpuidle_unregis.patch";
 size=1165

RnJvbSBhMjFhMDU0ZmE2NGY4OTg1NzZlZTYyZmNlZDMwNTA4ZTBhZmZlMjQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogPT9VVEYtOD9xP0phbi1TaW1vbj0yME09QzM9QjZsbGVyPz0g
PGphbnNpbW9uLm1vZWxsZXJAZ214LmRlPg0KRGF0ZTogTW9uLCAxMiBEZWMgMjAxMSAxNDo0MDo1
NiArMDEwMA0KU3ViamVjdDogW1BBVENIXSBFeHBvcnQgY3B1aWRsZV9yZWdpc3Rlcl9nb3Zlcm5v
ciBhbmQNCiBjcHVpZGxlX3VucmVnaXN0ZXJfZ292ZXJub3Igd2l0aCBFWFBPUlRfU1lNQk9MX0dQ
TCAoYXMgdGhlDQogb3RoZXIgY3B1aWRsZV8odW4pcmVnaXN0ZXJfKiApLg0KDQpSZWFzb25pbmc6
IGFsbG93IHJ1bnRpbWUgbG9hZGluZyBvZiBhIGNwdWlkbGUgZ292ZXJub3IgKG1haW5seSBmb3IN
CmRldmVsb3BtZW50IGZvciBub3cpLg0KLS0tDQogZHJpdmVycy9jcHVpZGxlL2dvdmVybm9yLmMg
fCAgICAzICsrKw0KIDEgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVpZGxlL2dvdmVybm9yLmMgYi9kcml2ZXJz
L2NwdWlkbGUvZ292ZXJub3IuYw0KaW5kZXggZWEyZjhlNy4uNTUyZjVhNCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvY3B1aWRsZS9nb3Zlcm5vci5jDQorKysgYi9kcml2ZXJzL2NwdWlkbGUvZ292ZXJu
b3IuYw0KQEAgLTk3LDYgKzk3LDggQEAgaW50IGNwdWlkbGVfcmVnaXN0ZXJfZ292ZXJub3Ioc3Ry
dWN0IGNwdWlkbGVfZ292ZXJub3IgKmdvdikNCiAJcmV0dXJuIHJldDsNCiB9DQogDQorRVhQT1JU
X1NZTUJPTF9HUEwoY3B1aWRsZV9yZWdpc3Rlcl9nb3Zlcm5vcik7DQorDQogLyoqDQogICogY3B1
aWRsZV9yZXBsYWNlX2dvdmVybm9yIC0gZmluZCBhIHJlcGxhY2VtZW50IGdvdmVybm9yDQogICog
QGV4Y2x1ZGVfcmF0aW5nOiB0aGUgcmF0aW5nIHRoYXQgd2lsbCBiZSBza2lwcGVkIHdoaWxlIGxv
b2tpbmcgZm9yDQpAQCAtMTM5LDMgKzE0MSw0IEBAIHZvaWQgY3B1aWRsZV91bnJlZ2lzdGVyX2dv
dmVybm9yKHN0cnVjdCBjcHVpZGxlX2dvdmVybm9yICpnb3YpDQogCW11dGV4X3VubG9jaygmY3B1
aWRsZV9sb2NrKTsNCiB9DQogDQorRVhQT1JUX1NZTUJPTF9HUEwoY3B1aWRsZV91bnJlZ2lzdGVy
X2dvdmVybm9yKTsNCi0tIA0KMS43LjcNCg==

------0L1IO01HFJX51SCATWDXPP62GXXRDU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------0L1IO01HFJX51SCATWDXPP62GXXRDU--
