From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers
 on resume
Date: Tue, 2 Oct 2018 15:03:50 -0500
Message-ID: <20181002200350.GC120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
 <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
 <7b0a5388-5b3a-a6e0-347f-94f87fc2e540@rockbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7b0a5388-5b3a-a6e0-347f-94f87fc2e540-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Thomas Martitz <kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
Cc: andy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, rchang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

SGkgVGhvbWFzLAoKT24gTW9uLCBPY3QgMDEsIDIwMTggYXQgMDQ6MjU6MDZQTSArMDIwMCwgVGhv
bWFzIE1hcnRpdHogd3JvdGU6Cj4gQW0gMDEuMTAuMTggdW0gMDY6NTcgc2NocmllYiBEYW5pZWwg
RHJha2U6Cj4gPiBPbiBTdW4sIFNlcCAzMCwgMjAxOCBhdCA1OjA3IEFNIFRob21hcyBNYXJ0aXR6
IDxrdWdlbEByb2NrYm94Lm9yZz4gd3JvdGU6Cj4gPiA+IFRoZSBsYXRlc3QgaXRlcmF0aW9uIGRv
ZXMgbm90IHdvcmsgb24gbXkgSFAgc3lzdGVtLiBUaGUgR1BVIGZhaWxzIHRvCj4gPiA+IHBvd2Vy
IHVwIGp1c3QgbGlrZSB0aGUgdW5wYXRjaGVkIGtlcm5lbC4KPiA+IAo+ID4gVGhhdCdzIHdlaXJk
LCBJIHdvdWxkIG5vdCBleHBlY3QgYSBiZWhhdmlvdXIgY2hhbmdlIGluIHRoZSBsYXRlc3QKPiA+
IHBhdGNoLiBwY2lfcmVzdG9yZV9jb25maWdfZHdvcmQoKSBoYXMgc29tZSBkZWJ1ZyBtZXNzYWdl
cywgY291bGQgeW91Cj4gPiBwbGVhc2UgbWFrZSB0aGVtIHZpc2libGUgYW5kIHNob3cgbG9ncyBh
Z2Fpbj8KPiA+IEFsc28gcmVtaW5kIHVzIG9mIHRoZSBQQ0kgZGV2aWNlIGFkZHJlc3Mgb2YgdGhl
IHBhcmVudCBicmlkZ2UgKGxzcGNpIC12dCkKPiAKPiBJJ2xsIGZvbGxvdyB1cCB3aXRoIG1vcmUg
dGhlIHJlcXVlc3RlZCBpbmZvcm1hdGlvbiBvbiBidWd6aWxsYQo+IChMaW5rOiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwMTA2OSkuCj4gCj4gT24gYSBxdWlj
ayByZS1jaGVjaywgaXQgc2VlbXMgdG8gZGVwZW5kIG9uIGlmIEkgdXNlZCB0aGUgZUdQVSBiZWZv
cmUKPiB0aGUgaW5pdGlhbCBzdXNwZW5kLiBJZiBJIHJ1biBnbHhnZWFycyAod2l0aCBEUklfUFJJ
TUU9MSkgYmVmb3JlIHN1c3BlbmQgaXQKPiBzZWVtcyBmaW5lLgoKRG9lcyB0aGUgcGF0Y2ggKFsx
XSkgbWFrZSB0aGluZ3MgKndvcnNlKiBjb21wYXJlZCB0byB2NC4xOS1yYzU/CgpJZiBzbywgSSds
bCBkcm9wIHRoZSBwYXRjaCB1bnRpbCB3ZSBmaWd1cmUgdGhpcyBvdXQuICBCdXQgaWYgdGhlIEdQ
VQpwb3dlciBpc3N1ZSBhbHNvIG9jY3VycyBpbiB2NC4xOS1yYzUsIEkgdGhpbmsgd2UgY2FuIGFz
c3VtZSBpdCdzIGEKZGlmZmVyZW50IHByb2JsZW0gYW5kIHdlIGNhbiBnbyBhaGVhZCBhbmQgbWVy
Z2UgWzFdLgoKWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L2hlbGdhYXMvcGNpLmdpdC9jb21taXQvP2g9Zm9yLWxpbnVzJmlkPTA4Mzg3NDU0OWZkZmVm
YTYyOWRmYTc1Mjc4NWUyMDQyN2RkZTE1MTEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTm91dmVhdSBtYWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9ub3V2ZWF1Cg==
