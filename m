From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 10:11:39 +0100
Message-ID: <20090130091139.GB7967@atrey.karlin.mff.cuni.cz>
References: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<Pine.LNX.4.44L0.0901292203470.4063-100000@netrider.rowland.org>
	<d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> >> - The user-space input-event thread returns from read. It determines that the
> >>   key should not wake up the system, releases the process-input-events
> >>   wakelock and calls select or poll.
> >
> > This makes no sense.  If the system wasn't asleep to begin with, how
> > could the key wake it up?  And if the system _was_ asleep to begin
> > with, how could all of this happen without waking the system up?
> 
> What I mean here is that the screen turns on and the system does not
> immediately go back to sleep. The user-space framework has its own
> idea of whether the system is awake or not. I can change this to
> "fully wake up" or "turn on the screen".

"turn on the screen", please. (But I still don't quite get it; screen
should be at full control of userspace, so why is kernel interaction needed?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
