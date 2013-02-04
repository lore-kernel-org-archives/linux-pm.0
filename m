From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4] davinci: cpuidle - some cleanups
Date: Mon, 04 Feb 2013 13:08:31 +0100
Message-ID: <510FA4BF.7050001@linaro.org>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org>
	<510C0E4E.3010008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <510C0E4E.3010008-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMDIvMDEvMjAxMyAwNzo0OSBQTSwgTGVuIEJyb3duIHdyb3RlOgo+IE9uIDAyLzAxLzIwMTMg
MDg6NDggQU0sIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+PiBUaGlzIHBhdGNoc2V0IGRvZXMgc29t
ZSBjbGVhbnVwLiBJdCBjb3VsZCBoYXZlIGJlZW4gZm9sZGVkIGluIGEgc2luZ2xlCj4+IHBhdGNo
IGJ1dCB0aGUgcmV2aWV3IHdvdWxkIGhhdmUgYmVlbiBsZXNzIGNsZWFuIHRoYW4gc3BsaXR0aW5n
IGl0IGludG8KPj4gc21hbGwgYW5kIHRyaXZpYWwgcGF0Y2hlcy4KPj4KPj4gVGhlIG1haW4gcHVy
cG9zZSBvZiB0aGlzIHBhdGNoIGlzIHRvIHJlbW92ZSB0aGUgdXNhZ2Ugb2YgdGhlIGRyaXZlcl9k
YXRhCj4+IGZpZWxkIGZyb20gdGhlIHN0YXRlX3VzYWdlIHN0cnVjdHVyZS4gTGVuIEJyb3duIGlz
IGRvaW5nIHRoaXMgY2xlYW51cCBpbgo+PiB0aGUgaW50ZWxfaWRsZS5jIGZpbGUuIFdpdGggdGhp
cyBwYXRjaHNldCwgdGhlIHByb2Nlc3Nvcl9pZGxlLmMgZmlsZSB3aWxsCj4+IGJlIHRoZSBsYXN0
IHVzZXIgb2YgdGhpcyBmaWVsZC4KPiAKPiBEYW5pZWwsCj4gVGhhbmtzIGZvciB0aGlzIGNsZWFu
dXAuCj4gSG9wZWZ1bGx5IHdlIGNhbiBoZWFyIGZyb20gc29tZWJvZHkgd2l0aCBkYXZpbmNpIEhX
IHdobyBjYW4gdGVzdCBpdD8KPiAKPiBMb29rcyBsaWtlIGl0IGlzIG5vdyB1cCB0byBtZSB0byBh
ZGRyZXNzIHByb2Nlc3Nvcl9pZGxlLmMgYW5kCj4gZmluaXNoIHRoZSBqb2Igb2YgZXhwdW5naW5n
IGRyaXZlcl9kYXRhLgoKQXJlIHlvdSBvayBpZiBJIHRha2UgY2FyZSBvZiB0aGF0ID8KCiAgLS0g
RGFuaWVsCgoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93
d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIu
Y29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJv
LWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGluYXJvLWRldiBtYWlsaW5nIGxpc3QKbGluYXJvLWRldkBsaXN0cy5saW5hcm8ub3Jn
Cmh0dHA6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4vbGlzdGluZm8vbGluYXJvLWRldgo=
