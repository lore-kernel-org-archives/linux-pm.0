From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Thu, 17 Mar 2005 08:44:03 +1100
Message-ID: <1111009442.3240.28.camel@desktop.cunningham.myip.net.au>
References: <20050313101453.GA4820@blackham.com.au>
	<200503141059.26107.david-b@pacbell.net>
	<20050314193054.GO5461@elf.ucw.cz>
	<200503161305.57698.david-b@pacbell.net>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65978639746283241=="
In-Reply-To: <200503161305.57698.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

--===============65978639746283241==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-03-17 at 08:05, David Brownell wrote:
> On Monday 14 March 2005 11:30 am, Pavel Machek wrote:
> > On Po 14-03-05 10:59:25, David Brownell wrote:
> > 
> > > > pci_choose_state() needs to return d3hot even 
> > > > for pmsg_freeze, because that's what old code did, and I did not audit
> > > > all the drivers.
> > > 
> > > Seems like a problem to me.  Do S1/S2/S3 transitions even
> > > need a "freeze" transition?  I thought we'd agreed they don't;
> > 
> > That's not the problem.
> 
> It's _a_ problem, maybe not the one you want to focus on right now.
> 
> 
> > Old code put devices into D3hot in swsusp "freeze" case. We'll need to
> > do the same now, slowly auditing the drivers and removing that
> > unneccessary D0->D3hot->D0 transition.
> 
> That's true.  The extra suspend/resume transition is trouble;
> it's not necessary for the checkpoint stage, or system poweroff.
> 
> 
> For the record, I've recently observed that all the swsusp issues
> start making sense to me when I start thinking of swsusp as being
> completely unrelated to suspend states.  (S4bios aside...)  And if
> I don't think of it that way, I keep tripping over complications
> where it's fighting against "real" suspend states.
> 
> The thing is, swsusp in normal usage does not involve system
> suspend states like S1/S2/S3, or their analogues in non-ACPI
> embedded systems.  Neither does it involve wakeup from those
> states ... in fact, it fights against addressing all those.

Both swsusp and suspend2 can enter S4 as their method of powering down,
and do use the prepare, enter and finish methods when doing so.

> If swsusp were called a system checkpoint/restore mechanism, it'd
> have a much clearer relationship to power management:  enabling
> system power-off is a useful side effect, but it's not exactly
> the point of a checkpoint mechanism.  I suspect that if it were
> packaged as halt-after-checkpoint, plus resume-from-checkpoint,
> a lot of technical issues would start shaking out better.  Also
> maybe some political/funding ones ... checkpointing has much
> value for enterprise server operations.

Checkpointing and restoring is very different from what swsusp and
suspend2 do. I've been asked a number of times if I could make Suspend2
do checkpointing as well as suspending, and it's simply not possible.
The reason is that we really are suspending to disk. We're writing the
entire contents of memory, and those contents are only valid while the
disk is in exactly the state it is in when we suspend. As soon as you
change a file on the disk (as you would after checkpointing), the image
is invalid and will create corruption if restored. To do checkpointing,
we'd at least have to  modify the implementations to be able to reverse
on disk changes back to the point where the checkpoint was taken, and
probably also add a mechanism for tracking in-memory changes and
updating the image to reflect them. It's not impossible, but it's not
what swsusp and Suspend2 do now.

I realise you're writing in the context of freezing drivers, and may
simply be thinking in terms of the action being the same as would be
required if you were checkpointing. From that point of view I'd probably
agree. But in the first instance, I'm reacting to you speaking of
calling swsusp a system checkpoint/restore mechanism.

Hope that helps.

Nigel

> OK, that's enough of a radical perspective for the moment.
> I'm not sure I'll throw any more monkey wrenches today.  ;)
> 
> - Dave
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============65978639746283241==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65978639746283241==--
