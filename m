From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Fri, 8 Jan 2016 09:13:05 +0900
Message-ID: <20160108000915.GA2551@swordfish>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34711 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbcAHAL5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 19:11:57 -0500
Content-Disposition: inline
In-Reply-To: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On (01/07/16 14:06), Andy Shevchenko wrote:
> 
> From time to time we have to match a string in an array. Make a simple helper
> for that purpose.
> 

Hello,

strncmp() case seems to be quite common.

> +int match_string(const char * const *array, size_t len, const char *string)
                                                  ^^^^^^^
a nitpick, [to me] `len' looks a bit confusing, usually it's array 'size'.

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


do you want to do something like this:

/*
 * hm, how to name this thing... nmatch_string() or match_nstring()...
 * nmatch_string() _probably_ better, match_nstring() is totally cryptic.
 */
int nmatch_string(array, array_size, string, string_len)
{
	do {
		strncmp();
	} while ();
}

int match_string(array, array_size, string)
{
	return nmatch_string(array, array_size, string, strlen(string));
}

	-ss
