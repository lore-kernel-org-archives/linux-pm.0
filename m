From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 13:33:22 -0800
Message-ID: <200503231333.22647.david-b@pacbell.net>
References: <1111113131.25179.73.camel@gaston>
	<200503231153.48230.david-b@pacbell.net>
	<20050323210835.GF30704@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76861815323164917=="
In-Reply-To: <20050323210835.GF30704-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============76861815323164917==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 1:08 pm, Pavel Machek wrote:
> Hi!
> 
> > > Thing is, it's the system power states that are placing clock
> > > constraints on devices.  On OMAP, going into "deep sleep" means
> > > you've got to stop using the 48 MHz clock.  For "big sleep",
> > > you can keep using that clock.  Most other CPUs have similar
> > > constraints:  multiple system states, defined primarily by
> > > clock usage.  
> > 
> > 
> > So to focus on one point:  "pm_message_t" doesn't work well
> > at all, since it doesn't have a way to identify the target
> > system power state, and drivers thus have no way to see if
> > they should drop their requests for those clocks or whether
> > the hardware should keep working away.
> 
> Well, in current model,

That is, after pm_message_t change.  That represents a loss of
functionality.  Previously drivers received a target system
sleep state, and could make such deductions easily:  anything
like a PCI D3cold ("4") means maximal power off, anything like
a PCI D3hot ("3") is less aggressive, and so on.  (Not that all
drivers behaved right, or that the different incarnations of
the "pm core" code used "3" vs "4" sanely, etc.)

So maybe one question for tomorrow should be how we'll restore
that temporarily-list functionality.


> drivers shoudl stop all the activity they can 
> ("deep sleep"). If you want to add support for "big sleep", then you
> should probably use flags... I guess calling "big sleep" standby is
> okay...

That's the loss of functionality.  Previously drivers didn't need
to "stop all the activity they can" (PCI D3cold = 4), they also
had options that didn't assume swsusp poweroff (PCI D3hot = 3).

I don't know what you mean by "flags".  Mapping "big sleep" to a
"standby" might make sense, specifically for that one architecture,
but that doesn't seem like it'd address the  general issue.  What
if there are more than two such non-"disk" system states that need
support, for example?  Or about system states that relate to more
factors than just the CPU/SOC states?

- Dave

--===============76861815323164917==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76861815323164917==--
