From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Wed, 28 Jan 2015 15:20:30 +0530
Message-ID: <54C8B0E6.5080406@linux.vnet.ibm.com>
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
 <m3wq47w9jj.fsf@oc8180480414.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <m3wq47w9jj.fsf@oc8180480414.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

T24gMDEvMjgvMjAxNSAwMjo0NSBQTSwgU3Rld2FydCBTbWl0aCB3cm90ZToKPiBQcmVldGkgVSBN
dXJ0aHkgPHByZWV0aUBsaW51eC52bmV0LmlibS5jb20+IHdyaXRlczoKPj4gVGhlIGRldmljZSB0
cmVlIG5vdyBleHBvc2VzIHRoZSByZXNpZGVuY3kgdmFsdWVzIGZvciBkaWZmZXJlbnQgaWRsZSBz
dGF0ZXMuIFJlYWQKPj4gdGhlc2UgdmFsdWVzIGluc3RlYWQgb2YgY2FsY3VsYXRpbmcgcmVzaWRl
bmN5IGZyb20gdGhlIGxhdGVuY3kgdmFsdWVzLiBUaGUgdmFsdWVzCj4+IGV4cG9zZWQgaW4gdGhl
IERUIGFyZSB2YWxpZGF0ZWQgZm9yIG9wdGltYWwgcG93ZXIgZWZmaWNpZW5jeS4gSG93ZXZlciB0
byBtYWludGFpbgo+PiBjb21wYXRpYmlsaXR5IHdpdGggdGhlIG9sZGVyIGZpcm13YXJlIGNvZGUg
d2hpY2ggZG9lcyBub3QgZXhwb3NlIHJlc2lkZW5jeQo+PiB2YWx1ZXMsIHVzZSBkZWZhdWx0IHZh
bHVlcyBhcyBhIGZhbGxiYWNrIG1lY2hhbmlzbS4gV2hpbGUgYXQgaXQsIGhhbmRsZSBzb21lCj4+
IGNsZWFudXBzLgo+IAo+IEZyb20gYSAiSSBqdXN0IG1lcmdlZCB0aGUgcGF0Y2ggdGhhdCBleHBv
cnRzIHRoZXNlIHZhbHVlcyBmcm9tIGZpcm13YXJlIgo+IHBvaW50IG9mIHZpZXcsIHVzaW5nIHRo
ZW0gYW5kIGZhbGxpbmcgYmFjayBsb29rcyBnb29kLgo+IAo+IChJIGZpbmQgdGhlIGhhcmRjb2Rp
bmcgb2Ygc25vb3plIGluIHRoZSBkcml2ZXIgYSBiaXQgb2RkLCBhcyBpcyB0aGUKClNub296ZSBp
cyB0aGUgb25seSBzb2Z0d2FyZSBkZWZpbmVkIGlkbGUgc3RhdGUsIHRoZSByZXN0IGFyZSBwbGF0
Zm9ybQpzcGVjaWZpYy4gVGhlIGZpcnN0IGlkbGUgc3RhdGUgaXMgdXN1YWxseSBhc3NvY2lhdGVk
IHdpdGggc29tZSBzb3J0IG9mIGEKcG9sbGluZyBvcGVyYXRpb24gYW5kIGVhY2ggYXJjaGl0ZWN0
dXJlIGhhcyBhIHZhcmlhbnQgdG8gdGhpcy4gVGhpcyBpcwp3aHkgd2UgZW5kIHVwIGhhcmQtY29k
aW5nIHRoaXMgaWRsZSBzdGF0ZSBpbiB0aGUgZHJpdmVyIGFzIGZhciBhcyBteQp1bmRlcnN0YW5k
aW5nIGdvZXMuCgo+IGhhcmRjb2Rpbmcgb2YgbWF4IHBvd2VyIHN0YXRlcyB0byA4IC0gd2hpY2gg
Y291bGQgYml0ZSB1cyBpbiB0aGUgZnV0dXJlCgpIbW0uLiBub3Qgc3VyZSBhYm91dCB0aGlzLiBO
ZWVkIHRvIGNoZWNrLgoKPiBpZiBhIGZ1dHVyZSBwcm9jZXNzb3IgaGFzIG1vcmUgc3RhdGVzLi4u
IGJ1dCB0aGVzZSBhcmVuJ3QgcHJvYmxlbXMgd2l0aAo+IHRoaXMgcGF0Y2gpCj4gCj4gQWNrZWQt
Ynk6IFN0ZXdhcnQgU21pdGggPHN0ZXdhcnRAbGludXgudm5ldC5pYm0uY29tPgoKVGhhbmtzIQoK
UmVnYXJkcwpQcmVldGkgVSBNdXJ0aHkKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4
cHBjLWRldg==
