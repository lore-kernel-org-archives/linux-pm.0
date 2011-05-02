From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Q] error handling in runtime PM
Date: Mon, 2 May 2011 10:00:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1105020954070.2106-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.64.1105021339140.13244@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.1105021339140.13244@axis700.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2 May 2011, Guennadi Liakhovetski wrote:

> Hi all
> 
> There are currently several functions similar to __pm_runtime_suspend() in 
> runtime.c, working according to the same principle: they check if the 
> RPM_GET_PUT flag is set, if so, they increment, or decrement-and-test the 
> usage-count, then call the actual worker function, e.g., rpm_suspend(). 
> This latter function can fail, then its return code will be passed back to 
> the caller, but - the usage counter will not be restored. Is this a design 
> decision or a bug?

It's a design decision.  In the case of suspend it really is the right
thing to do.  By calling the function you are telling the PM core that
you're finished using the device.  But some other code might be waiting
to use it, therefore we do indeed want to decrement usage_count while
leaving the device active.

For resumes, you have the option of writing a little wrapper function 
that calls the underlying pm_runtime_get_* routine and then decrements 
usage_count if there was an error.

Alan Stern
