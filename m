From: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: [RFC] PowerOP Take 3, sysfs UI core 2/5
Date: Wed, 26 Jul 2006 17:30:51 -0700
Message-ID: <5389061B65D50446B1783B97DFDB392D01F92E78@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>, David Brownell <david-b@pacbell.net>
Cc: "Mochel, Patrick" <patrick.mochel@intel.com>, linux-pm@lists.osdl.org, sampsa.fabritius@nokia.com, Pavel Machek <pavel@ucw.cz>, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-pm-bounces@lists.osdl.org
[mailto:linux-pm-bounces@lists.osdl.org] On Behalf Of Matthew
>Locke
>Sent: Wednesday, July 26, 2006 12:45 AM
>To: David Brownell
>Cc: Mochel, Patrick; Pavel Machek; linux-pm@lists.osdl.org;
sampsa.fabritius@nokia.com;
>linux@dominikbrodowski.net
>Subject: Re: [linux-pm] [RFC] PowerOP Take 3, sysfs UI core 2/5
>
>
>On Jul 24, 2006, at 11:48 AM, David Brownell wrote:
>
>> On Monday 24 July 2006 10:29 am, Pavel Machek wrote:
>>
>>> That looks quite ugly to do in sysfs, indeed.
>>
>> Yes, it's long been one of the things I most dislike about this
>> PowerOP thing.
>> Not just the UI, but the models it reflects.
>>
>> So I was glad to see it split out as fully optional... although from
>> what I
>> see, the internal models in the code have derived from this sysfs
>> model, so
>> I'd argue those need to change too.
>
>Is there something specific in the internal model that are you
>referring to?
>
>>
>> It'd be lots better to just have named operating points that get
>> selected just
>> the /sys/power/state file selects the, erm, "sleep point".
>
>I've tried to fit sleep into the operating point concept before but
>sleep always ends up being a special case.   The code has to check to
>see if the selected operating the "sleep point" and call the suspend
>function.  I think tying in sleep to the op point concept needs more
>discussion and probably should be handled separately until we get
>further along with power op.
>
>btw, we are in complete agreement about using named points.  This first
>set of patches is meant to introduce the operating point concept into
>the kernel without requiring massive changes to cpufreq.  This layer
>extends the bottom part of cpufreq to enable the control of multiple
>parameters beyond just cpu frequency and voltage across architectures.
>Currently, cpufreq does not use named operating points so we need to
>make sure cpufreq can use the power op API and continue to function.
>This topic also ties into our other email discussion on creating op
>points and names are assigned to op points.

I'm sorry if I take things off into a too large of a tangent with this.

I've been wanting to try to get multiple power parameter control some
how integrated with cpufreq for a while now.  Call it an itch and I may
be all wet on the following:  =


The way this plugs into the cpufreq code is from the architecture
dependent cpufreq_driver level.  I guess this is an easy first step, but
I wonder if / how something could be brought up to a higher level
somehow.  I don't know what this would look like at the moment.  But,
having a control system (cpufreq + governors) that control a single
variable, cpu frequency, that gets mapped into multi-variable control
(the operating point n-tuple) seems clunky to me.  =


Could we do better or more with a multivariable control from the
beginning?

--mgross
