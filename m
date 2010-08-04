From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 2.6.35 Regression: Ages spent discarding blocks that
 weren't used!
Date: Wed, 04 Aug 2010 08:44:32 -0400
Message-ID: <4C5960B0.7020003__4365.37039136073$1280956743$gmane$org@teksavvy.com>
References: <4C58C528.4000606@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C58C528.4000606@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Looks to me like more and more things are using the block discard
functionality, and as predicted it is slowing things down enormously.

The problem is that we still only discard tiny bits (a single range still??)
per TRIM command, rather than batching larger ranges and larger numbers
of ranges into single TRIM commands.

That's a very poor implementation, especially when things start enabling
it by default.  Eg. the swap code, mke2fs, etc..

Ugh.
