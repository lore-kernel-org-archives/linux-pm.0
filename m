From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 15559] Bad performance after suspend on Intel
	i7 and i5
Date: Thu, 18 Mar 2010 20:56:40 +0100
Message-ID: <201003182056.40655.rjw__21710.4967836805$1268942168$gmane$org@sisk.pl>
References: <bug-15559-10028@http.bugzilla.kernel.org/>
	<201003181842.o2IIgUSL031098@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003181842.o2IIgUSL031098@demeter.kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

SGksCgpIZXJlJ3MgYW4gaW50ZXJlc3RpbmcgaXNzdWUsIGFwcGFyZW50bHkgQ29yZSBpNSBhbmQg
aTcgaGF2ZSBwcm9ibGVtcyBhZnRlcgpyZXN1bWUgZnJvbSBzdXNwZW5kL3N0YW5kYnkuCgpJIHdv
bmRlciB3aG9tIGF0IEludGVsIEkgc2hvdWxkIGxldCBrbm93IGFib3V0IHRoYXQuCgpSYWZhZWwK
CgpPbiBUaHVyc2RheSAxOCBNYXJjaCAyMDEwLCBidWd6aWxsYS1kYWVtb25AYnVnemlsbGEua2Vy
bmVsLm9yZyB3cm90ZToKPiBodHRwOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MTU1NTkKPiAKPiAKPiAKPiAKPiAKPiAtLS0gQ29tbWVudCAjMyBmcm9tIFRob21hcyBCw6Rj
aGxlciA8dGhvbWFzQGFyY2hsaW51eC5vcmc+ICAyMDEwLTAzLTE4IDE4OjQyOjI2IC0tLQo+IEkg
aGF2ZSBvbmx5IHRlc3RlZCAyLjYuMzMgYW5kIDIuNi4zMy4xLCBhcyB0aGlzIG1hY2hpbmUgaXMg
cXVpdGUgbmV3LiBCZXNpZGVzCj4gb3RoZXIgdW5yZWxhdGVkIHN1c3BlbmQgcHJvYmxlbXMsIEkg
Y2FuIGFsd2F5cyByZXByb2R1Y2UgdGhpcyBvbmUgb24gYSBDb3JlCj4gaTUtNTIwTSwgdGhlIHN5
bXB0b21zIGFyZSBleGFjdGx5IHRoZSBvbmVzIHRoYXQgRmxvcmlhbiBkZXNjcmliZXMuCj4gCj4g
VGhlIGRpdmVyc2l0eSBvZiBoYXJkd2FyZSBhbmQgZGlmZmVyZW50IGtlcm5lbHMgaGVyZSBzdWdn
ZXN0cyB0aGF0IHRoaXMgaXMgYQo+IGdlbmVyYWwgcHJvYmxlbSB3aXRoIHRoZSBpNSBhbmQgaTcg
Q1BVcyBvbiBMaW51eC4gQWxzbyBpbnRlcmVzdGluZyBpcyB0aGF0Cj4gRmxvcmlhbiBpcyB1c2lu
ZyBhbiBpNyBvZiB0aGUgMjAwOSBnZW5lcmF0aW9uLCB3aGlsZSBJIHVzZSB0aGUgMjAxMCBpNSBD
UFUgYW5kCj4gdGhlIGJ1ZyBpcyB0aGUgc2FtZSBvbiBib3RoLgo+IAo+IE9uIHRoZSBzYW1lIGtl
cm5lbChzKSwgbXkgb2xkIENvcmUgMiBEdW8gQ1BVIGhhcyBubyB0cm91YmxlIGFmdGVyIHJlc3Vt
ZSwgYWxsCj4gY29yZXMgYXJlIHN0aWxsIGJlaW5nIHVzZWQgYXMgdXN1YWwuCj4gCj4gSWYgeW91
IG5lZWQgYW55IG1vcmUgaW5mbywgSSB0aGluayB3ZSB3aWxsIGJlIGFibGUgdG8gcHJvdmlkZSBh
bnl0aGluZyB5b3UKPiBuZWVkLiBNYXliZSBpdCBtaWdodCBhbHNvIGJlIHVzZWZ1bCB0byBicmlu
ZyBzb21lb25lIGZyb20gSW50ZWwgaW4gb24gdGhpcy4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
