From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Q: x86 suspend/hibernation code consolidation
Date: Sat, 26 Jan 2008 09:42:40 +0000
Message-ID: <20080126094239.GA4096__40990.8587033444$1201340709$gmane$org@ucw.cz>
References: <200801260132.09529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200801260132.09529.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> I'd like to move the 64-bit suspend/hibernation files from arch/x86/kernel to
> arch/x86/power, modify the names of the 32-bit files already in
> arch/x86/power and update the Makefiles accordingly, but there are some changes
> queued for merging that touch the files in question.

I have similar patch producing hibernation_*.S, I can send it as a
base. Moving it soon  would be nice :-).

As I'm in process of rewriting arch/x86/kernel/acpi/ , I'd prefer that
not to be moved from under me.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
