From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrinking memory for suspend?
Date: Thu, 3 May 2007 18:39:32 +0200
Message-ID: <200705031839.32952.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705031031500.3548-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705031031500.3548-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 16:34, Alan Stern wrote:
> On Thu, 3 May 2007, Rafael J. Wysocki wrote:
> 
> > On Thursday, 3 May 2007 12:34, Paul Mackerras wrote:
> > > Rafael J. Wysocki writes:
> > > 
> > > > I think that on a uniprocessor system it's quite safe, but on SMP it doesn't
> > > > seem so.  For example, imagine the situation in which one CPU is executing the
> > > > suspend code while another one is running userspace with system calls etc.
> > > > Pretty scary.
> > > 
> > > Which is why the powermac/powerbook sleep code insists on there only
> > > being one cpu active.  I have an SMP powermac which can sleep; I use a
> > > little script to take the second cpu down before sleeping and bring it
> > > back up after waking up.
> > 
> > That's quite intrusive.  Ideally, user space processes should not notice that
> > there have been a suspend at one point.
> 
> What happens without preemption enabled when a device driver's suspend() 
> method calls schedule()?
> 
> With or without preemption enabled, what happens when a user process tries
> to do I/O to a suspended device?

Yeah, right.  So much for the unforzen user space during a suspend. :-)

Greetings,
Rafael
