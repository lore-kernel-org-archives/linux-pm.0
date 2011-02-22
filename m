From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH] PM QoS: Allow parsing of ASCII values
Date: Mon, 21 Feb 2011 20:33:36 -0800
Message-ID: <20110222043336.GB23306@gvim.org>
References: <1297994096-1839-1-git-send-email-horms@verge.net.au>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1297994096-1839-1-git-send-email-horms@verge.net.au>
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
Cc: linux-pm@lists.linux-foundation.org, Dan Carpenter <error27@gmail.com>, Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 18, 2011 at 10:54:56AM +0900, Simon Horman wrote:
> In "PM QoS: Correct pr_debug() misuse and improve parameter checks"
> the parsing of the ASCII hex value was tightened. Unfortunately
> it was tightened to the point where no value is valid.
> 
> Root of the problem seems to lie in wheather the ASCII hex is followed
> by a '\n' or not. My reading of the documentation is that the '\n' should
> not be present. However the code previously only accepted that version.
> The current code accepts neither. My fix is to accept both.
> 
> Cc: Mark Gross <markgross@thegnar.org>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> ---
> This appears to have been introduced around 2.6.36-rc4.
> And was an @stable patch. As such I believe this change
> is stable material.
> ---
>  kernel/pm_qos_params.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
> index aeaa7f8..98a34ea 100644
> --- a/kernel/pm_qos_params.c
> +++ b/kernel/pm_qos_params.c
> @@ -387,10 +387,11 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
>  	if (count == sizeof(s32)) {
>  		if (copy_from_user(&value, buf, sizeof(s32)))
>  			return -EFAULT;
> -	} else if (count == 11) { /* len('0x12345678/0') */
> -		if (copy_from_user(ascii_value, buf, 11))
> +	} else if (count == 11 || count == 10) { /* len('0x12345678\n') or
shouldn't this be count ==12 ||count ==10?
After taking Alan's advice and looking at strict_strtoul it looks like
10 and 12 are the numbers to use.

Also playing with your dd test:
mgross@mgt:~$ echo -n 0x12345678 | dd of=junk.bin
0+1 records in
0+1 records out
10 bytes (10 B) copied, 0.000368621 s, 27.1 kB/s
mgross@mgt:~$ hexdump junk.bin 
0000000 7830 3231 3433 3635 3837               
000000a
mgross@mgt:~$ echo  0x12345678 | dd of=junk.bin
0+1 records in
0+1 records out
11 bytes (11 B) copied, 0.000384755 s, 28.6 kB/s
mgross@mgt:~$ hexdump junk.bin 
0000000 7830 3231 3433 3635 3837 000a          
000000b

it looks like I have 10 or 12 bytes (but can't reconcile the dd output
saying 11 bytes when hexdump is showing 12 )

The following patch (untested) should make things work ok.


diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
index aeaa7f8..6cbce91 100644
--- a/kernel/pm_qos_params.c
+++ b/kernel/pm_qos_params.c
@@ -381,19 +381,18 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
 {
 	s32 value;
 	int x;
-	char ascii_value[11];
+	char ascii_value[12];
 	struct pm_qos_request_list *pm_qos_req;
 
 	if (count == sizeof(s32)) {
 		if (copy_from_user(&value, buf, sizeof(s32)))
 			return -EFAULT;
-	} else if (count == 11) { /* len('0x12345678/0') */
-		if (copy_from_user(ascii_value, buf, 11))
+	} else if (count == 10 || count == 12) { /* '0x12345678' or
+						    '0x12345678/n/0'*/
+		memset(ascii_value, 0, sizeof(ascii_value));
+		if (copy_from_user(ascii_value, buf, count))
 			return -EFAULT;
-		if (strlen(ascii_value) != 10)
-			return -EINVAL;
-		x = sscanf(ascii_value, "%x", &value);
-		if (x != 1)
+		if (strict_strtoul(ascii_value,16,value) != 0)
 			return -EINVAL;
 		pr_debug("%s, %d, 0x%x\n", ascii_value, x, value);
 	} else

------
I'll test this tomorrow and do a proper posting (if it works right)

--mark
> +						  * len('0x12345678') */
> +		if (copy_from_user(ascii_value, buf, count))
>  			return -EFAULT;
> -		if (strlen(ascii_value) != 10)
> +		if (strlen(ascii_value) != count)
>  			return -EINVAL;
>  		x = sscanf(ascii_value, "%x", &value);
>  		if (x != 1)
> -- 
> 1.7.2.3
> 
