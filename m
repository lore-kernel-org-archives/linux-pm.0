From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Proposal for a new algorithm for reading & writing a
 hibernation image.
Date: Sun, 30 May 2010 07:25:46 +0200
Message-ID: <20100530052546.GA25287__18655.7826390073$1275552718$gmane$org@ucw.cz>
References: <4BE7475A.8030901@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BE7475A.8030901@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> 2. Prior to writing any of the image, also set up new 4k page tables 
> such that an attempt to make a change to any of the pages we're about to 
> write to disk will result in a page fault, giving us an opportunity to 
> flag the page as needing an atomic copy later. Once this is done, write 
> protection for the page can be disabled and the write that caused the 
> fault allowed to proceed.

Tricky.

page faulting code touches memory, too...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
