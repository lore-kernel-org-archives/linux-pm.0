From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [RFC PATCH] PM: Introduce generic DVFS framework
 with device-specific OPPs
Date: Wed, 27 Apr 2011 14:24:40 +0900
Message-ID: <BANLkTikr0BR2H7+zAFvSHxf=evP8JNQA7g@mail.gmail.com>
References: <1303807401-16350-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426150710.GB23812@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110426150710.GB23812@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBBcHIgMjcsIDIwMTEgYXQgMTI6MDcgQU0sIE1hcmsgQnJvd24gPGJyb29uaWVAc2ly
ZW5hLm9yZy51az4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMjYsIDIwMTEgYXQgMDU6NDM6MjFQTSAr
MDkwMCwgTXl1bmdKb28gSGFtIHdyb3RlOgo+Cj4+ICtzdGF0aWMgaW50IF9faW5pdCBkdmZzX2lu
aXQodm9pZCkKPj4gK3sKPj4gKyDCoCDCoCBwbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIoJmR2ZnNf
cG1fZHJ2KTsKPj4gKyDCoCDCoCBwbGF0Zm9ybV9kZXZpY2VfcmVnaXN0ZXIoJmR2ZnNfcG1fZGV2
KTsKPj4gKwo+PiArIMKgIMKgIElOSVRfREVMQVlFRF9XT1JLX0RFRkVSUkFCTEUoJmR2ZnNfd29y
aywgZHZmc19tb25pdG9yKTsKPj4gKyDCoCDCoCBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmR2ZnNf
d29yaywgbXNlY3NfdG9famlmZmllcyhEVkZTX0lOVEVSVkFMKSk7Cj4KPiBUaGlzIHdpbGwgdW5j
b25kaXRpb25hbGx5IHN0YXJ0IHRoZSB0aW1lciB3aGljaCBwb2xscyB0aGUgZGV2aWNlcyBhdAo+
IHdoYXRldmVyIHJhdGUuIMKgSSdkIGV4cGVjdCB0byBzdGFydCBhbmQgc3RvcCB0aGUgcG9sbCBk
ZXBlbmRpbmcgb24gaWYgd2UKPiBoYXZlIGRldmljZXMgYW5kL29yIGdvdmVybm9yIHR5cGUgY29k
ZSAod2hpY2ggSSBkb24ndCBzZWUgYW55dGhpbmcgZm9yCj4gaGVyZSwgdGhvdWdoIGl0J3MgaGFy
ZCB0byBrbm93IHdoYXQgY3JpdGVyaWEgYSBnZW5lcmljIGdvdmVybm9yIHdvdWxkCj4gdXNlKSB3
aGljaCByZXF1aXJlIGl0Lgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gbGludXgtcG0gbWFpbGluZyBsaXN0Cj4gbGludXgtcG1AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtcG0KPgoKVGhhbmtzLgoKSSB3aWxsIGxldCBpdCBwb2xsIG9ubHkg
d2hlbiB0aGVyZSBhcmUgZHZmcy1kZXZpY2VzIHdpdGggcG9sbGluZwppbnRlcnZhbCBzcGVjaWZp
ZWQuCgoKQ2hlZXJzIQoKLSBNeXVuZ0pvbwotLSAKTXl1bmdKb28gSGFtICjtlajrqoXso7wpLCBQ
aC5ELgpNb2JpbGUgU29mdHdhcmUgUGxhdGZvcm0gTGFiLApEaWdpdGFsIE1lZGlhIGFuZCBDb21t
dW5pY2F0aW9ucyAoRE1DKSBCdXNpbmVzcwpTYW1zdW5nIEVsZWN0cm9uaWNzCmNlbGw6IDgyLTEw
LTY3MTQtMjg1OApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1wbSBtYWlsaW5nIGxpc3QKbGludXgtcG1AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXBt
