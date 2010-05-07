From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.33-2.6.34-rc5 suspend issues
Date: Fri, 7 May 2010 15:43:02 +0200
Message-ID: <20100507134302.GB3089@ucw.cz>
References: <20100427074609.GA3261@ikn.schottelius.org>
	<20100427083202.GA3143@ikn.schottelius.org>
	<20100428160935.GA4010@schottelius.org>
	<20100429191241.GA3407@schottelius.org>
	<20100501122441.GA3273@schottelius.org>
	<20100504041849.GA1262@ucw.cz>
	<20100504144714.GA3527@schottelius.org>
	<20100507135704.GB3455@schottelius.org>
	<20100512060843.GA20895@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100512060843.GA20895@schottelius.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nico Schottelius <nico-kernel@schottelius.org>, Nico Schottelius <nico-linux-20100427@schottelius.org>, LKML <linux-kernel@vger.kernel.org>, Linux-pm
List-Id: linux-pm@vger.kernel.org


> > > > > Same happens on 2.6.34-rc5-00340-g79dba2e, now testing
> > > > > 2.6.34-rc6-00063-gbe1066b.
> > > > 
> > > > There's one bit that needs to be set to stay in the acpi mode, and
> > > > there's blacklist somewhere...?
> > > 
> > > Don't know if I should answer the question, but the problem also happens
> > > on 2.6.34-rc6-00063-gbe1066b.
> > > 
> > > Now compiling v2.6.34-rc6-106-gd93ac51.
> > 
> > Same issue on 2.6.34-rc6-00201-g722154e.
> 
> Success, success! With 2.6.34-rc7 I can resume at least two times!
> 
> I'll keep an eye on it and notify you if things continue to work / break again.
> 

Congratulations. I have no idea what fixed it, but hopefully it will
keep working.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
