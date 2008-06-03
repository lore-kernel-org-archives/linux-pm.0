From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Tue, 3 Jun 2008 11:45:38 +0100
Message-ID: <20080603104538.GQ27013__16464.3187811182$1212509980$gmane$org@shadowen.org>
References: <200805291333.42057.david-b@pacbell.net>
	<20080529162257.03426e48.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080529162257.03426e48.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

On Thu, May 29, 2008 at 04:22:57PM -0700, Andrew Morton wrote:

> > +static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
> > +{
> > +	static char		err_readtime [] __initdata =
> > +		KERN_ERR "PM: can't read %s time, err %d\n";
> > +	static char		err_wakealarm [] __initdata =
> > +		KERN_ERR "PM: can't set %s wakealarm, err %d\n";
> > +	static char		err_suspend [] __initdata =
> > +		KERN_ERR "PM: suspend test failed, error %d\n";
> > +	static char		info_test [] __initdata =
> > +		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
> 
> - One tab before the variable space is a waste of space.  Two tabs is
>   just extravagant.
> 
> - The space before the [] shouldn't be there.  checkpatch misses this.

Ok, this should be picked up in the next release:

ERROR: space prohibited before open square bracket '['
#1: FILE: Z152.c:1:
+       static char             info_test [] __initdata =

-apw
