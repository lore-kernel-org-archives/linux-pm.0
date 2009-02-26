From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Fri, 27 Feb 2009 07:57:29 +1100
Message-ID: <1235681849.7388.22.camel@pasglop>
References: <200902221837.49396.rjw@sisk.pl> <200902250029.16107.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<200902261050.50531.rjw@sisk.pl>
	<d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gVGh1LCAyMDA5LTAyLTI2IGF0IDEyOjM0IC0wODAwLCBBcnZlIEhqw7hubmV2w6VnIHdyb3Rl
Ogo+IFRoYXQgaXMgZW5vdWdoIGZvciBkcml2ZXJzIHRoYXQgdXNlIHdha2Vsb2NrcyB0byBhYm9y
dCBzdXNwZW5kIChpZiBJCj4gZml4IHRoZSB3YWtlbG9jayBjb2RlIHRvIG5vdCB1c2UgYSBwbGF0
Zm9ybSBkZXZpY2UgYXMgaXRzIGxhc3QgYWJvcnQKPiBwb2ludCkuIEl0IGlzIG5vdCBlbm91Z2gg
aWYgeW91IGRvbid0IGhhdmUgd2FrZWxvY2tzLCBzaW5jZSB0aGUKPiBpbnRlcnJ1cHQgY2FuIG9j
Y3VyIGFmdGVyIHN1c3BlbmRfbGF0ZSBoYXMgYmVlbiBjYWxsZWQgYW5kIHRoZSBkcml2ZXIKPiBo
YXMgbm8gd2F5IHRvIGFib3J0IHN1c3BlbmQuCj4gCkkgc3RpbGwgZG9uJ3QgcXVpdGUgc2VlIGhv
dyB5b3UgZGVhbCB3aXRoIHRoZSByYWNlIGFueXdheS4gSWUuIEV2ZW4Kd2l0aG91dCBSYWZhZWwg
cGF0Y2gsIHdoYXQgaWYgdGhlIGludGVycnVwdCBvY2N1cnMgYWZ0ZXIgeW91ciBzeXNkZXYKc3Vz
cGVuZCA/CgpJbiBnZW5lcmFsLCB1bmxlc3MgdGhleSBhcmUgbGV2ZWwgc2Vuc2l0aXZlLCB3YWtl
dXAgaW50ZXJydXB0cyB0ZW5kIHRvCmFsd2F5cyBiZSBzb21ld2hhdCByYWN5LgoKQ2hlZXJzLApC
ZW4uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBtQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1w
bQ==
