From: Matthew Locke <matt@nomadgs.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 12:30:12 -0700
Message-ID: <b0623b9bb79afacc77cddc6e39c96b62@nomadgs.com>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060911082025.GD1898@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Cc: pm list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

I know its confusing having oppoint (from Dave Singleton) and powerop =

being discussed at the same time.  However, I believe we (PowerOP) have =

already address most of the concerns/requirements from the community =

and the embedded folks.  Here is a summary of PowerOP that will =

(hopefully) clear up our approach:

- PowerOP is only one layer (towards the bottom) in a power management =

solution.
- PowerOP does *not* replace cpufreq
- PowerOP can replace the cpufreq_driver layer of cpufreq but cpufreq =

integration not required.
- in kernel cpufreq governors are not directly affect by integrating =

cpufreq and powerop. (Can be extended and/or ported to more =

architectures and operating points)
- Again, cpufreq userspace and kernel interfaces can continue to be =

used as they are today.
- PowerOP defines the parameters you want to change on a per =

architecture/board basis.
- The PowerOP interface was discussed in detail on this list and we =

haven't heard any negative comments.
- We are not advocating the integration with sleep states.  We want to =

get the PowerOP interface accepted and then we can build on it.
- PowerOP is *required* by the embedded folks.

We have a few more comments from Greg to take care of and  we can add a =

Documentation/ file. Then I think its time to get the PowerOP patches =

in the queue for acceptance.    Any comments about this?

btw,  PowerOP<->Cpufreq integration discussion can wait until Dominik =

and Dave Jones have time for more discussion.

On Sep 11, 2006, at 1:20 AM, Pavel Machek wrote:

> Hi!
>
> On Mon 2006-09-11 11:57:28, Eugeny S. Mints wrote:
>> [snip]
>>>> Are you arguing that the cpufreq interface be morphed to support =

>>>> power
>>>> op applications?
>>>
>>> No. I'm arguing that
>>>
>>> * cpufreq interface should be used for changing cpu frequency
>> the patch set i sent out has cpufreq used for changing cpu frequency,
>> hasn't it?
>
> I was talking about kernel<->user interface.
>
> You did echo low > something to change CPU frequency, IIRC.
>
>> can we eventually start talking more close to the code rather than
>> speculating without it?
>
> Lets get kernel<->user interface right, first. You'll need to create
> Documentation/ entries for your interfaces, eventually, so lets do
> that, first, and then talk about code. Oh and it would be nice to cc
> lkml on that document, too. New kernel<->user interface is not
> decision taken lightly.
> 									Pavel
> -- =

> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =

> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
