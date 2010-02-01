From: Pavel Machek <pavel@ucw.cz>
Subject: Re: syncing the disks when entering sleep
Date: Mon, 1 Feb 2010 22:09:21 +0100
Message-ID: <20100201210921.GB13638@elf.ucw.cz>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<201001272146.43660.rjw@sisk.pl> <20100131085210.GH2238@elf.ucw.cz>
	<201001311333.37620.rjw@sisk.pl>
	<20100201104922.GC5809@atrey.karlin.mff.cuni.cz>
	<76FA3B279DD9DA48896E2B404944957204F88D87@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <76FA3B279DD9DA48896E2B404944957204F88D87@USA7061MS02.na.xerox.net>
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

> So you're asking to give this knob "one shot behavior"
> (i.e. "then next sleep won't sync")?

Yes.

> But I'm primarily interested in the behavior on embedded systems (where you control all the processes running -- there's no "user" involved.
> 

Well, then "one shot behaviour" does not hurt you, right?

> If a user starts messing with default settings, any unwanted behavior is the users problem (besides, this should only be writable as root).
> 

I'd rather not add traps for the user unless absolutely
neccessary. Not even for root user.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
