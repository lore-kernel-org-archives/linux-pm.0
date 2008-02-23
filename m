From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel]
	2.6.25-rc2 System no longer powers off aftersuspend-to-disk.
	Screen becomes green.)
Date: Sat, 23 Feb 2008 12:36:48 +0800
Message-ID: <b6a2187b0802222036i33d5bcc2n4e3bafd6d846cc09__30011.0074611895$1203967789$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802230031.20292.rjw@sisk.pl>
	<alpine.LFD.1.00.0802221653000.21332@woody.linux-foundation.org>
	<200802230255.54510.rjw@sisk.pl>
	<alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Romano Giannetti <romano@dea.icai.upcomillas.es>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 23, 2008 at 10:07 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>  On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:
>  > OK, please have a look at the modified patch below.
>
>  All right, I'm fine with it. Now we just need to confirm that it works for
>  people..

Looks good. Applied Rafael patch on top of your latest git tree that
has Jesse's i915 fix.

No green screen. Tested with STD (platform), STR, and plain echo mem >
/sys/power/state.

Thanks,
Jeff.
