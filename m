From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 7/9] PM: Add suspend blocking work.
Date: Fri, 23 Apr 2010 10:16:46 +0200
Message-ID: <4BD1576E.5070401__12475.2812007957$1272010755$gmane$org@kernel.org>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<1271984938-13920-7-git-send-email-arve@android.com>
	<1271984938-13920-8-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1271984938-13920-8-git-send-email-arve@android.com>
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
Cc: Dmitri Vorobiev <dmitri.vorobiev@movial.com>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

SGVsbG8sCgpPbiAwNC8yMy8yMDEwIDAzOjA4IEFNLCBBcnZlIEhqw7hubmV2w6VnIHdyb3RlOgo+
IEFsbG93IHdvcmsgdG8gYmUgcXVldWVkIHRoYXQgd2lsbCBibG9jayBzdXNwZW5kIHdoaWxlIGl0
IGlzIHBlbmRpbmcKPiBvciBleGVjdXRpbmcuIFRvIGdldCB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5
IGluIHRoZSBjYWxsaW5nIGNvZGUgb2Z0ZW4KPiByZXF1aXJlcyBhIHNlcGFyYXRlIHN1c3BlbmRf
YmxvY2tlciBmb3IgcGVuZGluZyBhbmQgZXhlY3V0aW5nIHdvcmssIG9yCj4gYWRkaXRpb25hbCBz
dGF0ZSBhbmQgbG9ja2luZy4KCkhtbS4uLiBJIHRoaW5rIHRoaXMgY2FuIGJlIGltcGxlbWVudGVk
IGFzIHB1cmUgd3JhcHBlciBhcm91bmQKd29ya3F1ZXVlIGluc3RlYWQgb2YgaW5qZWN0aW5nIGEg
ZmxhZyBhbmQgY29kZSBpbnRvIHdvcmtxdWV1ZSBjb3JlLgpBZGRpbmcgQGZuIGZpZWxkIHRvIHN1
c3BlbmRfYmxvY2tpbmdfd29yayBzdHJ1Y3QgYW5kIHVzaW5nIGEgY3VzdG9tCndvcmsgZnVuY3Rp
b24gdG8gY2FsbCBpdCBhbmQgdGhlbiBpbnZva2Ugc3VzcGVuZF91bmJsb2NrKCkgc2hvdWxkIGJl
CmVub3VnaCwgcmlnaHQ/ICBPaCwgZGVkaWNhdGVkIHF1ZXVlIGZ1bmN0aW9ucyB3aWxsIGJlIG5l
ZWRlZCB0b28uICBJCmRvbid0IHRoaW5rIGl0J3Mgd2lzZSB0byBtZWRkbGUgd2l0aCB3b3JrcXVl
dWUgY29yZSBjb2RlIGZvciB0aGlzLgoKVGhhbmtzLgoKLS0gCnRlanVuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlzdAps
aW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
