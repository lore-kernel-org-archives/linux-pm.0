From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: Hibernation breaks between 2.6.23 and 2.6.24 on Acer
	Aspire 1690
Date: Tue, 6 Jan 2009 12:27:51 -0800 (PST)
Message-ID: <821729.77658.qm@web36806.mail.mud.yahoo.com>
References: <200901052053.22599.rjw@sisk.pl>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901052053.22599.rjw@sisk.pl>
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

Hi!
 
> > I've got Fedora 10 on Acer Aspire 1690 (1692 WLMi
> > to be exact) and some time ago I noticed that pm-hibernate
> > has the following problem:
> > 
> > pm-hibernate runs ok and cleanly shuts down the
> > machine but at the very moment it is supposed to be
> > hibernated it wakes up and resumes as if I had pressed the
> > power button.
> > 
> > I compiled few kernel.org kernels and noticed this
> > starts to occur between 2.6.23 and 2.6.24. 2.6.23 and all
> > older versions work, 2.6.24 and newer versions fail, including
> > 2.6.28.
> 
> Unfortunately, that's quite a few kernel versions back.
>  I'm afraid we won't be
> able to resolve this without knowing which patch broke it
> for you.

I've now bisected this to this commit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9cd9a0058dd35268b24fa16795a92c800f4086d4

If I revert that from 2.6.24 hibernation also works with it. With 2.6.28 the patch does not cleanly apply so I didn't test it.

I am able and willing to test any patches you might cook up.

Thanks!




      
