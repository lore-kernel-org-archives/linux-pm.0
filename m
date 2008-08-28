From: Pavel Machek <pavel@suse.cz>
Subject: Re: select with timeout across S3
Date: Thu, 28 Aug 2008 16:29:37 +0200
Message-ID: <20080828142937.GB6797@ucw.cz>
References: <556445368AFA1C438794ABDA8901891C096394F1@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <556445368AFA1C438794ABDA8901891C096394F1@USA0300MS03.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2008-08-27 15:23:13, Leisner, Martin wrote:
> What's a good way to "wait" across a transition to/from processor sleep
> (acpi S3 or other means)?
> 
> 
> It seems the timeouts on select(2) only deal with with time correctly
> when the processor is awake -- when the processor is sleeping its not
> subtracted from the request...
> 
> The desirable behavior out of select would be for it to timeout whenever
> the system wakes up if the desired interval has elapsed...

That sounds like a bug. Can you write small demo program and post it
to lkml?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
