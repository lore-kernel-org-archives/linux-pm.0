From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
Date: Fri, 31 Aug 2018 15:17:35 +0800
Message-ID: <CAD8Lp45An=kA2ymHgWUZUhTkhGfp2fp5ERR2Tw1gXs6hc=de0A@mail.gmail.com>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al>
 <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
 <CAD8Lp44Re2menmZfY3GLExZVMDfQANTvG3hWC1wQwrXpQ6WKCA@mail.gmail.com>
 <20180830094016.GA18925@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180830094016.GA18925@al>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Endless Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCBBdWcgMzAsIDIwMTggYXQgNTo0MCBQTSwgUGV0ZXIgV3UgPHBldGVyQGxla2Vuc3Rl
eW4ubmw+IHdyb3RlOgo+IEFzIHRoZSBCSU9TIGRhdGUgaXMgbm90IHZpc2libGUsIGNhbiB5b3Ug
YWxzbyBjb25maXJtIHRoYXQgdGhpcyBtZXNzYWdlCj4gaXMgdmlzaWJsZSBpbiBkbWVzZz8KPgo+
ICAgIG5vdXZlYXU6IGRldGVjdGVkIFBSIHN1cHBvcnQsIHdpbGwgbm90IHVzZSBEU00KClllcywg
dGhhdCBnZXRzIGxvZ2dlZC4KCj4gRm9yIGxhcHRvcHMsIGl0IGFwcGVhcnMgdGhhdCB5b3UgaGF2
ZSB0byBkbyBhdCBsZWFzdCB0d28gdGhpbmdzOgo+IC0gRW5zdXJlIHRoYXQgdGhlIFN1YnN5c3Rl
bSBWZW5kb3IvUHJvZHVjdCBJRCBhcmUgc2V0Lgo+IC0gRXhwb3NlIGEgX1JPTSBBQ1BJIG1ldGhv
ZCB0aGF0IHByb3ZpZGVzIFZCSU9TLgo+Cj4gUGVyaGFwcyB5b3UgYWxzbyBuZWVkIHRvIHByb3Zp
ZGUgYSAiX0RTTSIgbWV0aG9kIHRoYXQgZW11bGF0ZXMgYXQgbGVhc3QKPiB0aGUgIk9wdGltdXMi
IGludGVyZmFjZSBmb3IgR1VJRCBhNDg2ZDhmOC0wYmRhLTQ3MWItYTcyYi02MDQyYTZiNWJlZTAu
Cj4KPiBZb3UgcHJvYmFibHkgbG9zdCBpbnRlcmVzdCBoZXJlLCBidXQgaWYgeW91IHdhbnQgdG8g
Y29udGludWUgYW55d2F5IHRoaXMKPiBpcyB3aGF0IGFsbG93ZWQgbWUgdG8gaW5zdGFsbCB0aGUg
ZHJpdmVyIG9uIHRoZSBYUFMgOTU2MDoKPiBodHRwczovL2dpdGh1Yi5jb20vTGVrZW5zdGV5bi9h
Y3BpLXN0dWZmL2Jsb2IvbWFzdGVyL2QzdGVzdC9mYWtlZGV2LmFzbAoKSW5kZWVkLiBJJ20gZ29p
bmcgdG8gc3VibWl0IHRoZSB3b3JrYXJvdW5kIGFuZCBJJ2xsIGxvb2sgdG8gY29tZSBiYWNrCnRv
IHRoaXMgcWVtdS92ZmlvIGFuYWx5c2lzIGxhdGVyLgoKVGhhbmtzCkRhbmllbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpOb3V2ZWF1IG1haWxpbmcgbGlz
dApOb3V2ZWF1QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL25vdXZlYXUK
