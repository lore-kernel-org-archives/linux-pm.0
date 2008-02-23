From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] PM: Introduce PM_EVENT_HIBERNATE (was: Re:
 i915 hibernation patch (was: Re: 2.6.25-rc2 System no longer ...))
Date: Sat, 23 Feb 2008 10:43:57 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802231041510.21332__15177.4929523983$1203792423$gmane$org@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
	<b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09@mail.gmail.com>
	<200802231913.27592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802231913.27592.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:
> 
> Thanks for testing.  Below is the final version of the patch with a changelog
> etc.

Thanks, applied. 

With this, I also find that I dislike the use of suspend/resume for 
freezing for STD a lot less. It's still too easy to get confused, but at 
least now drivers always have total knowledge about what is really going 
on. I'd not like this interface as a driver writer, but now it's not 
fundamentally broken any more, just slightly confusing.

			Linus
