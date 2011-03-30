From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Wed, 30 Mar 2011 16:11:12 +0900
Message-ID: <20110330071111.GB23039@verge.net.au>
References: <20110224161732.GA6512@gvim.org>
	<Pine.LNX.4.44L0.1102241154540.2084-100000@iolanthe.rowland.org>
	<20110306140714.GA2438@gvim.org> <201103292201.24270.rjw@sisk.pl>
	<20110330035910.GA7163@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110330035910.GA7163@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: mark gross <markgross@thegnar.org>
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 29, 2011 at 08:59:11PM -0700, mark gross wrote:
> On Tue, Mar 29, 2011 at 10:01:24PM +0200, Rafael J. Wysocki wrote:
> > On Sunday, March 06, 2011, mark gross wrote:
> > > On Thu, Feb 24, 2011 at 12:00:35PM -0500, Alan Stern wrote:
> > > > On Thu, 24 Feb 2011, mark gross wrote:
> > > > 
> > > > > > How careful do you want to be here?  For example, which of the
> > > > > > following inputs do you want to accept?
> > > > > > 
> > > > > > 	0x1234
> > > > > > 	abcd1234
> > > > > > 	abcd123456
> > > > > > 	abcd123456\n
> > > > > > 	abcd1234567
> > > > > > 	1234567890
> > > > > > 	1234567890\n
> > > > > > 	12345678901
> > > > > 
> > > > > > 	0x12345678
> > > > > > 	0x12345678\n
> > > > > just these 2 are what I had planned to allow after this email thread.
> > > > > 
> > > > > > 	0x123456789
> > > > > > 
> > > > > > Maybe it's okay to be a little relaxed about this, and trust the caller 
> > > > > > to pass in data that makes sense.
> > > > > yeah but is it worth the effort?
> > > > 
> > > > Checking for exactly those two forms really is a lot of effort.  You
> > > > have to make sure the first two characters are "0x" or "0X", you have
> > > > to check that each of the next eight characters is a valid hex digit,
> > > > and you have to verify that the 11th character, if present, is a
> > > > newline.
> > > > 
> > > > If you can get results that are good enough just by calling
> > > > strict_strtoul() without all these checks, it's probably worthwhile.
> > > >
> > > I just don't want any buffer overrun bugs in code I'm writing.
> > > 
> > > I like the attached thank you for all the really useful input.
> > > 
> > > --mark
> > > Signed-off-by: mark gross <markgross@thegnar.org>
> > 
> > Mark, do you want the patch below to be merged?
> > 
> > Rafael
> > 
> 
> Yes.  There is was some discussion on if we should relax the value
> checking beyond this that died off.  But, at a minimum I think this
> should be merged as it fixes the usability issue raised by Simon.

Not entirely surprisingly, I agree :-)

Acked-by: Simon Horman <horms@verge.net.au>
> 
> thanks,
> 
> --mark
> 
> > 
> > > From df199e491c750c529abcfb0e2256f508f1afd061 Mon Sep 17 00:00:00 2001
> > > From: mark gross <markgross@thegnar.org>
> > > Date: Sun, 6 Mar 2011 05:45:44 -0800
> > > Subject: [PATCH] correct PM QOS's user mode interface to work with ascii input per
> > >  what is in the kernel docs.  Writing a string to the ABI from user mode
> > >  comes in 2 flavors.  one with and one without a '\n' at the end.  this
> > >  change accepts both.
> > > 
> > >  echo 0x12345678 > /dev/cpu_dma_latency
> > > and
> > >  echo -n 0x12345678 > /dev/cpu_dma_latency
> > > now both work.
> > > ---
> > >  kernel/pm_qos_params.c |   15 ++++++++-------
> > >  1 files changed, 8 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > index aeaa7f8..b315446 100644
> > > --- a/kernel/pm_qos_params.c
> > > +++ b/kernel/pm_qos_params.c
> > > @@ -40,6 +40,7 @@
> > >  #include <linux/string.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/init.h>
> > > +#include <linux/kernel.h>
> > >  
> > >  #include <linux/uaccess.h>
> > >  
> > > @@ -387,15 +388,15 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> > >  	if (count == sizeof(s32)) {
> > >  		if (copy_from_user(&value, buf, sizeof(s32)))
> > >  			return -EFAULT;
> > > -	} else if (count == 11) { /* len('0x12345678/0') */
> > > -		if (copy_from_user(ascii_value, buf, 11))
> > > +	} else if (count == 10 || count == 11) { /* '0x12345678' or
> > > +						    '0x12345678/n'*/
> > > +		ascii_value[count] = 0;
> > > +		if (copy_from_user(ascii_value, buf, count))
> > >  			return -EFAULT;
> > > -		if (strlen(ascii_value) != 10)
> > > +		if ((x=strict_strtol(ascii_value, 16, &value)) != 0){
> > > +			pr_debug("%s, 0x%x, 0x%x\n",ascii_value, value, x);
> > >  			return -EINVAL;
> > > -		x = sscanf(ascii_value, "%x", &value);
> > > -		if (x != 1)
> > > -			return -EINVAL;
> > > -		pr_debug("%s, %d, 0x%x\n", ascii_value, x, value);
> > > +		}
> > >  	} else
> > >  		return -EINVAL;
> > >  
> > > 
> > 
> 
