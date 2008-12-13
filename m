From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Bugs on aspire one A150
Date: Sat, 13 Dec 2008 15:15:38 +0200
Message-ID: <1229174138.24940.9.camel__19705.5588862442$1229174307$gmane$org@maxim-laptop>
References: <491506DB.1070000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <491506DB.1070000@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, alsa-devel@alsa-project.org, ath5k-devel@venema.h4ckr.net
List-Id: linux-pm@vger.kernel.org


So, big thanks for everything.

Now aspire one linux support is very close to perfect,
(only problem left is that wireless is limited to 18Mbits/s raw rate,
but at some point I or developers of ath5k will get to the bottom of
this)

I also noticed, that now the SD only card reader is always enabled
regardless of card been there while booting, and same happens in
windows, I suspect that this is permanent hardware change, which worries
me, but this reader works fine otherwise.
(This is another reason why binary bioses are evil, go and find out why
it enables it)


Also forgot to mention that both readers ignore write protect tab on SD
card, and I will report this to correct mailing list soon.
Everything else works fine

please include acpiphp fix in 2.6.28.
Also I applied patch to coretemp to make it show cpu temperature.

Thanks again,
	Maxim Levitsky
