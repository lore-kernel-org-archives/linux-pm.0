From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Wed, 25 Feb 2009 20:20:35 -0800
Message-ID: <m1y6vtkewc.fsf__38093.6104724698$1235622285$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl>
	<d6200be20902251717r531c022bl4c25fcb902201188@mail.gmail.com>
	<alpine.LFD.2.00.0902251724220.3111@localhost.localdomain>
	<d6200be20902251813o3ff4a065nb0a54321e27c512d@mail.gmail.com>
	<alpine.LFD.2.00.0902251848120.3111@localhost.localdomain>
	<20090226030050.GA3361@elte.hu>
	<d6200be20902251931lf563c2aw43d5266e9677e168@mail.gmail.com>
	<alpine.LFD.2.00.0902251935190.3111@localhost.localdomain>
	<d6200be20902251950l34d5968q4b553ce8305ebd4b@mail.gmail.com>
	<alpine.LFD.2.00.0902251956450.3111@localhost.localdomain>
	<d6200be20902252013v366ce771w8a129e9f3b75927f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902252013v366ce771w8a129e9f3b75927f@mail.gmail.com>
	("Arve =?utf-8?B?SGrDuG5uZXbDpWciJ3M=?= message of "Wed\, 25 Feb 2009
	20\:13\:27 -0800")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

QXJ2ZSBIasO4bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT4gd3JpdGVzOgoKPiBXZSBvbmx5IGhh
dmUgb25lIGdwaW8gaW5wdXQgZHJpdmVyLCBidXQgSSBkb24ndCB0aGluayBpcyBnb29kIHRvIGxv
b3NlCj4gYW55IHdha2V1cCBpbnRlcnJ1cHRzLiBBbnkgZHJpdmVyIHRoYXQgbmVlZHMgYW4gZWRn
ZSB0cmlnZ2VyZWQgd2FrZXVwCj4gaW50ZXJydXB0IHdpbGwgaGF2ZSBwcm9ibGVtcyBpZiB0aGUg
aGFyZHdhcmUgZG9lcyBub3QgcmVnZW5lcmF0ZSB0aGUKPiBpbnRlcnJ1cHQgd2hlbiB0aGUgaG9z
dCBkb2VzIG5vdCByZXNwb25kLgoKV2UgYXJlIG5vdCBsb29zaW5nIGludGVycnVwdHMuICBUaGUg
bm9ybWFsIGltcGxlbWVudGF0aW9uIG9mIGRpc2FibGUKaXMgYSBzb2Z0d2FyZSBkaXNhYmxlIGFu
ZCBzZXRzIElSUV9QRU5ESU5HIHRvIGVuc3VyZSB3ZSBkb24ndCBsb29zZQppbnRlcnJ1cHRzIHdo
ZW4gdGhlIGludGVycnVwdCBpcyBkaXNhYmxlZC4KCkVyaWMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtcG0gbWFpbGluZyBsaXN0CmxpbnV4LXBt
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1wbQ==
