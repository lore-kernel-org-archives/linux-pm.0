From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Thu, 17 Mar 2005 09:48:41 +1100
Message-ID: <1111013321.3240.63.camel@desktop.cunningham.myip.net.au>
References: <20050313101453.GA4820@blackham.com.au>
	<200503161305.57698.david-b@pacbell.net>
	<1111009442.3240.28.camel@desktop.cunningham.myip.net.au>
	<200503161412.42387.david-b@pacbell.net>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67862718476587336=="
In-Reply-To: <200503161412.42387.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============67862718476587336==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi David.

On Thu, 2005-03-17 at 09:12, David Brownell wrote:
> Hi,
> 
> On Wednesday 16 March 2005 1:44 pm, Nigel Cunningham wrote:
> > On Thu, 2005-03-17 at 08:05, David Brownell wrote:
> > > For the record, I've recently observed that all the swsusp issues
> > > start making sense to me when I start thinking of swsusp as being
> > > completely unrelated to suspend states.  (S4bios aside...)  And if
> > > I don't think of it that way, I keep tripping over complications
> > > where it's fighting against "real" suspend states.
> > > 
> > > The thing is, swsusp in normal usage does not involve system
> > > suspend states like S1/S2/S3, or their analogues in non-ACPI
> > > embedded systems.  Neither does it involve wakeup from those
> > > states ... in fact, it fights against addressing all those.
> > 
> > Both swsusp and suspend2 can enter S4 as their method of powering down,
> > and do use the prepare, enter and finish methods when doing so.
> 
> As I said, S4 aside.  The history I recall is that swsusp came
> out a fair degree of frustration with getting Linux to work
> with the BIOS support ... and lack of firmware init for video,
> etc.  And certainly S4 modes don't seem to be the default, or
> widely used/tested.

I think we're confusing things somewhere. You said "S4bios aside", and
that's fine. I wasn't talking about S4 bios support at all. Instead, I
was talking about the support swsusp and suspend2 have for invoking the
ACPI S4 sleep state. (S4 is suspend-to-disk. The problems you mention
sound more like S3 - suspend to ram).

> > > If swsusp were called a system checkpoint/restore mechanism, it'd
> > > have a much clearer relationship to power management:  enabling
> > > system power-off is a useful side effect, but it's not exactly
> > > the point of a checkpoint mechanism.  I suspect that if it were
> > > packaged as halt-after-checkpoint, plus resume-from-checkpoint,
> > > a lot of technical issues would start shaking out better.  Also
> > > maybe some political/funding ones ... checkpointing has much
> > > value for enterprise server operations.
> > 
> > Checkpointing and restoring is very different from what swsusp and
> > suspend2 do. I've been asked a number of times if I could make Suspend2
> > do checkpointing as well as suspending, and it's simply not possible.
> 
> That is, other folk have noticed that it's essentially the same
> problem...

Only from the point of view of quiescing drivers.

> > The reason is that we really are suspending to disk. We're writing the
> > entire contents of memory, and those contents are only valid while the
> > disk is in exactly the state it is in when we suspend. As soon as you
> > change a file on the disk (as you would after checkpointing), the image
> > is invalid and will create corruption if restored. To do checkpointing,
> > we'd at least have to  modify the implementations to be able to reverse
> > on disk changes back to the point where the checkpoint was taken, and
> > probably also add a mechanism for tracking in-memory changes and
> > updating the image to reflect them. It's not impossible, but it's not
> > what swsusp and Suspend2 do now.
> 
> True, not what they do now.  I didn't intend to imply they did.
> A checkpoint package would have key differences, including those.
> 
> That wasn't my point:  that swsusp, in normal usage, is more of a
> checkpoint/restore than a suspend/resume.  Which is why some of what
> it wants is different from suspend/resume.  In particular, since
> the devices are goin to be powered off, the resume paths are VERY
> different.  They are in fact reset paths, not resume paths.

Ok. I agree suspend to disk is by definition akin to a
checkpoint/restore operation. That's simply because of the nature of the
beast - devices get powered down in this state.

Can we nevertheless please still call it suspend/resume? Checkpointing
is a different creature, and we don't want to confuse the issue.

> > I realise you're writing in the context of freezing drivers, and may
> > simply be thinking in terms of the action being the same as would be
> > required if you were checkpointing. From that point of view I'd probably
> > agree. But in the first instance, I'm reacting to you speaking of
> > calling swsusp a system checkpoint/restore mechanism.
> 
> I'm trying to articulate why so much of the swsusp stuff seems (to me)
> to be fighting against "normal" suspend/resume and wakeup mechanisms,
> which can more naturally be built piecemeal from selective suspend.
> (And why there's any pushback on selective suspend, given that it's so
> basic to "normal" suspend/resume/wakeup.)

Not sure I understand everything you're saying here, so can I see if my
understanding matches/helps clarify?

I see the system states as being like a big clamp over the run-time
power management. To enter the PM_FREEZE state, for example, is to force
all the drivers into a lower state of activity & preparedness than they
would otherwise occupy. In normal operation, they'll happily interact
with each other and float between the various run-time states according
to whatever policy, but when PM_FREEZE comes along, they're collectively
forced to a lowest common denominator. Is that akin to the "fighting
again 'normal' suspend/resume and wakeup mechanisms" you speak of?

Regards,

Nigel 
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============67862718476587336==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67862718476587336==--
