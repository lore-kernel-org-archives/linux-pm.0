From: Pavel Machek <pavel@suse.cz>
Subject: Re: Suspend and hibernation patchset against -rc6
Date: Tue, 18 Mar 2008 13:07:04 +0100
Message-ID: <20080318120704.GA1841__32981.3107885004$1205847251$gmane$org@elf.ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803172317.33745.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> > For everyone interested, I have put together a patchset containing some "fresh"
> > patches related to suspend and hibernation, on top of 2.6.25-rc5, located at:
> > 
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc5/patches/
> 
> There's a new patchset against 2.6.25-rc6 at:
> 
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.25-rc6/patches/
> 
> It contains some more patches, specifically the "legacy PM removal" series, the
> fixed "PM: make wakeup flags available whenever CONFIG_PM is set" series posted
> recently by Alan (the second patch rebased by me), the Johannes' apm-emulation
> patch and the patches introducing the new suspend/hibernation callbacks I sent
> yesterday.

Ok, I ran basic tests on thinkpad x60, and they seem to work.

...one strange thing is I'm seeing some delays, I'll investigate a bit
more.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
pomozte zachranit klanovicky les:  http://www.ujezdskystrom.info/
