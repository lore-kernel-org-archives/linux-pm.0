From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Restore standard config registers of
	all devices early (was: Re: EeePC resume failure - timers)
Date: Tue, 20 Jan 2009 09:45:36 -0800
Message-ID: <200901200945.37371.jbarnes__3965.04529421708$1232473717$gmane$org@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0901161010400.2417-100000@iolanthe.rowland.org>
	<200901191421.56148.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0901201342510.3554@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0901201342510.3554@localhost.localdomain>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 19, 2009 8:56 pm Linus Torvalds wrote:
> On Mon, 19 Jan 2009, Jesse Barnes wrote:
> > Is i915 loaded?  Hopefully you can suspend/resume in text mode using its
> > suspend/resume code w/o using the s3_bios stuff?
>
> You're right, that works fine. So text-mode suspends and (immediately)
> resumes without any issues, multiple times. But X doesn't. The second
> resume will just hang when X re-initializes (sometimes I see the cursor,
> so I know X actually started up)

Getting register dumps before and after resume (and also preferably before and 
after X VT switches) might help us figure out what's going on (sounds like 
the driver's VT enter routine is broken somehow)...  The xf86-video-intel 
repo at git://git.freedesktop.org/git/xorg/driver/xf86-video-intel has a tool 
called "intel_reg_dumper" in src/reg_dumper that you can use to capture the 
dumps.  If you're having trouble building it just check out an old version 
like 2.5.1; current git needs a very new libdrm to build.

-- 
Jesse Barnes, Intel Open Source Technology Center
