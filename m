From: mgross <mgross@linux.intel.com>
Subject: Re: adding handles to pm_qos?
Date: Fri, 23 Oct 2009 15:53:04 -0700
Message-ID: <20091023225304.GA32562@linux.intel.com>
References: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <000001ca4cf3$2a2da9c0$7e88fd40$@org>
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

On Wed, Oct 14, 2009 at 11:24:19AM -0600, Ai Li wrote:
> We are calling pm_qos from some of our drivers.  One concern is that
> each call of pm_qos_update_requirement() iterates through the client
> list and strcmp the client names.  It could be slow.  A proposal is
> that pm_qos provides handles that can be used on
> pm_qos_update_requirement().
> 
> For measurement purposes, I added get/put interfaces to
> acquire/release the handles and a new pm_qos_update_requirement
> function that bypasses the iteration and strcmp.  Here are some
> collected data:
> 
> How many clock cycles does pm_qos_update_requirement take?
> when there is one client on this qos_class:
>     using handle        using name      using handle/using name
> avg 252.4               400.4           63%
> 
> when there are 5 clients on this qos_class:
>     using handle        using name      using handle/using name
> avg 407.6               644.8           63%
> 
> when there are 10 clients on this qos_class:
>     using handle        using name      using handle/using name
> avg 582.4               938.4           62%
> 
> Given the time differences, it seems worthwhile to add handles.

How often are you calling pm_qos_update_requirement?  

I think calling pm_qos_ interfaces too often makes me wonder about my
assumptions and your sanity.

Can you explain why the pm_qos_update_requirement is getting hit often
enough to bother with this change?

Other than that I don't have a problem with moving to handles, if its a
practical change made for reasons other than making api abuse less
painful.

Further, If the implicit assumption that pmqos calls are on cold paths
is wrong, then perhaps more thought is needed than just changing things
to handle based searches.

--mgross




 
> ~Ai
> 
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
