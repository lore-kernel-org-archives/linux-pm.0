From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 09:56:48 -0700
Message-ID: <200604250956.49177.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604241547.38692.david-b@pacbell.net>
	<200604252034.54352.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90069915292436664=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604252034.54352.ncunningham@cyclades.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============90069915292436664==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 April 2006 3:34 am, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 25 April 2006 08:47, David Brownell wrote:
> > On Monday 24 April 2006 2:47 pm, Rafael J. Wysocki wrote:
> > > I agree with this change but I think it'll cause some strange things to
> > > happen for some time.
> >
> > Let's see.  :)  I think it's less likely to be drivers with broken
> > shutdown() callbacks than drivers which are missing them.
> >
> > Plus, one of the main reasons that driver suspend/resume handling
> > is _still_ so goofy is that most drivers are stupid, and just reinit
> > devices from scratch in their resume() methods.  Drivers like that
> > should not notice any difference.  :)
> 
> No!

To what in particular?  The US version of fascism?  Everything in general?
One specific comment above?  All of them?


> The only reason that driver suspend/resume handling is still far from perfect 
> is that a good number of drivers still don't have any suspend/resume 
> handling.

That's a separate issue.  I was referring to the structural issues,
the "handling".  Specifically, the ones which make it hard to use
more device states than just the "on" and "off" required by swsusp.

For example, there's the "drivers can't detect the target system state"
issue ... the pm_message_t conversion replaced a value which had originally
been used to indicate that state (back in 2.4) with something that's all
but useless for any purpose other than telling IDE when not to spin down.
(I have one proposal to help there, which I'll make at some point in a
separate thread.)

It's those structural issues that make it hard to do things like handling
both swsusp _and_ real system suspend states like STR ... and to make
wakeup events work.  I do understand that ACPI is sometimes in the way,
but the structural issues are what keep things from acting sane even on
nice clean embedded hardware where not even a bootloader gets in the way
of having Linux do proper suspend/wakeup/resume handling.


> Getting rid of the instrastructure because it isn't completely  
> implemented is the wrong approach.

I didn't advocate getting rid of any infrastructure.  How could you even
read what I wrote as recommending that?  There wasn't even a mention of
anything to be removed.


> We should instead complete implementing  
> the support so that drivers understand the difference between freezing, 
> suspending, powering down, powering up and resuming. If we dumb things down, 
> we'll only create problems.

Another of the reasons system suspend/resume is goofy is that there's
still confusion about what that support is, and what those differences are.

For example, you were the one who recently (yesterday!!) advocated redefining
FREEZE so it's more than just driver quiescence.

And for that matter, there are no driver power down/up APIs; all we have are
suspend/resume.  That actually makes sense to me, but you seem to think there
should be some difference between the two.


How could you read what I wrote as recommending we "dumb things down"?
All I did was observe that swsusp was violating the existing definition
of device state during resume() callbacks, and provide a fix for it.

If you refer to my dislike of special cases ... that's not dumbing down,
that's experience.  You can't evolve complex systems **THAT WORK** only by
adding special cases whenever another inconvenient truth comes up.  At some
point you either succumb to chaos, or replace most of those special cases
with simple rules.


> Rafael raised the issue in another email of code built as modules that is 
> suspended and not resumed or vice versa because in the case of suspend to 
> disk, the module is loaded at boot time but not in the suspended kernel (or 
> v.v).

Which issue made no sense to me when he tried to write it up either.


> It seems to me that the right way to deal with this is to extend the  
> use of __nosave so that information about what was loaded in the boot kernel 
> is available when resuming drivers after the atomic restore.

I seriously doubt you'll be able to get all the hardware designers to
cooperate with you.  Not all the hardware state is directly visible to
software even in normal operation, so there's no way to turn all the
relevant information into driver state to which __nosave (etc) could
be applied ...

- Dave


--===============90069915292436664==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90069915292436664==--
