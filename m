From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BRFC_09/15=5D_PM_/_Hibernate=3A_user?=
 =?iso-8859-1?q?=2C_=09implement_user=5Fops_writer?=
Date: Mon, 5 Apr 2010 01:13:56 +0200
Message-ID: <201004050113.56521.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003312336.50620.rjw@sisk.pl> <4BB91BEC.6030906@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB91BEC.6030906@crca.org.au>
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
Cc: linux-pm@lists.linux-foundation.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday 05 April 2010, Nigel Cunningham wrote:
> Hi again.
> 
> On 01/04/10 08:36, Rafael J. Wysocki wrote:
> >>>> Regarding using LRU pages as temporary storage, if it wasn't safe and
> >>>> reliable, I would have stopped doing it ages ago.
> >>>
> >>> We've been through that already and as you can see I'm still not convinced.
> >>> Sorry, but that's how it goes.  The fact that ToI uses this approach without
> >>> seeing any major breakage is a good indication that it _may_ be safe in
> >>> general, not that it _is_ safe in all cases one can imagine.
> >>
> >> It's not "any major breakage", but no breakage at all over a course of
> >> about 6 or 7 years of usage. I agree that it's not mathematical proof,
> >> but still...
> >
> > I'd say without any reported breakage you could blame on the usage of LRU
> > pages.  But I think even if such things were reported, it wouldn't be really
> > straightforward to track them down to the LRU, because they wouldn't be
> > reproducible.
> 
> That depends on the cause. There are only so many things that can change 
> the contents of the LRU. Freezing tasks significantly reduces that 
> number, and with memory allocation tracking, it shouldn't be that hard 
> to figure out what caused the issue - especially when we find the 
> problem while atomic and can therefore dump etc data structures without 
> worrying about locking. Ugly, yes. But it would reliably find the cause.

Possibly.

However, I think we can also do something different.  Namely, add a mechanism
tracking modifications of the LRU pages like copy-on-write.  We can safely
assume that the number of LRU pages modified during hibernation will be very
limited, so it should be possible to keep some spare pages for saving them
if need be and use the following high-level hibernation algorithm:
- freeze tasks
- make room for atomic copying of non-LRU memory
- freeze devices
- create the copy of non-LRU memory, start monitoring LRU
- thaw devices
- save the copy of non-LRU memory and the contents of LRU pages
  to the storage; if an LRU page is modified in the process, copy its contents
  to a spare page (before the modification) and save it later (that can be done
  using pages previously used to store the copy of non-LRU memory that have
  been already saved)

That sounds pretty straightforward to me and doesn't seem to depend on
assumptions that would be difficult to verify.

> >>> Besides, that would be a constraint on the future changes of the mm subsystem
> >>> that I'm not sure we should introduce.  At least the mm people would need to
> >>> accept that and there's a long way before we're even able to ask them.
> >>
> >> It doesn't need to be that way. As with KMS, a simple way of flagging
> >> which pages need to be atomically copied is all that's necessary.
> >
> > I'm not sure about that.
> >
> > Besides, assuming that the LRU pages are really safe, I'd prefer to save them
> > directly as a part of the image along with the atomic copy instead of using
> > them as temporary storage.
> 
> We're obviously not going to agree on this. Can we nevertheless find a 
> way ahead in which we're both happy?

I believe so.

> Seek to minimise the differences, even if some of the TuxOnIce code isn't
> merged?

Sure.

Thanks,
Rafael
