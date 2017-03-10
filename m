From: Vlad Zakharov <Vladislav.Zakharov@synopsys.com>
Subject: update timer frequencies
Date: Fri, 10 Mar 2017 09:17:21 +0000
Message-ID: <1489137441.2333.46.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Language: en-US
Content-ID: <1C1DBD0AC475144C93E4B200EB5D5D5B@internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "john.stultz@linaro.org" <john.stultz@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

SGVsbG8sDQoNCkkgYW0gdHJ5aW5nIHRvIGltcGxlbWVudCBhIGNwdWZyZXEgZHJpdmVyIGZvciBB
UkMgQ1BVcy7CoA0KVGhlIHBvaW50IGlzIHRoYXQgQVJDIHRpbWVycyAoaW5jbHVkaW5nIHRob3Nl
IGFyZSB1c2VkIGZvciB0aW1la2VlcGluZykgYXJlIGRyaXZlbiBieSB0aGUgc2FtZSBjbG9jayBh
cyBBUkMgQ1BVIGNvcmUocykuDQoNClNvIGlmIGNwdWZyZXEgZHJpdmVyIGNoYW5nZXMgQ1BVIGZy
ZXF1ZW5jeSB0aW1lcnMgZnJlcXVlbmN5IGFsc28gdXBkYXRlcy7CoA0KSSBhZGRlZCBub3RpZmlj
YXRpb24gaGFuZGxlciB0byBBUkMgdGltZXIgZHJpdmVyIHdlcmUgSSBhdHRlbXB0ZWQgdG8gdXBk
YXRlIGNsb2Nrc291cmNlIGZyZXF1ZW5jeSB3aXRoDQoiX19jbG9ja3NvdXJjZV91cGRhdGVfZnJl
cV9oeigpIiBidXQgSSBmb3VuZCB0aGF0IGFjdHVhbGx5IHRoZSBmcmVxdWVuY3kgZGlkbid0IHVw
ZGF0ZS7CoA0KDQpEdXJpbmcgbXkgZnVydGhlciBpbnZlc3RpZ2F0aW9uIEkgbWVudGlvbmVkIHRo
YXQgdGltZWtlZXBpbmcgZnJhbWV3b3JrIGRvZXNuJ3QgYWxsb3cgZnJlcXVlbmN5IGNoYW5nZXMg
Zm9yIG1vcmUgdGhhbg0KMTElLiBUaGlzIGlzIHF1aWV0IGZydXN0cmF0aW5nbHk6IEFSQyBjb3Jl
cyBzdXBwb3J0cyBzdWNoIGFkanVzdG1lbnRzIHRoZW1zZWx2ZXMgYnV0IGN1cnJlbnQgZnJhbWV3
b3JrIEFQSSBkb2Vzbid0IGdpdmUNCnVzIGEgY2hhbmNlIHRvIHVzZSB0aGlzIGZ1bmN0aW9uYWxp
dHkgYW5kIGluIGZhY3QgaXQgZXZlbiBmb3JiaWRzIENQVSBmcmVxdWVuY3kgY2hhbmdlcyBpbiBy
dW50aW1lIGF0IGFsbC4NCg0KTWF5YmUgSSBhbSBtaXN0YWtlbiBhbmQgdGhlcmUgaXMgc29tZSB3
YXkgdG8gZ2V0IHRoaXMgZ29pbmc/IE9yIG1heWJlIHdlIGNhbiBhZGQgc29tZSBtaW5vciBjaGFu
Z2VzIHRvIHRpbWVrZWVwaW5nDQpmcmFtZXdvcmsgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlIChzcGVj
aWFsIGZsYWcgdGhhdCBhbGxvd3Mgc3VjaCBjaGFuZ2VzIG9yIHNvbWV0aGluZyBsaWtlIHRoaXM/
KS4NCg0KVGhhbmtzLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWQgWmFraGFyb3YgPHZ6YWto
YXJAc3lub3BzeXMuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1zbnBzLWFyYyBtYWlsaW5nIGxpc3QKbGludXgtc25wcy1hcmNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXNucHMtYXJj
