From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Tue, 6 Jan 2009 22:10:45 +0100
Message-ID: <200901062210.45278.rjw@sisk.pl>
References: <821729.77658.qm@web36806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <821729.77658.qm@web36806.mail.mud.yahoo.com>
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
To: linux-pm@lists.linux-foundation.org, dqarras@yahoo.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 06 January 2009, Daniel Qarras wrote:
> Hi!
>  
> > > I've got Fedora 10 on Acer Aspire 1690 (1692 WLMi
> > > to be exact) and some time ago I noticed that pm-hibernate
> > > has the following problem:
> > > 
> > > pm-hibernate runs ok and cleanly shuts down the
> > > machine but at the very moment it is supposed to be
> > > hibernated it wakes up and resumes as if I had pressed the
> > > power button.
> > > 
> > > I compiled few kernel.org kernels and noticed this
> > > starts to occur between 2.6.23 and 2.6.24. 2.6.23 and all
> > > older versions work, 2.6.24 and newer versions fail, including
> > > 2.6.28.
> > 
> > Unfortunately, that's quite a few kernel versions back.
> >  I'm afraid we won't be
> > able to resolve this without knowing which patch broke it
> > for you.
> 
> I've now bisected this to this commit:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9cd9a0058dd35268b24fa16795a92c800f4086d4
> 
> If I revert that from 2.6.24 hibernation also works with it. With 2.6.28 the patch does not cleanly apply so I didn't test it.
> 
> I am able and willing to test any patches you might cook up.

Have you tried with acpi_sleep=old_ordering in the kernel's command line?

Rafael
