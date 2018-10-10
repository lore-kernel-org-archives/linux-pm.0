From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu
 device nodes
Date: Wed, 10 Oct 2018 15:16:28 +0530
Message-ID: <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180827151112.25211-6-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMjctMDgtMTgsIDA5OjExLCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IEFkZCB0aGUgbm9kZXMg
dG8gZGVzY3JpYmUgdGhlIEFkcmVubyBHUFUgYW5kIEdNVSBkZXZpY2VzLgo+IAo+IFNpZ25lZC1v
ZmYtYnk6IEpvcmRhbiBDcm91c2UgPGpjcm91c2VAY29kZWF1cm9yYS5vcmc+Cj4gLS0tCj4gIGFy
Y2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSB8IDEyMSArKysrKysrKysrKysrKysr
KysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDEyMSBpbnNlcnRpb25zKCspCj4gCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaSBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaQo+IGluZGV4IGNkYWFiZWIzYzk5NS4uMTBkYjBj
ZWIzNjk5IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRz
aQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zZG04NDUuZHRzaQo+IEBAIC0xOTIs
NiArMTkyLDU5IEBACj4gIAkJbWV0aG9kID0gInNtYyI7Cj4gIAl9Owo+ICAKPiArZ3B1X29wcF90
YWJsZTogYWRyZW5vLW9wcC10YWJsZSB7Cj4gKwkJY29tcGF0aWJsZSA9ICJvcGVyYXRpbmctcG9p
bnRzLXYyLXFjb20tbGV2ZWwiOwo+ICsKPiArCQlvcHAtNzEwMDAwMDAwIHsKPiArCQkJb3BwLWh6
ID0gL2JpdHMvIDY0IDw3MTAwMDAwMDA+Owo+ICsJCQlxY29tLGxldmVsID0gPDQxNj47CgpXaGF0
IGlzIHFjb20sbGV2ZWwgaGVyZSA/IElzIGl0IGRpZmZlcmVudCB0aGFuIHRoZSBSUE0gdm90aW5n
IHRoaW5nID8KCklmIG5vdCB0aGVuIHlvdSBuZWVkIHRvIGZvbGxvdyB3aGF0IFJhamVuZHJhLCBO
aWtsYXMgYXJlIGRvaW5nIGFzCndlbGwuIFRoZXJlIG5lZWRzIHRvIGJlIGEgZ2VucGQgd2hpY2gg
bmVlZHMgdG8gY2FycnkgdGhpcyB2YWx1ZSBhbmQKdGhlIGdwdSdzIHRhYmxlIHdpbGwgaGF2ZSBy
ZXF1aXJlZC1vcHBzIGVudHJ5IHRvIHBvaW50IHRvIGl0LgoKLS0gCnZpcmVzaApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcmVlZHJlbm8gbWFpbGluZyBs
aXN0CkZyZWVkcmVub0BsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9mcmVlZHJlbm8K
