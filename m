From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Mon, 18 Jan 2010 01:23:48 +0900
Message-ID: <28c262361001170823s445591fao1fca4bc539a27125__48780.8922458955$1263745694$gmane$org@mail.gmail.com>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001162317.39940.rjw@sisk.pl> <201001170138.37283.rjw@sisk.pl>
	<201001171455.55909.rjw@sisk.pl>
	<1263745267.2162.42.camel@barrios-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1263745267.2162.42.camel@barrios-desktop>
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
Cc: linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> I think we can use lockdep annotation, too. but it's overkill.
> That's because suspend/resume is rare event so that I want to add

so that I don't want to add

Sorry for the typo.
-- 
Kind regards,
Minchan Kim
