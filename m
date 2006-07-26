From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 00:44:52 -0700
Message-ID: <083b1ba275390c298727816bc51f21b4@nomadgs.com>
References: <c55240ed0607201256q2d902a0nd3e9e3fba4ac9dd8@mail.gmail.com>
	<20060724172954.GC1926@elf.ucw.cz>
	<200607241149.01700.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607241149.01700.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: patrick.mochel@intel.com, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org


On Jul 24, 2006, at 11:48 AM, David Brownell wrote:

> On Monday 24 July 2006 10:29 am, Pavel Machek wrote:
>
>> That looks quite ugly to do in sysfs, indeed.
>
> Yes, it's long been one of the things I most dislike about this =

> PowerOP thing.
> Not just the UI, but the models it reflects.
>
> So I was glad to see it split out as fully optional... although from =

> what I
> see, the internal models in the code have derived from this sysfs =

> model, so
> I'd argue those need to change too.

Is there something specific in the internal model that are you =

referring to?

>
> It'd be lots better to just have named operating points that get =

> selected just
> the /sys/power/state file selects the, erm, "sleep point".

I've tried to fit sleep into the operating point concept before but =

sleep always ends up being a special case.   The code has to check to =

see if the selected operating the "sleep point" and call the suspend =

function.  I think tying in sleep to the op point concept needs more =

discussion and probably should be handled separately until we get =

further along with power op.

btw, we are in complete agreement about using named points.  This first =

set of patches is meant to introduce the operating point concept into =

the kernel without requiring massive changes to cpufreq.  This layer =

extends the bottom part of cpufreq to enable the control of multiple =

parameters beyond just cpu frequency and voltage across architectures.  =

Currently, cpufreq does not use named operating points so we need to =

make sure cpufreq can use the power op API and continue to function.  =

This topic also ties into our other email discussion on creating op =

points and names are assigned to op points.
>
>
>> But better run this by lkml.
>
> I'd rather see some rough consensus on this list that this is the =

> right way
> to head, before running things like this by LKML.

That is why we submitted here first:)  We will figure out if there is a =

better interface for this patch to use by discussing with Greg or LKML. =

  Meanwhile let's continue to discuss the ideas here for a bit.
>
> - Dave
>
