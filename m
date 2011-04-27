From: Stanislav Brabec <utx@penguin.cz>
Subject: Re: [RFC PATCH v2 1/3] PM / Core: suspend_again callback
 for device PM.
Date: Wed, 27 Apr 2011 11:46:43 +0200
Message-ID: <1303897603.4431.16.camel__18878.7943603986$1303915568$gmane$org@oct.suse.cz>
References: <1303288106-2965-1-git-send-email-myungjoo.ham@samsung.com>
	<20110426210627.GA28033@elf.ucw.cz> <201104262346.58046.rjw@sisk.pl>
	<201104270032.42046.rjw@sisk.pl>
	<BANLkTi=QDjBtY2WypXjYzyAOUGYjf_oRvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=QDjBtY2WypXjYzyAOUGYjf_oRvw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: zaurus-devel@www.linuxtogo.org, arminlitzel@web.de, thommycheck@gmail.com, Marek Vasut <marek.vasut@gmail.com>, dbaryshkov@gmail.com, lenz@cs.wisc.edu, linux-pm@lists.linux-foundation.org, omegamoon@gmail.com, Len Brown <len.brown@intel.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, eric.y.miao@gmail.com, Cyril Hrubis <metan@ucw.cz>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, kyungmin.park@samsung.com, "Jean Delvare (PC drivers core)" <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

TXl1bmdKb28gSGFtIHdyb3RlOgoKPiBBcyBsb25nIGFzIHN5c2RldnMgYXJlIHJlc3VtZWQgYW5k
IHNvbWUgZGV2aWNlcy9zdWJzeXN0ZW1zIChJMkMtUE1JQywKPiBBREMsIGFuZCBSVEMgaW4gbXkg
Y2FzZXMpIGNhbiBiZSBzZWxlY3RpdmVseSByZXN1bWVkIGFuZCBzdXNwZW5kZWQsIGl0Cj4gaXMg
ZmluZS4KPiBUaHVzLCB5b3VyICJhbHRlcm5hdGl2ZSIgc3VnZ2VzdGlvbiBpcyBwZXJmZWN0IHdp
dGggbWUuIEFjdHVhbGx5LCB0aGlzCj4gaXMgYWxtb3N0IGdvaW5nIGJhY2sgdG8gdGhlIG9yaWdp
bmFsIGhhY2suID0pCj4gCj4gSSdsbCBzdWJtaXQgbmV4dCByZXZpc2lvbiB3aXRoIHBsYXRmb3Jt
X3N1c3BlbmRfb3BzIGxhdGVyLgoKRG9lcyBrZXJuZWwgaGF2ZSBzb21ldGhpbmcgbGlrZSAic2xl
ZXB5IHRhc2siIGludGVyZmFjZSwgZS4gZy4gc3BlY2lhbAptb2RlIHRoYXQgaXMgdHJpZ2dlcmVk
IGJ5IHNvbWUgc29ydCBvZiBpbnRlcnJ1cHQgYW5kIGluc3RlYWQgb2YgZ29pbmcgdG8KcGVyZm9y
bSBmdWxsIHJlc3VtZSwgaXQganVzdCBsZXRzIGEgaG9vayB0byB3YWtlIHVwICJtYW51YWxseSIg
bmVlZGVkCmRldmljZXMsIHBlcmZvcm0gdGhlICJzbGVlcHkgdGFzayIgYW5kIHRoZW4gdGVsbCB0
aGUgc3lzdGVtIHdoZXRoZXIgZnVsbApyZXN1bWUgaXMgcmVxdWVzdGVkPwoKSXQgY2FuIGZpdCBm
b3IgWmF1cnVzIGJhdHRlcnkgY2hhcmdpbmcgbW9uaXRvcmluZyAtIHRpbWVyIGludGVycnVwdApu
ZWVkcyB0byB3YWtlIGp1c3QgdGhlIFNQSSBidXMuCgpCdXQgSSBjYW4gaW1hZ2luZSBhIEdQUyBs
b2dnZXIgdXNpbmcgc3VjaCBpbnRlcmZhY2UgdG8gc2F2ZSBlbmVyZ3kgLQpzZXJpYWwgaW50ZXJy
dXB0IHNlbWktd2FrZXMgdGhlIHN5c3RlbSBlYWNoIHNlY29uZCwgYnV0IHdpbGwgbm90IGdvIHRv
CmRvIGZ1bGwgcmVzdW1lLiBJdCBqdXN0IHByb2Nlc3NlcyBOTUVBIHNlbnRlbmNlIGFuZCBidWZm
ZXJzIHRoZSByZXN1bHQuCk9ubHkgaWYgYnVmZmVyIGJlY29tZXMgZnVsbCwgaXQgaXNzdWVzIGZ1
bGwgcmVzdW1lIGFuZCB3cml0ZXMgZGF0YQpzb21ld2hlcmUuCgotLSAKQmVzdCBSZWdhcmRzIC8g
UyBwb3pkcmF2ZW0sCgpTdGFuaXNsYXYgQnJhYmVjCnNvZnR3YXJlIGRldmVsb3BlcgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KU1VTRSBMSU5VWCwgcy4gci4gby4gICAgICAgICAgICAgICAgICAgICAgICAgIGUtbWFp
bDogc2JyYWJlY0BzdXNlLmN6CkxpaG92YXJza8OhIDEwNjAvMTIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGVsOiArNDkgOTExIDc0MDUzODQ1NDcKMTkwIDAwIFByYWhhIDkgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZmF4OiArNDIwIDI4NCAwMjggOTUxCkN6ZWNoIFJlcHVi
bGljICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHR0cDovL3d3dy5zdXNlLmN6
LwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
cG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
