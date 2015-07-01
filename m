From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate/resume: clarify documentation
Date: Wed, 1 Jul 2015 10:46:11 +0200
Message-ID: <20150701084611.GB6946@amd>
References: <87pp4gq0bl.fsf@e6510-131.site>
 <87mvzip8gz.fsf@e6510-131.site>
 <87lhf2p81y.fsf@e6510-131.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49097 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbbGAIqN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 04:46:13 -0400
Content-Disposition: inline
In-Reply-To: <87lhf2p81y.fsf@e6510-131.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe Geuder <linuxkernel2015-ugeuder@snkmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Mon 2015-06-29 23:35:05, Uwe Geuder wrote:
> it was not the whole truth that kernel mode cannot be used with swap on LVM
> 
> Signed-off-by: Uwe Geuder <linuxkernel2015-ugeuder@snkmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks for clarifying this.

(Hmm, and I guess we shoudl rename swsusp.txt -> hibernation.txt one
day :-).

									Pavel
> ---
>  Documentation/power/swsusp.txt | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> index f732a83..8cc17ca 100644
> --- a/Documentation/power/swsusp.txt
> +++ b/Documentation/power/swsusp.txt
> @@ -410,8 +410,17 @@ Documentation/usb/persist.txt.
>  
>  Q: Can I suspend-to-disk using a swap partition under LVM?
>  
> -A: No. You can suspend successfully, but you'll not be able to
> -resume. uswsusp should be able to work with LVM. See suspend.sf.net.
> +A: Yes and No.  You can suspend successfully, but the kernel will not be able
> +to resume on its own.  You need an initramfs that can recognize the resume
> +situation, activate the logical volume containing the swap volume (but not
> +touch any filesystems!), and eventually call
> +
> +echo -n "$major:$minor" > /sys/power/resume
> +
> +where $major and $minor are the respective major and minor device numbers of
> +the swap volume.
> +
> +uswsusp works with LVM, too.  See http://suspend.sourceforge.net/
>  
>  Q: I upgraded the kernel from 2.6.15 to 2.6.16. Both kernels were
>  compiled with the similar configuration files. Anyway I found that

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
