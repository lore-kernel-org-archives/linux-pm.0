From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI: S4 disappeared [mmotm 2009-02-10-16-35]
Date: Fri, 13 Feb 2009 10:37:49 +0100
Message-ID: <20090213093749.GA29550__16275.3883436837$1234518033$gmane$org@atrey.karlin.mff.cuni.cz>
References: <200902110036.n1B0aBZs013975@imap1.linux-foundation.org>
	<499291A3.9070501@gmail.com> <4992A59F.5090502@gmail.com>
	<200902111643.10191.rjw@sisk.pl> <20090211162247.GA32301@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090211162247.GA32301@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: mm-commits@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> ---------------->
> From 17993b49b1f540aace8e9b4242530d0b3376eb2a Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed, 11 Feb 2009 17:20:51 +0100
> Subject: [PATCH] x86: make hibernation always-possible
> 
> This commit:
> 
>   aced3ce: x86/Voyager: remove HIBERNATION Kconfig quirk
> 
> Made hibernation only available on UP - instead of making it available
> on all of x86. Fix it.
> 
> Reported-by: Jiri Slaby <jirislaby@gmail.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

ACK.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
