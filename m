From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 02 Jun 2010 12:21:28 +0200
Message-ID: <1275474088.27810.31000.camel__27653.5896388397$1275474146$gmane$org@twins>
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
To: Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

T24gV2VkLCAyMDEwLTA2LTAyIGF0IDAzOjAwIC0wNzAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IDIwMTAvNi8yIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz46Cj4gPiBP
biBXZWQsIDIwMTAtMDYtMDIgYXQgMDE6NTQgLTA3MDAsIEFydmUgSGrDuG5uZXbDpWcgd3JvdGU6
Cj4gPj4gTm8gSSB3YW50IHlvdSB0byBzdG9wIGNvbmZ1c2luZyBsb3cgcG93ZXIgaWRsZSBtb2Rl
cyB3aXRoIHN1c3BlbmQuCj4gPgo+ID4gSSB0aGluayBpdCBpcyB5b3Ugd2hvIGlzIGNvbmZ1c2Vk
LiBGb3IgcG93ZXIgbWFuYWdlbWVudCBwdXJwb3NlcyBzdXNwZW5kCj4gPiBpcyBub3RoaW5nIG1v
cmUgYnV0IGEgZGVlcCBpZGxlIHN0YXRlLgo+IAo+IE5vLCBpZGxlIGlzIHRyYW5zcGFyZW50LCBz
dXNwZW5kIGlzIG5vdC4KCldoaWNoIGlzIHdoZXJlIHRoZSBwcm9ibGVtIGlzLCBpdCBzaG91bGQg
YmUuCgo+IFdoeSB3b3VsZCBJIGFkZCBzdXNwZW5kIGJsb2NrZXJzIHRvIHRoZSBjb2RlIEkgd2Fu
dCB0byBwcmV2ZW50IHJ1bm5pbmc/CgpCZWNhdXNlIHdoYXQgeW91IHdhbnQgbWlnaHQgbm90IGJl
IHdoYXQgb3RoZXJzIHdhbnQuIFN1cHBvc2UgeW91J3JlIGZpbmUKd2l0aCB5b3VyIHRvcnJlbnQg
Y2xpZW50L2lyYyBjbGllbnQvZXRjLi4gdG8gbG9vc2UgdGhlaXIgbmV0d29yawpjb25uZWN0aW9u
IHdoZW4geW91J3JlIG5vdCBiZWhpbmQgeW91ciBkZXNrdG9wIHNvIHlvdSBkb24ndCBhZGQgc3Vz
cGVuZApibG9ja2VycyB0aGVyZS4KCk1lLCBJJ2QgYmUgcmVhZHkgdG8gYWRtaW5pc3RlciBwaHlz
aWNhbCB2aW9sZW5jZSBpZiBlaXRoZXIgb2YgdGhvc2UgbG9zdAp0aGVpciBjb25uZWN0aW9ucyB3
aGVuIEkgd2Fzbid0IGFyb3VuZCB0byBrZWVwIHRoZSBzY3JlZW4tc2F2ZXIgZnJvbQpraWNraW5n
IGluLgoKVGhpcyBsZWFkcyB0byBoYXZpbmcgdG8gc3ByaW5rbGUgbWFnaWMgZHVzdCAoYW5kIGxv
dHMgb2YgY29uZmlnIG9wdGlvbnMpCmFsbCBvdmVyIHVzZXJzcGFjZS4gU29tZXRoaW5nIHRoYXQg
Z2V0cyBlc3AgaW50ZXJlc3Rpbmcgd2l0aCBvbmx5IGEKYm9vbGVhbiBpbnRlcmZhY2UuCgpJbiB0
aGUgZXhhbXBsZSBhYm92ZSwgaGF2aW5nIGFuIGFjdGl2ZSBuZXQgY29ubmVjdGlvbiB3b3VsZCBw
cmV2ZW50IG15CmRlc2t0b3AgZnJvbSBzdXNwZW5kaW5nLCBidXQgd2hhdCBpZiBhbm90aGVyIHBs
YXRmb3JtIGNhbiBtYWludGFpbiBuZXQKY29ubmVjdGlvbnMgd2hpbGUgc3VzcGVuZGVkPyBEbyB3
ZSB0aGVuIGVuZCB1cCB3aXRoIGFyY2ggc3BlY2lmaWMgY29kZQppbiB0aGUgbmV0LXN0YWNrPyBJ
J20gc3VyZSBEYXZlTSB3b3VsZCBsb3ZlIHRoYXQuCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
