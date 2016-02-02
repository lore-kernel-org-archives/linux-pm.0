From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 1/9] lib/string: introduce match_string() helper
Date: Mon, 1 Feb 2016 22:05:38 -0800
Message-ID: <20160201220538.481cb8ee.akpm@linux-foundation.org>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1453986865-133572-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56043 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcBBGCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 01:02:49 -0500
In-Reply-To: <1453986865-133572-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, 28 Jan 2016 15:14:17 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> >From time to time we have to match a string in an array. Make a simple helper
> for that purpose.
> 
> ...
>
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -131,6 +131,8 @@ extern void argv_free(char **argv);
>  extern bool sysfs_streq(const char *s1, const char *s2);
>  extern int strtobool(const char *s, bool *res);
>  
> +int match_string(const char * const *array, size_t n, const char *string);
> +
>  #ifdef CONFIG_BINARY_PRINTF
>  int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
>  int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
> diff --git a/lib/string.c b/lib/string.c
> index 0323c0d..ba01d4f 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -631,6 +631,32 @@ bool sysfs_streq(const char *s1, const char *s2)
>  EXPORT_SYMBOL(sysfs_streq);
>  
>  /**
> + * match_string - matches given string in an array

I can't say I'm in love with the name, but I guess it will suffice. 
search_string() doesn't seem much better.


> + * @array:	array of strings
> + * @n:		number of strings in the array or -1 for NULL terminated arrays
> + * @string:	string to match with
> + *
> + * Return:
> + * index of a @string in the @array if matches, or %-ENODATA otherwise.
> + */
> +int match_string(const char * const *array, size_t n, const char *string)
> +{
> +	int index;
> +	const char *item;
> +
> +	for (index = 0; index < n; index++) {

So we're taking an int and comparing that with (size_t)-1, relying upon
the compiler promoting the int to an unsigned type because size_t is
unsigned.  It works, but it isn't pretty - there wasn't really much
point in making size have type size_t.


> +		item = array[index];
> +		if (!item)
> +			break;
> +		if (!strcmp(item, string))
> +			return index;
> +	}
> +
> +	return -ENODATA;
> +}
> +EXPORT_SYMBOL(match_string);

