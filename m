From: Matthew Locke <matt@nomadgs.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 14 Aug 2006 15:24:19 -0700
Message-ID: <c948ef9077556626e85291ad716b7ddb@nomadgs.com>
References: <20060814200735.GC14099@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060814200735.GC14099@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Aug 14, 2006, at 1:07 PM, Greg KH wrote:

> I'm seeing a lot of threads without very much resolution on the
> differing patches that are flying around here in regards to the rework
> of the power management stuff (not suspend stuff...)
>

RIght now there are two sets of patches with the name powerop.

One set (from Eugeny and myself) is focused on getting agreement for =

the PowerOP interface and operating point definition.  I believe the =

last patchset Eugeny submitted as incorporated all the comments about =

PowerOP so far.   I don't think integrating PowerOP with suspend =

(/sys/power/state) is appropriate at this time (as others agreed).  I =

would rather see PowerOP accepted and used by cpufreq before we tackle =

suspend/resume.

The other set posted by Dave Singleton is geared towards showing how =

PowerOP can be used by both cpufreq and suspend code.  It contains lots =

of features that have not been reviewed or discussed.



> So, should I just grab a random patchset from here and add it to my
> trees and get it into -mm for testing, or does someone want to possibly
> guide me to the set that everyone seems to agree apon?

No, please don't grab a random patchset:)  IMO,  the patches from =

Eugeny and myself are the ones to grab and put into -mm.  We were =

hoping to get some feedback on the set posted here  =

http://lists.osdl.org/pipermail/linux-pm/2006-August/003196.html but I =

think the two patchsets have confused the situation.   We are working =

on the next rev of these patches which will mostly be some clean up and =

tighter integration  with cpufreq.  Our plan was to get the next rev =

out before we request inclusion in -mm.  However if you are ready to =

look at and play with patches. Start with the ones at the link above.

I am a little concerned that none of the cpufreq developers have =

responded. I was hoping to get their feedback.

>
> Or, is there two (or more) competing patch sets here that need to get
> resolved?

I don't view the two patchsets as competing.  Eugeny and I are focused =

on getting the basic building block necessary to do advanced frequency =

and voltage scaling accepted.  If we can get PowerOP in the mainline, =

then we can add more feature by feature.    As Dave outlined in his =

email,  his patches are a starting point for further discussion about =

integrating with other subsystems and additional features.  Let's focus =

on getting PowerOP accepted by starting with Eugeny's patches which =

provides powerop as a separate component and integration with cpufreq.

> (If you can't tell I'm getting a bit annoyed at having to tell people
> all the time that yes, power management on Linux is bad, and yes, =

> people
> are working on it, but no, I have no idea when it will ever see the
> light of day...)

Well, we are working on it.  I think we had some really good =

discussion/feedback over the last weeks and we are almost there.  =

Unfortunately, the discussion tapered off recently when we needed some =

final feedback.  Probably related to having two patchsets with the name =

powerop.  Let's try to get something acceptable in -mm over the next =

couple days.

Thanks

Matt
>
> thanks,
>
> greg k-h
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
