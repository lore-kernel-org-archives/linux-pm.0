From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3] PCI: Reprogram bridge prefetch registers
 on resume
Date: Mon, 1 Oct 2018 12:57:11 +0800
Message-ID: <CAD8Lp47uL3DQTBiVTduO1+Cg8px4CDpv26qVJsgT+RJ4WZx9oA@mail.gmail.com>
References: <20180913033745.11178-1-drake@endlessm.com>
 <20180918213244.GE13616@bhelgaas-glaptop.roam.corp.google.com>
 <20180927205247.GA18434@bhelgaas-glaptop.roam.corp.google.com>
 <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c@rockbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3f8efcd6-7cd2-b41a-d984-28c9e1740d6c-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
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
Cc: andy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, rchang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gU3VuLCBTZXAgMzAsIDIwMTggYXQgNTowNyBBTSBUaG9tYXMgTWFydGl0eiA8a3VnZWxAcm9j
a2JveC5vcmc+IHdyb3RlOgo+IFRoZSBsYXRlc3QgaXRlcmF0aW9uIGRvZXMgbm90IHdvcmsgb24g
bXkgSFAgc3lzdGVtLiBUaGUgR1BVIGZhaWxzIHRvCj4gcG93ZXIgdXAganVzdCBsaWtlIHRoZSB1
bnBhdGNoZWQga2VybmVsLgoKVGhhdCdzIHdlaXJkLCBJIHdvdWxkIG5vdCBleHBlY3QgYSBiZWhh
dmlvdXIgY2hhbmdlIGluIHRoZSBsYXRlc3QKcGF0Y2guIHBjaV9yZXN0b3JlX2NvbmZpZ19kd29y
ZCgpIGhhcyBzb21lIGRlYnVnIG1lc3NhZ2VzLCBjb3VsZCB5b3UKcGxlYXNlIG1ha2UgdGhlbSB2
aXNpYmxlIGFuZCBzaG93IGxvZ3MgYWdhaW4/CkFsc28gcmVtaW5kIHVzIG9mIHRoZSBQQ0kgZGV2
aWNlIGFkZHJlc3Mgb2YgdGhlIHBhcmVudCBicmlkZ2UgKGxzcGNpIC12dCkKClRoYW5rcwpEYW5p
ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVh
dSBtYWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==
