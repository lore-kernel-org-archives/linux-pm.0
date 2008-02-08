From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend to ram problem
Date: Fri, 8 Feb 2008 23:10:15 +0100
Message-ID: <20080208221015.GB1648__42169.9532577351$1202508802$gmane$org@elf.ucw.cz>
References: <47A5C399.7010405@free.fr> <20080207092035.GB1816@elf.ucw.cz>
	<47AB60C4.50602@free.fr> <200802072100.32205.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802072100.32205.rjw@sisk.pl>
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
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, matthieu castet <castet.matthieu@free.fr>
List-Id: linux-pm@vger.kernel.org

> > I wonder if there a way to check that we are realy in real mode ?
> 
> Yes.  In real mode bit 0 of the cr0 register should be 0.

It is not as simple. There's stuff like "unreal" mode... real mode
with 4GB descriptor limits... and similar crazyness.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
