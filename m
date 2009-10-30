From: mgross <mgross@linux.intel.com>
Subject: Re: adding handles to pm_qos?
Date: Fri, 30 Oct 2009 07:56:09 -0700
Message-ID: <20091030145609.GA21256@linux.intel.com>
References: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
	<20091023225304.GA32562@linux.intel.com>
	<000301ca5766$e671f870$b355e950$@org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <000301ca5766$e671f870$b355e950$@org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ai Li <aili@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 27, 2009 at 06:37:58PM -0600, Ai Li wrote:
> > How often are you calling pm_qos_update_requirement?
> > 
> > I think calling pm_qos_ interfaces too often makes me wonder
> > about my
> > assumptions and your sanity.
> > 
> > Can you explain why the pm_qos_update_requirement is getting hit
> > often
> > enough to bother with this change?
> > 
> > Other than that I don't have a problem with moving to handles,
> > if its a
> > practical change made for reasons other than making api abuse
> > less
> > painful.
> > 
> > Further, If the implicit assumption that pmqos calls are on cold
> > paths
> > is wrong, then perhaps more thought is needed than just changing
> > things
> > to handle based searches.
> > 
> 
> Our embedded platforms support different low power modes.  With the
> modes, the deeper the sleep, the more the power savings, and the
> larger the interrupt latency coming out of the low power mode.
> 
> To help the platform achieving greatest power savings, some of our
> device drivers set lateny qos only when there is a service request to
> the driver or a device transaction.  When the transaction or request
> is done, the drivers cancel the QoS with
> pm_qos_update_requirement(PM_QOS_DEFAULT_VALUE), allowing the
> platform to reach a deeper sleep.  
> 
> The approach gives us good power savings.  However when there are
> lots of transactions, pm_qos_update_requirement() gets called a lot
> of times.

Oh. 

This will not scale with the aggregation logic very well at all if
pm_qos update requirement gets hit per transaction through a driver code
path, then I think some thought on the scalability is needed and perhaps
a change to the aggregation design for such uses.

Do you have a patch for the handle implementation I could look at?

--mgross


.  

> 
> ~Ai
> 
