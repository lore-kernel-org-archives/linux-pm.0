From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Fri, 08 May 2009 06:41:00 +1000
Message-ID: <1241728860.19600.207.camel__24961.2671359957$1241729087$gmane$org@nigel-laptop>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905072022.15202.rjw@sisk.pl>
	<b637ec0b0905071157x2d6f050aqcb825241c51ccb84@mail.gmail.com>
	<200905072127.11995.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072127.11995.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Fabio Comolli <fabio.comolli@gmail.com>, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2009-05-07 at 21:27 +0200, Rafael J. Wysocki wrote:
> In fact I agree, but there's a catch.  The way in which TuxOnIce operates LRU
> pages is based on some assumptions that may or may not be satisfied in future,
> so if we decide to merge it, then we'll have to make sure these assumptions
> will be satisfied.  That in turn is going to require quite some discussion I
> guess.

Agreed. That's why I've got that GEMS patch - it's putting pages on the
LRU that don't satisfy the former assumptions: they are used during
hibernating and need to be atomically copied. If there are further
developments in that area, I would hope we could just extend what's been
done with GEMS.

Regards,

Nigel
