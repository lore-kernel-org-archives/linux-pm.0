From: "Mansoor, Illyas" <illyas.mansoor@intel.com>
Subject: RE: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Tue, 17 Jan 2012 06:25:30 +0000
Message-ID: <810586B7581CC8469141DADEBC37191204112D@BGSMSX102.gar.corp.intel.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl> <87r4yyrh2e.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87r4yyrh2e.fsf@amiettinen-lnx.nvidia.com>
Content-Language: en-US
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of Antti P Miettinen
> Sent: Tuesday, January 17, 2012 11:45 AM
> To: linux-pm@lists.linux-foundation.org
> Cc: cpufreq@vger.kernel.org
> Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
> params
> 
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > If that hasn't been clear enough so far, I'm still not convinced that
> > using PM QoS for that is a good idea.
> >
> > First off, frequency as a unit of throughput is questionable to say
> > the least, because it isn't portable from one system to another.
> > Moreover, even on a given system it isn't particularly clear what the
> > exact correspondence between frequency and throughput actually is.
> >
> > Second, it's not particularly clear what the meaning of the "min"
> > frequency is supposed to be in terms of throughput.
> >
> > Moreover, you make cpufreq export user_policy.min and user_policy.max
> > regardless of the new PM QoS parameters, so it looks like you could
> > use those new attributes to set the min/max as well.
> >
> > Thanks,
> > Rafael
> 
> Thanks - yes - I've understood you are not convinced :-)
> 
> Is there any reason why the mapping from application oriented performance
> requirement metric to hardware oriented performance setting metric would
> need to be inside kernel? As I've said (and Mark Gross seems to agree) the
> performance requirements are likely to be system specific and probably obtained
> via trial and error or some kind of adaptive iteration. Wouldn't it be better to
> leave this complexity outside PM QoS core or even outside kernel if possible?
> 
> The change to cpufreq core just adds two read-only files to be able to inspect
> user_policy.min/max in addition to the currently enforced
> policy->min/max. Yes - there has been the possibility of using the sysfs
> min for setting a frequency floor but this is problematic when there are multiple
> clients. You'd need some kind of arbitration and book keeping to set/restore the
> minimum. And PM QoS provides exactly this mechanism.
> 
> I think the kernel needs to be extended to handle more PM constraints and PM
> QoS is the closest thing I know for this kind of functionality. However, I'm open to
> suggestions about alternative approaches. I think we need e.g. more than just
> min/max "reduction operators". Ideas, anyone?

How about a notion of platform agnostic freq metric that can then me normalized to
The platform available freq's like for example a value 100 that denotes top freq, that
Way PM QoS can then ajust the application requested number to platform available 
Freq.

Just like the On-Demand power_savebias option that uses 0 for the highest freq

-Illyas
