From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 2/6] PM QoS: Add CPU frequency min/max as PM
	QoS params
Date: Fri, 06 Jan 2012 21:32:36 +0200 (EET)
Message-ID: <20120106.213236.1775053150950189700.apm@brigitte.kvy.fi>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-3-git-send-email-amiettinen@nvidia.com>
	<20120106153027.GE12530@mgross-G62>
Reply-To: ananaza@iki.fi
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
List-Id: linux-pm@vger.kernel.org

[seems that posting via gmane is broken - resenting manually via mail
- sorry if you get duplicates]

mark gross <markgross@thegnar.org> writes:
> On Fri, Jan 06, 2012 at 02:36:22AM +0200, Antti P Miettinen wrote:
[..]
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index 5ac91d8..7b8d08b 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -14,8 +14,11 @@ enum {
>>  	PM_QOS_CPU_DMA_LATENCY,
>>  	PM_QOS_NETWORK_LATENCY,
>>  	PM_QOS_NETWORK_THROUGHPUT,
>> +	PM_QOS_CPU_FREQ_MIN,
>> +	PM_QOS_CPU_FREQ_MAX,
> What is this about?  How sould freq_max make any sense in the context of
> constraining power mangement throutling?  this is wrong.
>
> You should only have a cpu throughput qos.  I.e. FREQ_MIN.
> FWIW in my patch I named it : PM_QOS_CPU_THROUGHPUT  but, its just a
> different name to your PM_QOS_CPU_FREQ_MIN name.

I anticipated getting this comment :-)

I originally added the max just for symmetry. But it could actually be
useful for e.g. requesting a minimum level of energy efficiency. If your
workload keeps CPU busy but does not need any specific throughput and
energy is more critical to you, by limiting the maximum frequency you
can request a level of energy efficiency (provided that the platform
DVFS works in a sensible way). Max frequency could be useful also for
thermal management.

Also, I think general "PM constraints" would be useful, not just
"minimum level of service" requests so why not extend PM QoS towards a
generic PM constraints framework?

	--Antti
