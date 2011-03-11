From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: WARNING: at kref_get
Date: Fri, 11 Mar 2011 21:04:51 +0100
Message-ID: <201103112104.51710.rjw@sisk.pl>
References: <20110310054945.GB3058@merit.edu> <201103101139.58837.rjw@sisk.pl>
	<20110311012246.GA1115@merit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110311012246.GA1115@merit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jim Rees <rees@umich.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, March 11, 2011, Jim Rees wrote:
> Rafael J. Wysocki wrote:
> 
>   On Thursday, March 10, 2011, Jim Rees wrote:
>   > Was there ever a resolution to this bug?
>   
>   Do you still see the warning in 2.6.38-rc8?
> 
> I won't be able to test it, rc8 is unusable for other reasons.  My
> orinoco_cs won't resume after suspend.  I put a dmesg here in case you're
> interested:
> 
> http://jim.rees.org/x40-38-rc8.log

PCMCIA resume problem have been reported already, but the root cause is
unknown.  It looks like the driver's resume callback is never executed.

Thanks,
Rafael
