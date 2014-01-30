From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/2] mm: add kstrimdup function
Date: Thu, 30 Jan 2014 13:44:45 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1401301343430.15271@chino.kir.corp.google.com>
References: <1391116318-17253-1-git-send-email-sebastian.capella@linaro.org> <1391116318-17253-2-git-send-email-sebastian.capella@linaro.org> <20140130132251.4f662aeddc09d8410dee4490@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140130132251.4f662aeddc09d8410dee4490@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Joe Perches <joe@perches.com>, Mikulas Patocka <mpatocka@redhat.com>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 30 Jan 2014, Andrew Morton wrote:

> > @@ -63,6 +64,35 @@ char *kstrndup(const char *s, size_t max, gfp_t gfp)
> >  EXPORT_SYMBOL(kstrndup);
> >  
> >  /**
> > + * kstrimdup - Trim and copy a %NUL terminated string.
> > + * @s: the string to trim and duplicate
> > + * @gfp: the GFP mask used in the kmalloc() call when allocating memory
> > + *
> > + * Returns an address, which the caller must kfree, containing
> > + * a duplicate of the passed string with leading and/or trailing
> > + * whitespace (as defined by isspace) removed.
> > + */
> > +char *kstrimdup(const char *s, gfp_t gfp)
> > +{
> > +	char *buf;
> > +	char *begin = skip_spaces(s);
> > +	size_t len = strlen(begin);
> > +
> > +	while (len > 1 && isspace(begin[len - 1]))
> > +		len--;
> 
> That's off-by-one isn't it?  kstrimdup("   ") should return "", not " ".
> 

Yeah, this is an incorrect copy-and-paste of Joe Perches' suggested code 
from http://marc.info/?l=linux-kernel&m=139104508317989.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
