From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nigel's current for-rafael queue
Date: Tue, 3 Aug 2010 08:55:43 +0200
Message-ID: <20100803065543.GF3344__26575.2612999224$1280818621$gmane$org@ucw.cz>
References: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Wed 2010-06-02 22:18:59, Nigel Cunningham wrote:
> Hi all.
> 
> Here is my current patch queue.
> 
> Taken together, the patches implement the separation of low level
> block i/o into a separate file, switch from using swap_map_pages
> to extents stores prior to the 'header' page and implement fully
> asynchronous (rather than batched I/O). I have only run it under
> VMware so far, but would estimate a doubling in speed due to the
> async i/o.

Do you have any numbers from real hw? Could similar speedup be
accomplished by just increasing the batch size?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
