From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] PM_QOS api update to use handles 1/5
Date: Mon, 4 Jan 2010 09:31:27 +0100
Message-ID: <20100104083127.GA1450__23331.9525527351$1262594042$gmane$org@ucw.cz>
References: <20091130010953.GA4732@mgross-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091130010953.GA4732@mgross-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: 640E9920 <640e9920@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun 2009-11-29 17:09:53, 640E9920 wrote:
> I'm using this crazy email address because I have problems getting to
> linux.intel.com from home, and my work at intel has changed a bit.
> 
> This is the first in a 5 part series that attempts to update PM_QOS to
> use handles instead of named strings in its kernel api.  It seams that
> some folks are using pm_qos on hot paths and the overhead of the list
> walks and string compares is a problem.
> 
> Most of the changes came from aili@codeaurora.org, and I spent some time
> cleaning up the API.
> 
> Also, I couldn't resist myself in renaming the API's a bit give the fact
> that the signatures changed enough that I had to touch all the pm_qos
> users anyway.  I changed *requirement* to *request* in keeping with the
> way PM_QOS really only does best effort.  I've felt "requirement" is too
> strong a word for the way it works.

Looks good on quick scan. Moving away from strings is certainly good.

> @@ -384,15 +363,14 @@ static ssize_t pm_qos_power_write(struct file *filp, const char __user *buf,
>  		size_t count, loff_t *f_pos)
>  {
>  	s32 value;
> -	int pm_qos_class;
> +	struct pm_qos_request_list *pm_qos_req;
>  
> -	pm_qos_class = (long)filp->private_data;
>  	if (count != sizeof(s32))
>  		return -EINVAL;
>  	if (copy_from_user(&value, buf, sizeof(s32)))
>  		return -EFAULT;
> -	sprintf(name, "process_%d", current->pid);
> -	pm_qos_update_requirement(pm_qos_class, name, value);
> +	pm_qos_req = (struct pm_qos_request_list *)filp->private_data;
> +	pm_qos_update_request(pm_qos_req, value);
>  
>  	return  sizeof(s32);
>  }

Umm.. passing binary numbers like that... is not exactly good
interface. Think endianness issues  when writing to it from high-level
language.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
