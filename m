From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 22:57:28 +0100
Message-ID: <20050316215727.GB2641@elf.ucw.cz>
References: <20050313101453.GA4820@blackham.com.au>
	<200503141059.26107.david-b@pacbell.net>
	<20050314193054.GO5461@elf.ucw.cz>
	<200503161305.57698.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============075666742151979438=="
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
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============075666742151979438==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 16-03-05 13:05:57, David Brownell wrote:
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

We do not do "device_suspend(...FREEZE)" for suspend-to-RAM (= S3). We
freeze processes in order to make driver's life easier.

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
> 
> 
> If swsusp were called a system checkpoint/restore mechanism, it'd
> have a much clearer relationship to power management:  enabling
> system power-off is a useful side effect, but it's not exactly
> the point of a checkpoint mechanism.  I suspect that if it were
> packaged as halt-after-checkpoint, plus resume-from-checkpoint,
> a lot of technical issues would start shaking out better.  Also
> maybe some political/funding ones ... checkpointing has much
> value for enterprise server operations.

Yes, I pretty much agree with this one. OTOH drivers must be aware
that powerdown *is* eventually going to happen, and that state of
their devices is going to be lost. And they can't just store it just
before powerdown, because that context is going to be lost.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============075666742151979438==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============075666742151979438==--
