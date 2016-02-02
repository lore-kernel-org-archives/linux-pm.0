From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 1/9] lib/string: introduce match_string() helper
Date: Tue, 02 Feb 2016 20:50:02 +0100
Message-ID: <87a8nizyc5.fsf@rasmusvillemoes.dk>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1453986865-133572-2-git-send-email-andriy.shevchenko@linux.intel.com>
	<20160201220538.481cb8ee.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35376 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757739AbcBBTuG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 14:50:06 -0500
Received: by mail-wm0-f44.google.com with SMTP id r129so134238831wmr.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 11:50:05 -0800 (PST)
In-Reply-To: <20160201220538.481cb8ee.akpm@linux-foundation.org> (Andrew
	Morton's message of "Mon, 1 Feb 2016 22:05:38 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>

On Tue, Feb 02 2016, Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 28 Jan 2016 15:14:17 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> + * @array:	array of strings
>> + * @n:		number of strings in the array or -1 for NULL terminated arrays
>> + * @string:	string to match with
>> + *
>> + * Return:
>> + * index of a @string in the @array if matches, or %-ENODATA otherwise.
>> + */
>> +int match_string(const char * const *array, size_t n, const char *string)
>> +{
>> +	int index;
>> +	const char *item;
>> +
>> +	for (index = 0; index < n; index++) {
>
> So we're taking an int and comparing that with (size_t)-1, relying upon
> the compiler promoting the int to an unsigned type because size_t is
> unsigned.  It works, but it isn't pretty - there wasn't really much
> point in making size have type size_t.

n has unsigned type to make it easy to pass 'infinity'; *that's* where
we rely on integer promotion.

One could make index be unsigned int (or size_t), but it won't matter,
because it will never have a value where the type promotion (nor the
implicit cast back to int if/when it's used as a return value) changes
its value.

Rasmus
