From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] power management: no valid states	w/o	pm_ops
	+ docs
Date: Tue, 13 Feb 2007 18:54:19 +0100
Message-ID: <1171389259.10344.62.camel@johannes.berg>
References: <1171383980.10344.39.camel@johannes.berg>
	<20070213092357.7ea02880.randy.dunlap@oracle.com>
	<1171388184.10344.55.camel@johannes.berg> <45D1F835.9030103@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-0dvoCeyzSozvb+CJ69ww"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45D1F835.9030103@oracle.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--=-0dvoCeyzSozvb+CJ69ww
Content-Type: multipart/mixed; boundary="----------=_1171389419-20113-469"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1171389419-20113-469
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 2007-02-13 at 09:41 -0800, Randy Dunlap wrote:

> >>  * struct pm_ops - callbacks for managing platform-dependent suspend s=
tates
> >=20
> > But then the description "callbacks for ..." disappears completely in
> > the HTML output! Should I duplicate it or something?
>=20
> No, it's right there by the struct name (top line).
> As you have it, it shows up at the bottom, after the struct members,
> doesn't it (i.e., out of order)?

I now have:

/**
 * struct pm_ops - Callbacks for managing platform dependent suspend states.
 *
 *... (rest kept identical)
 */

and it's not there for me (output of
  ./scripts/kernel-doc -html include/linux/pm.h
attached). I also get an empty "Description" section.

But yes, if I put it into the third line then it shows up in the
"Description" section which is all the way down.

I think I'll put this down to a bug in the html output (that maybe you
get to fix? :) ), I just tested text and man output now and they both
look fine as you describe.

> I would probably just indent all of them by one tab.  Don't worry about
> the @verylong one.

ok.

johannes

------------=_1171389419-20113-469
Content-Disposition: attachment; filename="pm.html"
Content-Type: text/html; name=pm.html; charset=utf-8
Content-Transfer-Encoding: base64

PGgyPnN0cnVjdCBwbV9vcHM8L2gyPg0KPGI+c3RydWN0IHBtX29wczwvYj4g
ezxicj4NCiA8aT5pbnQgKCo8L2k+PGI+dmFsaWQ8L2I+KSA8aT4oc3VzcGVu
ZF9zdGF0ZV90IHN0YXRlKTwvaT47PGJyPg0KIDxpPmludCAoKjwvaT48Yj5w
cmVwYXJlPC9iPikgPGk+KHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSk8L2k+Ozxi
cj4NCiA8aT5pbnQgKCo8L2k+PGI+ZW50ZXI8L2I+KSA8aT4oc3VzcGVuZF9z
dGF0ZV90IHN0YXRlKTwvaT47PGJyPg0KIDxpPmludCAoKjwvaT48Yj5maW5p
c2g8L2I+KSA8aT4oc3VzcGVuZF9zdGF0ZV90IHN0YXRlKTwvaT47PGJyPg0K
IDxpPnN1c3BlbmRfZGlza19tZXRob2RfdDwvaT4gPGI+cG1fZGlza19tb2Rl
PC9iPjs8YnI+DQp9Ozxicj4NCjxoMz5NZW1iZXJzPC9oMz4NCjxkbD4NCjxk
dD48Yj52YWxpZDwvYj4NCjxkZD5DYWxsYmFjayB0byBkZXRlcm1pbmUgd2hl
dGhlciB0aGUgZ2l2ZW4gc3RhdGUgY2FuIGJlIGVudGVyZWQuDQpJZiA8aT5D
T05GSUdfU09GVFdBUkVfU1VTUEVORDwvaT4gaXMgc2V0IHRoZW4gPGk+UE1f
U1VTUEVORF9ESVNLPC9pPiBpcw0KYWx3YXlzIHZhbGlkIGFuZCBuZXZlciBw
YXNzZWQgdG8gdGhpcyBjYWxsLg0KSWYgbm90IGFzc2lnbmVkLCBhbGwgc3Vz
cGVuZCBzdGF0ZXMgYXJlIGFkdmVydGlzZWQgYXMgdmFsaWQNCmluIC9zeXMv
cG93ZXIvc3RhdGUgKGJ1dCBjYW4gc3RpbGwgYmUgcmVqZWN0ZWQgYnkgcHJl
cGFyZSBvciBlbnRlci4pDQo8ZHQ+PGI+cHJlcGFyZTwvYj4NCjxkZD5QcmVw
YXJlIHRoZSBwbGF0Zm9ybSBmb3IgdGhlIGdpdmVuIHN1c3BlbmQgc3RhdGUu
IENhbiByZXR1cm4gYQ0KbmVnYXRpdmUgZXJyb3IgY29kZSBpZiBuZWNlc3Nh
cnkuDQo8ZHQ+PGI+ZW50ZXI8L2I+DQo8ZGQ+RW50ZXIgdGhlIGdpdmVuIHN1
c3BlbmQgc3RhdGUsIG11c3QgYmUgYXNzaWduZWQuIENhbiByZXR1cm4gYQ0K
bmVnYXRpdmUgZXJyb3IgY29kZSBpZiBuZWNlc3NhcnkuDQo8ZHQ+PGI+Zmlu
aXNoPC9iPg0KPGRkPkNhbGxlZCB3aGVuIHRoZSBzeXN0ZW0gaGFzIGxlZnQg
dGhlIGdpdmVuIHN0YXRlIGFuZCBhbGwgZGV2aWNlcw0KYXJlIHJlc3VtZWQu
IFRoZSByZXR1cm4gdmFsdWUgaXMgaWdub3JlZC4NCjxkdD48Yj5wbV9kaXNr
X21vZGU8L2I+DQo8ZGQ+U2V0IHRvIHRoZSBkaXNrIG1ldGhvZCB0aGF0IHRo
ZSB1c2VyIHNob3VsZCBiZSBhYmxlIHRvDQpjb25maWd1cmUgZm9yIHN1c3Bl
bmQtdG8tZGlzay4gU2luY2UgPGk+UE1fRElTS19TSFVURE9XTjwvaT4sDQo8
aT5QTV9ESVNLX1JFQk9PVDwvaT4sIDxpPlBNX0RJU0tfVEVTVDwvaT4gYW5k
IDxpPlBNX0RJU0tfVEVTVFBST0M8L2k+DQphcmUgYWx3YXlzIGFsbG93ZWQs
IGN1cnJlbnRseSBvbmx5IDxpPlBNX0RJU0tfUExBVEZPUk08L2k+DQptYWtl
cyBzZW5zZS4gSWYgdGhlIHVzZXIgdGhlbiBjaG9zZXMgPGk+UE1fRElTS19Q
TEFURk9STTwvaT4sDQp0aGUgPHR0PjxiPnByZXBhcmU8L2I+PC90dD4gY2Fs
bCB3aWxsIGJlIGNhbGxlZCBiZWZvcmUgc3VzcGVuZGluZyB0byBkaXNrDQoo
aWYgcHJlc2VudCksIHRoZSA8dHQ+PGI+ZW50ZXI8L2I+PC90dD4gY2FsbCBz
aG91bGQgYmUgcHJlc2VudCBhbmQgd2lsbA0KYmUgY2FsbGVkIGFmdGVyIGFs
bCBzdGF0ZSBoYXMgYmVlbiBzYXZlZCBhbmQgdGhlIG1hY2hpbmUNCmlzIHJl
YWR5IHRvIGJlIHNodXQgZG93bi9zdXNwZW5kZWQvLi4uLCBhbmQgdGhlIDx0
dD48Yj5maW5pc2g8L2I+PC90dD4NCmNhbGxiYWNrIGlzIGNhbGxlZCBhZnRl
ciBzdGF0ZSBoYXMgYmVlbiByZXN0b3JlZC4gQWxsDQp0aGVzZSBjYWxscyBh
cmUgY2FsbGVkIHdpdGggPGk+UE1fU1VTUEVORF9ESVNLPC9pPiBhcyB0aGUg
c3RhdGUuDQo8L2RsPg0KPGgzPkRlc2NyaXB0aW9uPC9oMz4NCjxibG9ja3F1
b3RlPg0KPC9ibG9ja3F1b3RlPg0KPGhyPg0KPGgyPkZ1bmN0aW9uPC9oMj4N
CjxpPnZvaWQ8L2k+DQo8Yj5wbV9zZXRfb3BzPC9iPg0KKDxpPnN0cnVjdCBw
bV9vcHMgKjwvaT4gPGI+cG1fb3BzPC9iPikNCjxoMz5Bcmd1bWVudHM8L2gz
Pg0KPGRsPg0KPGR0PjxiPnBtX29wczwvYj4NCjxkZD5UaGUgbmV3IHBvd2Vy
IG1hbmFnZW1lbnQgb3BlcmF0aW9ucyB0byBzZXQuDQo8L2RsPg0KPGhyPg0K

------------=_1171389419-20113-469--

--=-0dvoCeyzSozvb+CJ69ww
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF0ftL/ETPhpq3jKURAhKNAJ4g23FcoTLb+VRV1Y6PTnjj9Wh8eACfbtRP
Ca726HNu5NkFUsYKDBnjBfU=
=YF1Y
-----END PGP SIGNATURE-----

--=-0dvoCeyzSozvb+CJ69ww
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--=-0dvoCeyzSozvb+CJ69ww--
