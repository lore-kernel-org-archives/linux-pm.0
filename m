From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Tue, 26 May 2009 23:36:45 +0200
Message-ID: <20090526213644.GA6287__24904.242429375$1243373955$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260058.54482.rjw@sisk.pl>
	<20090526091940.GA29867@elf.ucw.cz>
	<200905261307.22664.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905261307.22664.oliver@neukum.org>
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
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2009-05-26 13:07:22, Oliver Neukum wrote:
> Am Dienstag, 26. Mai 2009 11:19:40 schrieb Pavel Machek:
> 
> Hello,
> 
> > For small allocations... I still believe we should free a bit of
> > memory for s2ram so that small allocations can be done without
> > problems.
> > 									Pavel
> 
> it is essential that this work. Some subsystems, ie. USB, need to allocate
> memory to do IO. For them to work, small allocations must be possible.
> 
> Now, is this a real issue? Can most devices really save a device state?
> This capability seems to me to be limited to memory mapped IO at best.
> USB devices generally don't save and restore state but bring the device
> into the state it ought to be in, not the state it was in during resumption.

Well, you are resuming, with disk still sleeping. You still need to
submit those URBs. You have same problems as during suspend...

BTW... patch removing that small pool of memory was merged few hours
ago:

[merged] pm-suspend-do-not-shrink-memory-before-suspend.patch

I think it should be reverted.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
