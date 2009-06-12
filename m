From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 05/38] s390: hibernation support for s390
Date: Fri, 12 Jun 2009 08:37:44 +0200
Message-ID: <20090612083744.3d0d3fa4__5639.3550280065$1244788739$gmane$org@skybase>
References: <20090604161847.513682672@de.ibm.com>
	<20090604161900.659762303@de.ibm.com>
	<20090608064451.GD1444@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608064451.GD1444@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Hans-Joachim Picht <hans@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 8 Jun 2009 08:44:51 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2009-06-04 18:18:52, Martin Schwidefsky wrote:
> > From: Hans-Joachim Picht <hans@linux.vnet.ibm.com>
> > 
> > This patch introduces the hibernation backend support to the 
> > s390 architecture. Now it is possible to suspend a mainframe Linux 
> > guest using the following command:
> > 
> > echo disk > /sys/power/state
> 
> Should this one be last in series?
> 
> Otherwise no obvious problems...

Ok, I will move the base patch to the end of the patch queue.
Thanks for the review.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
