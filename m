From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Wed, 7 Jan 2009 11:44:53 +0100
Message-ID: <200901071144.53582.rjw@sisk.pl>
References: <999617.71355.qm@web36808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <999617.71355.qm@web36808.mail.mud.yahoo.com>
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
To: dqarras@yahoo.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 06 January 2009, Daniel Qarras wrote:
> Hi!
>  
> > > I've now bisected this to this commit:
> > >
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9cd9a0058dd35268b24fa16795a92c800f4086d4
> > 
> > Have you tried with acpi_sleep=old_ordering in the
> > kernel's command line?
> 
> I hadn't done that yet, never heard about such parameter. Well, tested with Fedora 10 kernel and 2.6.28, it does not fix the issue.

Thanks for verification.

Apparently, one of devices is set up to wake up the system and it does that
right after it's been put to sleep.  I don't think it's a PCI device, because
2.6.28 prevents PCI devices from doing this, unless they are intentionally
set up for system wake-up.

Can you send me the output of /proc/acpi/wakeup, please?

Rafael
