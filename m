From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Wed, 29 Jan 2014 17:24:28 -0800
Message-ID: <1391045068.2422.30.camel@joe-AO722>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
	 <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
	 <alpine.LRH.2.02.1401291956510.8304@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LRH.2.02.1401291956510.8304@file01.intranet.prod.int.rdu2.redhat.com>
Sender: owner-linux-mm@kvack.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-01-29 at 19:58 -0500, Mikulas Patocka wrote:
> On Wed, 29 Jan 2014, Sebastian Capella wrote:
> > kstrimdup will duplicate and trim spaces from the passed in
> > null terminated string.  This is useful for strings coming from
> > sysfs that often include trailing whitespace due to user input. 
[]
> > diff --git a/mm/util.c b/mm/util.c
[]
> >  /**
> > + * kstrimdup - Trim and copy a %NUL terminated string.
> > + * @s: the string to trim and duplicate
> > + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> > + *
> > + * Returns an address, which the caller must kfree, containing
> > + * a duplicate of the passed string with leading and/or trailing
> > + * whitespace (as defined by isspace) removed.
> 
> It doesn't remove leading whitespace. To remove them, you need to do
> 
> char *p = strim(ret);
> memmove(ret, p, strlen(p) + 1);
[]
> > + */
> > +char *kstrimdup(const char *s, gfp_t gfp)
> > +{
> > +	char *ret = kstrdup(skip_spaces(s), gfp);
> > +
> > +	if (ret)
> > +		strim(ret);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(kstrimdup);

Why not minimize the malloc length too?

maybe something like:

char *kstrimdup(const char *s, gfp_t gfp)
{
	char *buf;
	const char *begin = skip_spaces(s);
	size_t len = strlen(begin);

	while (len && isspace(begin[len - 1]))
		len--;

	buf = kmalloc_track_caller(len + 1, gfp);
	if (!buf)
		return NULL;

	memcpy(buf, begin, len);
	buf[len] = 0;

	return buf;
}


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
