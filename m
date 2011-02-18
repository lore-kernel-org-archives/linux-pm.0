From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Fri, 18 Feb 2011 10:17:20 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102181006110.1972-100000@iolanthe.rowland.org>
References: <20110218063955.GA2558@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110218063955.GA2558@verge.net.au>
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
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 18 Feb 2011, Simon Horman wrote:

> Hi Mark,
> 
> On Thu, Feb 17, 2011 at 09:05:16PM -0800, mark gross wrote:
> > On Fri, Feb 18, 2011 at 10:54:56AM +0900, Simon Horman wrote:
> > > In "PM QoS: Correct pr_debug() misuse and improve parameter checks"
> > > the parsing of the ASCII hex value was tightened. Unfortunately
> > > it was tightened to the point where no value is valid.
> > 
> > How is it of no value?  Can you not sent a 10 char string with a
> > zero-byte end of string maker?
> 
> My testing indicates that
> 
> echo -n "0x12345678" will yield count == 10 in copy_from_user()
> 
> that
> 
> echo "0x12345678" will yield count == 11 in copy_from_user()
> 
> and that in both case strlen() will yeild the same value as count.
> 
> > Is expecting the c-string marker in the interface a bad idea that needs
> > fixing?
> 
> I think that is the crux of the problem from my point of view.
> That is, using echo as above there is no '\0' by the time
> the string gets to the kernel.
> 
> I now see that the following works :-)
> 
> echo -ne '0x12345678\0' | dd of=/dev/network_latency
> 
> However I wonder if the call to strlen() is safe.
> In the case of the following is there any guarantee that
> ascii_value is '\0' terminated? Perhaps strnlen() is needed?
> 
> echo -n '0x123456789' | dd of=/dev/network_latency

Normally these interfaces are designed so that people can do either

	echo '...data...' >/dev/...

or

	echo -n '...data...' >/dev/...

and it will just work.  This means you should allow count to be equal 
to either 10 or 11, but if it is 11 then you should check that the last 
character really is '\n'.

Also, you might want to consider using strict_strtoul() for parsing or 
conversion.

Alan Stern
