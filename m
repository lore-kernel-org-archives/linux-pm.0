From: mark gross <markgross@thegnar.org>
Subject: Re: PM QoS: Interface design question
Date: Tue, 22 Feb 2011 22:47:04 -0800
Message-ID: <20110223064704.GA26136@gvim.org>
References: <20110222062944.GA5125@verge.net.au>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110222062944.GA5125@verge.net.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-pm@lists.linux-foundation.org, Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 22, 2011 at 03:30:10PM +0900, Simon Horman wrote:
> Hi,
> 
> I am curious about an aspect of the design of PM QoS.
> 
> While working with the devices provided to configure PM QoS it struck me
> that this is a rather unusual interface - holding a file descriptor to a
> device open so long as configuration parameters apply.  I understand that
> this is a mechanism to apply parameters on a per-task basis.  But I am
> wondering if any consideration was given to using cgroups, which seem to me
> to be designed specifically for applying QoS parameters on a per-task
> basis.
The design was driven by a worry that we cannot trust user mode to
remember to clean up after itself and we needed a way to make sure any
requests made from user mode would be cleaned up when the application
went way for any reason.

I don't think cgroups existed when we first put this in place.  At the
time we where trying to figure out how to get applications that cared
the ability to constrain the throttling of the system.  The thinking was
that the app knows better than anyone what its latency and throughput
needs are and if it cared it should set them.  I was thinking of a
network game or skype type of thing that would request lower-latency
network when its running as a use case.

I still think it should be the burden of the application to request the
resources it needs if it really cares.  But, to date I don't think any
application really cares and the API to user mode should have waited for
user mode users requesting it before being implemented.  That way the
abi could have had more input before it got away from us.


--mark
