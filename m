From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.22-rc3][ACPI?] Resume from s2r doesn't work.
Date: Thu, 7 Jun 2007 12:23:04 +0000
Message-ID: <20070607122303.GA8938__36578.19835139$1181219047$gmane$org@ucw.cz>
References: <878xb35sje.fsf@goat.bogus.local> <200706012340.54394.rjw@sisk.pl>
	<87hcpr2ubl.fsf@goat.bogus.local> <200706020037.16615.rjw@sisk.pl>
	<87wsykpweu.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wsykpweu.fsf@goat.bogus.local>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Olaf Dietsche <olaf+list.linux-acpi@olafdietsche.de>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Second, you can use PM_TRACE (Documentation/power/s2ram.txt) to find the
> > place where it really fails.
> 
> First I augmented my minimal config kernel with some TRACE_RESUME()s:
> 
> --- a/kernel/power/main.c	2007-05-27 23:48:05.000000000 +0200
> +++ b/kernel/power/main.c	2007-06-03 22:28:46.000000000 +0200
> @@ -223,6 +223,7 @@
>  	pr_debug("PM: Finishing wakeup.\n");
>  	suspend_finish(state);
>   Unlock:
> +	TRACE_RESUME(error);
>  	mutex_unlock(&pm_mutex);
>  	return error;
>  }
> @@ -303,6 +304,7 @@
>  		error = enter_state(state);
>  	else
>  		error = -EINVAL;
> +	TRACE_RESUME(error);
>  	return error ? error : n;
>  }
...
> I got alternating
>   hash matches drivers/base/power/resume.c:58
> and
>   hash matches kernel/power/main.c:307
> 
> > First, you can check if the patch
> >
> > http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/20-ACPI-preserve-the-ebx-value-in-acpi_copy_wakeup_routine.patch
> 
> Then I applied this patch, but it doesn't change anything.
> 
> But either way the script never reaches "shutdown -rn now". So, it
> seems, that my laptop does a full resume every other reboot, but it
> never returns to userspace.

But it returns to kernel... can you use more trace points to figure
out where it hangs?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
