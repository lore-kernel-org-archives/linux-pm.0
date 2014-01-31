From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Fri, 31 Jan 2014 11:32:32 +0100
Message-ID: <20140131103232.GB1534@amd.pavel.ucw.cz>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
 <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57778 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbaAaKcd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2014 05:32:33 -0500
Content-Disposition: inline
In-Reply-To: <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed 2014-01-29 15:48:23, Sebastian Capella wrote:
> kstrimdup will duplicate and trim spaces from the passed in
> null terminated string.  This is useful for strings coming from
> sysfs that often include trailing whitespace due to user input.

Is it good idea? I mean "\n\n/foo bar baz" is valid filename in
unix. This is kernel interface, it is not meant to be too user
friendly...
									Pavel


> +char *kstrimdup(const char *s, gfp_t gfp)
> +{
> +	char *ret = kstrdup(skip_spaces(s), gfp);
> +
> +	if (ret)
> +		strim(ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kstrimdup);
> +
> +/**
>   * kmemdup - duplicate region of memory
>   *
>   * @src: memory region to duplicate

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
