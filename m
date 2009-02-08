From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?Acer_Aspire_1690_Suspend/Hibernate_Repo?=
 =?iso-8859-1?q?rt_with=092=2E6=2E29-rc3?=
Date: Sun, 8 Feb 2009 14:25:23 +0100
Message-ID: <200902081425.23579.rjw@sisk.pl>
References: <20090207092111.GF1411@ucw.cz>
	<449895.60011.qm@web36806.mail.mud.yahoo.com>
	<20090208103230.GB14143@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090208103230.GB14143@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Pavel Machek wrote:
> On Sat 2009-02-07 14:24:17, Daniel Qarras wrote:
> > Hi!
> > 
> > > > Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3
> > > > suspend/hibernate behave in this manner:
> > > > 
> > > > Hibernation completes ok but resumes immediately as if
> > > > I would have pressed the power button.
> > 
> > Thanks a lot for the tip, indeed it makes hibernation working again:
> > 
> > root@localhost:~# echo shutdown > /sys/power/disk
> > root@localhost:~# pm-hibernate
> > 
> > Great! Is there a way to make this default on my system, e.g., with a quirk?
> 
> Well, it would be better to fix it properly, than just work around it
> with quirk. I think it worked before and you already identified commit
> that breaks it?

That was the patch that made hibernation use ACPI to enter S4.  IOW, the thing
has never worked on this machine.

Thanks,
Rafael
