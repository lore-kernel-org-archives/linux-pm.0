From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 3/9] PM: suspend_block: Abort task freezing
 if a suspend_blocker is active.
Date: Sat, 09 May 2009 10:12:23 +1000
Message-ID: <1241827943.19600.386.camel@nigel-laptop>
References: <1241583529-5092-1-git-send-email-arve@android.com>
	<200905081640.44894.rjw@sisk.pl>
	<1241821626.19600.325.camel@nigel-laptop>
	<200905090101.02390.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905090101.02390.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

On Sat, 2009-05-09 at 01:01 +0200, Rafael J. Wysocki wrote:
> On Saturday 09 May 2009, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Fri, 2009-05-08 at 16:40 +0200, Rafael J. Wysocki wrote:
> > > The timeout is actually a workaround for the problem that we don't
> > > really
> > > know if tasks are going to react to our freeze requests and how much time it is
> > > going to take.  The current value of 20 s was chosen after a number of
> > > experiments showing that in some cases the freezing _was_ going to take so
> > > much time.  Of course the question is whether it makes sense to give up earlier
> > > even if tasks would eventually freeze, but that's a different issue.
> > 
> > What were the circumstances in which freezing could take 20s?
> 
> Compiling the kernel with "make -j<big number>" on a dual core system IIRC.
> 
> Generally, the situation in which there are many runnable tasks and new tasks
> come and go etc.  I haven't repeated this benchmark recently, though, so it's
> probably worth doing again.
> 
> Which has a little to do with the $subject patch IMO, because I think that
> it's reasonable to stop freezing tasks as soon as we know that it won't be
> necessary anyway.

Yes, but it's still good to know.

Regards,

Nigel
