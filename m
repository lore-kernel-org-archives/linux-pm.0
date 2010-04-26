From: tytso@mit.edu
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 20:00:25 -0400
Message-ID: <20100426000025.GE667__9224.21655054695$1272240398$gmane$org@thunk.org>
References: <1271984938-13920-1-git-send-email-arve@android.com>
	<1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<20100425181517.GA22676@kroah.com> <4BD49D9D.7020004@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BD49D9D.7020004@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 25, 2010 at 12:53:01PM -0700, Randy Dunlap wrote:
> > It's debug-like information, and has more than one value per file, so
> > debugfs seems like the proper place for it.  I have no objection to it
> > going there.
> 
> I have no objection if it really is debug info, but I'm not convinced
> of that yet.

Well, I'll note right now we have a somewhat annoying gap.  If you
need to export multiple values such that they are consistent with each
other, what's the choice?  /proc, where some (but not all) kernel
developers will say, "eeeeeeviilllll".  /sys is explicitly for single
value per files only.  And then we have /debugfs, where some pendants
are kvetching about whether something is "really" debug information.

One of the things that we sometimes have to tell people who are trying
to navigate the maze of upstream submission is that sometimes you need
to know who to ignore, and that sometimes rules are guidelines
(despite pendants who will NACK based on rules like, "/proc,
eeeeewwww", or "/debugfs must only strictly be for debug information".

Telling embedded developers who only want to submit their driver that
they must create a whole new pseudo-filesystem just to export a single
file that in older, simpler times, would have just been thrown into
/proc is really not fair, and is precisely the sort of thing that may
cause them to say, "f*ck it, these is one too many flaming hoops to
jump through".  If we throw up too many barriers, in the long run it's
not actually doing Linux a service.

Sure, we need to make sure is code doesn't become a future burden, but
does a new file in /proc or something that might not _really_ be debug
information showing up in /debugfs really such a terrible thing in
terms of making the kernel less maintainable in the future?

Regards,

						- Ted
