From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [TuxOnIce-devel] [PATCH] Hibernate: Implement
 readahead when resuming
Date: Tue, 28 Sep 2010 21:09:08 +1000
Message-ID: <1285672148.2606.11.camel__17802.2131244235$1285672249$gmane$org@shrek.rexursive.com>
References: <1285416056-9735-1-git-send-email-nigel@tuxonice.net>
	<4C9E79BD.4030003@tuxonice.net>
	<201009281006.49727.Martin@lichtvoll.de>
	(sfid-20100928_101216_879880_B5940F00)
	<201009281156.51365.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009281156.51365.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-09-28 at 11:56 +0200, Martin Steigerwald wrote:
> So in-kernel-suspend actually seems to write faster, but TuxOnIce had
> lzo compressor active. 

If you used recent versions of Rafael's tree, this will have LZO as
well. Just look at kernel/power/swap.c. If it has lzo.h there, it's
being used (unless you told it not to).

-- 
Bojan
