From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Mon, 9 Feb 2009 07:43:11 -0800 (PST)
Message-ID: <432089.67665.qm@web36807.mail.mud.yahoo.com>
References: <200902080041.49657.rjw@sisk.pl>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902080041.49657.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi!
 
> > Thanks a lot for the tip, indeed it makes hibernation
> > working again:
> > 
> > root@localhost:~# echo shutdown > /sys/power/disk
> > root@localhost:~# pm-hibernate
> > 
> > Great! Is there a way to make this default on my
> > system, e.g., with a quirk?
> 
> Well, put 'echo shutdown > /sys/power/disk' into
> your init scripts?

I meant could there be a way to do this with, e.g., an in-kernel or hal quirk so that those other Acer 1690 users who are not aware of the fix would also benefit from it?

Regardless, this works for me now, so I'm happy, thanks a lot for your help!

Cheers!


      
