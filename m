From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 21:46:15 +0100
Message-ID: <20090227204615.GC1387__18343.4736718938$1235767732$gmane$org@ucw.cz>
References: <200902191356.53584.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
	<20090222140311.GF1387@ucw.cz>
	<200902231504.27879.oliver@neukum.org>
	<20090227101818.GH4582@elf.ucw.cz> <49A81E59.6010105@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49A81E59.6010105@nortel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Chris Friesen <cfriesen@nortel.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2009-02-27 11:09:45, Chris Friesen wrote:
> Pavel Machek wrote:
>> On Mon 2009-02-23 15:04:22, Oliver Neukum wrote:
>
>>> We can just as well have a class of tasks less important than power
>>> saving. They'd just run when power saving is not active for some other
>>> reason. Just like other such schemes we end up with the problem
>>> of priority inversion with locking.
>>
>> Ok, I guess this could be interesting in some cases... maybe. What are
>> real examples of such tasks?
>
> Some people might put casual system monitoring tools into this  
> category--top, xload, gkrellm, xclock, etc.

I guess system monitoring should stop itself when screen is
blanked... no need to compute list of processes if user can't see the
output.

But I see that may be slightly hard for command-line tool like
top. .... but it still seems like right solution. Why waste power/cycles
displaying xclock at tty9 when user is looking at tty10?

> It'd be nice if the animated banner ad in my web browser could be  
> treated this way. :)

Well, my web browser already has an option 'animate once'. No need to
waste power with that at all :-).
							Pavel 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
