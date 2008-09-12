From: marty <martyleisner@yahoo.com>
Subject: Re: FW:  select with timeout across S3
Date: Fri, 12 Sep 2008 08:29:51 -0700 (PDT)
Message-ID: <739522.18279.qm__30433.0019666397$1221235235$gmane$org@web50606.mail.re2.yahoo.com>
References: <20080911092408.GA14503@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080911092408.GA14503@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>, Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I don't see a behavior change in the current kernels.

Select(2) timeouts only count the time the machine is up -- not sleeping...

I had a patch for 2.6.20 that I tried (it modified schedule_timeout) -- 
it didn't do anything useful in 2.6.27-rc5.

marty


--- On Thu, 9/11/08, Pavel Machek <pavel@suse.cz> wrote:

> From: Pavel Machek <pavel@suse.cz>
> Subject: Re: FW: [linux-pm] select with timeout across S3
> To: "Leisner, Martin" <Martin.Leisner@xerox.com>
> Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, martyleisner@yahoo.com
> Date: Thursday, September 11, 2008, 5:24 AM
> On Thu 2008-09-11 02:17:10, Leisner, Martin wrote:
> > Hi,
> > 
> > I finally got 2.6.27-rc5 running...no change in my
> test program...
> > 
> > I'm going to look at the patches we're using
> for 2.4.20/2.6.20...
> 
> So the bug is still there, or did 2.6.27-rc5 magically
> solve the problem?
> 
> > marty
> > 
> > 
> > -----Original Message-----
> > From: Pavel Machek [mailto:pavel@suse.cz]
> > Sent: Mon 9/1/2008 2:25 AM
> > To: Leisner, Martin
> > Cc: linux-kernel@vger.kernel.org;
> linux-pm@lists.linux-foundation.org
> > Subject: Re: FW: [linux-pm] select with timeout across
> S3
> >  
> > Hi!
> > 
> > > The behavior of linux (in both 2.4.x and 2.6.x)
> is when the processor
> > > sleeps, timeouts on select don't take into
> account the sleep time,
> > > only the run time.
> > > 
> > > For example, this program should pause for 10
> minutes -- however
> > > if we go into S3 in the middle its pausing for
> (10 minutes + time in
> > > S3)
> > > 
> > > I saw this on both 2.6.20 and 2.6.22...
> > 
> > Can you test this on 2.6.27-rc? We did have some fixes
> in that
> > area....
> > 
> > 							Pavel
> > 
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


      
