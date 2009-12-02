From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem again
Date: Wed, 2 Dec 2009 22:49:07 +0100
Message-ID: <200912022249.07325.rjw__3996.73309079862$1259790716$gmane$org@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <87638qw2zy.fsf@tac.ki.iif.hu>
	<87skbtve5w.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87skbtve5w.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 02 December 2009, Ferenc Wagner wrote:
> Ferenc Wagner <wferi@niif.hu> writes:
> 
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >
> >> On Tuesday 01 December 2009, Ferenc Wagner wrote:
> >>
> >>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >>> 
> >>>> On Tuesday 01 December 2009, Ferenc Wagner wrote:
> >>>>
> >>>>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >>>>>
> >>>>>> In addition to that, you can run multiple hibernation/resume cycles in
> >>>>>> a tight loop using the RTC wakealarm.
> >>>>> 
> >>>>> I'll do so, as soon as I find a way to automatically supply the dm-crypt
> >>>>> passphrase... or even better, learn to hibernate to ramdisk from the
> >>>>> initramfs. :)
> >>>>
> >>>> Well, you don't need to use swap encryption for _testing_. :-)
> >>> 
> >>> I use partition encryption, everything except for /boot is encrypted.
> >>
> >> If /boot is big enough, you could use a swap file in /boot for the testing.
> >
> > Ramdisk worked good.  Maybe too good, because I left the machine doing
> > s2disks while I was having dinner, and it achieved some 120 suspends
> > without a freeze.  Only the e100 and the mii modules were loaded.
> >
> > After some script munging I got the machine automatically boot with an
> > alternate passphrase, so in vivo testing is possible now.  I mean,
> > tomorrow.
> 
> After almost 100 hibernate/resume cycles, I have to say that this issue
> can't be reproduced by suspending in a tight loop.  I tried that while
> flood pinging my gateway and also with no network activity.  The rc8
> e100 module was loaded all the time.

I wonder if this patch:

http://patchwork.kernel.org/patch/64276/

helps in your case.

Thanks,
Rafael
