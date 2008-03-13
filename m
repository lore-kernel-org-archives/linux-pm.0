From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Hibernation: Fix mark_nosave_pages()
Date: Thu, 13 Mar 2008 08:46:21 +0100
Message-ID: <20080313074621.GB19117__10909.8591180102$1205404266$gmane$org@elf.ucw.cz>
References: <200803120034.58615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200803120034.58615.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-03-12 00:34:57, Rafael J. Wysocki wrote:
> Hi Len,
> 
> The following patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=9966 .
> 
> Although the problem has been there for quite some time (since before 2.6.22,
> apparently), it would be good to have in 2.6.25, because it may fix booting
> problems on the affected systems.
> 
> Please note that it doesn't modify the code behavior on the systems which are
> not affected by bug #9966 .
> 
> Thanks,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> There is a problem in the hibernation code that triggers on some NUMA
> systems on which pfn_valid() returns 'true' for some PFNs that don't
> belong to any zone.  Namely, there is a BUG_ON() in
> memory_bm_find_bit() that triggers for PFNs not belonging to any
> zone and passing the pfn_valid() test.  On the affected systems it
> triggers when we mark PFNs reported by the platform as not saveable,
> because the PFNs in question belong to a region mapped directly using
> iorepam() (i.e. the ACPI data area) and they pass the pfn_valid()
> test.
> 
> Modify memory_bm_find_bit() so that it returns an error if given PFN
> doesn't belong to any zone instead of crashing the kernel and ignore
> the result returned by it in mark_nosave_pages(), while marking the
> "nosave" memory regions.
> 
> This doesn't affect the hibernation functionality, as we won't touch
> the PFNs in question anyway.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. I hate how it adds more code to swsusp, but I could not find a
simple way to avoid that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
