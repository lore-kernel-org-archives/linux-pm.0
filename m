From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: uhci-hcd suspend/resume under the new driver model
Date: Wed, 16 Mar 2005 23:19:32 +0100
Message-ID: <20050316221931.GC2641@elf.ucw.cz>
References: <20050313101453.GA4820@blackham.com.au>
	<200503161305.57698.david-b@pacbell.net>
	<1111009442.3240.28.camel@desktop.cunningham.myip.net.au>
	<200503161412.42387.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21493506617304381=="
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
Cc: Bernard Blackham <bernard-4vSAtV5O1nc0n/F98K4Iww@public.gmane.org>, ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============21493506617304381==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

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

Careful, S4 *is* being used/tested. But it is very similar to swsusp
with powerdown. S4bios is *not* used. It is going to die real soon.

> True, not what they do now.  I didn't intend to imply they did.
> A checkpoint package would have key differences, including those.
> 
> That wasn't my point:  that swsusp, in normal usage, is more of a
> checkpoint/restore than a suspend/resume.  Which is why some of what
> it wants is different from suspend/resume.  In particular, since
> the devices are goin to be powered off, the resume paths are VERY
> different.  They are in fact reset paths, not resume paths.

Well, hardware may have been initialized by normal boot. So if drivers
are not modular, it will work okay with suspend/resume paths in
drivers. If drivers are modular, then you are right.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============21493506617304381==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21493506617304381==--
