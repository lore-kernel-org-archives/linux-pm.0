From: Thomas Martitz <kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers
 on resume
Date: Tue, 2 Oct 2018 23:26:35 +0200
Message-ID: <0b3bc158-b836-7b44-ef09-7c124f479c58@rockbox.org>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
 <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
 <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181002200350.GC120535-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: andy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, "Wysocki,
 Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rchang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

QW0gMDIuMTAuMTggdW0gMjI6MDMgc2NocmllYiBCam9ybiBIZWxnYWFzOgo+IEhpIFRob21hcywK
PiAKPiBPbiBNb24sIE9jdCAwMSwgMjAxOCBhdCAwNDoyNTowNlBNICswMjAwLCBUaG9tYXMgTWFy
dGl0eiB3cm90ZToKPj4gQW0gMDEuMTAuMTggdW0gMDY6NTcgc2NocmllYiBEYW5pZWwgRHJha2U6
Cj4+PiBPbiBTdW4sIFNlcCAzMCwgMjAxOCBhdCA1OjA3IEFNIFRob21hcyBNYXJ0aXR6IDxrdWdl
bEByb2NrYm94Lm9yZz4gd3JvdGU6Cj4+Pj4gVGhlIGxhdGVzdCBpdGVyYXRpb24gZG9lcyBub3Qg
d29yayBvbiBteSBIUCBzeXN0ZW0uIFRoZSBHUFUgZmFpbHMgdG8KPj4+PiBwb3dlciB1cCBqdXN0
IGxpa2UgdGhlIHVucGF0Y2hlZCBrZXJuZWwuCj4+Pgo+Pj4gVGhhdCdzIHdlaXJkLCBJIHdvdWxk
IG5vdCBleHBlY3QgYSBiZWhhdmlvdXIgY2hhbmdlIGluIHRoZSBsYXRlc3QKPj4+IHBhdGNoLiBw
Y2lfcmVzdG9yZV9jb25maWdfZHdvcmQoKSBoYXMgc29tZSBkZWJ1ZyBtZXNzYWdlcywgY291bGQg
eW91Cj4+PiBwbGVhc2UgbWFrZSB0aGVtIHZpc2libGUgYW5kIHNob3cgbG9ncyBhZ2Fpbj8KPj4+
IEFsc28gcmVtaW5kIHVzIG9mIHRoZSBQQ0kgZGV2aWNlIGFkZHJlc3Mgb2YgdGhlIHBhcmVudCBi
cmlkZ2UgKGxzcGNpIC12dCkKPj4KPj4gSSdsbCBmb2xsb3cgdXAgd2l0aCBtb3JlIHRoZSByZXF1
ZXN0ZWQgaW5mb3JtYXRpb24gb24gYnVnemlsbGEKPj4gKExpbms6IGh0dHBzOi8vYnVnemlsbGEu
a2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAxMDY5KS4KPj4KPj4gT24gYSBxdWljayByZS1j
aGVjaywgaXQgc2VlbXMgdG8gZGVwZW5kIG9uIGlmIEkgdXNlZCB0aGUgZUdQVSBiZWZvcmUKPj4g
dGhlIGluaXRpYWwgc3VzcGVuZC4gSWYgSSBydW4gZ2x4Z2VhcnMgKHdpdGggRFJJX1BSSU1FPTEp
IGJlZm9yZSBzdXNwZW5kIGl0Cj4+IHNlZW1zIGZpbmUuCj4gCj4gRG9lcyB0aGUgcGF0Y2ggKFsx
XSkgbWFrZSB0aGluZ3MgKndvcnNlKiBjb21wYXJlZCB0byB2NC4xOS1yYzU/Cj4gCgpObywgY2Vy
dGFpbmx5IG5vdC4gSXQgZG9lcyBsb29rIGxpa2UgYSBkaWZmZXJlbnQgaXNzdWUgc2luY2UgcmVz
dW1pbmcgbm93CndvcmtzIGF0IGxlYXN0IGlmIEkgdXNlZCB0aGUgZUdQVSBpbiBzb21lIHdheSBi
ZWZvcmUgc3VzcGVuZCAKKERSSV9QUklNRT0xIGdseGdlYXJzIHNlZW1zIHRvIGJlIGVub3VnaCwg
SSBhc3N1bWUgZ2x4aW5mbyB3b3VsZCB3b3JrIGFzIAp3ZWxsKS4KCldpdGhvdXQgdGhlIHBhdGNo
IHJlc3VtaW5nIHRoZSBlR1BVIGRvZXMgbm90IHdvcmsgd2hhdHNvZXZlci4KClBsZWFzZSBzaGlw
IHRoZSBwYXRjaC4gSSdsbCBob3BlZnVsbHkgc29ydCB0aGlzIG90aGVyIGlzc3VlIG91dC4KCkJl
c3QgcmVnYXJkcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCk5vdXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVhdQo=
