From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Mon, 10 Nov 2008 23:13:43 +0100
Message-ID: <20081110221343.GA17951__9574.88776552982$1226355412$gmane$org@mobydick>
References: <20081109195033.GA1335@mobydick>
	<20081110094239.GA14204@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081110094239.GA14204@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 10, 2008 at 10:42:39AM +0100, Pavel Machek wrote:
> Trying with minimum drivers is likely to help here, and should be
> easier than bisect. Boot with init=/bin/bash, then try "devices" >
> pm_dest and disk > state...

Some progress with (2.6.28-rc4 this time)...  I've booted with /bin/bash
as init: works.

Then I rebooted in single mode => works
Runlevel 3 => works
Runlevel 5 => doesn't work

In terms of devices, lsmod says the only differences between runlevel 3
and runlevel 5 are that both drm and radeon are loaded...

If I rmmod radeon and drm while X is running suspending the devices
works...  I guess I don't have DRI enabled???  Just looked at the logs,
I guess I don't [1]...

Looking at a git log -p of gpu/drm/radeon shows lots of difference
between 2.6.26 and HEAD...  I see a vblank change [2] that changes the
way the device is suspended, not sure if it really matters though...

Alex, Jesse and/or Dave can you think of anything before I bisect?  FYI
my radeon is a:
ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] rev 0,

Cheers,
Mathieu

[1]
(EE) RADEON(0): Static buffer allocation failed.  Disabling DRI.
(EE) RADEON(0): At least 21263 kB of video memory needed at this resolution and depth.

[2] Commit 0a3e67a4caac273a3bfc4ced3da364830b1ab241
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
