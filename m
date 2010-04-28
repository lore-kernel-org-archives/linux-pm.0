From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Wed, 28 Apr 2010 22:58:51 +0200
Message-ID: <201004282258.51354.rjw__4053.63621325723$1272488376$gmane$org@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1272429119-12103-3-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?utf-8?q?Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

T24gV2VkbmVzZGF5IDI4IEFwcmlsIDIwMTAsIEFydmUgSGrDuG5uZXbDpWcgd3JvdGU6Cj4gQWRk
IGEgbWlzYyBkZXZpY2UsICJzdXNwZW5kX2Jsb2NrZXIiLCB0aGF0IGFsbG93cyB1c2VyLXNwYWNl
IHByb2Nlc3Nlcwo+IHRvIGJsb2NrIGF1dG8gc3VzcGVuZC4gVGhlIGRldmljZSBoYXMgaW9jdGxz
IHRvIGNyZWF0ZSBhIHN1c3BlbmRfYmxvY2tlciwKPiBhbmQgdG8gYmxvY2sgYW5kIHVuYmxvY2sg
c3VzcGVuZC4gVG8gZGVsZXRlIHRoZSBzdXNwZW5kX2Jsb2NrZXIsIGNsb3NlCj4gdGhlIGRldmlj
ZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBBcnZlIEhqw7hubmV2w6VnIDxhcnZlQGFuZHJvaWQuY29t
PgouLi4KPiArCj4gKyNpbmNsdWRlIDxsaW51eC9mcy5oPgo+ICsjaW5jbHVkZSA8bGludXgvbWlz
Y2RldmljZS5oPgo+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4gKyNpbmNsdWRlIDxsaW51
eC91YWNjZXNzLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4gKyNpbmNsdWRlIDxsaW51
eC9zdXNwZW5kX2Jsb2NrZXIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3N1c3BlbmRfYmxvY2tfZGV2
Lmg+Cj4gKwo+ICtlbnVtIHsKPiArCURFQlVHX0ZBSUxVUkUJPSBCSVQoMCksCj4gK307Cj4gK3N0
YXRpYyBpbnQgZGVidWdfbWFzayA9IERFQlVHX0ZBSUxVUkU7CgpXaGF0J3MgdGhlIGV4YWN0IHB1
cnBvc2Ugb2YgdGhpcz8KCj4gK21vZHVsZV9wYXJhbV9uYW1lZChkZWJ1Z19tYXNrLCBkZWJ1Z19t
YXNrLCBpbnQsIFNfSVJVR08gfCBTX0lXVVNSIHwgU19JV0dSUCk7Cj4gKwo+ICtzdGF0aWMgREVG
SU5FX01VVEVYKGlvY3RsX2xvY2spOwo+ICsKPiArc3RydWN0IHVzZXJfc3VzcGVuZF9ibG9ja2Vy
IHsKPiArCXN0cnVjdCBzdXNwZW5kX2Jsb2NrZXIJYmxvY2tlcjsKPiArCWNoYXIJCQluYW1lWzBd
Owo+ICt9OwoKV2h5IGlzIHRoaXMgbm90IGluIGEgaGVhZGVyPwoKUmFmYWVsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXBtIG1haWxpbmcgbGlz
dApsaW51eC1wbUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcG0=
