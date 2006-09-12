From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Tue, 12 Sep 2006 01:26:29 -0700
Message-ID: <de6b6331fa0bc1e3bfe825f611b6c3a2@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<c728abebb17f975089390dd3f87069af@nomadgs.com>
	<20060911200636.GC11901@elf.ucw.cz>
	<20060911200936.GA12433@elf.ucw.cz>
	<6d5d95c88706be8a338f703579cd62b9@nomadgs.com>
	<20060911210634.GI11901@elf.ucw.cz>
	<c63579dda747a35a5ba48ba5495b3d72@nomadgs.com>
	<20060912033143.GB27397@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060912033143.GB27397@kroah.com>
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
Cc: pm list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>, Preece Scott-PREECE <scott.preece@motorola.com>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org


On Sep 11, 2006, at 8:31 PM, Greg KH wrote:

> On Mon, Sep 11, 2006 at 02:50:04PM -0700, Matthew Locke wrote:
>>
>> I would like to get a plan in place for acceptance with the power
>> management guys before we move this to lkml.
>
> Sure, let's see something here that we all agree on.  You have yet to
> achieve that, so you still have work to do.
>
>> I propose that we submit the current set of PowerOP patches plus final
>> few changes (from Greg's comments and a Documentation/ file).
>
> Nothing is keeping you from sending these to the list now.  Please do
> so.

The only thing stopping us is time:)  It will happen soon.

>
>> The patches do not affect anyone else.  The sysfs interface is
>> optional.
>
> If so, it will be interesting to see why the code is even needed, I
> await the patches :)

PowerOP patches have been submitted to this list several times for =

review.  You even reviewed a version or two.  The main comments we are =

addressing are small issues such as add a file in Documentation and =

module reference counting.  Not much else will change so you have the =

code.  The cpufreq<->PowerOP integration patches have also been =

submitted but no one has responded to those.

Just read the other emails.  I will stop here.  It's time to reset the =

discussion again.

>
>> If necessary Eugeny and I will maintain userspace interface patches
>> outside the mainline for now.
>
> Why?  What good would the in-kernel patches be then if it can't be used
> except for some external patches?  That's not acceptable.  And the user
> interface has been tied to the other kernel code, so I think you need
> them both, but am willing to be convinced otherwise.

I think so too.  This offer is in response to Pavel's comment that =

PowerOP is ok for in-kernel usage but not userspace.

>
>> Will any of the power management maintainers ACK this plan and then
>> ACK the patches?
>
> Let's see the code please.
>
>> If no one here is willing to ACK, then I don't see what will change by
>> submitting to lkml.
>
> Let's get this agreed on first, I feel that you still have some way to
> go here.
>
> Sending stuff to lkml is fine too, you should be doing that for such a
> core change anyway.  I don't see why you can't do that at the same =

> time,
> it's just an extra email on the CC: line...
>
> thanks,
>
> greg k-h
>
