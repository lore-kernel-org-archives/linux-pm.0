From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 21:34:11 +0100
Message-ID: <201001192134.11518.rjw__44574.2233460352$1263933291$gmane$org@sisk.pl>
References: <1263745267.2162.42.camel@barrios-desktop>
	<201001182206.36365.rjw@sisk.pl>
	<201001191015.00470.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001191015.00470.oliver@neukum.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 19 January 2010, Oliver Neukum wrote:
> Am Montag, 18. Januar 2010 22:06:36 schrieb Rafael J. Wysocki:
> > I was concerned about another problem, though, which is what happens if the
> > suspend process runs in parallel with a memory allocation that started earlier
> > and happens to do some I/O.  I that case the suspend process doesn't know
> > about the I/O done by the mm subsystem and may disturb it in principle.
> 
> How could this happen? Who would allocate that memory?
> Tasks won't be frozen while they are allocating memory.

The majority of kernel threads are not freezable, but I agree it's rather low
risk.

Rafael
