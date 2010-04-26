From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 17:23:06 -0700
Message-ID: <4BD4DCEA.8060602__23848.626347217$1272241567$gmane$org@oracle.com>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<20100425181517.GA22676@kroah.com>
	<4BD49D9D.7020004@oracle.com> <20100426000025.GE667@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100426000025.GE667@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Greg KH <greg@kroah.com>, Arve Hj?nnev?g <arve@android.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 04/25/10 17:00, tytso@mit.edu wrote:
> On Sun, Apr 25, 2010 at 12:53:01PM -0700, Randy Dunlap wrote:
>>> It's debug-like information, and has more than one value per file, so
>>> debugfs seems like the proper place for it.  I have no objection to it
>>> going there.
>>
>> I have no objection if it really is debug info, but I'm not convinced
>> of that yet.
> 
> Well, I'll note right now we have a somewhat annoying gap.  If you
> need to export multiple values such that they are consistent with each
> other, what's the choice?  /proc, where some (but not all) kernel
> developers will say, "eeeeeeviilllll".  /sys is explicitly for single
> value per files only.  And then we have /debugfs, where some pendants
> are kvetching about whether something is "really" debug information.

First of all, I am not a pendant.

> One of the things that we sometimes have to tell people who are trying
> to navigate the maze of upstream submission is that sometimes you need
> to know who to ignore, and that sometimes rules are guidelines
> (despite pendants who will NACK based on rules like, "/proc,
> eeeeewwww", or "/debugfs must only strictly be for debug information".
> 
> Telling embedded developers who only want to submit their driver that
> they must create a whole new pseudo-filesystem just to export a single
> file that in older, simpler times, would have just been thrown into
> /proc is really not fair, and is precisely the sort of thing that may
> cause them to say, "f*ck it, these is one too many flaming hoops to
> jump through".  If we throw up too many barriers, in the long run it's
> not actually doing Linux a service.

Yeah, I think that it should be in procfs.  It's not strictly closed
to new files.  (IOW, I'm sure that we can find a bunch of recent files
added to procfs.)

> Sure, we need to make sure is code doesn't become a future burden, but
> does a new file in /proc or something that might not _really_ be debug
> information showing up in /debugfs really such a terrible thing in
> terms of making the kernel less maintainable in the future?

I don't think that we want to make debugfs required to get decent
tuning info/stats from the kernel.  That's all.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
