From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Suspend to disk broken in latest 2.6.28-rc3
Date: Mon, 10 Nov 2008 15:06:52 -0800
Message-ID: <200811101506.53324.jbarnes__12563.9386162677$1226358584$gmane$org@virtuousgeek.org>
References: <20081109195033.GA1335@mobydick>
	<20081110094239.GA14204@atrey.karlin.mff.cuni.cz>
	<20081110221343.GA17951@mobydick>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081110221343.GA17951@mobydick>
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
To: Mathieu Chouquet-Stringer <mchouque@free.fr>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, November 10, 2008 2:13 pm Mathieu Chouquet-Stringer wrote:
> On Mon, Nov 10, 2008 at 10:42:39AM +0100, Pavel Machek wrote:
> > Trying with minimum drivers is likely to help here, and should be
> > easier than bisect. Boot with init=/bin/bash, then try "devices" >
> > pm_dest and disk > state...
>
> Some progress with (2.6.28-rc4 this time)...  I've booted with /bin/bash
> as init: works.
>
> Then I rebooted in single mode => works
> Runlevel 3 => works
> Runlevel 5 => doesn't work
>
> In terms of devices, lsmod says the only differences between runlevel 3
> and runlevel 5 are that both drm and radeon are loaded...
>
> If I rmmod radeon and drm while X is running suspending the devices
> works...  I guess I don't have DRI enabled???  Just looked at the logs,
> I guess I don't [1]...
>
> Looking at a git log -p of gpu/drm/radeon shows lots of difference
> between 2.6.26 and HEAD...  I see a vblank change [2] that changes the
> way the device is suspended, not sure if it really matters though...
>
> Alex, Jesse and/or Dave can you think of anything before I bisect?  FYI
> my radeon is a:
> ATI Technologies Inc Radeon Mobility M7 LW [Radeon Mobility 7500] rev 0,

If you have radeon loaded but DRI was never enabled, you'll likely see a 
crash.  That's because the radeon driver doesn't map the registers it needs 
for suspend/resume at load time; they only get mapped by DRI initialization 
code which lives in the X driver.  There's a patch in 
http://bugzilla.kernel.org/show_bug.cgi?id=11891 that might help you...

-- 
Jesse Barnes, Intel Open Source Technology Center
