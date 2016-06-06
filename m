From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 8/9] cpufreq: Keep policy->freq_table sorted in
 ascending order
Date: Mon, 6 Jun 2016 17:54:06 +0530
Message-ID: <CAKohponw8wjFTXA+JyH0A2yXwtF4DxPSVCLcji4=yYV14OC3fw@mail.gmail.com>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
 <20160603234854.GF14579@graphite.smuckle.net>
 <20160606035231.GZ16176@vireshk-i7> <1649758.V7uyzAJShK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1649758.V7uyzAJShK@vostro.rjw.lan>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Steven Miao <realmz6@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Paul Mackerras <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-pm@vger.kernel.org

T24gNiBKdW5lIDIwMTYgYXQgMTc6NDAsIFJhZmFlbCBKLiBXeXNvY2tpIDxyandAcmp3eXNvY2tp
Lm5ldD4gd3JvdGU6Cj4gT24gTW9uZGF5LCBKdW5lIDA2LCAyMDE2IDA5OjIyOjMxIEFNIFZpcmVz
aCBLdW1hciB3cm90ZToKCj4+IEkgYWdyZWUgd2l0aCB0aGF0LCB0aG91Z2ggdGhhdCByZXF1aXJl
cyBsYXJnZXIgY2hhbmdlcyBhY3Jvc3MgbXVsdGlwbGUKPj4gc2l0ZXMuCj4KPiBXaGF0IGNoYW5n
ZXMgYW5kIHdoZXJlPwoKcy9sYXJnZXIvc29tZSA6KQoKU28gd2UgY2FuIGNoYW5nZSBhbGwgdGhl
IGNhbGxlcnMgb2YgY3B1ZnJlcV9mcmVxdWVuY3lfdGFibGVfdGFyZ2V0KCksCmxpa2UgdGhlIGdv
dmVybm9ycywgb25kZW1hbmQtYmlhcyBzdHViIGRyaXZlcnMsIGNvcmUsIGV0YyBhbmQgY2FsbAp0
aGUgZGVkaWNhdGVkICdyZWxhdGlvbicgc3BlY2lmaWMgcm91dGluZXMgZGlyZWN0bHksIGFzIHdl
IG1vc3RseSBrbm93CmluIGFkdmFuY2UgdGhlICdyZWxhdGlvbicgaW4gd2hpY2ggd2Ugd2FudCB0
byB1cGRhdGUgdGhlIGZyZXEuCgpBbmQsIHNvIGRvaW5nIHRoYXQgd2l0aCBhIGRlZGljYXRlZCBw
YXRjaCBtaWdodCBiZSBiZXR0ZXIuCgotLQp2aXJlc2hqCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZv
L2xpbnV4cHBjLWRldg==
