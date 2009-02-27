From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 27 Feb 2009 14:18:07 +0100
Message-ID: <20090227131807.GA1482@ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131155.07530.u.luckas@road.de>
	<20090213140654.GC26549@srcf.ucam.org>
	<200902131749.57728.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902131749.57728.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-02-13 17:49:57, Uli Luckas wrote:
> On Friday, 13. February 2009, Matthew Garrett wrote:
> > Userland ABI would then be a single /dev/inhibit_suspend,
> > with the counter being bumped each time an application opens it. It'll
> > automatically be dropped if the application exits without cleaning up.
> >
> > This seems simpler and also avoids any arguments about the naming
> > scheme. What am I missing?
> Opening and closing an fd sounds like a lot of overhead. Taking and releasing 
> locks if going to be a called with very highg frequency. I'd go for an ioctl.

Ehm?

And introduce nasty interface, and probably slower too since open() is
time-critical and ioctl() is not? Or do you have benchmarks?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
