From: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Date: Thu, 10 Jan 2019 08:55:31 +0100
Message-ID: <CAKpie0TvS4bzdv82m8T24GaH_DrGsjdznCSQcugtt9DqKss_sg@mail.gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
 <20190108200509.30494-5-pawel.mikolaj.chmiel@gmail.com>
 <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190110070208.lvnrcd2nld3zthmk@vireshk-i7>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, "moderated list:SAMSUNG SOC CLOCK DRIVERS" <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux@armlinux.org.uk, Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Y3p3LiwgMTAgc3R5IDIwMTkgbyAwODowMiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5h
cm8ub3JnPiBuYXBpc2HFgihhKToKPgo+IE9uIDA4LTAxLTE5LCAyMTowNSwgUGF3ZcWCIENobWll
bCB3cm90ZToKPiA+IFRoaXMgY29tbWl0IGVuYWJsZXMgY3B1ZnJlcSBzdXBwb3J0IGZvciBhbGwg
czVwdjIxMCBkZXZpY2VzLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFBhd2XFgiBDaG1pZWwgPHBh
d2VsLm1pa29sYWouY2htaWVsQGdtYWlsLmNvbT4KPiA+IC0tLQo+ID4gIGFyY2gvYXJtL2NvbmZp
Z3MvczVwdjIxMF9kZWZjb25maWcgfCA2ICsrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEw
X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvczVwdjIxMF9kZWZjb25maWcKPiA+IGluZGV4
IDk1MTE5NmJkZjAwOC4uZmQ0ZjI4YWFiZGE2IDEwMDY0NAo+ID4gLS0tIGEvYXJjaC9hcm0vY29u
Zmlncy9zNXB2MjEwX2RlZmNvbmZpZwo+ID4gKysrIGIvYXJjaC9hcm0vY29uZmlncy9zNXB2MjEw
X2RlZmNvbmZpZwo+ID4gQEAgLTExLDYgKzExLDEyIEBAIENPTkZJR19BUkNIX1M1UFYyMTA9eQo+
ID4gIENPTkZJR19WTVNQTElUXzJHPXkKPiA+ICBDT05GSUdfQVJNX0FQUEVOREVEX0RUQj15Cj4g
PiAgQ09ORklHX0NNRExJTkU9InJvb3Q9L2Rldi9yYW0wIHJ3IHJhbWRpc2s9ODE5MiBpbml0cmQ9
MHgyMDgwMDAwMCw4TSBjb25zb2xlPXR0eVNBQzEsMTE1MjAwIGluaXQ9L2xpbnV4cmMiCj4gPiAr
Q09ORklHX0NQVV9GUkVRPXkKPiA+ICtDT05GSUdfQ1BVX0ZSRVFfU1RBVD15Cj4gPiArQ09ORklH
X0NQVV9GUkVRX0RFRkFVTFRfR09WX09OREVNQU5EPXkKPiA+ICtDT05GSUdfQ1BVX0ZSRVFfR09W
X1BPV0VSU0FWRT1tCj4gPiArQ09ORklHX0NQVV9GUkVRX0dPVl9VU0VSU1BBQ0U9bQo+ID4gK0NP
TkZJR19DUFVfRlJFUV9HT1ZfQ09OU0VSVkFUSVZFPW0KPgo+IFlvdSBkb24ndCB3YW50IHRvIHVz
ZSBzY2hlZHV0aWwgPyBUaGF0IGlzIHRoZSBkZWZhdWx0IGdvdmVybm9yIGZvcgo+IGV2ZXJ5b25l
IG5vdyBhIGRheXMuCnNjaGVkdXRpbCBkZXBlbmRzIG9uIFNNUCwgd2hpY2ggaXMgbm90IGVuYWJs
ZWQgb24gczVwdjIxMCAoaXQgaGFzIG9ubHkKb25lIGNwdSBjb3JlKS4KPgo+IC0tCj4gdmlyZXNo
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1h
cm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0t
a2VybmVsCg==
