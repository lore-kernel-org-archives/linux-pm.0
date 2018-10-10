From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 6/9] PM / OPP: dt-bindings: Add
 opp-interconnect-bw
Date: Wed, 10 Oct 2018 19:59:05 +0530
Message-ID: <20181010142905.n44dkuq725jwiqph@vireshk-i7>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-7-jcrouse@codeaurora.org>
 <0998a374-6cb0-9218-d2e3-92f8ee9861ed@linaro.org>
 <20181010095951.hgeiy7yxsqi6behd@vireshk-i7>
 <20181010142723.GA9977@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181010142723.GA9977-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/freedreno>
List-Post: <mailto:freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/freedreno>,
 <mailto:freedreno-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Freedreno" <freedreno-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gMTAtMTAtMTgsIDA4OjI3LCBKb3JkYW4gQ3JvdXNlIHdyb3RlOgo+IEknbSBub3QgY29udmlu
Y2VkIHRoYXQgcmVxdWlyZWQtb3BwcyB3b3VsZCB3b3JrLiBJJ20gd29ycmllZCB0aGF0IHRoZQo+
IGZvcm1hdCBpcyB0b28gdmFndWUgaWYgd2UgbmVlZCB0byB1c2UgaXQgZm9yIG11bHRpcGxlIHBh
dGhzIGFuZCBwb3NzaWJseQo+IG90aGVyIHVzZXMgdG9vLCBjb25zaWRlciB0aGlzOgo+IAo+IHJl
cXVpcmVkLW9wcCA9IDwmbWRwX3BhdGgwX29wcDMsICZtZHBfcGF0aDFfb3BwNSwgJm1kcF9ycG1o
X29wcDE+Owo+IAo+IFRoaXMgaGFzIG9yZGVyaW5nIHByb2JsZW1zIGFuZCBJTU8gcG9sbHV0ZXMg
dGhlIERUIG5hbWVzcGFjZSBmb3Igbm8KPiBncmVhdCB0ZWNobmljYWwgYWR2YW50YWdlLiBJIGFw
cHJlY2lhdGUgdGhlIGhlc2l0YXRpb24gZm9yIG9wZW5pbmcgdXAKPiB0aGUgZmxvb2QgZ2F0ZXMg
Zm9yIG5ldyBPUFAgYmluZGluZ3MgYnV0IHdlIGFyZSBlbnRlcmluZyBhIG5ldyBlcmEKPiBvZiBo
eXBlciBwb3dlciBhd2FyZSBkZXZpY2VzIGFuZCBzb21lIGNvbmNlc3Npb25zIHdpbGwgbmVlZCB0
byBiZSBtYWRlLgoKU3VyZS4KCi0tIAp2aXJlc2gKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KRnJlZWRyZW5vIG1haWxpbmcgbGlzdApGcmVlZHJlbm9AbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vZnJlZWRyZW5vCg==
