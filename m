From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sat, 12 Jul 2008 22:47:49 +0200
Message-ID: <200807122247.50851.rjw__16022.6144748323$1215895711$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <200807122051.25634.rjw@sisk.pl>
	<48791484.4010408@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48791484.4010408@myrealbox.com>
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
To: Andy Lutomirski <luto@myrealbox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 12 of July 2008, Andy Lutomirski wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 12 of July 2008, Andy Lutomirski wrote:
> >> My Lenovo X61s fails to resume if I suspend it from within X, on both 
> >> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is 
> >> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between 
> >> -rc8 and -rc9 is also consistent with this being the problem.
> >>
> >> The symptom is that, when I push the power button to resume, the hard 
> >> drive light turns on, the fan turns on, then the hard drive light turns 
> >> off, the sleep light stays on, and the fan keeps running.  Sometimes the 
> >> battery light will blink off very briefly (1/4 sec, maybe) every few 
> >> seconds.  The system is locked hard at this point.
> >>
> >> I'm using Ubuntu Hardy userspace.
> > 
> > Well, that's bad.
> > 
> > There is the bugzilla entry at http://bugzilla.kernel.org/show_bug.cgi?id=11064
> > for this bug and you've just confirmed my suspicion that this particular
> > commit is to blame.
> > 
> > Can you please see if the appended patch changes anything?
> 
> I suspended and resumed OK.  Then I rebooted and tried again, and it failed.

That's very strange.

Well, is suspend/resume 100% reliable without commit
4b4f7280d7fd1feeff134c2cf2db32fd583b6c29 ?

Also, is the system 64-bit or 32-bit and do you use any user-space quirks to
bring the graphics to life during resume?

And what does happen if you suspend it from the console (no X)?

Rafael
