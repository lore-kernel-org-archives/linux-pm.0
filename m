From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Thu, 19 Jan 2012 00:10:38 +0100
Message-ID: <201201190010.38790.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com> <201201172227.59080.rjw@sisk.pl> <87ipk9qwff.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87ipk9qwff.fsf@amiettinen-lnx.nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 18, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> [..]
> > If I understand you correctly, you want to have an iterface for specifying
> > min and max frequencies from user space.  I can understand that.  At least
> > I can see some use cases for that.
> >
> > Now, the question is if using the PM QoS framework is the right way to do
> > that.
> >
> >> The change to cpufreq core just adds two read-only files to be able to
> >> inspect user_policy.min/max in addition to the currently enforced
> >> policy->min/max. Yes - there has been the possibility of using the sysfs
> >> min for setting a frequency floor but this is problematic when there are
> >> multiple clients. You'd need some kind of arbitration and book keeping
> >> to set/restore the minimum. And PM QoS provides exactly this mechanism.
> >
> > Just as I suspected. :-)
> >
> > OK, so what's your anticipated usage model of this?
> 
> We've been experimenting with hooking the frequency boost to e.g. touch
> screen UI events and application launch. I believe there are also some
> specific applications that would want to either set a frequency floor or
> ceiling in some situations.
> 
> >> I think the kernel needs to be extended to handle more PM constraints
> >> and PM QoS is the closest thing I know for this kind of
> >> functionality. However, I'm open to suggestions about alternative
> >> approaches. I think we need e.g. more than just min/max "reduction
> >> operators". Ideas, anyone?
> >
> > I first need to know who those multiple clients are going to be.
> >
> > Thanks,
> > Rafael
> 
> For the touch screen UI, the boost could be implemented as a kernel
> module hooked with suitable event filter to the input event
> stream. Another possibility is the UI framework in user space. Some
> specific user space applications would also be clients.

I see.

However, if you use PM QoS for that as proposed, there will be only one
misc device for the minimum CPU frequency and one for the maximum, so
user space will only be able to specify those numbers globally, ie. for
all CPUs in the system.  Is that your intention?

Rafael
