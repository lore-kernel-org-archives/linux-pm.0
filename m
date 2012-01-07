From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH 2/6] PM QoS: Add CPU frequency min/max as PM
 QoS params
Date: Fri, 6 Jan 2012 19:47:46 -0800
Message-ID: <20120107034746.GB3119@mgross-G62>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<1325810186-28986-3-git-send-email-amiettinen@nvidia.com>
	<20120106153027.GE12530@mgross-G62>
	<20120106.213236.1775053150950189700.apm@brigitte.kvy.fi>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120106.213236.1775053150950189700.apm@brigitte.kvy.fi>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ananaza@iki.fi
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2012 at 09:32:36PM +0200, Antti P Miettinen wrote:
> [seems that posting via gmane is broken - resenting manually via mail
> - sorry if you get duplicates]
> 
> mark gross <markgross@thegnar.org> writes:
> > On Fri, Jan 06, 2012 at 02:36:22AM +0200, Antti P Miettinen wrote:
> [..]
> >> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> >> index 5ac91d8..7b8d08b 100644
> >> --- a/include/linux/pm_qos.h
> >> +++ b/include/linux/pm_qos.h
> >> @@ -14,8 +14,11 @@ enum {
> >>  	PM_QOS_CPU_DMA_LATENCY,
> >>  	PM_QOS_NETWORK_LATENCY,
> >>  	PM_QOS_NETWORK_THROUGHPUT,
> >> +	PM_QOS_CPU_FREQ_MIN,
> >> +	PM_QOS_CPU_FREQ_MAX,
> > What is this about?  How sould freq_max make any sense in the context of
> > constraining power mangement throutling?  this is wrong.
> >
> > You should only have a cpu throughput qos.  I.e. FREQ_MIN.
> > FWIW in my patch I named it : PM_QOS_CPU_THROUGHPUT  but, its just a
> > different name to your PM_QOS_CPU_FREQ_MIN name.
> 
> I anticipated getting this comment :-)

I'm glad.  Say did we talk at plumbers last year?  This is starting to
ring a bell.

> I originally added the max just for symmetry. But it could actually be
> useful for e.g. requesting a minimum level of energy efficiency. If your
> workload keeps CPU busy but does not need any specific throughput and
> energy is more critical to you, by limiting the maximum frequency you
> can request a level of energy efficiency (provided that the platform
> DVFS works in a sensible way). Max frequency could be useful also for
> thermal management.

yes, there are a lot of interesting things one can do to attempt to
somewhat gracefully deal with some sort of power or thermal envelope
limitations.  But, they are not PM_QoS. 

> 
> Also, I think general "PM constraints" would be useful, not just
> "minimum level of service" requests so why not extend PM QoS towards a
> generic PM constraints framework?

I think you need to change the name of what you are talking about to
"operational envelopes" or "operational constraints" and not try to
attach it onto pm_qos.  FWIW: I like "envelopes". 

The problem always comes down to not giving the user what is asked
and how to deal with that in a way that doesn't make the device seem
defective.

For instance: Consider thermal envelopes Your watching a video on a
device and its getting hot but, not critical, yet.  What do you do?
When do you do it? 

You can dim the display, (but the user may turn it back up)
You can turn down the audio, (but the user may turn it back up)
You can current limit any charging (if charging is happening at that
time)
You can start closing files or rate limit the data going to user mode.
You can inject cpuidle for a fraction of every millisecond (or some PWM
like idle injection scheme)
You can stop the processes that are keeping the CPU / GPU busy. 

Or you can simply shutdown or suspend the device because its hit a
thermal trigger point and needs a time out.

Another case is you have a battery powered device and the battery is
getting low such that the device will brown out if you light up the
screen or run the vibrator.  How best to deal with this?

Most times its: tell the user battery is critical and shut down.

If there was a nice way to tell the user we are in low battery mode and
only critical operations are allowed then we could do something.

You can also consider a runtime PM like thing where devices are kept in
D1 (or lower) and to get to D0 they need to ask if the system can handle
the registered maxed out D0 state of the device.

But, you need a way to identify and exempt from this policy those
devices and processes processes are critical or won't dead lock the
system if you stop scheduling them or stop letting them go to D0.

Also I'm overlooking the problem of modeling system power needs and
measuring of instantaneous load.  Not simple.

There is no infrastructure to deal with such limitations or operational
envelopes today.  And there may never be a good way to let the user
down.

This is a challenging and interesting problem that will take touching a
lot of the kernel. 

But, it is not pm_qos... IMO.

--mark
