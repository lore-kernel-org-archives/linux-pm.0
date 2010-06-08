From: "Chidambaram, Praveen" <pchidamb@codeaurora.org>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 8 Jun 2010 08:44:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1006080830090.14258@pchidamb-lnx.qualcomm.com>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
	<20100525145223.GA4974@gvim.org>
	<AANLkTikLgu2c1GPE3glHLlaznOM59SVeCj2NHzDjyjZR@mail.gmail.com>
	<20100608033333.GA23066@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100608033333.GA23066@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: kheitke@codeaurora.org, mark gross <640e9920@gmail.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Most of the ideas where around clock throttling of buses and memory.
> Things like throttling the graphics BW to whatever memory it was using,
> or clocking down the GPU when idle.  My thought was a pm_qos hint could
> be handy, but I was assured that modern hardware auto-throttled and
> didn't need this.  So I dropped it.  (At that time I also thought it
> would apply to HD audio to allow better DAC throttling.  I also dropped
> this one too for the same reasons.)

Yes, auto throttling by tying the Bus clock in relation to the CPU is 
a fairly good idea, but cannot be the only solution. The drivers know 
best their requirements and some drivers would need arbirated 
bandwidth that no one else can encroach on.

> One problem was what type of units to use when talking about the qos of
> the graphics was not obvious.  It needs to be something meaningful to  
> be portable or provide a good abstraction.

With PM QoS you can specify one parameter. However, a single parameter 
is quite insufficient. To specify bus bandwidth (say MBPS), we would 
need 2 dimensional values. Buses are getting complex and the arbiters 
that sit around them can make good decisions when they are fed the 
right data. The clock speed is just one of them. To allocate a 
bandwidth to a specific client, you would need to specify the amount 
of data to be transferred and when transferred, the amount of data in 
burst that need to be transferred would help in specifying the speed 
for each transaction. The clock speed can be deduced by the 
arbiter/driver from these two inputs.

> One problem was what type of units to use when talking about the qos of
> the graphics was not obvious.  It needs to be something meaningful to
> be portable or provide a good abstraction.

The units as we understand better are MBPS. They are something that 
drivers can calculate before they make a request and request the 
Bandwidth and the burst bandwidth to the arbiter.

What do you think about vector data inputs?

Thanks,
Praveen
