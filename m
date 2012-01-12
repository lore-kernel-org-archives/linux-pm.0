From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Fri, 13 Jan 2012 00:55:35 +0100
Message-ID: <201201130055.35698.rjw@sisk.pl>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201120015.55740.rjw@sisk.pl>
	<87ipkhco4h.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ipkhco4h.fsf@amiettinen-lnx.nvidia.com>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 12, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> By blocking sleep states we can address "system level latency" or "best case
> >> latency" but as far as I can see PM QoS does not address "worst case
> >> latency".
> >
> > I'm not sure what you mean by "worst case latency".
> 
> Umm.. the usual concept. If latency is the time from stimulus to
> response, this time can vary based on context. One part of the context
> is the hardware state but there is also the system load. So for example
> the time from interrupt to display being updated is affected by hardware
> state but also system load. As far as I understand, current PM QoS
> latency requests addresses hardware state but do not account for
> possible resource contention, e.g. several latency sensitive clients
> (device drivers, tasks) competing for CPU. In this sense minimum CPU
> frequency requests would be similar.

That's correct, we don't take possible contention into account in PM QoS,
because such conditions may happen idependently of power management anyway.

Thanks,
Rafael
