From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/6] ACPI / PM: Modify the "low-level resume
 finished" message
Date: Fri, 4 Mar 2011 16:38:07 +0100
Message-ID: <20110304153807.GE1358__33519.2486913458$1299254316$gmane$org@ucw.cz>
References: <201102072316.41270.rjw@sisk.pl> <201102072319.56040.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201102072319.56040.rjw@sisk.pl>
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
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Move the low-level resume completion message to the point where
> control goes back to acpi_suspend_enter() during resume and change
> it so that it's more informative.

Well, doing some printk as soon as reasonably possible was helpful for
debugging in the past. I'd move it sooner, not later.

(If you see that message, it means that normal printk debugging can be
used, not exotic stuff like hashes in NVRAM).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
