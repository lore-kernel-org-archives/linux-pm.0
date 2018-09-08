From: Thomas Martitz <kugel-UCKwuKHb1aVAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] PCI: Reprogram bridge prefetch registers on
 resume
Date: Sat, 8 Sep 2018 13:05:11 +0200
Message-ID: <cd2f572a-9c1f-41c1-6e95-759cfec501d9@rockbox.org>
References: <20180907053614.6540-1-drake@endlessm.com>
 <20180907150515.GA28739@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180907150515.GA28739@al>
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
To: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Cc: nic_swsd-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

QW0gMDcuMDkuMTggdW0gMTc6MDUgc2NocmllYiBQZXRlciBXdToKPiBPbiBGcmksIFNlcCAwNywg
MjAxOCBhdCAwMTozNjoxNFBNICswODAwLCBEYW5pZWwgRHJha2Ugd3JvdGU6Cj4gPC4uPgo+PiBU
aG9tYXMgTWFydGl0eiByZXBvcnRzIHRoYXQgdGhpcyB3b3JrYXJvdW5kIGFsc28gc29sdmVzIGFu
IGlzc3VlIHdoZXJlCj4+IHRoZSBBTUQgUmFkZW9uIFBvbGFyaXMgMTAgR1BVIG9uIHRoZSBIUCBa
Ym9vayAxNHUgRzUgaXMgdW5yZXNwb25zaXZlCj4+IGFmdGVyIFMzIHN1c3BlbmQvcmVzdW1lLgo+
IAo+IFdoZXJlIHdhcyB0aGlzIGNsYWltZWQ/IEl0IGlzIG5vdCBzdGF0ZWQgaW4gdGhlIGxpbmtl
ZCBidWc6Cj4gKGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEw
NTc2MAo+IAoKCkFjdHVhbGx5LCBJIHJlcG9ydGVkIHRoYXQgaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMDU4MzIyOS8gCndvcmtzLiBJIHVwZGF0ZWQgdGhlIGJ1ZyBub3csIEkg
ZGlkbid0IGRvIHNvIHlldCBiZWNhdXNlIGl0J3MgY2xvc2VkLgoKSG93ZXZlciwgSSBkaWQgbm90
IGFjdHVhbGx5IHRlc3QgdGhlIGV4YWN0IHBhdGNoICp0aGlzKiB0aHJlYWQgaXMgYWJvdXQuIApE
byB5b3Ugd2FudCBtZSB0byBnaXZlIGl0IGEgc3Bpbj8KCkJlc3QgcmVnYXJkcy4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBtYWlsaW5nIGxp
c3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==
