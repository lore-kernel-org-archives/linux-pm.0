From: Pavel Machek <pavel@ucw.cz>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel]
	2.6.25-rc2	System no longer powers off aftersuspend-to-disk.
	Screen becomes	green.)
Date: Sat, 23 Feb 2008 12:17:00 +0100
Message-ID: <20080223111700.GB1909__18224.3380383172$1203765505$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802230031.20292.rjw@sisk.pl>
	<alpine.LFD.1.00.0802221653000.21332@woody.linux-foundation.org>
	<200802230255.54510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200802230255.54510.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Alexey Starikovskiy <astarikovskiy@suse.de>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > Apart from those issues it looks fine to me.

> 
> OK, please have a look at the modified patch below.

Seems to work here after basic tests. ACK.

(I discovered that -rc2 swsusp will not power down in some cases, but
it was here before the patch, too...)
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
