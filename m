From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report
	with	2.6.29-rc3
Date: Sun, 8 Feb 2009 11:32:30 +0100
Message-ID: <20090208103230.GB14143@elf.ucw.cz>
References: <20090207092111.GF1411@ucw.cz>
	<449895.60011.qm@web36806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <449895.60011.qm@web36806.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Qarras <dqarras@yahoo.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat 2009-02-07 14:24:17, Daniel Qarras wrote:
> Hi!
> 
> > > Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3
> > > suspend/hibernate behave in this manner:
> > > 
> > > Hibernation completes ok but resumes immediately as if
> > > I would have pressed the power button.
> 
> Thanks a lot for the tip, indeed it makes hibernation working again:
> 
> root@localhost:~# echo shutdown > /sys/power/disk
> root@localhost:~# pm-hibernate
> 
> Great! Is there a way to make this default on my system, e.g., with a quirk?

Well, it would be better to fix it properly, than just work around it
with quirk. I think it worked before and you already identified commit
that breaks it?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
