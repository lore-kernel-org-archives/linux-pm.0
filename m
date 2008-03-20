From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation patchset against -rc6)
Date: Thu, 20 Mar 2008 16:53:59 +0100
Message-ID: <20080320155359.GA4044__8613.28288815475$1206028638$gmane$org@ucw.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318225201.GA2115@elf.ucw.cz>
	<20080320150637.GC5615@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080320150637.GC5615@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-03-20 12:06:37, Henrique de Moraes Holschuh wrote:
> On Tue, 18 Mar 2008, Pavel Machek wrote:
> >     ACPI: Ignore _BQC object when registering backlight device
> 
> Thinkpads always have them all, or none at all.

Yep, this was not issue after all.

I tried to do bisect, but it looks like the X-and-lid-close/open  problem is present in
2.6.24, too. I'll try to do some meaningfull bisect tonight.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
