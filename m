From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 3/4] swsusp: Introduce restore platform
	operations
Date: Tue, 22 May 2007 01:38:48 +0200
Message-ID: <20070521233848.GN10714__17674.1661307917$1179790915$gmane$org@elf.ucw.cz>
References: <200705180019.35548.rjw@sisk.pl> <200705180024.52170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200705180024.52170.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> At least on some machines it is necessary to prepare the ACPI firmware for the
> restoration of the system memory state from the hibernation image if the
> "platform" mode of hibernation has been used.  Namely, in that cases we need to
> disable the GPEs before replacing the "boot" kernel with the "frozen" kernel.
> After the restore they will be re-enabled by hibernation_ops->finish(), but if
> the restore fails, they have to be re-enabled by the restore code explicitly.
> 
> For this purpose we can introduce two additional hibernation operations, called
> pre_restore() and restore_cleanup() and call them from the restore code path.
> Still, they should be called if the "platform" mode of hibernation has been
> used, so we need to pass the information about the hibernation mode from the
> "frozen" kernel to the "boot" kernel in the image header.

I don't quite like this one... passing flags from frozen to boot
kernel makes it more complex.

Is it really neccessary?

Could we do the same steps as the first thing when the frozen kernel
wakes up?

What machines does it fix?  

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
