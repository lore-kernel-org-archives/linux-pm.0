From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Thu, 29 Jan 2009 10:13:10 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901291010110.3123@localhost.localdomain>
References: <826361.85762.qm@web36805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <826361.85762.qm@web36805.mail.mud.yahoo.com>
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



On Thu, 29 Jan 2009, Daniel Qarras wrote:
>
> Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3 suspend/hibernate behave in this manner:
> 
> Hibernation completes ok but resumes immediately as if I would have 
> pressed the power button. This was bisected earlier this month and was a 
> regression between 2.6.23 and 2.6.24 (so no change with 2.6.29-rc3):
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019225.html

Hmm. Does suspend/resume (STR) have the same issue? Or is this purely a 
hibernation thing?

> Suspend completes ok and resume works also! Only thing which might be 
> worth mentioning is that when pressing or moving USB mouse, its internal 
> led goes on and stays that way no matter how long untouched. After 
> unplugging the mouse the system also resume when plugging the mouse 
> back.

Sounds suspiciously like auto-suspend getting turned off. What's 
surprising is that it was on in the first place - I thought we defaulted 
to autosuspend off (for non-hub devices) regardless of any suspend issues.

		Linus
