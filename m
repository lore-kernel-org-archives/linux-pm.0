From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 03/04] PM: Add platform bus runtime dev_pm_ops
Date: Wed, 3 Jun 2009 11:47:19 +0200
Message-ID: <200906031147.20265.rjw@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<200905300123.18367.rjw@sisk.pl>
	<aec7e5c30906020637i3fc67d10w23e21b035620798f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5132405030438232600=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906020637i3fc67d10w23e21b035620798f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============5132405030438232600==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_oakJK/Dtt/KqS4+"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_oakJK/Dtt/KqS4+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 02 June 2009, Magnus Damm wrote:
> Hi Rafael,
> 
> Thanks for your feedback!
> 
> 2009/5/30 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 27 May 2009, Magnus Damm wrote:
> >> From: Magnus Damm <damm@igel.co.jp>
> >>
> >> Wrap the platform device bus dev_pm_ops to allow runtime
> >> pm and regular suspend and resume to coexist.
> >>
> >> Platform device data is extended with flags that allow
> >> us to keep track of which dev_pm_ops that has been called.
> >>
> >> Basically, if a device has been frozen by the runtime pm
> >> code, don't call ->freeze() again when hibernating.
> >>
> >> Architecture code can use platform_runtime_dev_pm_ops to
> >> call driver dev_pm_ops associated with a certain device.
> >>
> >> Enable with CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM.
> >>
> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >> ---
> >>
> >>  This is a bit of a hack, any better way to wrap dev_pm_ops?
> >
> > I'm not really sure you need to wrap them at all.
> 
> I realize that I didn't explain very well why I decided to wrap
> dev_pm_ops. Sorry about that. Basically there are two reasons:
> 1) Wrap to always have the runtime dev_pm_ops functions regardless of kconfig.

Well, I'm not sure if this is the right approach (see below).

> 2) Wrap to make sure runtime and system-wide dev_pm_ops can coexist.

That's if you want to have a separate dev_pm_ops object for run-time PM, which
I don't think is necessary.

> > There are a few choices:
> >
> > (1) You can use the platform_pm_* functions directly for run-time PM, but
> > in that case you'll need to make sure that the "suspend" ones return 0
> > immediately when called during system-wide suspend or hibernation (there's the
> > question whether the "resume" ones should still put the device into the full
> > power state in that case).  For this purpose you can add a single flag to
> > struct platform_device and set it for devices that have already been
> > "suspended" (this flag, when set, will make all of the "suspend" callbacks
> > return 0 without doing anything until the device is "resumed").
> 
> I have to make sure that the right Kconfig bits are enabled though,
> otherwise some platform_pm_* functions will be missing. So one merit
> for the wrapped functions is in this patch is that they are always
> there regardless of CONFIG_SUSPEND and CONFIG_HIBERNATION.

Make them depend on CONFIG_PM, then.  They are not _that_ much code anyway,
we can easily afford building them even on platforms that really don't use them,
but I expect them to be used by more and more platforms over time anyway.

> Is one flag really enough?

Not necessarily, although I think we'll end up using one flag only.

> Isn't it a bit strange from the driver point of view to always get their
> ->prepare() callback executed, but ->suspend() gets filtered?

In fact, from the run-time PM POV, ->prepare() and ->suspend() should
always be executed together and ->suspend_noirq() shouldn't be executed
at all.  Now, it may be necessary to execute some code from ->suspend_noirq()
for run-time PM too, but not by using this callback directly.

> The bitmap in this patch is more fine-grained, so struct
> platform_device remember which of each dev_pm_ops callback that have
> been called. It may be overly complex though. Also, please note that
> both runtime dev_pm_ops and system-wide dev_pm_ops go through the same
> dev_pm_ops that keep track of which callbacks that have been called.
> 
> Using some kind of flag(s) for coexisting with system-wide
> suspend-to-ram/disk sounds good.

Of course we should be avoiding double suspend, so some kind of sychronization
between the "sleep" suspend and run-time suspend is necessary and I agree that
it's probably most convenient to use some flags for this purpose.  The
questions are how many flags we're going to need and how exactly we're going
to use them.

> > (2) You can add separate platform callbacks for run-time PM that will execute
> > the drivers' dev_pm_ops callbacks and presumably do something else (I don't
> > know what that may be for platform devices, though).  In that case, again,
> > adding a flag to struct platform_device and making platform_pm_* check it
> > should be sufficient to prevent devices from being suspended twice in a row.
> 
> We may need to do other things as well - not sure - but regardless we
> still need flag(s) to avoid double suspend.

Agreed.

> > (3) You can add separate platform callbacks for run-time PM for both the
> > bus type and the drivers, in which dev_pm_ops will be totally separate from
> > these new callbacks, although of course you'll need provide some kind of
> > synchronization bettween them all.  That also may be done through a flag
> > in struct platform_device IMO.
> 
> Yeah, that's also one way. I wonder if that helps us though, I feel
> that we already have a pretty wide range of callbacks in dev_pm_ops.
> I'm not sure if they cover all cases we need though, I guess future
> experiments will tell.

Yes.  Still, we can anticipate that the run-time PM operations may be slightly
different from the 'sleep state' PM ones, in which case it makes sens to
introduce new callbacks, because that makes it clear(er) what the code is
supposed to do.

> > Now, since other bus types will most probably also need a flag in their
> > _device structures, it may be worth putting it into struct device (we've
> > discsussed that already).
> 
> Yeah, I wonder if a single flag is enough though? Aren't we coexisting
> with CONFIG_SUSPEND, CONFIG_HIBERNATION and CONFIG_KEXEC_JUMP?
> 
> > I'm not sure which of (1) - (3) are the most suitable for the platform bus
> > type.  For PCI I'd probably choose (2), because the current PCI bus type's
> > dev_pm_ops callbacks are tailored to system-wide power transitions.
> > Moreover, PCI devices can generally be put first into D1, then into D2 and
> > finally into D3, which only makes sense at run time, and some of them may
> > have to be put back into the full power state before a system-wide transition
> > (apparently, we'll need a separate flag to mark such devices).
> 
> If I understand (1)-(3) correctly, then I think (1) is probably the
> best choice for our platform devices.

OK, for _your_ platform devices it may be the best choice, but what about
the other platforms' platform devices?  Do you think (1) will be suitable for
them all and if so then why?

> I guess (2) is not very far from (1), so if we go with (1) to begin with
> then we can deal with SoC specific things in our arch code to come closer to
> (2) over time if needed.
> 
> > Of course, if you decide to add separate run-time PM callbacks for the
> > platform bus type, you won't need to wrap its dev_pm_ops callbacks any more,
> > but you'll need to modify them to check the appropriate flag(s).  For example,
> > you may choose to use a two-bit pm_suspend_level field such that
> >
> > * if pm_suspend_level = 1, platform_pm_prepare() will return immediately
> > * if pm_suspend_level = 2, platform_pm_prepare() and platform_pm_suspend()
> >  will return immediately
> > * if pm_suspend_level = 3, platform_pm_prepare(), platform_pm_suspend()
> >  and platform_pm_suspend_noirq() will return immediately
> >
> > (and analogously for the hibernation callbacks) and make your run-time PM
> > callbacks set this field appropriately.
> 
> That is true, but this checking is not needed for systems where
> runtime PM is disabled.

No, it is not, but it won't hurt really.  Also, if we do it intelligently, we
can make the compiler optimize out the checks.  I'm not really sure it's worth
the effort, however.

> Or am I misunderstanding?
>
> Maybe it's worth to discuss how to integrate this. I suspect that this
> will only affect some selected architectures to begin with, and the
> rest of the code base should be unaffected by this change as long as
> the runtime kconfig is disabled.
> 
> So I decided to wrap dev_pm_ops to make the impact for non runtime PM
> systems as small as possible. This while giving the runtime PM case
> access to all dev_pm_ops regardless of suspend/hibernation kconfig.
> 
> Does it make sense?

Well, as I said above, I don't really think that run-time PM is going to need
all of the callbacks from dev_pm_ops.  Moreover, I'm not sure if it makes
sense to have more than two (call it 'autosuspend' and 'autoresume' using the
already existing USB terminology) callbacks for run-time PM, at least at
the driver level.

Best,
Rafael

--Boundary-00=_oakJK/Dtt/KqS4+
Content-Type: text/html;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-=
html40/strict.dtd"><html><head><meta name=3D"qrichtext" content=3D"1" /><st=
yle type=3D"text/css">p, li { white-space: pre-wrap; }</style></head><body =
style=3D" font-family:'Sans Serif'; font-size:11pt; font-weight:400; font-s=
tyle:normal;"><table style=3D"-qt-table-type: root; margin-top:2px; margin-=
bottom:2px; margin-left:4px; margin-right:4px;"><tr><td style=3D"border: no=
ne;">On Tuesday 02 June 2009, Magnus Damm wrote:<br>
&gt; Hi Rafael,<br>
&gt; <br>
&gt; Thanks for your feedback!<br>
&gt; <br>
&gt; 2009/5/30 Rafael J. Wysocki &lt;rjw@sisk.pl&gt;:<br>
&gt; &gt; On Wednesday 27 May 2009, Magnus Damm wrote:<br>
&gt; &gt;&gt; From: Magnus Damm &lt;damm@igel.co.jp&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Wrap the platform device bus dev_pm_ops to allow runtime<br>
&gt; &gt;&gt; pm and regular suspend and resume to coexist.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Platform device data is extended with flags that allow<br>
&gt; &gt;&gt; us to keep track of which dev_pm_ops that has been called.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Basically, if a device has been frozen by the runtime pm<br>
&gt; &gt;&gt; code, don't call -&gt;freeze() again when hibernating.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Architecture code can use platform_runtime_dev_pm_ops to<br>
&gt; &gt;&gt; call driver dev_pm_ops associated with a certain device.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Enable with CONFIG_HAVE_PLATFORM_DEVICE_RUNTIME_PM.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Magnus Damm &lt;damm@igel.co.jp&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0This is a bit of a hack, any better way to wrap dev_pm_ops=
?<br>
&gt; &gt;<br>
&gt; &gt; I'm not really sure you need to wrap them at all.<br>
&gt; <br>
&gt; I realize that I didn't explain very well why I decided to wrap<br>
&gt; dev_pm_ops. Sorry about that. Basically there are two reasons:<br>
&gt; 1) Wrap to always have the runtime dev_pm_ops functions regardless of =
kconfig.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Well, I'm not sure if this is the right approach (see=
 below).<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; 2) Wrap to make sure runtime and system-wide dev=
_pm_ops can coexist.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>That's if you want to have a separate dev_pm_ops obje=
ct for run-time PM, which<br>
I don't think is necessary.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; &gt; There are a few choices:<br>
&gt; &gt;<br>
&gt; &gt; (1) You can use the platform_pm_* functions directly for run-time=
 PM, but<br>
&gt; &gt; in that case you'll need to make sure that the "suspend" ones ret=
urn 0<br>
&gt; &gt; immediately when called during system-wide suspend or hibernation=
 (there's the<br>
&gt; &gt; question whether the "resume" ones should still put the device in=
to the full<br>
&gt; &gt; power state in that case). =A0For this purpose you can add a sing=
le flag to<br>
&gt; &gt; struct platform_device and set it for devices that have already b=
een<br>
&gt; &gt; "suspended" (this flag, when set, will make all of the "suspend" =
callbacks<br>
&gt; &gt; return 0 without doing anything until the device is "resumed").<b=
r>
&gt; <br>
&gt; I have to make sure that the right Kconfig bits are enabled though,<br>
&gt; otherwise some platform_pm_* functions will be missing. So one merit<b=
r>
&gt; for the wrapped functions is in this patch is that they are always<br>
&gt; there regardless of CONFIG_SUSPEND and CONFIG_HIBERNATION.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Make them depend on CONFIG_PM, then.  They are not _t=
hat_ much code anyway,<br>
we can easily afford building them even on platforms that really don't use =
them,<br>
but I expect them to be used by more and more platforms over time anyway.<b=
r>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; Is one flag really enough?<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Not necessarily, although I think we'll end up using =
one flag only.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; Isn't it a bit strange from the driver point of =
view to always get their<br>
&gt; -&gt;prepare() callback executed, but -&gt;suspend() gets filtered?<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>In fact, from the run-time PM POV, -&gt;prepare() and=
 -&gt;suspend() should<br>
always be executed together and -&gt;suspend_noirq() shouldn't be executed<=
br>
at all.  Now, it may be necessary to execute some code from -&gt;suspend_no=
irq()<br>
for run-time PM too, but not by using this callback directly.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; The bitmap in this patch is more fine-grained, s=
o struct<br>
&gt; platform_device remember which of each dev_pm_ops callback that have<b=
r>
&gt; been called. It may be overly complex though. Also, please note that<b=
r>
&gt; both runtime dev_pm_ops and system-wide dev_pm_ops go through the same=
<br>
&gt; dev_pm_ops that keep track of which callbacks that have been called.<b=
r>
&gt; <br>
&gt; Using some kind of flag(s) for coexisting with system-wide<br>
&gt; suspend-to-ram/disk sounds good.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Of course we should be avoiding double suspend, so so=
me kind of sychronization<br>
between the "sleep" suspend and run-time suspend is necessary and I agree t=
hat<br>
it's probably most convenient to use some flags for this purpose.  The<br>
questions are how many flags we're going to need and how exactly we're goin=
g<br>
to use them.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; &gt; (2) You can add separate platform callbacks=
 for run-time PM that will execute<br>
&gt; &gt; the drivers' dev_pm_ops callbacks and presumably do something els=
e (I don't<br>
&gt; &gt; know what that may be for platform devices, though). =A0In that c=
ase, again,<br>
&gt; &gt; adding a flag to struct platform_device and making platform_pm_* =
check it<br>
&gt; &gt; should be sufficient to prevent devices from being suspended twic=
e in a row.<br>
&gt; <br>
&gt; We may need to do other things as well - not sure - but regardless we<=
br>
&gt; still need flag(s) to avoid double suspend.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Agreed.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; &gt; (3) You can add separate platform callbacks=
 for run-time PM for both the<br>
&gt; &gt; bus type and the drivers, in which dev_pm_ops will be totally sep=
arate from<br>
&gt; &gt; these new callbacks, although of course you'll need provide some =
kind of<br>
&gt; &gt; synchronization bettween them all. =A0That also may be done throu=
gh a flag<br>
&gt; &gt; in struct platform_device IMO.<br>
&gt; <br>
&gt; Yeah, that's also one way. I wonder if that helps us though, I feel<br>
&gt; that we already have a pretty wide range of callbacks in dev_pm_ops.<b=
r>
&gt; I'm not sure if they cover all cases we need though, I guess future<br>
&gt; experiments will tell.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Yes.  Still, we can anticipate that the run-time PM o=
perations may be slightly<br>
different from the 'sleep state' PM ones, in which case it makes sens to<br>
introduce new callbacks, because that makes it clear(er) what the code is<b=
r>
supposed to do.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; &gt; Now, since other bus types will most probab=
ly also need a flag in their<br>
&gt; &gt; _device structures, it may be worth putting it into struct device=
 (we've<br>
&gt; &gt; discsussed that already).<br>
&gt; <br>
&gt; Yeah, I wonder if a single flag is enough though? Aren't we coexisting=
<br>
&gt; with CONFIG_SUSPEND, CONFIG_HIBERNATION and CONFIG_KEXEC_JUMP?<br>
&gt; <br>
&gt; &gt; I'm not sure which of (1) - (3) are the most suitable for the pla=
tform bus<br>
&gt; &gt; type. =A0For PCI I'd probably choose (2), because the current PCI=
 bus type's<br>
&gt; &gt; dev_pm_ops callbacks are tailored to system-wide power transition=
s.<br>
&gt; &gt; Moreover, PCI devices can generally be put first into D1, then in=
to D2 and<br>
&gt; &gt; finally into D3, which only makes sense at run time, and some of =
them may<br>
&gt; &gt; have to be put back into the full power state before a system-wid=
e transition<br>
&gt; &gt; (apparently, we'll need a separate flag to mark such devices).<br>
&gt; <br>
&gt; If I understand (1)-(3) correctly, then I think (1) is probably the<br>
&gt; best choice for our platform devices.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>OK, for _your_ platform devices it may be the best ch=
oice, but what about<br>
the other platforms' platform devices?  Do you think (1) will be suitable f=
or<br>
them all and if so then why?<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; I guess (2) is not very far from (1), so if we g=
o with (1) to begin with<br>
&gt; then we can deal with SoC specific things in our arch code to come clo=
ser to<br>
&gt; (2) over time if needed.<br>
&gt; <br>
&gt; &gt; Of course, if you decide to add separate run-time PM callbacks fo=
r the<br>
&gt; &gt; platform bus type, you won't need to wrap its dev_pm_ops callback=
s any more,<br>
&gt; &gt; but you'll need to modify them to check the appropriate flag(s). =
=A0For example,<br>
&gt; &gt; you may choose to use a two-bit pm_suspend_level field such that<=
br>
&gt; &gt;<br>
&gt; &gt; * if pm_suspend_level =3D 1, platform_pm_prepare() will return im=
mediately<br>
&gt; &gt; * if pm_suspend_level =3D 2, platform_pm_prepare() and platform_p=
m_suspend()<br>
&gt; &gt; =A0will return immediately<br>
&gt; &gt; * if pm_suspend_level =3D 3, platform_pm_prepare(), platform_pm_s=
uspend()<br>
&gt; &gt; =A0and platform_pm_suspend_noirq() will return immediately<br>
&gt; &gt;<br>
&gt; &gt; (and analogously for the hibernation callbacks) and make your run=
=2Dtime PM<br>
&gt; &gt; callbacks set this field appropriately.<br>
&gt; <br>
&gt; That is true, but this checking is not needed for systems where<br>
&gt; runtime PM is disabled.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>No, it is not, but it won't hurt really.  Also, if we=
 do it intelligently, we<br>
can make the compiler optimize out the checks.  I'm not really sure it's wo=
rth<br>
the effort, however.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>&gt; Or am I misunderstanding?<br>
&gt;<br>
&gt; Maybe it's worth to discuss how to integrate this. I suspect that this=
<br>
&gt; will only affect some selected architectures to begin with, and the<br>
&gt; rest of the code base should be unaffected by this change as long as<b=
r>
&gt; the runtime kconfig is disabled.<br>
&gt; <br>
&gt; So I decided to wrap dev_pm_ops to make the impact for non runtime PM<=
br>
&gt; systems as small as possible. This while giving the runtime PM case<br>
&gt; access to all dev_pm_ops regardless of suspend/hibernation kconfig.<br>
&gt; <br>
&gt; Does it make sense?<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Well, as I said above, I don't really think that run-=
time PM is going to need<br>
all of the callbacks from dev_pm_ops.  Moreover, I'm not sure if it makes<b=
r>
sense to have more than two (call it 'autosuspend' and 'autoresume' using t=
he<br>
already existing USB terminology) callbacks for run-time PM, at least at<br>
the driver level.<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p>Best,<br>
Rafael<br>
<p style=3D"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; ma=
rgin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-u=
ser-state:0;"><br></p></td></tr></table></body></html>
--Boundary-00=_oakJK/Dtt/KqS4+--

--===============5132405030438232600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5132405030438232600==--
