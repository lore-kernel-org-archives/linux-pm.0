From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe
 runtime PM
Date: Tue, 31 May 2016 14:20:26 +0200
Message-ID: <20160531122026.GA14129@wunner.de>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
 <20160530161351.GA1355@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160530161351.GA1355@al>
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
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

T24gTW9uLCBNYXkgMzAsIDIwMTYgYXQgMDY6MTM6NTFQTSArMDIwMCwgUGV0ZXIgV3Ugd3JvdGU6
Cj4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGZvciB0aGUgY2FzZSB3aGVyZSB0aGUgcGNp
ZXBvcnQgZHJpdmVyCj4gcmVmdXNlcyB0byBwdXQgdGhlIGJyaWRnZSBpbiBEMyAoYmVjYXVzZSB0
aGUgQklPUyBpcyB0b28gb2xkKT8gSW4gdGhhdAo+IGNhc2UgdGhlIG5vdXZlYXUgZHJpdmVyIG5l
ZWRzIHRvIGZhbGxiYWNrIHRvIHRoZSBEU00gbWV0aG9kIChidXQgbm90Cj4gd2hlbiBydW50aW1l
IFBNIGlzIGRlbGliZXJhdGVseSBkaXNhYmxlZCBieSB3cml0aW5nIGNvbnRyb2w9b24pLgoKVGhl
IEJJT1MgY3V0LW9mZiBkYXRlIGlzIG1lYW50IHRvIGF2b2lkIGlzc3VlcyB3aGVuIHN1c3BlbmRp
bmcgcG9ydHMKb24gb2xkZXIgY2hpcHNldHMuIEhvd2V2ZXIgaWYgdGhlIHBvcnQgaXMgdXNlZCBm
b3IgYW4gT3B0aW11cyBHUFUKYW5kIHdlIGNhbiBjbGVhcmx5IGlkZW50aWZ5IHRoYXQsIGFuZCB0
aGVyZSdzIGEgX1BSMyBtZXRob2QgcHJvdmlkZWQsCml0J3MgcHJvYmFibHkgc2FmZSB0byBzYXkg
dGhhdCB0aGUgcG9ydCBpcyAqaW50ZW5kZWQqIHRvIGJlIHN1c3BlbmRlZC4KClNvIHlvdSBtYXkg
d2FudCB0byBjb25zaWRlciBhbWVuZGluZyBwY2lfYnJpZGdlX2QzX3Bvc3NpYmxlKCkgdG8KYWxs
b3cgRDMgZm9yIHN1Y2ggcG9ydHMgcmVnYXJkbGVzcyBvZiB0aGUgQklPUyBkYXRlLCBhcyBJJ3Zl
IGRvbmUKZm9yIFRodW5kZXJib2x0IGluIHRoaXMgY29tbWl0OgpodHRwczovL2dpdGh1Yi5jb20v
bDFrL2xpbnV4L2NvbW1pdC8zY2I4NTQ5Y2Q0ZTUKCk5vdCBzdXJlIGhvdyB0byB1bmlxdWVseSBp
ZGVudGlmeSBzdWNoIHBvcnRzIHRob3VnaC4gUGVyaGFwcyBjaGVjawppZiB0aGVyZSdzIGEgZGV2
aWNlIGluIHNsb3QgMCBiZWxvdyB0aGUgcG9ydCB3aGljaCBoYXMKCShwZGV2LT5jbGFzcyA+PiAx
NikgPT0gUENJX0JBU0VfQ0xBU1NfRElTUExBWSAmJgoJKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVO
RE9SX0lEX05WSURJQSB8fAoJIHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0FUSSkKCkJl
c3QgcmVnYXJkcywKCkx1a2FzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCk5vdXZlYXUgbWFpbGluZyBsaXN0Ck5vdXZlYXVAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vbm91dmVh
dQo=
