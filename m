From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: What woke system up?
Date: Thu, 05 Jan 2006 18:27:41 -0800
Message-ID: <43BDD59D.4090400@mvista.com>
References: <20051221002958.GA15851@slurryseal.ddns.mvista.com>	<Pine.LNX.4.50.0512201809520.21656-100000@monsoon.he.net>	<20051222034630.GA4320@slurryseal.ddns.mvista.com>	<20060104182116.GA17218@best.com>
	<Pine.LNX.4.50.0601051321550.17046-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0601051321550.17046-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Patrick Mochel wrote:
> Out of curiosity, are there really cases where there is > 1 wakeup
> device?

I will guess there are systems in which software will be presented with 
more than one candidate device that may have woken the system (for 
example, more than one interrupt is pending at resume time, and this is 
the only information available on what the wakeup source was).  But I 
don't have a definite example of such a system.   So far I've only 
looked at 2 embedded platforms.  One of 'em devotes registers 
specifically to what woke up the system, and has not yet turned up 2 
wakers, but I haven't hit this very hard yet.  The other I can't get 
useful info out of as of yet.

-- 
Todd
