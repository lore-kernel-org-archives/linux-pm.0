From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9] PM / Hibernate: use name_to_dev_t to parse resume
Date: Sat, 15 Feb 2014 00:47:41 +0100
Message-ID: <20140214234741.GA9104@amd.pavel.ucw.cz>
References: <1392418376-30060-1-git-send-email-sebastian.capella@linaro.org>
 <1392418376-30060-2-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52421 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaBNXro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 18:47:44 -0500
Content-Disposition: inline
In-Reply-To: <1392418376-30060-2-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi!

> Use the name_to_dev_t call to parse the device name echo'd to
> to /sys/power/resume.  This imitates the method used in hibernate.c
> in software_resume, and allows the resume partition to be specified
> using other equivalent device formats as well.  By allowing
> /sys/debug/resume to accept the same syntax as the resume=device
> parameter, we can parse the resume=device in the init script and
> use the resume device directly from the kernel command line.
> 
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -972,16 +972,20 @@ static ssize_t resume_show(struct kobject *kobj, struct kobj_attribute *attr,
>  static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
>  			    const char *buf, size_t n)
>  {
> -	unsigned int maj, min;
>  	dev_t res;
> -	int ret = -EINVAL;
> +	int len = n;
> +	char *name;
>  
> -	if (sscanf(buf, "%u:%u", &maj, &min) != 2)
> -		goto out;
> +	if (len && buf[len-1] == '\n')
> +		len--;
> +	name = kstrndup(buf, len, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;

And yes, it seems to do right thing even if "\n" is passed to it.

> -	res = MKDEV(maj,min);
> -	if (maj != MAJOR(res) || min != MINOR(res))
> -		goto out;
> +	res = name_to_dev_t(name);
> +	kfree(name);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
