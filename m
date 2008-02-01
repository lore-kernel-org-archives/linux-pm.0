From: David Brownell <david-b@pacbell.net>
Subject: Re: Removing dev.power.power_state (WAS: Feature
	Removals for 2.6.25)
Date: Fri, 1 Feb 2008 13:12:53 -0800
Message-ID: <200802011312.53404.david-b__24968.3115901009$1201900578$gmane$org@pacbell.net>
References: <200801312128.10700.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801312128.10700.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org, Harvey.Harrison@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thursday 31 January 2008, David Brownell wrote:
> Quoth Harvey Harrison:
> 
> > Ping?
> > What:	dev->power.power_state
> > When:	July 2007
> 
> ... there are still quite a few users left, and a new one was (sigh)
> recently added.
> 
>  - drivers/rtc/rtc-sa1100.c ... new usage, merged last week

Fixed in a patch I just sent.

>  - drivers/spi/... some controller drivers use this (look easy to fix)

Ditto.

- Dave
