From: "V, Sankara Narayanan" <sankara.narayanan.v@intel.com>
Subject: Power event notification patch
Date: Thu, 5 Jul 2007 17:32:46 +0530
Message-ID: <67670A5CEA5C374B8E7B16D7DC55F95301247403@bgsmsx413.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7BEFC.66C5BD53"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7BEFC.66C5BD53
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C7BEFC.66C5BD53"


------_=_NextPart_002_01C7BEFC.66C5BD53
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Folks,

=20

Here is a simple patch for power event notification to user-space
applications. Basically, what it does is notify the user-space
applications that the system is going to a low power state
(Suspend-to-RAM and Suspend-to-Disk) and resume from that state. This is
useful for the user-space applications to do some significant action
when the system goes to the low power state (like saving an unsaved
file). The user-space objects can form a netlink socket and listen to
these events. It is done through a kobject-netlink socket. For this I
have used the kobject_uevent system call, posting the notification to
user space with standby, hibernate and resume in the action parameter of
the kobject_uevent call (mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME
enums). Appreciate your comments on the patch.

=20

Thanks,

Sankara Narayanan V.

=20


------_=_NextPart_002_01C7BEFC.66C5BD53
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Book Antiqua";
	panose-1:2 4 6 2 5 3 5 3 3 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:blue;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Book Antiqua";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Book Antiqua";
	color:blue;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'>Hi =
Folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'>Here is a simple patch for power =
event
notification to user-space applications. Basically, what it does is =
notify the
user-space applications that the system is going to a low power state
(Suspend-to-RAM and Suspend-to-Disk) and resume from that state. This is =
useful
for the user-space applications to do some significant action when the =
system
goes to the low power state (like saving an unsaved file). The =
user-space
objects can form a netlink socket and listen to these events. It is done =
through
a kobject-netlink socket. For this I have used the kobject_uevent system =
call,
posting the notification to user space with standby, hibernate and =
resume in
the <b><span style=3D'font-weight:bold'>action </span></b>parameter of =
the
kobject_uevent call (mapped to KOBJ_S3, KOBJ_S4 and KOBJ_RESUME enums). =
Appreciate
your comments on the patch.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Book Antiqua"><span =
style=3D'font-size:
11.0pt;font-family:"Book Antiqua"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D3 color=3D"#0099cc" =
face=3D"Book Antiqua"><span
style=3D'font-size:12.0pt;font-family:"Book =
Antiqua";color:#0099CC;font-weight:
bold'>Thanks,</span></font></i></b></em><font color=3D"#0099cc"><span
style=3D'color:#0099CC'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><em><b><i><font size=3D3 color=3D"#0099cc" =
face=3D"Book Antiqua"><span
style=3D'font-size:12.0pt;font-family:"Book =
Antiqua";color:#0099CC;font-weight:
bold'>Sankara Narayanan V.</span></font></i></b></em><font =
color=3D"#0099cc"><span
style=3D'color:#0099CC'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_002_01C7BEFC.66C5BD53--

------_=_NextPart_001_01C7BEFC.66C5BD53
Content-Type: application/octet-stream;
	name="pwr-evnt-notfn.patch"
Content-Transfer-Encoding: base64
Content-Description: pwr-evnt-notfn.patch
Content-Disposition: attachment;
	filename="pwr-evnt-notfn.patch"

ZGlmZiAtYXJ1TiBrZXJuZWwtbWlkLy5naXRpZ25vcmUgbGludXgtcHdyLWV2bnQtbm90Zm4vLmdp
dGlnbm9yZQotLS0ga2VybmVsLW1pZC8uZ2l0aWdub3JlCTE5NzAtMDEtMDEgMDU6MzA6MDAuMDAw
MDAwMDAwICswNTMwCisrKyBsaW51eC1wd3ItZXZudC1ub3Rmbi8uZ2l0aWdub3JlCTIwMDctMDct
MDUgMTU6MTc6MDIuMDAwMDAwMDAwICswNTMwCkBAIC0wLDAgKzEsNDcgQEAKKyMKKyMgTk9URSEg
RG9uJ3QgYWRkIGZpbGVzIHRoYXQgYXJlIGdlbmVyYXRlZCBpbiBzcGVjaWZpYworIyBzdWJkaXJl
Y3RvcmllcyBoZXJlLiBBZGQgdGhlbSBpbiB0aGUgIi5naXRpZ25vcmUiIGZpbGUKKyMgaW4gdGhh
dCBzdWJkaXJlY3RvcnkgaW5zdGVhZC4KKyMKKyMgTm9ybWFsIHJ1bGVzCisjCisuKgorKi5vCisq
LmEKKyoucworKi5rbworKi5zbworKi5tb2QuYworKi5pCisqLmxzdAorKi5zeW10eXBlcworCisj
CisjIFRvcC1sZXZlbCBnZW5lcmljIGZpbGVzCisjCit0YWdzCitUQUdTCit2bWxpbnV4KgorU3lz
dGVtLm1hcAorTW9kdWxlLnN5bXZlcnMKKworIworIyBHZW5lcmF0ZWQgaW5jbHVkZSBmaWxlcwor
IworaW5jbHVkZS9hc20KK2luY2x1ZGUvYXNtLSovYXNtLW9mZnNldHMuaAoraW5jbHVkZS9jb25m
aWcKK2luY2x1ZGUvbGludXgvYXV0b2NvbmYuaAoraW5jbHVkZS9saW51eC9jb21waWxlLmgKK2lu
Y2x1ZGUvbGludXgvdmVyc2lvbi5oCitpbmNsdWRlL2xpbnV4L3V0c3JlbGVhc2UuaAorCisjIHN0
Z2l0IGdlbmVyYXRlZCBkaXJzCitwYXRjaGVzLSoKKworIyBxdWlsdCdzIGZpbGVzCitwYXRjaGVz
CitzZXJpZXMKKworIyBjc2NvcGUgZmlsZXMKK2NzY29wZS4qCmRpZmYgLWFydU4ga2VybmVsLW1p
ZC9pbmNsdWRlL2xpbnV4L2tvYmplY3QuaCBsaW51eC1wd3ItZXZudC1ub3Rmbi9pbmNsdWRlL2xp
bnV4L2tvYmplY3QuaAotLS0ga2VybmVsLW1pZC9pbmNsdWRlL2xpbnV4L2tvYmplY3QuaAkyMDA3
LTA0LTE2IDA1OjIwOjU3LjAwMDAwMDAwMCArMDUzMAorKysgbGludXgtcHdyLWV2bnQtbm90Zm4v
aW5jbHVkZS9saW51eC9rb2JqZWN0LmgJMjAwNy0wNy0wNSAxNToxNzoxMS4wMDAwMDAwMDAgKzA1
MzAKQEAgLTQ4LDYgKzQ4LDkgQEAKIAlLT0JKX09GRkxJTkUJPSAoX19mb3JjZSBrb2JqZWN0X2Fj
dGlvbl90KSAweDA2LAkvKiBkZXZpY2Ugb2ZmbGluZSAqLwogCUtPQkpfT05MSU5FCT0gKF9fZm9y
Y2Uga29iamVjdF9hY3Rpb25fdCkgMHgwNywJLyogZGV2aWNlIG9ubGluZSAqLwogCUtPQkpfTU9W
RQk9IChfX2ZvcmNlIGtvYmplY3RfYWN0aW9uX3QpIDB4MDgsCS8qIGRldmljZSBtb3ZlICovCisJ
S09CSl9TMwkJPSAoX19mb3JjZSBrb2JqZWN0X2FjdGlvbl90KSAweDA5LAkvKiBzeXN0ZW0gc3Vz
cGVuZCB0byBSQU0gKi8KKwlLT0JKX1M0CQk9IChfX2ZvcmNlIGtvYmplY3RfYWN0aW9uX3QpIDB4
MEEsCS8qIHN5c3RlbSBzdXNwZW5kIHRvIGRpc2sgKi8KKwlLT0JKX1JFU1VNRQk9IChfX2ZvcmNl
IGtvYmplY3RfYWN0aW9uX3QpIDB4MEIsCS8qIHN5c3RlbSByZXN1bWUgKi8KIH07CiAKIHN0cnVj
dCBrb2JqZWN0IHsKZGlmZiAtYXJ1TiBrZXJuZWwtbWlkL2tlcm5lbC9wb3dlci9kaXNrLmMgbGlu
dXgtcHdyLWV2bnQtbm90Zm4va2VybmVsL3Bvd2VyL2Rpc2suYwotLS0ga2VybmVsLW1pZC9rZXJu
ZWwvcG93ZXIvZGlzay5jCTIwMDctMDQtMTYgMDU6MjA6NTcuMDAwMDAwMDAwICswNTMwCisrKyBs
aW51eC1wd3ItZXZudC1ub3Rmbi9rZXJuZWwvcG93ZXIvZGlzay5jCTIwMDctMDctMDUgMTU6MTc6
MDQuMDAwMDAwMDAwICswNTMwCkBAIC0xODQsNiArMTg0LDcgQEAKIAlyZXN1bWVfY29uc29sZSgp
OwogIFRoYXc6CiAJdW5wcmVwYXJlX3Byb2Nlc3NlcygpOworCWtvYmplY3RfdWV2ZW50KCZwb3dl
cl9zdWJzeXMua3NldC5rb2JqLCBLT0JKX1JFU1VNRSk7CiAJcmV0dXJuIGVycm9yOwogfQogCmRp
ZmYgLWFydU4ga2VybmVsLW1pZC9rZXJuZWwvcG93ZXIvbWFpbi5jIGxpbnV4LXB3ci1ldm50LW5v
dGZuL2tlcm5lbC9wb3dlci9tYWluLmMKLS0tIGtlcm5lbC1taWQva2VybmVsL3Bvd2VyL21haW4u
YwkyMDA3LTA0LTE2IDA1OjIwOjU3LjAwMDAwMDAwMCArMDUzMAorKysgbGludXgtcHdyLWV2bnQt
bm90Zm4va2VybmVsL3Bvd2VyL21haW4uYwkyMDA3LTA3LTA1IDE1OjE3OjA0LjAwMDAwMDAwMCAr
MDUzMApAQCAtMTQxLDYgKzE0MSw3IEBACiAKIHN0YXRpYyB2b2lkIHN1c3BlbmRfZmluaXNoKHN1
c3BlbmRfc3RhdGVfdCBzdGF0ZSkKIHsKKwlrb2JqZWN0X3VldmVudCgmcG93ZXJfc3Vic3lzLmtz
ZXQua29iaiwgS09CSl9SRVNVTUUpOwogCWVuYWJsZV9ub25ib290X2NwdXMoKTsKIAlwbV9maW5p
c2goc3RhdGUpOwogCWRldmljZV9yZXN1bWUoKTsKQEAgLTE5MSw2ICsxOTIsMTEgQEAKIHsKIAlp
bnQgZXJyb3I7CiAKKwlpZiAoc3RhdGUgPT0gUE1fU1VTUEVORF9NRU0pIC8qIGlmIHN1c3BlbmQg
dG8gUkFNICovCisJCWtvYmplY3RfdWV2ZW50KCZwb3dlcl9zdWJzeXMua3NldC5rb2JqLCBLT0JK
X1MzKTsKKwlpZiAoc3RhdGUgPT0gUE1fU1VTUEVORF9ESVNLKSAvKiBpZiBzdXNwZW5kIHRvIGRp
c2sgKi8KKwkJa29iamVjdF91ZXZlbnQoJnBvd2VyX3N1YnN5cy5rc2V0LmtvYmosIEtPQkpfUzQp
OworCiAJaWYgKCF2YWxpZF9zdGF0ZShzdGF0ZSkpCiAJCXJldHVybiAtRU5PREVWOwogCWlmICgh
bXV0ZXhfdHJ5bG9jaygmcG1fbXV0ZXgpKQpAQCAtMzM1LDggKzM0MSwxMCBAQAogc3RhdGljIGlu
dCBfX2luaXQgcG1faW5pdCh2b2lkKQogewogCWludCBlcnJvciA9IHN1YnN5c3RlbV9yZWdpc3Rl
cigmcG93ZXJfc3Vic3lzKTsKLQlpZiAoIWVycm9yKQorCWlmICghZXJyb3IpIHsKKwkJa3NldF9z
ZXRfa3NldF9zKCZwb3dlcl9zdWJzeXMsIHBvd2VyX3N1YnN5cyk7CiAJCWVycm9yID0gc3lzZnNf
Y3JlYXRlX2dyb3VwKCZwb3dlcl9zdWJzeXMua3NldC5rb2JqLCZhdHRyX2dyb3VwKTsKKwl9CiAJ
cmV0dXJuIGVycm9yOwogfQogCmRpZmYgLWFydU4ga2VybmVsLW1pZC9saWIva29iamVjdF91ZXZl
bnQuYyBsaW51eC1wd3ItZXZudC1ub3Rmbi9saWIva29iamVjdF91ZXZlbnQuYwotLS0ga2VybmVs
LW1pZC9saWIva29iamVjdF91ZXZlbnQuYwkyMDA3LTA0LTE2IDA1OjIwOjU3LjAwMDAwMDAwMCAr
MDUzMAorKysgbGludXgtcHdyLWV2bnQtbm90Zm4vbGliL2tvYmplY3RfdWV2ZW50LmMJMjAwNy0w
Ny0wNSAxNToxNToxNC4wMDAwMDAwMDAgKzA1MzAKQEAgLTUyLDYgKzUyLDEyIEBACiAJCXJldHVy
biAib25saW5lIjsKIAljYXNlIEtPQkpfTU9WRToKIAkJcmV0dXJuICJtb3ZlIjsKKwljYXNlIEtP
QkpfUzM6CisJCXJldHVybiAic3RhbmRieSI7CisJY2FzZSBLT0JKX1M0OgorCQlyZXR1cm4gImhp
YmVybmF0ZSI7CisJY2FzZSBLT0JKX1JFU1VNRToKKwkJcmV0dXJuICJyZXN1bWUiOwogCWRlZmF1
bHQ6CiAJCXJldHVybiBOVUxMOwogCX0K

------_=_NextPart_001_01C7BEFC.66C5BD53
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01C7BEFC.66C5BD53--
