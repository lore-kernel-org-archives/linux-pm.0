From: Kevin Hilman <khilman@ti.com>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Thu, 27 Jan 2011 10:54:19 -0800
Message-ID: <87bp32npno.fsf__33799.0441512831$1296154600$gmane$org@ti.com>
References: <Pine.LNX.4.44L0.1012212032590.11252-100000@netrider.rowland.org>
	<201012221329.40251.rjw@sisk.pl> <87k4hrtfcb.fsf@ti.com>
	<AANLkTikH0aHQNzShAYQfPLPg4C_0HS_pWEqbJJ4aHZgm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikH0aHQNzShAYQfPLPg4C_0HS_pWEqbJJ4aHZgm@mail.gmail.com>
	(Vitaly Wool's message of "Thu, 27 Jan 2011 19:20:10 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Ido Yariv <ido@wizery.com>
List-Id: linux-pm@vger.kernel.org

Vml0YWx5IFdvb2wgPHZpdGFseXdvb2xAZ21haWwuY29tPiB3cml0ZXM6Cgo+IEhpIEtldmluLAo+
Cj4+IFRoZXJlZm9yZSwgd2hhdCBpcyBpZGVhbGx5IG5lZWRlZCBpcyB0aGUgYWJpbGl0eSBmb3Ig
QSdzIHN1c3BlbmQgdG8KPj4gc2ltcGx5IGNhbGwgcG1fcnVudGltZV9zdXNwZW5kKCkgc28gdGhl
IHN1YnN5c3RlbSBjYW4gZG8gdGhlIHdvcmsuCj4+IEhvd2V2ZXIsIHNpbmNlIHJ1bnRpbWUgdHJh
bnNpdGlvbnMgYXJlIGxvY2tlZCBvdXQgYnkgdGhpcyB0aW1lLCB0aGF0Cj4+IGRvZXNuJ3Qgd29y
ay4gwqBJT1csIHdoYXQgaXMgbmVlZGVkIGlzIGEgd2F5IGZvciBhIHN5c3RlbSBzdXNwZW5kIHRv
IHNheQo+PiAicGxlYXNlIGZpbmlzaCB0aGUgcnVudGltZSBzdXNwZW5kIHRoYXQgd2FzIGFscmVh
ZHkgcmVxdWVzdGVkLiIKPj4KPj4gV2hhdCBJJ3ZlIGRvbmUgdG8gd29yayBhcm91bmQgdGhpcyBp
biBkcml2ZXIgQSBpcyB0byBtYW51YWxseSBjaGVjawo+PiBwbV9ydW50aW1lX3N1c3BlbmRlZCgp
IGFuZCBkaXJlY3RseSBjYWxsIHRoZSBzdWJzeXN0ZW0ncyBydW50aW1lCj4+IHN1c3BlbmQvcmVz
dW1lIChwYXRjaCBiZWxvd1sxXS4gwqBOT1RFLCBJJ3ZlIHVzZWQgdGhlIF9ub2lycSBtZXRob2Rz
IHRvCj4+IGVuc3VyZSBkZXZpY2UgQSBpcyBhdmFpbGFibGUgd2hlbiBkZXZpY2UgQiBuZWVkcyBp
dC4pCj4KPiBzdXBwb3NlIHRoaXMgZHJpdmVyIHJ1bnMgb24gYSBwbGF0Zm9ybSB0aGF0IGhhcyBy
dW50aW1lIFBNIGRpc2FibGVkLgo+IEhvdyBpcyBpdCBnb2luZyB0byB3b3JrIHRoZW4/Cj4KClRo
ZW4gcG1fcnVudGltZV9zdXNwZW5kZWQoKSB3aWxsIGJlIGZhbHNlLCBhbmQgdGhlIGJ1cyBtZXRo
b2RzIHdpbGwKc3VzcGVuZCB0aGUgZGV2aWNlLgoKS2V2aW4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdApsaW51eC1w
bUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
