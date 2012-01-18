From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Wed, 18 Jan 2012 10:15:03 +0200
Message-ID: <87ehuxqveg.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201162238.57556.rjw@sisk.pl> <20120118031319.GB27153@mgross-G62>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

mark gross <markgross@thegnar.org> writes:
> I'm not a big fan of the cpufreq seamanly redundant export either.
> Doesn't the equivalent data get exported under
> /sys/devices/system/cpu/cpu?/cpufreq/ ?

The added sysfs nodes are under /sys/devices/system/cpu/cpu?/cpufreq.
They do no not duplicate functionality, they are just an
addition. Currently you can request a new minimum by writing to
scaling_min_freq and you can view the currently enforced policy->min via
the same file. Patch 3 adds read-only policy_{min,max}_freq nodes for
being able to inspect the user_policy.min/max. This is related to patch
4 which preserves the requested min/max in user_policy instead of
storing the enforced min/max to user_policy. This is in turn related to
patch 5. We need to be able to revert back to requested min/max when PM
QoS constraints get lifted. I think we do not want to overwrite
user_policy min/max with policy->min/max as those values can be affected
by temporary constraints.

I would welcome more comments on patches 3 and 4.

	--Antti
