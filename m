From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 26 May 2012 22:27:47 +0200
Message-ID: <201205262227.47442.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<1338005001.13348.279.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1338005001.13348.279.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 26, 2012, Steven Rostedt wrote:
> On Fri, 2012-05-25 at 22:01 -0400, Alan Stern wrote:
> > Steve and Andrey:
> > 
> > It turns out that the proposed solution for your problem causes a
> > regression on other ASUS computers (see Bugzilla 43278).  Rafael's got a
> > proposal for a replacement.
> > 
> > Can you try out the patch attached to comment #61 of Bugzilla 42728?  It
> > may even allow USB wakeup to work for you (but I wouldn't count on it!).
> > Thanks.
> 
> I added the patch against 3.4 and my laptop still suspends.
> 
> And no, wakeup still doesn't work.
> 
> Tested-by: Steven Rostedt <rostedt@goodmis.org>

Thanks!

Unfortunately, I have no idea what to do to make wakeup work on the
affected machines.

Rafael
