From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v14] acpi, apei, arm64: APEI initial support for aarch64.
Date: Thu, 1 Dec 2016 12:41:37 +0100
Message-ID: <20161201114137.herpemkbg3rqxrc4@pd.tnic>
References: <1470834168-1780-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470834168-1780-1-git-send-email-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: fu.wei@linaro.org
Cc: tony.luck@intel.com, linaro-acpi@lists.linaro.org, tn@semihalf.com, linux-pm@vger.kernel.org, x86@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCBBdWcgMTAsIDIwMTYgYXQgMDk6MDI6NDhQTSArMDgwMCwgZnUud2VpQGxpbmFyby5v
cmcgd3JvdGU6Cj4gRnJvbTogVG9tYXN6IE5vd2lja2kgPHRvbWFzei5ub3dpY2tpQGxpbmFyby5v
cmc+Cj4gCj4gVGhpcyBwYXRjaCBwcm92aWRlcyBBUEVJIGFyY2gtc3BlY2lmaWMgYml0cyBmb3Ig
YWFyY2g2NAo+IAo+IE1lYW53aGlsZSwKPiAoMSltb3ZlIEhFU1QgdHlwZSAoQUNQSV9IRVNUX1RZ
UEVfSUEzMl9DT1JSRUNURURfQ0hFQ0spIGNoZWNraW5nIHRvCj4gYSBnZW5lcmljIHBsYWNlLgo+
ICgyKXNlbGVjdCBIQVZFX0FDUElfQVBFSSB3aGVuIEVGSSBhbmQgQUNQSSBpcyBzZXQgb24gQVJN
NjQsCj4gYmVjYXVzZSBhcmNoX2FwZWlfZ2V0X21lbV9hdHRyaWJ1dGUgaXMgdXNpbmcgZWZpX21l
bV9hdHRyaWJ1dGVzIG9uIEFSTTY0LgoKLi4uCgo+IEBAIC0xMTAsOCArMTExLDI3IEBAIHN0YXRp
YyBpbmxpbmUgY29uc3QgY2hhciAqYWNwaV9nZXRfZW5hYmxlX21ldGhvZChpbnQgY3B1KQo+ICB9
Cj4gIAo+ICAjaWZkZWYJQ09ORklHX0FDUElfQVBFSQo+ICsvKgo+ICsgKiBhY3BpX2Rpc2FibGVf
Y21jZmYgaXMgdXNlZCBpbiBkcml2ZXJzL2FjcGkvYXBlaS9oZXN0LmMgZm9yIGRpc2FibGluZwo+
ICsgKiBJQS0zMiBBcmNoaXRlY3R1cmUgQ29ycmVjdGVkIE1hY2hpbmUgQ2hlY2sgKENNQykgRmly
bXdhcmUtRmlyc3QgbW9kZSBieQo+ICsgKiBib290IHBhcmFtZXRlcihhY3BpPW5vY21jZmYpLiBC
dXQgd2UgZG9uJ3QgaGF2ZSB0aGlzIElBLTMyIHNwZWNpZmljCgpNYWtlIHRoYXQKCiIuLi4gd2l0
aCBhIGtlcm5lbCBjb21tYW5kIGxpbmUgcGFyYW1ldGVyICJhY3BpPW5vY21jb2ZmIi4iCgpQbGVh
c2UgZml4IHRoYXQgdXAgd2hlbiBhcHBseWluZy4KCldpdGggdGhhdDoKClJldmlld2VkLWJ5OiBC
b3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+CgpUaGFua3MhCgotLSAKUmVnYXJkcy9HcnVzcywK
ICAgIEJvcmlzLgoKU1VTRSBMaW51eCBHbWJILCBHRjogRmVsaXggSW1lbmTDtnJmZmVyLCBKYW5l
IFNtaXRoYXJkLCBHcmFoYW0gTm9ydG9uLCBIUkIgMjEyODQgKEFHIE7DvHJuYmVyZykKLS0gCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0t
a2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2Vy
bmVsCg==
