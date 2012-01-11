From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Thu, 12 Jan 2012 00:15:55 +0100
Message-ID: <201201120015.55740.rjw@sisk.pl>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201102144.00903.rjw@sisk.pl>
	<87vcoid7j5.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87vcoid7j5.fsf@amiettinen-lnx.nvidia.com>
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

On Wednesday, January 11, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > On Monday, January 09, 2012, Antti P Miettinen wrote:
> >> Hmm.. congestion is an issue for latency requests as well.
> >
> > I'm not sure what you mean.  Care to elaborate?
> >
> > Rafael
> 
> Well, I was just thinking that latencies can get hurt by system load
> just like throughput can suffer from load.

The idea with latencies is different.  Latency constraints specify how
much time a given resource may be unavailable (due to power management).
So, when putting the resource into a low-power state we only need to
consider the minimum of those.

> By blocking sleep states we can address "system level latency" or "best case
> latency" but as far as I can see PM QoS does not address "worst case
> latency".

I'm not sure what you mean by "worst case latency".

Thanks,
Rafael
