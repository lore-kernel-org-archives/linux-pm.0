From: Thomas Martitz <kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers
 on resume
Date: Mon, 1 Oct 2018 16:25:06 +0200
Message-ID: <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
 <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: andy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, rchang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

QW0gMDEuMTAuMTggdW0gMDY6NTcgc2NocmllYiBEYW5pZWwgRHJha2U6Cj4gT24gU3VuLCBTZXAg
MzAsIDIwMTggYXQgNTowNyBBTSBUaG9tYXMgTWFydGl0eiA8a3VnZWxAcm9ja2JveC5vcmc+IHdy
b3RlOgo+PiBUaGUgbGF0ZXN0IGl0ZXJhdGlvbiBkb2VzIG5vdCB3b3JrIG9uIG15IEhQIHN5c3Rl
bS4gVGhlIEdQVSBmYWlscyB0bwo+PiBwb3dlciB1cCBqdXN0IGxpa2UgdGhlIHVucGF0Y2hlZCBr
ZXJuZWwuCj4gCj4gVGhhdCdzIHdlaXJkLCBJIHdvdWxkIG5vdCBleHBlY3QgYSBiZWhhdmlvdXIg
Y2hhbmdlIGluIHRoZSBsYXRlc3QKPiBwYXRjaC4gcGNpX3Jlc3RvcmVfY29uZmlnX2R3b3JkKCkg
aGFzIHNvbWUgZGVidWcgbWVzc2FnZXMsIGNvdWxkIHlvdQo+IHBsZWFzZSBtYWtlIHRoZW0gdmlz
aWJsZSBhbmQgc2hvdyBsb2dzIGFnYWluPwo+IEFsc28gcmVtaW5kIHVzIG9mIHRoZSBQQ0kgZGV2
aWNlIGFkZHJlc3Mgb2YgdGhlIHBhcmVudCBicmlkZ2UgKGxzcGNpIC12dCkKPiAKCkknbGwgZm9s
bG93IHVwIHdpdGggbW9yZSB0aGUgcmVxdWVzdGVkIGluZm9ybWF0aW9uIG9uIGJ1Z3ppbGxhCihM
aW5rOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMTA2OSku
CgpPbiBhIHF1aWNrIHJlLWNoZWNrLCBpdCBzZWVtcyB0byBkZXBlbmQgb24gaWYgSSB1c2VkIHRo
ZSBlR1BVIGJlZm9yZQp0aGUgaW5pdGlhbCBzdXNwZW5kLiBJZiBJIHJ1biBnbHhnZWFycyAod2l0
aCBEUklfUFJJTUU9MSkgYmVmb3JlIHN1c3BlbmQgCml0IHNlZW1zIGZpbmUuCgpCZXN0IHJlZ2Fy
ZHMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCk5vdXZl
YXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVhdQo=
