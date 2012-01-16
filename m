From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Mon, 16 Jan 2012 22:38:57 +0100
Message-ID: <201201162238.57556.rjw@sisk.pl>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, January 16, 2012, Antti P Miettinen wrote:
> [did not reach linux-pm as I sent to wrong address, sorry for
> duplicates]
> 
> The inspiration for this patch series is the N9 CPU frequency boost
> upon input events:
> 
> http://www.spinics.net/lists/cpufreq/msg00667.html
> 
> and the related changes in git://codeaurora.org/kernel/msm.git tree.
> Those patches modify the ondemand cpufreq governor. This patch series
> adds minimum and maximum CPU frequency as PM QoS parameters and
> modifies the cpufreq core to enforce the PM QoS limits.

If that hasn't been clear enough so far, I'm still not convinced that using
PM QoS for that is a good idea.

First off, frequency as a unit of throughput is questionable to say the least,
because it isn't portable from one system to another.  Moreover, even on a
given system it isn't particularly clear what the exact correspondence
between frequency and throughput actually is.

Second, it's not particularly clear what the meaning of the "min" frequency
is supposed to be in terms of throughput.

Moreover, you make cpufreq export user_policy.min and user_policy.max
regardless of the new PM QoS parameters, so it looks like you could use those
new attributes to set the min/max as well.

Thanks,
Rafael
