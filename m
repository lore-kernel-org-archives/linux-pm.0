From: "Frank Hofmann" <Frank.Hofmann@tomtom.com>
Subject: Re: [RFC PATCH] ARM hibernation / suspend-to-disk
	support code
Date: Sun, 22 May 2011 09:01:14 +0200
Message-ID: <2C577202CB5719438D4E9608C565CB2C01B69D7B__46830.082688439$1306047738$gmane$org@NL-EXC-07.intra.local>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<201105210027.17159.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CC184E.0A79A553"
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org
Cc: Dave Martin <dave.martin@linaro.org>, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC184E.0A79A553
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CC184E.0A79A553"


------_=_NextPart_002_01CC184E.0A79A553
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> [ ... ]
> > > r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ handler,
> > > if FIQ is in use.  Can we expect any driver using FIQ to =
save/restore
> > > this state itself, rather than doing it globally?  This may be
> > > reasonable.
> >=20
> > We don't need to save/restore those, because at the time the =
snapshot is=20
> > taken interrupts are off and we cannot be in any trap handler =
either. On=20
> > resume, the kernel that has been loaded has initialized them =
properly=20
> > already.
>=20
> I'm not sure if this is a safe assumption in general.  We may decide =
to
> switch to loading hibernate images from boot loaders, for example, and
> it may not hold any more.  Generally, please don't assume _anything_ =
has
> been properly initialized during resume, before the image is loaded.
> This has already beaten us a couple of times.
>=20
> Thanks,
> Rafael

Hi Rafael,

regarding "cannot rely on any state", if that is so then it seems quite =
unnecessary to save/restore _any_ ARM non-#SYSTEM_MODE state - it'd =
better be reinitialized by calling cpu_init() after the "core restore" =
callback. The archives were quite a bit helpful in this context:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12671.html

that's the same situation isn't it ?

Regarding FIQ: I agree with Russell and others who previously stated =
that a driver using FIQ is responsible for implementing suspend/resume =
hooks itself. But what could be done is to disable/enable it for the =
snapshot, just in case.

I've also found out that the vmlinux.lds changes don't seem to be =
necessary - they've been the last remnant of the "old" ARM hibernation =
patch, but just leaving those out looks to make no difference (the =
nosave data still ends up in the same place, with the same elf section =
attributes).

With all this in mind, the core part of the patch becomes somewhat =
simpler. See attached.


I'll test this on Monday.
FrankH.

------_=_NextPart_002_01CC184E.0A79A553
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7654.12">
<TITLE>RE: [linux-pm] [RFC PATCH] ARM hibernation / suspend-to-disk =
support code</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>&gt; [ ... ]<BR>
&gt; &gt; &gt; r8_FIQ..r12_FIQ can store arbitrary state used by the FIQ =
handler,<BR>
&gt; &gt; &gt; if FIQ is in use.&nbsp; Can we expect any driver using =
FIQ to save/restore<BR>
&gt; &gt; &gt; this state itself, rather than doing it globally?&nbsp; =
This may be<BR>
&gt; &gt; &gt; reasonable.<BR>
&gt; &gt;<BR>
&gt; &gt; We don't need to save/restore those, because at the time the =
snapshot is<BR>
&gt; &gt; taken interrupts are off and we cannot be in any trap handler =
either. On<BR>
&gt; &gt; resume, the kernel that has been loaded has initialized them =
properly<BR>
&gt; &gt; already.<BR>
&gt;<BR>
&gt; I'm not sure if this is a safe assumption in general.&nbsp; We may =
decide to<BR>
&gt; switch to loading hibernate images from boot loaders, for example, =
and<BR>
&gt; it may not hold any more.&nbsp; Generally, please don't assume =
_anything_ has<BR>
&gt; been properly initialized during resume, before the image is =
loaded.<BR>
&gt; This has already beaten us a couple of times.<BR>
&gt;<BR>
&gt; Thanks,<BR>
&gt; Rafael<BR>
<BR>
Hi Rafael,<BR>
<BR>
regarding &quot;cannot rely on any state&quot;, if that is so then it =
seems quite unnecessary to save/restore _any_ ARM non-#SYSTEM_MODE state =
- it'd better be reinitialized by calling cpu_init() after the =
&quot;core restore&quot; callback. The archives were quite a bit helpful =
in this context:<BR>
<BR>
<A =
HREF=3D"http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12671.h=
tml">http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12671.html=
</A><BR>
<BR>
that's the same situation isn't it ?<BR>
<BR>
Regarding FIQ: I agree with Russell and others who previously stated =
that a driver using FIQ is responsible for implementing suspend/resume =
hooks itself. But what could be done is to disable/enable it for the =
snapshot, just in case.<BR>
<BR>
I've also found out that the vmlinux.lds changes don't seem to be =
necessary - they've been the last remnant of the &quot;old&quot; ARM =
hibernation patch, but just leaving those out looks to make no =
difference (the nosave data still ends up in the same place, with the =
same elf section attributes).<BR>
<BR>
With all this in mind, the core part of the patch becomes somewhat =
simpler. See attached.<BR>
<BR>
<BR>
I'll test this on Monday.<BR>
FrankH.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_002_01CC184E.0A79A553--

------_=_NextPart_001_01CC184E.0A79A553
Content-Type: text/x-patch;
	name="hibernation-core-22May2011.patch"
Content-Transfer-Encoding: base64
Content-Description: hibernation-core-22May2011.patch
Content-Disposition: attachment;
	filename="hibernation-core-22May2011.patch"

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL0tjb25maWcgYi9hcmNoL2FybS9LY29uZmlnCmluZGV4IDQ0
YzE2ZjAuLmYyODJiYWMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL0tjb25maWcKKysrIGIvYXJjaC9h
cm0vS2NvbmZpZwpAQCAtMjA3LDYgKzIwNyw5IEBAIGNvbmZpZyBBUk1fUEFUQ0hfUEhZU19WSVJU
XzE2QklUCiAJZGVmX2Jvb2wgeQogCWRlcGVuZHMgb24gQVJNX1BBVENIX1BIWVNfVklSVCAmJiBB
UkNIX01TTQogCitjb25maWcgQVJDSF9ISUJFUk5BVElPTl9QT1NTSUJMRQorCWRlZl9ib29sIG4K
Kwogc291cmNlICJpbml0L0tjb25maWciCiAKIHNvdXJjZSAia2VybmVsL0tjb25maWcuZnJlZXpl
ciIKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2luY2x1ZGUvYXNtL21lbW9yeS5oIGIvYXJjaC9hcm0v
aW5jbHVkZS9hc20vbWVtb3J5LmgKaW5kZXggNDMxMDc3Yy4uYzdlZjQ1NCAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vaW5jbHVkZS9hc20vbWVtb3J5LmgKKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20v
bWVtb3J5LmgKQEAgLTI1MCw2ICsyNTAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgKnBoeXNfdG9f
dmlydChwaHlzX2FkZHJfdCB4KQogICovCiAjZGVmaW5lIF9fcGEoeCkJCQlfX3ZpcnRfdG9fcGh5
cygodW5zaWduZWQgbG9uZykoeCkpCiAjZGVmaW5lIF9fdmEoeCkJCQkoKHZvaWQgKilfX3BoeXNf
dG9fdmlydCgodW5zaWduZWQgbG9uZykoeCkpKQorI2RlZmluZSBfX3BhX3N5bWJvbCh4KQkJX19w
YShSRUxPQ19ISURFKCh1bnNpZ25lZCBsb25nKSh4KSwwKSkKICNkZWZpbmUgcGZuX3RvX2thZGRy
KHBmbikJX192YSgocGZuKSA8PCBQQUdFX1NISUZUKQogCiAvKgpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0va2VybmVsL01ha2VmaWxlIGIvYXJjaC9hcm0va2VybmVsL01ha2VmaWxlCmluZGV4IDhkOTU0
NDYuLmExZjU0Y2QgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2tlcm5lbC9NYWtlZmlsZQorKysgYi9h
cmNoL2FybS9rZXJuZWwvTWFrZWZpbGUKQEAgLTQ0LDYgKzQ0LDcgQEAgb2JqLSQoQ09ORklHX0FS
TV9USFVNQkVFKQkrPSB0aHVtYmVlLm8KIG9iai0kKENPTkZJR19LR0RCKQkJKz0ga2dkYi5vCiBv
YmotJChDT05GSUdfQVJNX1VOV0lORCkJKz0gdW53aW5kLm8KIG9iai0kKENPTkZJR19IQVZFX1RD
TSkJCSs9IHRjbS5vCitvYmotJChDT05GSUdfSElCRVJOQVRJT04pCSs9IGNwdS5vIHN3c3VzcC5v
CiBvYmotJChDT05GSUdfQ1JBU0hfRFVNUCkJKz0gY3Jhc2hfZHVtcC5vCiBvYmotJChDT05GSUdf
U1dQX0VNVUxBVEUpCSs9IHN3cF9lbXVsYXRlLm8KIENGTEFHU19zd3BfZW11bGF0ZS5vCQk6PSAt
V2EsLW1hcmNoPWFybXY3LWEKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2tlcm5lbC9jcHUuYyBiL2Fy
Y2gvYXJtL2tlcm5lbC9jcHUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4w
ZjFjMzFmCi0tLSAvZGV2L251bGwKKysrIGIvYXJjaC9hcm0va2VybmVsL2NwdS5jCkBAIC0wLDAg
KzEsNjQgQEAKKy8qCisgKiBIaWJlcm5hdGlvbiBzdXBwb3J0IHNwZWNpZmljIGZvciBBUk0KKyAq
CisgKiBEZXJpdmVkIGZyb20gd29yayBvbiBBUk0gaGliZXJuYXRpb24gc3VwcG9ydCBieToKKyAq
CisgKiBVYnVudHUgcHJvamVjdCwgaGliZXJuYXRpb24gc3VwcG9ydCBmb3IgbWFjaC1kb3ZlCisg
KiBDb3B5cmlnaHQgKEMpIDIwMTAgTm9raWEgQ29ycG9yYXRpb24gKEhpcm9zaGkgRG95dSkKKyAq
IENvcHlyaWdodCAoQykgMjAxMCBUZXhhcyBJbnN0cnVtZW50cywgSW5jLiAoVGVlcnRoIFJlZGR5
IGV0IGFsLikKKyAqCWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEwLzYvMTgvNAorICoJaHR0cHM6
Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvbGludXgtcG0vMjAxMC1KdW5l
LzAyNzQyMi5odG1sCisgKglodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzk2NDQy
LworICoKKyAqIENvcHlyaWdodCAoQykgMjAwNiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHNpc2su
cGw+CisgKgorICogTGljZW5zZSB0ZXJtczogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgKEdQ
TCkgdmVyc2lvbiAyCisgKi8KKworI2luY2x1ZGUgPGxpbnV4L21tLmg+CisjaW5jbHVkZSA8bGlu
dXgvc2NoZWQuaD4KKyNpbmNsdWRlIDxsaW51eC9zdXNwZW5kLmg+CisjaW5jbHVkZSA8YXNtL3Rs
YmZsdXNoLmg+CisKK2V4dGVybiBjb25zdCB2b2lkIF9fbm9zYXZlX2JlZ2luLCBfX25vc2F2ZV9l
bmQ7CisKK2ludCBwZm5faXNfbm9zYXZlKHVuc2lnbmVkIGxvbmcgcGZuKQoreworCXVuc2lnbmVk
IGxvbmcgbm9zYXZlX2JlZ2luX3BmbiA9IF9fcGFfc3ltYm9sKCZfX25vc2F2ZV9iZWdpbikgPj4g
UEFHRV9TSElGVDsKKwl1bnNpZ25lZCBsb25nIG5vc2F2ZV9lbmRfcGZuID0gUEFHRV9BTElHTihf
X3BhX3N5bWJvbCgmX19ub3NhdmVfZW5kKSkgPj4gUEFHRV9TSElGVDsKKworCXJldHVybiAocGZu
ID49IG5vc2F2ZV9iZWdpbl9wZm4pICYmIChwZm4gPCBub3NhdmVfZW5kX3Bmbik7Cit9CisKK3Zv
aWQgc2F2ZV9wcm9jZXNzb3Jfc3RhdGUodm9pZCkKK3sKKwlmbHVzaF90aHJlYWQoKTsKKwlsb2Nh
bF9maXFfZGlzYWJsZSgpOworfQorCit2b2lkIHJlc3RvcmVfcHJvY2Vzc29yX3N0YXRlKHZvaWQp
Cit7CisJbG9jYWxfZmx1c2hfdGxiX2FsbCgpOworCWxvY2FsX2ZpcV9lbmFibGUoKTsKK30KKwor
dTggX19zd3N1c3BfYXJjaF9jdHhbUEFHRV9TSVpFXSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKFBB
R0VfU0laRSkpKTsKK3U4IF9fc3dzdXNwX3Jlc3VtZV9zdGtbUEFHRV9TSVpFLzJdIF9fbm9zYXZl
ZGF0YTsKKworLyoKKyAqIFRoZSBmcmFtZXdvcmsgbG9hZHMgdGhlIGhpYmVybmF0aW9uIGltYWdl
IGludG8gdGhpcyBsaW5rZWQgbGlzdCwKKyAqIGZvciBzd3N1c3BfYXJjaF9yZXN1bWUoKSB0byBj
b3B5IGJhY2sgdG8gdGhlIHByb3BlciBkZXN0aW5hdGlvbnMuCisgKgorICogVG8gbWFrZSB0aGlz
IHdvcmsgaWYgcmVzdW1lIGlzIHRyaWdnZXJlZCBmcm9tIGluaXRyYW1mcywgdGhlCisgKiBwYWdl
dGFibGVzIG5lZWQgdG8gYmUgc3dpdGNoZWQgdG8gYWxsb3cgd3JpdGVzIHRvIGtlcm5lbCBtZW0u
CisgKi8KK3ZvaWQgbm90cmFjZSBfX3N3c3VzcF9hcmNoX3Jlc3RvcmVfaW1hZ2Uodm9pZCkKK3sK
KwlleHRlcm4gc3RydWN0IHBiZSAqcmVzdG9yZV9wYmxpc3Q7CisJc3RydWN0IHBiZSAqcGJlOwor
CisJY3B1X3N3aXRjaF9tbShfX3ZpcnRfdG9fcGh5cyhzd2FwcGVyX3BnX2RpciksICZpbml0X21t
KTsKKworCWZvciAocGJlID0gcmVzdG9yZV9wYmxpc3Q7IHBiZTsgcGJlID0gcGJlLT5uZXh0KQor
CQljb3B5X3BhZ2UocGJlLT5vcmlnX2FkZHJlc3MsIHBiZS0+YWRkcmVzcyk7Cit9CmRpZmYgLS1n
aXQgYS9hcmNoL2FybS9rZXJuZWwvc3dzdXNwLlMgYi9hcmNoL2FybS9rZXJuZWwvc3dzdXNwLlMK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZDdlYmJlOQotLS0gL2Rldi9udWxs
CisrKyBiL2FyY2gvYXJtL2tlcm5lbC9zd3N1c3AuUwpAQCAtMCwwICsxLDY4IEBACisvKgorICog
SGliZXJuYXRpb24gc3VwcG9ydCBzcGVjaWZpYyBmb3IgQVJNCisgKgorICogQmFzZWQgb24gd29y
ayBieToKKyAqCisgKiBVYnVudHUgcHJvamVjdCwgaGliZXJuYXRpb24gc3VwcG9ydCBmb3IgbWFj
aC1kb3ZlLAorICogQ29weXJpZ2h0IChDKSAyMDEwIE5va2lhIENvcnBvcmF0aW9uIChIaXJvc2hp
IERveXUpCisgKiBDb3B5cmlnaHQgKEMpIDIwMTAgVGV4YXMgSW5zdHJ1bWVudHMsIEluYy4gKFRl
ZXJ0aCBSZWRkeSBldCBhbC4pCisgKglodHRwczovL2xrbWwub3JnL2xrbWwvMjAxMC82LzE4LzQK
KyAqCWh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvcGlwZXJtYWlsL2xpbnV4LXBt
LzIwMTAtSnVuZS8wMjc0MjIuaHRtbAorICoJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC85NjQ0Mi8KKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMDYgUmFmYWVsIEouIFd5c29ja2kg
PHJqd0BzaXNrLnBsPgorICoKKyAqIExpY2Vuc2UgdGVybXM6IEdOVSBHZW5lcmFsIFB1YmxpYyBM
aWNlbnNlIChHUEwpIHZlcnNpb24gMgorICovCisKKyNpbmNsdWRlIDxsaW51eC9saW5rYWdlLmg+
CisjaW5jbHVkZSA8YXNtL21lbW9yeS5oPgorI2luY2x1ZGUgPGFzbS9wYWdlLmg+CisjaW5jbHVk
ZSA8YXNtL2NhY2hlLmg+CisjaW5jbHVkZSA8YXNtL3B0cmFjZS5oPgorCisvKgorICogU2F2ZSB0
aGUgY3VycmVudCBDUFUgc3RhdGUgYmVmb3JlIHN1c3BlbmQgLyBwb3dlcm9mZi4KKyAqLworRU5U
Ulkoc3dzdXNwX2FyY2hfc3VzcGVuZCkKKwlsZHIJcjAsID1fX3N3c3VzcF9hcmNoX2N0eAorCW1y
cwlyMSwgY3BzcgorCXN0bQlyMCEsIHtyMS1yMTIsbHJ9CS8qIENQU1IsIG5vbnZvbGF0aWxlIHJl
Z3MgKi8KKwlzdG1mZAlzcCEsIHtscn0KKwlibAlfX3NhdmVfcHJvY2Vzc29yX3N0YXRlCisJbGRt
ZmQJc3AhLCB7bHJ9CisJYglzd3N1c3Bfc2F2ZQorRU5EUFJPQyhzd3N1c3BfYXJjaF9zdXNwZW5k
KQorCisvKgorICogUmVzdG9yZSB0aGUgbWVtb3J5IGltYWdlIGZyb20gdGhlIHBhZ2VsaXN0cywg
YW5kIGxvYWQgdGhlIENQVSByZWdpc3RlcnMKKyAqIGZyb20gc2F2ZWQgc3RhdGUuCisgKi8KK0VO
VFJZKHN3c3VzcF9hcmNoX3Jlc3VtZSkKKwkvKgorCSAqIFN3aXRjaCBzdGFjayB0byBhIG5vc2F2
ZWRhdGEgcmVnaW9uIHRvIG1ha2Ugc3VyZSBpbWFnZSByZXN0b3JlCisJICogZG9lc24ndCBjbG9i
YmVyIGl0IHVuZGVybmVhdGggaXRzZWxmLgorCSAqLworCWxkcglzcCwgPShfX3N3c3VzcF9yZXN1
bWVfc3RrICsgUEFHRV9TSVpFIC8gMikKKwlibAlfX3N3c3VzcF9hcmNoX3Jlc3RvcmVfaW1hZ2UK
KworCS8qCisJICogUmVzdG9yZSB0aGUgQ1BVIHJlZ2lzdGVycy4KKwkgKi8KKwlsZHIJcjAsID1f
X3N3c3VzcF9hcmNoX2N0eAorCWxkcglyMSwgW3IwXSwgIzQKKwltc3IJY3BzciwgcjEKKwlsZG0J
cjAhLCB7cjItcjEyLGxyfQorCS8qCisJICogRnJvbSBoZXJlIG9uIHdlIGhhdmUgYSB2YWxpZCBz
dGFjayBhZ2Fpbi4gQ29yZSBzdGF0ZSBpcworCSAqIG5vdCByZXN0b3JlZCB5ZXQsIHJlZGlyZWN0
IHRvIHRoZSBtYWNoaW5lLXNwZWNpZmljCisJICogaW1wbGVtZW50YXRpb24gdG8gZ2V0IHRoYXQg
ZG9uZS4KKwkgKiBSZXN1bWUgaGFzIHN1Y2NlZWRlZCBhdCB0aGlzIHBvaW50OyBpZiB0aGUgbWFj
aGluZS1zcGVjaWZpYworCSAqIGNvZGUgd2FudHMgdG8gZmFpbCBpdCBuZWVkcyB0byBwYW5pYy4K
KwkgKi8KKwltb3YJcjEsICMwCisJcHVzaAl7cjEsbHJ9CisJYmwJX19yZXN0b3JlX3Byb2Nlc3Nv
cl9zdGF0ZQkvKiByZXN0b3JlIGNvcmUgc3RhdGUgKi8KKwlibAljcHVfaW5pdAorCXBvcAl7cjAs
cGN9CitFTkRQUk9DKHN3c3VzcF9hcmNoX3Jlc3VtZSkK

------_=_NextPart_001_01CC184E.0A79A553
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------_=_NextPart_001_01CC184E.0A79A553--
