From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 20:44:24 +0300
Message-ID: <AANLkTikna-Vs_phy2VrJs0I8gIsdSmwuxTJ67gQ_2oTt__7752.24670437655$1275760013$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

MjAxMC82LzIgQXJ2ZSBIasO4bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT46Cj4gMjAxMC82LzIg
UGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjoKPj4gKGFuZCBwbGVhc2UgZG9u
J3QgbWVudGlvbiBAIyRAIHVwIHg4NiBBQ1BJIGFnYWluLCBJbnRlbCBrbm93cywgdGhleSdyZQo+
PiBmaXhpbmcgaXQsIGdldCBvdmVyIGl0IGFscmVhZHkpLgo+Pgo+Cj4gSSBkb24ndCB0aGluayBp
dCBpcyByZWFsaXN0aWMgdG8gZHJvcCBzdXBwb3J0IGZvciBhbGwgZXhpc3RpbmcgaGFyZHdhcmUu
CgpXZSBhcmUgdGFsa2luZyBhYm91dCBtYWlubGluZSBoZXJlLCB0aGVyZSdzIG5vIHN1cHBvcnQg
Zm9yIHN1c3BlbmQKYmxvY2tlcnMsIHNvIG5vdGhpbmcgaXMgZHJvcHBlZC4KCkluIHRoZSBtaW5k
IG9mIGV2ZXJ5Ym9keSwgc3VzcGVuZCBibG9ja2VycyBpcyBmb3Igb3Bwb3J0dW5pc3RpYwpzdXNw
ZW5kLCB3aGljaCBvbmx5IG1ha2VzIHNlbnNlIG9uIHNlbnNpYmxlIGh3IChub3QgY3VycmVudCB4
ODYpLiBTbwppbiB0aGUgbWluZCBvZiBldmVyeWJvZHksIHg4NiBzaG91bGQgYmUgb3V0IG9mIHNj
b3BlIGZvciB0aGUgYW5hbHlzaXMKb2Ygc3VzcGVuZCBibG9ja2Vycy4KCkFyZSB5b3Ugc2VyaW91
c2x5IHN1Z2dlc3RpbmcgdGhhdCBvbmUgb2YgdGhlIHN0cm9uZyBhcmd1bWVudHMgaW4gZmF2b3IK
b2Ygc3VzcGVuZCBibG9ja2VycyBpcyB4ODYgdXNhZ2UgKG5vYm9keSBhZ3JlZXMpPyBJZiBub3Qs
IHRoZW4gZHJvcAppdC4KCj4+PiBVbnJlbGF0ZWQgdG8KPj4+IEFuZHJvaWQsIEkgYWxzbyB3YW50
IHRvIHVzZSBvcHBvcnR1bmlzdGljIHN1c3BlbmQgb24gbXkgZGVza3RvcC4KPj4KPj4gU28geW91
J3JlIGdvaW5nIHRvIHNwcmlua2xlIHRoaXMgc3VzcGVuZCBibG9ja2VyIHNoaXRlIGFsbCBvdmVy
IHJlZ3VsYXIKPj4gdXNlcnNwYWNlPwo+Cj4gSSBoYXZlIHNhaWQgc2V2ZXJhbCB0aW1lcywgdGhh
dCByZWd1bGFyIHVzZXItc3BhY2Ugd2lsbCBub3QgbmVlZCB0byBiZQo+IG1vZGlmaWVkIHRvIG1h
aW50YWluIHRoZWlyIGN1cnJlbnQgYmVoYXZpb3IuCgpJZiBJIGVuYWJsZSBzdXNwZW5kIGJsb2Nr
ZXJzIG9uIG15IGxhcHRvcCwgSSBoYXZlIHRvIG1vZGlmeSBteQp1c2VyLXNwYWNlLiBPdGhlcndp
c2UgbXkgc3lzdGVtIHdpbGwgYmVoYXZlIGhvcnJpYmx5LgoKLS0gCkZlbGlwZSBDb250cmVyYXMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0g
bWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
