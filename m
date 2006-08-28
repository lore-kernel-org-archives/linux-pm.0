From: Matthew Locke <matt@nomadgs.com>
Subject: Re: PowerOP, Intro 0/3
Date: Mon, 28 Aug 2006 00:37:44 -0700
Message-ID: <1d71fc171bd3635111b4da9024db747f@nomadgs.com>
References: <44ECFC0E.10803@gmail.com> <20060826082848.GC8538@elf.ucw.cz>
	<44EF3D6F.3030802@gmail.com> <20060826203841.GA4144@ucw.cz>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060826203841.GA4144@ucw.cz>
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
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


On Aug 26, 2006, at 1:38 PM, Pavel Machek wrote:

> Hi!
>
>>>> PowerOP Core upper layer interface provides the
>>>> following capabilities:
>>>> - to register an operating point by passing an
>>>> idenificator of the point
>>>> represened by a string and arbitrary substet of power
>>>> paremeters available on a
>>>> certain platform by a string (parameter name) and
>>>> value pairs.
>>>> - to unregister operating point by name
>>>> - to set operating point by name
>>>> - to get values of arbitrary subset of platform power
>>>> parameters associated
>>>> this  a point (point is passed by name or NULL to get
>>>> current parameter values
>>>> from hw)
>>>
>>> I do not think this can work in notebook world, sorry.
>>> You'll just get
>>> way too many operating points.
>> The only feature for notebook world currently presented
>> in the kernel is CPUFreq. CPUFreq PowerOP integration
>
> Actually no. In the notebook world, we do cpufreq, selective powerdown
> of devices (/sys/**/power/state), and suspend-to-ram/disk (not sure if
> it applies to you, but at least some powerop versions wanted to
> replace that).


The main point is that you won't get too many operating points.  You =

will get the number of operating points the x86 port of PowerOP chooses =

to have.  In the cpufreq/PowerOP integration patches you get the same =

number of operating points you have today in cpufreq.   We query ACPI =

for the list or use the hardcoded table.  Also, if we provide a =

userspace API for creating operating points,  distro's can create =

additional operating points that make sense for some specific use cases =

they would like to optimize around.


Matt
