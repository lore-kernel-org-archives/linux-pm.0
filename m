From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS params
Date: Thu, 19 Jan 2012 00:16:03 +0100
Message-ID: <201201190016.03552.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com> <20120118031319.GB27153@mgross-G62> <87ehuxqveg.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87ehuxqveg.fsf@amiettinen-lnx.nvidia.com>
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 18, 2012, Antti P Miettinen wrote:
> mark gross <markgross@thegnar.org> writes:
> > I'm not a big fan of the cpufreq seamanly redundant export either.
> > Doesn't the equivalent data get exported under
> > /sys/devices/system/cpu/cpu?/cpufreq/ ?
> 
> The added sysfs nodes are under /sys/devices/system/cpu/cpu?/cpufreq.
> They do no not duplicate functionality, they are just an
> addition.

So please drop them for now.

> Currently you can request a new minimum by writing to
> scaling_min_freq and you can view the currently enforced policy->min via
> the same file. Patch 3 adds read-only policy_{min,max}_freq nodes for
> being able to inspect the user_policy.min/max. This is related to patch
> 4 which preserves the requested min/max in user_policy instead of
> storing the enforced min/max to user_policy. This is in turn related to
> patch 5. We need to be able to revert back to requested min/max when PM
> QoS constraints get lifted. I think we do not want to overwrite
> user_policy min/max with policy->min/max as those values can be affected
> by temporary constraints.
> 
> I would welcome more comments on patches 3 and 4.

I would drop patch 3 and fold patch 4 into patch 5.

Thanks,
Rafael
