From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/4][V2] cpuidle : multiple drivers support
Date: Thu, 25 Oct 2012 16:11:32 +0200
Message-ID: <50894894.7050609@linaro.org>
References: <1350641449-22863-1-git-send-email-daniel.lezcano@linaro.org>
	<20121025134933.GA1962@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20121025134933.GA1962-Rysk9IDjsxmJz7etNGeUX8VPkgjIgRvpAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "rjw-KKrjLPT3xs0@public.gmane.org" <rjw-KKrjLPT3xs0@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gMTAvMjUvMjAxMiAwMzo0OSBQTSwgUGV0ZXIgRGUgU2NocmlqdmVyIHdyb3RlOgo+IE9uIEZy
aSwgT2N0IDE5LCAyMDEyIGF0IDEyOjEwOjQ1UE0gKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3Rl
Ogo+PiBUaGUgZGlzY3Vzc2lvbiBhYm91dCBoYXZpbmcgZGlmZmVyZW50IGNwdXMgb24gdGhlIHN5
c3RlbSB3aXRoCj4+IGRpZmZlcmVudCBsYXRlbmNpZXMgYnJpbmcgdXMgdG8gYSBmaXJzdCBhdHRl
bXAgYnkgYWRkaW5nIGEKPj4gcG9pbnRlciBpbiB0aGUgY3B1aWRsZV9kZXZpY2UgdG8gdGhlIHN0
YXRlcyBhcnJheS4KPj4KPj4gQnV0IGFzIFJhZmFlbCBzdWdnZXN0ZWQsIGl0IHdvdWxkIG1ha2Ug
bW9yZSBzZW5zZSB0byBjcmVhdGUgYQo+PiBkcml2ZXIgcGVyIGNwdSBbMV0uCj4+Cj4+IFRoaXMg
cGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBtdWx0aXBsZSBjcHVpZGxlIGRyaXZlcnMuCj4+Cj4+IEl0
IGNyZWF0ZXMgYSBwZXIgY3B1IGNwdWlkbGUgZHJpdmVyIHBvaW50ZXIuCj4+Cj4+IEluIG9yZGVy
IHRvIG5vdCBicmVhayB0aGUgZGlmZmVyZW50IGRyaXZlcnMsIHRoZSBmdW5jdGlvbiBjcHVpZGxl
X3JlZ2lzdGVyX2RyaXZlcgo+PiBhc3NpZ24gZm9yIGVhY2ggY3B1LCB0aGUgZHJpdmVyLgo+Pgo+
PiBUaGUgbXVsdGlwbGUgZHJpdmVyIHN1cHBvcnQgaXMgb3B0aW9uYWwgYW5kIGlmIGl0IGlzIG5v
dCBzZXQsIHRoZSBjcHVpZGUgZHJpdmVyCj4+IGNvcmUgY29kZSByZW1haW5zIHRoZSBzYW1lIChl
eGNlcHQgc29tZSBjb2RlIHJlb3JnYW5pc2F0aW9uKS4KPj4KPj4gSSBkaWQgdGhlIGZvbGxvd2lu
ZyB0ZXN0cyBjb21waWxlZCwgYm9vdGVkLCB0ZXN0ZWQgd2l0aG91dC93aXRoIENPTkZJR19DUFVf
SURMRSwKPj4gd2l0aC93aXRob3V0IENPTkZJR19DUFVfSURMRV9NVUxUSVBMRV9EUklWRVJTLgo+
Pgo+PiBUZXN0ZWQgb24gQ29yZTIgRHVvIFQ5NTAwIHdpdGggYWNwaV9pZGxlIFthbmQgaW50ZWxf
aWRsZV0KPj4gVGVzdGVkIG9uIEFSTSBEdWFsIENvcnRleC1BOSBVODUwMCAoYWthIFNub3diYWxs
KQo+Pgo+PiBWMSB0ZXN0ZWQgb24gVGVncmEzIGFuZCBWZXhwcmVzcyBUQzIKPj4KPiAKPiBWMiB0
ZXN0ZWQgb24gVGVncmEzLgoKQ29vbCB0aGFua3MgIQoKLS0gCiA8aHR0cDovL3d3dy5saW5hcm8u
b3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCgpG
b2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4gRmFj
ZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8CjxodHRw
Oi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGluYXJvLWRldiBtYWlsaW5nIGxpc3QKbGlu
YXJvLWRldkBsaXN0cy5saW5hcm8ub3JnCmh0dHA6Ly9saXN0cy5saW5hcm8ub3JnL21haWxtYW4v
bGlzdGluZm8vbGluYXJvLWRldgo=
