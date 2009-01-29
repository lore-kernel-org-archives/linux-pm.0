From: Daniel Qarras <dqarras@yahoo.com>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Thu, 29 Jan 2009 12:20:30 -0800 (PST)
Message-ID: <754700.49237.qm@web36801.mail.mud.yahoo.com>
References: <alpine.LFD.2.00.0901291010110.3123@localhost.localdomain>
Reply-To: dqarras@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901291010110.3123@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html
> 
> Hmm. Does suspend/resume (STR) have the same issue? Or is
> this purely a hibernation thing?

Only with hibernation, suspend stays put.

> > After unplugging the mouse the system also resume when
> > plugging the mouse back.
> 
> Sounds suspiciously like auto-suspend getting turned off.
> What's surprising is that it was on in the first place - I thought
> we defaulted to autosuspend off (for non-hub devices) regardless of
> any suspend issues.

FWIW, I have usbcore.autosuspend=1 in grub.conf...

Cheers!




      
