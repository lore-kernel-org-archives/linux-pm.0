From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: Boot problems with 2.6.29.1 - cannot smoothly boot
	on battery
Date: Mon, 25 May 2009 08:49:48 +0800
Message-ID: <1243212588.8523.192.camel__3501.46494242853$1243212592$gmane$org@localhost.localdomain>
References: <3d2f29dc0905180125x5e7ef51dqf10955a3d44336e2@mail.gmail.com>
	<200905242236.22715.rjw@sisk.pl>  <4A19BA09.4050502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A19BA09.4050502@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg KH <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Chris Howie <cdhowie@gmail.com>, Linux PM List <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-05-25 at 05:20 +0800, H. Peter Anvin wrote:
> Rafael J. Wysocki wrote:
> > On Monday 18 May 2009, Chris Howie wrote:
> >> Folks:
> >>
> >> I've been running 2.6.29.1 for some time and reported an issue to this
> >> mailing list a while ago about the boot process.  I believe I have now
> >> nailed down the one factor that determines whether I see this issue.
> >>
> >> The problem arises only when booting or halting my laptop when there
> >> is no power plugged in, e.g. the system is running on battery.
> >> Sometime after init begins starting services I must hold down a key on
> >> the keyboard to convince it to continue booting, otherwise it just
> >> hangs.  If the system is running on AC then it boots fine.  This same
> >> problem repeats itself during the halt process if running on battery.
> >>
> >> This also happens when resuming a suspend-to-disk image, after loading
> >> the data from the hard drive, but before control is returned to
> >> userspace.  The keyboard has no effect on this hang, presumably
> >> because the kernel is not listening to the keyboard at this point.
> >> When this happens the only solution is to hold the power button and
> >> boot normally instead.
> >>
> >> An issue like this is a serious usability problem for me.  I am
> >> neither a kernel developer nor hacker, my coding skills applying
> >> mostly to userspace applications.  If there is anything you need from
> >> me to help diagnose this problem please let me know.
> >>
> >> I am not subscribed so please CC me on replies.
> > 
> > Let's try to make your report a bit more visible (some CCs added).
> > 
> 
> I presume it boots with "acpi=off"?
How about using the following boot option?
   a. idle=poll
   b. nolapic_timer
   c. processor.max_cstate=1

If the box can be booted with the above option, please open a new bug at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI and attach the
output of acpidump, lspci -xxx.

Thanks.
> 
> 	-hpa
> 
