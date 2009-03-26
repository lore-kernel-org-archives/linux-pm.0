From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Resume after hibernation regression in 2.6.29
Date: Thu, 26 Mar 2009 23:38:55 +0100
Message-ID: <20090326223855.GF29836__28647.5211069503$1238107275$gmane$org@elf.ucw.cz>
References: <200903261920.32173.tvrtko@ursulin.net>
	<20090326211406.GC29836@elf.ucw.cz>
	<200903262235.29576.rjw@sisk.pl>
	<200903262201.03931.tvrtko@ursulin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903262201.03931.tvrtko@ursulin.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, linux-pm@lists.linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-03-26 22:01:03, Tvrtko A. Ursulin wrote:
> On Thursday 26 March 2009 21:35:29 Rafael J. Wysocki wrote:
> > On Thursday 26 March 2009, Pavel Machek wrote:
> > > On Thu 2009-03-26 20:55:23, Tvrtko A. Ursulin wrote:
> > > > On Thursday 26 March 2009 20:18:40 Pavel Machek wrote:
> > > > > On Thu 2009-03-26 19:20:32, Tvrtko A. Ursulin wrote:
> > > > > > Hi guys,
> > > > > > I have been running custom compiled 2.6.28.7 in OpenSUSE 11.1 and
> > > > > > using hiberation/resume daily as configured by the distro.
> > > > > > Yesterday I upgraded to 2.6.29 (make oldconfig from 2.6.28.7,
> > > > > > attached) and after resume networking (at least) does not work.
> > > > > > Reboot at this point takes very long because of timeouts on CIFS
> > > > > > and whatelse.
> > > > > >
> > > > > > Below is how /var/log/messagess looks for one cycle
> > > > > > (hibernate-resume-reboot) and I am also attaching kernel config and
> > > > > > /var/log/pm-suspend.log.
> > > > > >
> > > > > > You will probably notice evil nvidia.ko in there but don't panic,
> > > > > > it all happens without it as well. Tested from runlevel 3 and by
> > > > > > running pm-hibernate. After resume from that NIC LEDs were off. I
> > > > > > tried /etc/init.d/network restart but that hung so I ^C and tried
> > > > > > rmmod forcedeth && modprobe forcedeth && ifup eth0 and after some
> > > > > > time network went live again. Haven't had time to test further
> > > > > > though, so this is all pretty rough.
> > > > >
> > > > > Ok, can you try to rmmod forcedeth before hibernation, then insmod it
> > > > > after resume?
> > > >
> > > > Sure, after insmod and /etc/init.d/network start following resume
> > > > network was fine. Guess I could kludge that sequence into pm scripts
> > > > somehow but would rather avoid that since it slows down the cycle and
> > > > would make scripts non-stock.
> > >
> > > Ok, I guess you need to talk to forcedeth maintainers then... sounds
> > > like a forcedeth problem to me.
> >
> > I have a box with forcedeth somewhere here, I should be able to check that
> > in the next few days.
> 
> Not a lot activity in forcedeth.c from 2.6.28 to 2.6.29 so I will CC two guys 
> who commited changes in that period. Ayaz, Tobias, forcedeth does not seem to 
> come up after hibernation well for me. Actual hardware is:
> 
> 00:0f.0 Ethernet controller: nVidia Corporation MCP73 Ethernet (rev a2)
> 
> Anything more I can do just shout!

Actually yes. Testing forcedeth from 2.6.28 in 2.6.29 would be nice
way to prove problem is indeed in that module.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
