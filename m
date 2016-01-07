From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Thu, 07 Jan 2016 23:05:09 +0100
Message-ID: <874mepnizu.fsf@rasmusvillemoes.dk>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32912 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbcAGWFN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 17:05:13 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so115018771wmf.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2016 14:05:12 -0800 (PST)
In-Reply-To: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Thu, 7 Jan 2016 14:06:01 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jan 07 2016, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> From time to time we have to match a string in an array. Make a simple helper
> for that purpose.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/string.h |  2 ++
>  lib/string.c           | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b0a732b..37062fb 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -131,6 +131,8 @@ extern void argv_free(char **argv);
>  extern bool sysfs_streq(const char *s1, const char *s2);
>  extern int strtobool(const char *s, bool *res);
>  
> +int match_string(const char * const *array, size_t len, const char *string);
> +
>  #ifdef CONFIG_BINARY_PRINTF
>  int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args);
>  int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf);
> diff --git a/lib/string.c b/lib/string.c
> index 0323c0d..dd02270 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -631,6 +631,32 @@ bool sysfs_streq(const char *s1, const char *s2)
>  EXPORT_SYMBOL(sysfs_streq);
>  
>  /**
> + * match_string - matches given string in an array
> + * @array:	array of strings
> + * @len:	number of strings in the array or 0 for NULL terminated arrays
> + * @string:	string to match with
> + *
> + * Return:
> + * index of a @string in the @array if matches, or %-ENODATA otherwise.
> + */
> +int match_string(const char * const *array, size_t len, const char *string)
> +{
> +	int index = 0;
> +	const char *item;
> +
> +	do {
> +		item = array[index];
> +		if (!item)
> +			break;
> +		if (!strcmp(item, string))
> +			return index;
> +	} while (++index < len || !len);
> +
> +	return -ENODATA;
> +}
> +EXPORT_SYMBOL(match_string);
> +

I'd suggest making it -1 (which, since len is a size_t, is effectively
infinity) having the meaning "the array is terminated by a NULL
entry". match_string(..., ARRAY_SIZE(my_array), ...) will break if the
array happens to be empty, which could e.g. happen in a case like

const char *my_array[] = {
#ifdef CONFIG_THIS
       "this",
#endif
#ifdef CONFIG_THAT
       "that",
#endif
};

I also think the condition/loop above is unreadable.

for (index = 0; index < len; index++) {
    ...
}

is much clearer.

Why -ENODATA and not just -1? It is rather unlikely that anyone would
pass on that particular -Exxx value. Not a biggie, just curious.

Would there be more potential users if we had a flag argument allowing
case-insensitive matching? Would there be more potential users if a flag
allowed to ask whether the given string is a _prefix_ of one of the
strings in the array, or vice versa? Something like

#define MATCH_STRING_CASE 0x01
#define MATCH_STRING_PREFIX_OF_ARRAY_ELEM 0x02 /* yeah, that name sucks */
#define MATCH_ARRAY_ELEM_PREFIX_OF_STRING 0x04 /* this too */

int match_string(const char * const *array, size_t len, const char *string, unsigned flags)
{
#define MATCH_PREFIX (MATCH_... | MATCH_...)
    int index;
    const char *item;
    int (*match_func)(const char *, const char *) =
        flags & MATCH_STRING_CASE ? strcasecmp : strcmp;
    int (*prefix_func)(const char *, const char *, size_t) =
        flags & MATCH_STRING_CASE ? strncasecmp : strncmp;
  
    for (index = 0; index < len; ++index) {
        item = array[index];
        if (!item)
            break;
        if (flags & MATCH_PREFIX) {
            size_t len = strlen(flags & MATCH_STRING_PREFIX_OF_ARRAY_ELEM ?
                string : item);
            if (!prefix_func(item, string, len))
                return index;
        } else if (!match_func(item, string)) {
            return index;
        }
    }
    return -1;
}

(Ok, it's not that pretty; maybe it'd be better to use
switch(flags&MATCH_PREFIX) {}. Or maybe just the case-insensitive part
is worth keeping; in that case the above isn't that bad.)

Rasmus
