From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 13:25:42 -0700
Message-ID: <991df5640aa53989f0801feecf46c979@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911200636.GC11901@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


On Sep 11, 2006, at 1:06 PM, Pavel Machek wrote:

> On Mon 2006-09-11 12:53:27, Matthew Locke wrote:
>> On Sep 11, 2006, at 12:36 PM, Pavel Machek wrote:
>>
>>>>> You did echo low > something to change CPU frequency, IIRC.
>>>> My patch set presents two different interfaces built on top of
>>>> PowerOP -
>>>> cpufreq and sysfs interfaces. So _no_, PowerOP is not all about
>>>
>>> Okay, drop sysfs interface, and we may have something that can be
>>> reviewed.
>>
>> Sysfs is a separate patch that can rejected.  Nothing is stopping
>> people from reviewing.
>
> If you submit patch series with one bad patch, you are very unlikely
> to get feedback for the good patches.
>
>>> Actually that's good idea. Submit powerop without doing _any_ kernel
>>> interface changes, so we can see that it makes sense...
>>
>> Just to be clear this is the approach we did and are doing.
>
> That's not what I remember. Please resubmit, then. And cc lkml this
> time.
>
>> btw, if people on this list are not ready to ACK PowerOP, I would like
>> to hear why before we go elsewhere.   It looks like all major issues
>> have been addressed by our approach and implementation.
>
> No, I'm not ready to ACK. Actually I'd describe it as "broken piece of
> code noone needs".

But people on this list from TI, Nokia, and Motorola have explained why =

its needed.  Also, we explained why in the f2f linux-pm summit.  Can =

you give some concrete reasons why its not needed that have not been =

addressed already?

> And IIRC Greg's last question was "what is it good
> for?".

That was a long time ago and again many people from the embedded =

community have provided lots of answers.

> Dave Jones was not too pleased with cpufreq/powerop
> integration.

Really?!  I don't think he has reviewed our latest integration patches. =

  Our first submission was a result of discussion with Dominik at the =

linux-pm summit.  The latest submission is a result of Dave Jones =

comments.  I think we have addressed all expressed concerns.  I can't =

force anybody to review this stuff and I'm sure Dave is still catching =

up from his vacation.

>  Intel people explained you broke centrino
> speedstep.

I didn't see that.  Was it off-list?  We did not break centrino.  In =

fact we use both the acpi and hardcoded tables just as  cpufreq does.  =

If its broken, then it was already broken.

>  Shall I continue?

Please.  Again,  I still say we have addressed all expressed =

concerns/questions/issues.  If you don't feel we have, please give some =

concrete statements that you are concerned about or don't understand.  =

As you can see, many people are happy to help explain.

PowerOP is necessary to build the power management software required =

for embedded mobile devices, so we need to reach an understanding.  If =

the power management guys on this list don't understand PowerOP, then =

moving this discussion to lkml isn't going to help.  I much prefer to =

work together to figure out something than throw it over the wall.

>
> 								Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
