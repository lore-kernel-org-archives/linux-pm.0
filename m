From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Thu, 24 Feb 2011 08:17:32 -0800
Message-ID: <20110224161732.GA6512@gvim.org>
References: <20110223065647.GB26136@gvim.org>
	<Pine.LNX.4.44L0.1102231009070.2233-100000@iolanthe.rowland.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1102231009070.2233-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 23, 2011 at 10:20:35AM -0500, Alan Stern wrote:
> On Tue, 22 Feb 2011, mark gross wrote:
> 
> > On Mon, Feb 21, 2011 at 08:33:36PM -0800, mark gross wrote:
> > > On Fri, Feb 18, 2011 at 10:54:56AM +0900, Simon Horman wrote:
> > > > In "PM QoS: Correct pr_debug() misuse and improve parameter checks"
> > > > the parsing of the ASCII hex value was tightened. Unfortunately
> > > > it was tightened to the point where no value is valid.
> > > > 
> > > > Root of the problem seems to lie in wheather the ASCII hex is followed
> > > > by a '\n' or not. My reading of the documentation is that the '\n' should
> > > > not be present. However the code previously only accepted that version.
> > > > The current code accepts neither. My fix is to accept both.
> > > > 
> > > > Cc: Mark Gross <markgross@thegnar.org>
> > > > Cc: Dan Carpenter <error27@gmail.com>
> > > > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > > 
> > > > ---
> > > > This appears to have been introduced around 2.6.36-rc4.
> > > > And was an @stable patch. As such I believe this change
> > > > is stable material.
> > > > ---
> > > >  kernel/pm_qos_params.c |    7 ++++---
> > > >  1 files changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > > index aeaa7f8..98a34ea 100644
> > > > --- a/kernel/pm_qos_params.c
> > > > +++ b/kernel/pm_qos_params.c
> > > > @@ -387,10 +387,11 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> > > >  	if (count == sizeof(s32)) {
> > > >  		if (copy_from_user(&value, buf, sizeof(s32)))
> > > >  			return -EFAULT;
> > > > -	} else if (count == 11) { /* len('0x12345678/0') */
> > > > -		if (copy_from_user(ascii_value, buf, 11))
> > > > +	} else if (count == 11 || count == 10) { /* len('0x12345678\n') or
> > > shouldn't this be count ==12 ||count ==10?
> > > After taking Alan's advice and looking at strict_strtoul it looks like
> > > 10 and 12 are the numbers to use.
> > > 
> > > Also playing with your dd test:
> > > mgross@mgt:~$ echo -n 0x12345678 | dd of=junk.bin
> > > 0+1 records in
> > > 0+1 records out
> > > 10 bytes (10 B) copied, 0.000368621 s, 27.1 kB/s
> > > mgross@mgt:~$ hexdump junk.bin 
> > > 0000000 7830 3231 3433 3635 3837               
> > > 000000a
> > > mgross@mgt:~$ echo  0x12345678 | dd of=junk.bin
> > > 0+1 records in
> > > 0+1 records out
> > > 11 bytes (11 B) copied, 0.000384755 s, 28.6 kB/s
> > > mgross@mgt:~$ hexdump junk.bin 
> > > 0000000 7830 3231 3433 3635 3837 000a          
> > > 000000b
> 
> The "extra" byte here is undoubtedly caused by the fact that hexdump is 
> presenting the data in 2-byte chunks.  I almost always invoke hexdump 
> with the -C option, to get individual bytes.  The length of the data 
> really is 11 bytes.
> 
> > > 
> > > it looks like I have 10 or 12 bytes (but can't reconcile the dd output
> > > saying 11 bytes when hexdump is showing 12 )
> > 
> > on a 64 bit ubuntu box its 11 bytes that get sent to the kernel hexdump
> > must be padding the extra byte.> 
> > > The following patch (untested) should make things work ok.
> > it doesn't work and I'm still debugging some straingess with  strict_strtoul
> > 
> > it looks like its munging the string I'm passing in.
> 
> No, strict_strtoul() doesn't touch the input string.

I've been having really bad luck with this function.  I must be having a
operator error happening.  I'm still looking at it and plan on setting
up more tracing tonight.
 
> > > diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> > > index aeaa7f8..6cbce91 100644
> > > --- a/kernel/pm_qos_params.c
> > > +++ b/kernel/pm_qos_params.c
> > > @@ -381,19 +381,18 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
> > >  {
> > >  	s32 value;
> > >  	int x;
> > > -	char ascii_value[11];
> > > +	char ascii_value[12];
> > >  	struct pm_qos_request_list *pm_qos_req;
> > >  
> > >  	if (count == sizeof(s32)) {
> > >  		if (copy_from_user(&value, buf, sizeof(s32)))
> > >  			return -EFAULT;
> > > -	} else if (count == 11) { /* len('0x12345678/0') */
> > > -		if (copy_from_user(ascii_value, buf, 11))
> > > +	} else if (count == 10 || count == 12) { /* '0x12345678' or
> > 	} else if (count == 10 || count == 11) { /* '0x12345678' or
> 
> The test should be for 10 or 11: "0x12345678" or "0x12345678\n".  By 
> the way, note the difference between "\n" and "/n".
> 
> > > +						    '0x12345678/n/0'*/
> > > +		memset(ascii_value, 0, sizeof(ascii_value));
> 
> Actually, it suffices to do
> 
> 		ascii_value[count] = 0;
> 
> if the number of bytes you copy is equal to count.
true.
 
> > > +		if (copy_from_user(ascii_value, buf, count))
> > 		if (copy_from_user(ascii_value, buf, 10))
> 
> Which line does the patch add?
> 
> > >  			return -EFAULT;
> > > -		if (strlen(ascii_value) != 10)
> > > -			return -EINVAL;
> > > -		x = sscanf(ascii_value, "%x", &value);
> > > -		if (x != 1)
> > > +		if (strict_strtoul(ascii_value,16,value) != 0)
> >                                                   ^&value
> > its odd the array ascii_value is getting stomped on.  Very strange.
> > I'm sure I'm doing something dumb.  I'll keep working on this and send
> > an patch after it checks out.
> 
> How careful do you want to be here?  For example, which of the
> following inputs do you want to accept?
> 
> 	0x1234
> 	abcd1234
> 	abcd123456
> 	abcd123456\n
> 	abcd1234567
> 	1234567890
> 	1234567890\n
> 	12345678901

> 	0x12345678
> 	0x12345678\n
just these 2 are what I had planned to allow after this email thread.

> 	0x123456789
> 
> Maybe it's okay to be a little relaxed about this, and trust the caller 
> to pass in data that makes sense.
yeah but is it worth the effort?

--mark
 
