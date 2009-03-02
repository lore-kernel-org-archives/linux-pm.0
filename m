From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/4] PM: Rework handling of interrupts
 during suspend-resume (rev. 4)
Date: Mon, 2 Mar 2009 15:35:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021533130.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903012324.39327.rjw@sisk.pl>
	<d6200be20903021501x4ad710fbr834b11b8a6647d2c@mail.gmail.com>
	<200903030013.02805.rjw@sisk.pl>
	<d6200be20903021518r48fe6fb2vd07e9dedc4f5ff44@mail.gmail.com>
	<alpine.LFD.2.00.0903021530200.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903021530200.3111@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 2 Mar 2009, Linus Torvalds wrote:
> 
> If IRQ_SUSPENDED _is_ set, then that means that we're after the 
> suspend_late() sequence and before the resume_early() sequence

Sorry, after the suspend, and before the resume.

We could be _in_ the suspend_late/resume_early sequence, but a driver that 
were to try to play with interrupts at that stage would be broken. It 
can't very well do a enable_irq(), because that would be a MAJOR BUG - it 
would make the whole irq suspend thing pointless, since now interrupts 
would start to happen exactly where they must not happen!

			Linus
