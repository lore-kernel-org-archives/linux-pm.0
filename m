From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Wed, 29 Jan 2014 19:50:59 -0800
Message-ID: <1391053859.2422.34.camel@joe-AO722>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
	 <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
	 <alpine.LRH.2.02.1401291956510.8304@file01.intranet.prod.int.rdu2.redhat.com>
	 <1391045068.2422.30.camel@joe-AO722>
	 <20140130034137.2769.50210@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140130034137.2769.50210@capellas-linux>
Sender: owner-linux-mm@kvack.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2014-01-29 at 19:41 -0800, Sebastian Capella wrote:
> Quoting Joe Perches (2014-01-29 17:24:28)
> > Why not minimize the malloc length too?
> > 

> I figured it would be mostly for small trimming, but it seems like
> it could be and advantage and used more generally this way.
> 
> I have a couple of small changes to return NULL in empty string/all ws
> cases and fix a buffer underrun.
> 
> How does this look?
[]
> char *kstrimdup(const char *s, gfp_t gfp)
> {                                                                                
>         char *buf;                                                               
>         const char *begin = skip_spaces(s);                                      
>         size_t len = strlen(begin);                                              

removing begin and just using s would work

>         if (len == 0)                                                            
>                 return NULL;                                                     
>                                                                                  
>         while (len > 1 && isspace(begin[len - 1]))                               
>                 len--;                                                           
>                                                                                  
>         buf = kmalloc_track_caller(len + 1, gfp);                                
>         if (!buf)                                                                
>                 return NULL;                                                     
>                                                                                  
>         memcpy(buf, begin, len);                                                 
>         buf[len] = '\0';                                                            
>                                                                                  
>         return buf;                                                              
> }

What should the return be to this string?

" "

Should it be "" or " " or NULL?

I don't think it should be NULL.
I don't think it should be " ".

cheers, Joe

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
