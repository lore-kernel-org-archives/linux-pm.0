From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Thu, 4 Mar 2010 21:15:48 +0100
Message-ID: <20100304201548.GA1341@elf.ucw.cz>
References: <Pine.LNX.4.44L0.1003032142580.6963-100000@netrider.rowland.org>
	<201003042026.30303.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201003042026.30303.rjw@sisk.pl>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > My thought exactly.  This is the only approach that also solves the 
> > following race:
> > 
> > 	A driver is unloaded at the same time as a suspend starts.
> > 
> > 	The writeback thread gets frozen.
> > 
> > 	Then before the rmmod thread is frozen, it calls del_gendisk.
> > 
> > Delaying things by means of a workqueue (or the equivalent) might also 
> > work, but it doesn't seem as safe.  For example, some important 
> > writebacks might end up getting delayed until too late.

Delaying writebacks during sleep should be ok... That's why we do
sync() after userspace is frozen -- nothing really important should be
waiting for writeback after that point. 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
