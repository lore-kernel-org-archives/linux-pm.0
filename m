From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Wed, 18 Dec 2013 09:30:46 +0100
Message-ID: <20131218093046.6d439329@ipc1.ka-ro>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>
 <20131217121358.GM6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131217121358.GM6691@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, cpufreq@vger.kernel.org, Anson Huang <b20788@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

SGksCgpTaGF3biBHdW8gd3JvdGU6Cj4gT24gVHVlLCBEZWMgMTcsIDIwMTMgYXQgMTA6NTM6NDdB
TSArMDEwMCwgTG90aGFyIFdhw59tYW5uIHdyb3RlOgo+ID4gPiA+ICsJaWYgKHNvY19vcHBfaW5k
ZXggPj0gc29jX29wcF9jb3VudCkgewo+ID4gPiAKPiA+ID4gQ2FuIHNvY19vcHBfaW5kZXggYmUg
cG9zc2libHkgZ3JlYXRlciB0aGFuIHNvY19vcHBfY291bnQ/ICBPdGhlcndpc2UsCj4gPiA+IHRo
ZSBjb25kaXRpb24gY2hlY2sgYmVsb3cgaXMgZ29vZCBlbm91Z2g/Cj4gPiA+IAo+ID4gPiAJaWYg
KHNvY19vcHBfaW5kZXggPT0gc29jX29wcF9jb3VudCkKPiA+ID4KPiA+IGl0IGRvZW4ndCBoYXJt
IHRvIGJlIG9uIHRoZSBzYWZlIHNpZGUgYW5kIHVzZSA+PSBhbnl3YXkhCj4gCj4gV2VsbCwgaXQg
bWF5IGNvbmZ1c2UgcmVhZGVyLiAgQXQgbGVhc3QsIGl0IHRvb2sgbWUgc29tZSB0aW1lIHVuZGVy
c3RhbmQKPiBob3cgdGhhdCAiPiIgY29uZGl0aW9uIHdpbGwgaGFwcGVuLiAgQW5kIGl0IHR1cm5z
IG91dCBuZXZlci4KPiAKbWFuICJkZWZlbnNpdmUgcHJvZ3JhbW1pbmciCgoKTG90aGFyIFdhw59t
YW5uCi0tIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwoKS2EtUm8gZWxlY3Ryb25pY3MgR21iSCB8IFBhc2NhbHN0cmHDn2UgMjIgfCBE
IC0gNTIwNzYgQWFjaGVuClBob25lOiArNDkgMjQwOCAxNDAyLTAgfCBGYXg6ICs0OSAyNDA4IDE0
MDItMTAKR2VzY2jDpGZ0c2bDvGhyZXI6IE1hdHRoaWFzIEthdXNzZW4KSGFuZGVsc3JlZ2lzdGVy
ZWludHJhZzogQW10c2dlcmljaHQgQWFjaGVuLCBIUkIgNDk5NgoKd3d3Lmthcm8tZWxlY3Ryb25p
Y3MuZGUgfCBpbmZvQGthcm8tZWxlY3Ryb25pY3MuZGUKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
