From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 3/6] ARM: dts: qcom: Removed unused
 interrupt-names from GPU node
Date: Tue, 18 Dec 2018 14:29:25 -0800
Message-ID: <CAD=FV=Vi2bNCQ-A+h=1w9P15-XwCq7weZJ7LP7HBfs+GMTv=rA@mail.gmail.com>
References: <20181218183241.12830-1-jcrouse@codeaurora.org>
 <20181218183241.12830-4-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181218183241.12830-4-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, freedreno <freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGksCgpPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAxMDozMiBBTSBKb3JkYW4gQ3JvdXNlIDxqY3Jv
dXNlQGNvZGVhdXJvcmEub3JnPiB3cm90ZToKPgo+ICdpbnRlcnJ1cHQtbmFtZXMnIHNob3VsZG4n
dCBiZSB1c2VkIGluIGNhc2VzIHdoZW4gdGhlcmUgaXMgb25seQo+IG9uZSBpbnRlcnJ1cHQgYW5k
IGl0IGlzIG5vdCBvdGhlcndpc2UgdXNlZCBpbiB0aGUgZHJpdmVyLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSm9yZGFuIENyb3VzZSA8amNyb3VzZUBjb2RlYXVyb3JhLm9yZz4KPiAtLS0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvcWNvbS1hcHE4MDY0LmR0c2kgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKCkxvb2tzIGdvb2QgdG8gbWUuICBJdCBzaG91bGQgYmUgbm90ZWQgdGhhdCBB
bmR5IHNob3VsZG4ndCBsYW5kIHRoaXMKdW50aWwgaGUgaGFzIGEgdHJlZSB0aGF0IGNvbnRhaW5z
ICgiZHJtL21zbS9ncHU6IFJlbW92ZSBoYXJkY29kZWQKaW50ZXJydXB0IG5hbWUiKS4gIC4uLm9y
IGhlIHNob3VsZCBBY2sgdGhpcyBhbmQgaXQgc2hvdWxkIGdvIHRocm91Z2gKdGhlIHNhbWUgdHJl
ZSBhcyB0aGF0IHBhdGNoLgoKSSdtIGN1cmlvdXM6IGlzIHRoZXJlIGEgcmVhc29uIHlvdSBkaWRu
J3QgcmVtb3ZlIGl0IGZyb20gdGhlIG90aGVyIHR3byB1c2Vycz8KCmxpbnV4bmV4dC9tYXN0ZXI6
YXJjaC9hcm0vYm9vdC9kdHMvaW14NTEuZHRzaToKaW50ZXJydXB0LW5hbWVzID0gImtnc2xfM2Qw
X2lycSI7CmxpbnV4bmV4dC9tYXN0ZXI6YXJjaC9hcm0vYm9vdC9kdHMvaW14NTMuZHRzaToKaW50
ZXJydXB0LW5hbWVzID0gImtnc2xfM2QwX2lycSI7CgouLi5hbHNvOiBpZiB0aGlzIHJlYWxseSBp
cyBvbmx5IGZvciAiYXBxODA2NCIgYW5kIG5vdCBnbG9iYWxseSBmb3IgYWxsCnFjb20gZGV2aWNl
cyBpdCdkIGJlIG5pY2UgdG8gbWVudGlvbiAiYXBxODA2NCIgc29tZXdoZXJlIGluIHRoZQpzdWJq
ZWN0LgoKLURvdWcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZnJlZWRyZW5v
Cg==
