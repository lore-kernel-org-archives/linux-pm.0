From: mark gross <640e9920@gmail.com>
Subject: Re: PM QoS dynamic resource manager
Date: Tue, 25 May 2010 07:52:23 -0700
Message-ID: <20100525145223.GA4974@gvim.org>
References: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005211533530.25765@pchidamb-lnx.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Chidambaram, Praveen" <pchidamb@codeaurora.org>
Cc: linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 21, 2010 at 03:37:39PM -0600, Chidambaram, Praveen wrote:
> Hi,
> 
> I am looking for some extensible features for PM QoS. Specifically, 
> dynamic runtime parameters that my architecture could define at 
> runtime and the drivers can make use of. 
> 
> What are the plans in this regard?

we've talked about it a few times in the past.  

It's come down to how do we prevent platform independent code from
depending on such platform independent dynamic prarams in a sane manner.

I've alway's pushed for coming up with more reasonable abstractions that
could be re-used and adding them (like the bus thing) as opposed to
having drivers make / use new parrameters dynamically.

--mgross

> 
> Thanks,
> Praveen
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
