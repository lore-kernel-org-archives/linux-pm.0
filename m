From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 05:52:04 -0700
Message-ID: <AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk__47807.0845515051$1275051269$gmane$org@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<20100528114123.GA22947@srcf.ucam.org> <4BFFB681.1000105@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BFFB681.1000105@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 5:26 AM, Igor Stoppa <igor.stoppa@nokia.com> wrote:
> ext Matthew Garrett wrote:
>> On Fri, May 28, 2010 at 10:37:13AM +0100, Alan Cox wrote:
>>> The other vendors appear to be managing nicely without magic blockers. I
>>> conjecture therefore there are other solutions.
>>
>> Actually, no. A badly behaved application will kill the N900's battery
>> life. Nobody else has "managed nicely" - they've just made life harder for
>> application developers and users, which may have something to do with the
>> relative levels of market adoption of Maemo and Android. I'm not aware of
>> any form of resource management framework in MeeGo either, so as far as I
>> know it'll have exactly the same problem.
>
> It's true that a braindead app can kill the battery.
>
> However we provide a version of powertop that is tailored to the N900, there
> is a nokia energy profiler meant to give graphical representation of the
> battery current, there is htop available and you can even get the processor
> activity visualized on the leftmost and rightmost keyboard backlight LEDS,
> when in RD mode and with screen blanked.
>
> I would advice you to not start debating on company strategies, this is not
> the right place.

At a certain point, if one side of the argument is using "N900 / OMAP3
works just fine as is" (which has certainly been the case stated by a
number of folks throughout these discussions), I think it's a little
unrealistic to express shock that somebody argues the opposing point.

I've personally avoided commenting on specific power management issues
or properties of competitive platforms because it can easily be viewed
as rather rude or unprofessional.  (though in theory we all could
benefit from any improvements to the kernel regarding power
management, no?).

I am quite willing to state that on both MSM and OMAP based Android
platforms, we've found that the suspend blocker model allows us to
obtain a lower average power draw than if we don't use it -- Mike Chan
provided some numbers earlier in another thread in the trivial device
idle case, the win is of course much larger in the case of several
poorly behaved apps being active.

I do think that everyone involved agrees that it is beneficial to
educate users and developers in hopes that users will understand that
some apps are non-optimal and developers will be encouraged to write
better apps.

I think we also all agree that striving to obtain the lowest power
state at all times through cpu frequency scaling, runtime pm, drivers
that aggressively clock/power down when idle, etc is a worthy goal.
Some have argued that suspend blockers may deter further development
in these areas, but I think this is unlikely -- power usage while the
device is active and the user is interacting with it is just as
critical as when it's not being used interactively.  We (Android)
certainly pursue aggressive low power optimization in both states.

There appears to be some disagreement in terms of what one should do
in the face of poorly behaved applications.  The Android approach has
been to both gather as much data as possible for education of user and
developer and to mitigate the impact of poorly written apps on
endusers, goals which are aided by the suspend blocker model.

A reality of a mass market device with a completely open and
unrestricted application development and distribution ecosystem is
that there will be plenty of non-optimal apps available to users
(Sturgeon's Law applies everywhere, after all).  Worse yet, many of
these non-optimal apps may be beloved by users for various reasons.  I
think there's value in trying to do the best you can power-wise even
in the face of such horrible foes as the dreaded Bouncing Cows App
that Matthew is fond of citing as an example.

Brian
