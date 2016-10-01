From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 00/15] improve function-level documentation
Date: Sat, 1 Oct 2016 22:39:15 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1610012232350.3445@hadrien>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
 <1475353194.1996.3.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1475353194.1996.3.camel@perches.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Joe Perches <joe@perches.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org, linux-media@vger.kernel.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, drbd-dev@lists.linbit.com
List-Id: linux-pm@vger.kernel.org

CgpPbiBTYXQsIDEgT2N0IDIwMTYsIEpvZSBQZXJjaGVzIHdyb3RlOgoKPiBPbiBTYXQsIDIwMTYt
MTAtMDEgYXQgMjE6NDYgKzAyMDAsIEp1bGlhIExhd2FsbCB3cm90ZToKPiA+IFRoZXNlIHBhdGNo
ZXMgZml4IGNhc2VzIHdoZXJlIHRoZSBkb2N1bWVudGF0aW9uIGFib3ZlIGEgZnVuY3Rpb24gZGVm
aW5pdGlvbgo+ID4gaXMgbm90IGNvbnNpc3RlbnQgd2l0aCB0aGUgZnVuY3Rpb24gaGVhZGVyLiAg
SXNzdWVzIGFyZSBkZXRlY3RlZCB1c2luZyB0aGUKPiA+IHNlbWFudGljIHBhdGNoIGJlbG93ICho
dHRwOi8vY29jY2luZWxsZS5saXA2LmZyLykuICBCYXNpY2FsbHksIHRoZSBzZW1hbnRpYwo+ID4g
cGF0Y2ggcGFyc2VzIGEgZmlsZSB0byBmaW5kIGNvbW1lbnRzLCB0aGVuIG1hdGNoZXMgZWFjaCBm
dW5jdGlvbiBoZWFkZXIsCj4gPiBhbmQgY2hlY2tzIHRoYXQgdGhlIG5hbWUgYW5kIHBhcmFtZXRl
ciBsaXN0IGluIHRoZSBmdW5jdGlvbiBoZWFkZXIgYXJlCj4gPiBjb21wYXRpYmxlIHdpdGggdGhl
IGNvbW1lbnQgdGhhdCBwcmVjZWVkcyBpdCBtb3N0IGNsb3NlbHkuCj4KPiBIaSBKdWxpYS4KPgo+
IFdvdWxkIGl0IGJlIHBvc3NpYmxlIGZvciBhIHNlbWFudGljIHBhdGNoIHRvIHNjYW4gZm9yCj4g
ZnVuY3Rpb24gZGVmaW5pdGlvbnMgd2hlcmUgdGhlIHR5cGVzIGRvIG5vdCBoYXZlCj4gaWRlbnRp
ZmllcnMgYW5kIHVwZGF0ZSB0aGUgZGVmaW5pdGlvbnMgdG8gbWF0Y2ggdGhlCj4gZGVjbGFyYXRp
b25zPwo+Cj4gRm9yIGluc3RhbmNlLCBnaXZlbjoKPgo+IDxzb21lLmg+Cj4gaW50IGZvbyhpbnQp
Owo+Cj4gPHNvbWUuYz4KPiBpbnQgZm9vKGludCBiYXIpCj4gewo+IAlyZXR1cm4gYmF6Owo+IH0K
Pgo+IENvdWxkIGNvY2NpbmVsbGUgb3V0cHV0Ogo+Cj4gZGlmZiBhL3NvbWUuaCBiL3NvbWUuaAo+
IFtdCj4gLWludCBmb28oaW50KTsKPiAraW50IGZvbyhpbnQgYmFyKTsKClRoZSBmb2xsb3dpbmcg
c2VlbXMgdG8gd29yazoKCkByQAppZGVudGlmaWVyIGY7CnBvc2l0aW9uIHA7CnR5cGUgVCwgdDsK
cGFyYW1ldGVyIGxpc3Rbbl0gcHM7CkBACgpUIGZAcChwcyx0LC4uLik7CgpAc0AKaWRlbnRpZmll
ciByLmYseDsKdHlwZSByLlQsIHIudDsKcGFyYW1ldGVyIGxpc3Rbci5uXSBwczsKQEAKClQgZihw
cyx0IHgsLi4uKSB7IC4uLiB9CgpAQAppZGVudGlmaWVyIHIuZiwgcy54Owpwb3NpdGlvbiByLnA7
CnR5cGUgci5ULCByLnQ7CnBhcmFtZXRlciBsaXN0W3Iubl0gcHM7CkBACgpUIGZAcChwcyx0Cisg
eAogICwuLi4pOwoKQWZ0ZXIgbGV0dGluZyBpdCBydW4gZm9yIGEgZmV3IG1pbnV0ZXMgd2l0aG91
dCBtYWtpbmcgYW55IGVmZm9ydCB0bwppbmNsdWRlIC5oIGZpbGVzLCBJIGdldCBvdmVyIDI3MDAg
Y2hhbmdlZCBsaW5lcy4KCmp1bGlhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
