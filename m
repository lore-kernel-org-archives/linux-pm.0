From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend slow in 2.6.25-rc6 (was Re: Suspend and
	hibernation	patchset against -rc6)
Date: Wed, 19 Mar 2008 12:49:24 +0100
Message-ID: <20080319114924.GC21270@atrey.karlin.mff.cuni.cz>
References: <200803120129.25585.rjw@sisk.pl> <200803172317.33745.rjw@sisk.pl>
	<20080318130642.GA1609@elf.ucw.cz>
	<20080318130710.GB1609@elf.ucw.cz>
	<alpine.LFD.1.00.0803181028400.3020@woody.linux-foundation.org>
	<20080318232037.GA1670@elf.ucw.cz> <47E05408.7000003@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47E05408.7000003@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

> Pavel Machek wrote:
> >On Tue 2008-03-18 10:31:28, Linus Torvalds wrote:
> >>
> >>On Tue, 18 Mar 2008, Pavel Machek wrote:
> >>>On Tue 2008-03-18 14:06:42, Pavel Machek wrote:
> >>>>Confirmed, suspend slowness is in 2.6.25-rc6, too. It takes 15 seconds
> >>>>to suspend/resume, while 2.6.24 takes 9. Thinkpad x60.
> >>>IIRC 2.6.25-rc5 was "fast".
> >>Can you bisect it? There's only 343 commits between -rc5 and -rc6, so it 
> >>should not take too long to check which commit it is. Even if it should 
> >>take 9 reboots to bisect it entirely, going just five or six will likely 
> >>narrow it down sufficiently that we can probably guess fairly well what 
> >>it's about.
> >
> >Slowdown is fixed by this patch:
> I think only this part is relevant here. But yes, I agree that the whole 
> patch should be reverted.
> >@@ -230,7 +227,6 @@ static int acpi_ec_wait(struct acpi_ec *
> > 		while (time_before(jiffies, delay)) {
> > 			if (acpi_ec_check_status(ec, event))
> > 				goto end;
> >-			msleep(5);
> > 		}
> > 	}
> > 	pr_err(PREFIX "acpi_ec_wait timeout,"
> Thanks,
> Alex.

> ACPI: EC: Revert storm handler patch
> 
> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> 
> Patch have caused several new troubles, so just revert it for now.
> 
> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>

Tested-by: Pavel Machek <pavel@suse.cz>
ACK.
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
