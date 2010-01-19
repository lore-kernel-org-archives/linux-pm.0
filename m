From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 10:15:00 +0100
Message-ID: <201001191015.00470.oliver__18901.4627635062$1263892601$gmane$org@neukum.org>
References: <1263745267.2162.42.camel@barrios-desktop>
	<20100118111703.AE36.A69D9226@jp.fujitsu.com>
	<201001182206.36365.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001182206.36365.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 18. Januar 2010 22:06:36 schrieb Rafael J. Wysocki:
> I was concerned about another problem, though, which is what happens if the
> suspend process runs in parallel with a memory allocation that started earlier
> and happens to do some I/O.  I that case the suspend process doesn't know
> about the I/O done by the mm subsystem and may disturb it in principle.

How could this happen? Who would allocate that memory?
Tasks won't be frozen while they are allocating memory.

	Regards
		Oliver
