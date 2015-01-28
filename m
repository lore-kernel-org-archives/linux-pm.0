From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Wed, 28 Jan 2015 20:15:28 +1100
Message-ID: <m3wq47w9jj.fsf@oc8180480414.ibm.com>
References: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
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
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

UHJlZXRpIFUgTXVydGh5IDxwcmVldGlAbGludXgudm5ldC5pYm0uY29tPiB3cml0ZXM6Cj4gVGhl
IGRldmljZSB0cmVlIG5vdyBleHBvc2VzIHRoZSByZXNpZGVuY3kgdmFsdWVzIGZvciBkaWZmZXJl
bnQgaWRsZSBzdGF0ZXMuIFJlYWQKPiB0aGVzZSB2YWx1ZXMgaW5zdGVhZCBvZiBjYWxjdWxhdGlu
ZyByZXNpZGVuY3kgZnJvbSB0aGUgbGF0ZW5jeSB2YWx1ZXMuIFRoZSB2YWx1ZXMKPiBleHBvc2Vk
IGluIHRoZSBEVCBhcmUgdmFsaWRhdGVkIGZvciBvcHRpbWFsIHBvd2VyIGVmZmljaWVuY3kuIEhv
d2V2ZXIgdG8gbWFpbnRhaW4KPiBjb21wYXRpYmlsaXR5IHdpdGggdGhlIG9sZGVyIGZpcm13YXJl
IGNvZGUgd2hpY2ggZG9lcyBub3QgZXhwb3NlIHJlc2lkZW5jeQo+IHZhbHVlcywgdXNlIGRlZmF1
bHQgdmFsdWVzIGFzIGEgZmFsbGJhY2sgbWVjaGFuaXNtLiBXaGlsZSBhdCBpdCwgaGFuZGxlIHNv
bWUKPiBjbGVhbnVwcy4KCkZyb20gYSAiSSBqdXN0IG1lcmdlZCB0aGUgcGF0Y2ggdGhhdCBleHBv
cnRzIHRoZXNlIHZhbHVlcyBmcm9tIGZpcm13YXJlIgpwb2ludCBvZiB2aWV3LCB1c2luZyB0aGVt
IGFuZCBmYWxsaW5nIGJhY2sgbG9va3MgZ29vZC4KCihJIGZpbmQgdGhlIGhhcmRjb2Rpbmcgb2Yg
c25vb3plIGluIHRoZSBkcml2ZXIgYSBiaXQgb2RkLCBhcyBpcyB0aGUKaGFyZGNvZGluZyBvZiBt
YXggcG93ZXIgc3RhdGVzIHRvIDggLSB3aGljaCBjb3VsZCBiaXRlIHVzIGluIHRoZSBmdXR1cmUK
aWYgYSBmdXR1cmUgcHJvY2Vzc29yIGhhcyBtb3JlIHN0YXRlcy4uLiBidXQgdGhlc2UgYXJlbid0
IHByb2JsZW1zIHdpdGgKdGhpcyBwYXRjaCkKCkFja2VkLWJ5OiBTdGV3YXJ0IFNtaXRoIDxzdGV3
YXJ0QGxpbnV4LnZuZXQuaWJtLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBj
LWRldg==
