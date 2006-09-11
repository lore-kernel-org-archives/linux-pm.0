From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 14:50:04 -0700
Message-ID: <c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<20060911200936.GA12433@elf.ucw.cz>
	<6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
	<20060911210634.GI11901@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911210634.GI11901@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org


On Sep 11, 2006, at 2:06 PM, Pavel Machek wrote:

> On Mon 2006-09-11 13:33:00, Matthew Locke wrote:
>> On Sep 11, 2006, at 1:09 PM, Pavel Machek wrote:
>>> On Mon 2006-09-11 22:06:36, Pavel Machek wrote:
>>>> On Mon 2006-09-11 12:53:27, Matthew Locke wrote:
>>>>> On Sep 11, 2006, at 12:36 PM, Pavel Machek wrote:
>>>
>>>>> btw, if people on this list are not ready to ACK PowerOP, I would
>>>>> like
>>>>> to hear why before we go elsewhere.   It looks like all major =

>>>>> issues
>>>>> have been addressed by our approach and implementation.
>>>
>>> Oh and I am pretty tired of teaching you 'how to submit a patch', so
>>> if I'm quiet, do not take it as an "ACK".
> ...
>> What does your going quiet mean?  You have had some good feedback so I
>> much prefer we reach some sort of understanding.  If your final
>> statement is that PowerOP is not needed and you are never going to =

>> like
>> it or ACK It, let us know.  We can agree to disagree.
>
> You got the interfaces wrong. While I believe that something like
> powerop can indeed be useful for system-on-chip platforms, I do not
> think it should be exposed outside of kernel.


Ok.  I don't think its wrong because its designed from understanding =

the requirements of pm software for embedded mobile devices.   I think =

the embedded folk all agree that the type of interface submitted is =

required.  I don't understand why you think its wrong.  Just to be =

clear, your previous email made it very clear you don't like the =

userspace interface but this email says interfaces generically.  I am =

assuming your only objection at this point is the userspace interface.  =

  We are more than willing to work this out.  The current sysfs =

interface is surrounded by ifdefs and is optional.  If there is no =

exposure to userspace, then testing/debuging will be more difficult.

Greg, Pavel, Dominik, Dave J and Dave B,

I would like to get a plan in place for acceptance with the power =

management guys before we move this to lkml.  I propose that we submit =

the current set of PowerOP patches plus final few changes (from Greg's =

comments and a Documentation/ file).  The patches do not affect anyone =

else.  The sysfs interface is optional.  If necessary Eugeny and I will =

maintain userspace interface patches outside the mainline for now.  =

Will any of the power management maintainers ACK this plan and then ACK =

the patches?  If no one here is willing to ACK, then I don't see what =

will change by submitting to lkml.


> 								Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
