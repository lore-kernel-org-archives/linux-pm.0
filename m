From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 3/6] cpufreq: Export user_policy min/max
Date: Sat, 07 Jan 2012 10:47:23 +0200 (EET)
Message-ID: <20120107.104723.1386766787855536005.apm@brigitte.kvy.fi>
References: <20120106153320.GF12530@mgross-G62>
	<20120106.212926.720061341805749024.apm@brigitte.kvy.fi>
	<20120107035328.GC3119@mgross-G62>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120107035328.GC3119@mgross-G62>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: mark gross <markgross@thegnar.org>
> Maybe I'm missing something but cpufreq already has ABI for setting
> upper and lower bounds for frequencies.
> 
> /sys/devices/system/cpu/cpu0/cpufreq/[scaling_min_freq,
> scaling_max_freq]
> 
> --mark

Yes, and the patch just adds two read-only files,
/sys/devices/system/cpu/cpu?/cpufreq/policy_{min,max}_freq:

+show_one(policy_min_freq, user_policy.min);
+show_one(policy_max_freq, user_policy.max);

to show the user_policy.min/max in addition to the
policy->min/max. This is related to patch 4 which changes the
scaling_{min,max}_freq store function to store the received value to
user_policy instead of the enforced value. Related in turn to the
restoring of the policy values when PM QoS constraints get lifted. The
purpose of patch 3 is to allow inspecting the requested min/max in
addition to the enforced min/max.

	--Antti

Adding cpufreq to cc, previous comments for context:

http://thread.gmane.org/gmane.linux.power-management.general/26532
