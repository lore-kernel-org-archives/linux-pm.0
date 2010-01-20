From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Wed, 20 Jan 2010 22:13:23 +0100
Message-ID: <201001202213.23373.rjw__37442.0365355492$1264022116$gmane$org@sisk.pl>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001192137.35232.rjw@sisk.pl>
	<201001201505.41167.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001201505.41167.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 January 2010, Oliver Neukum wrote:
> Am Dienstag, 19. Januar 2010 21:37:35 schrieb Rafael J. Wysocki:
> > That said, Maxim reported that in his test case the mm subsystem apparently
> > attempted to use I/O even if there was a plenty of free memory available and
> > I'd like prevent that from happening.
> 
> Hi,
> 
> it seems to me that this is caused by the mm subsytem maintaing
> a share of clean pages precisely so that GFP_NOIO will work.
> Perhaps it is a good idea to
> a) launder a number of pages if the system is about to be suspended
> between the freezer and notifying drivers

That was tried, didn't work.

> b) set the ration of clean pages to dirty pages to 0 while suspending
> the system.

Patch, please?

Rafael
