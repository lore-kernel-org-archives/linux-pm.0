From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Fri, 31 Jan 2014 02:46:08 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1401310243090.7183@chino.kir.corp.google.com>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org> <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org> <20140131103232.GB1534@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140131103232.GB1534@amd.pavel.ucw.cz>
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Fri, 31 Jan 2014, Pavel Machek wrote:

> > kstrimdup will duplicate and trim spaces from the passed in
> > null terminated string.  This is useful for strings coming from
> > sysfs that often include trailing whitespace due to user input.
> 
> Is it good idea? I mean "\n\n/foo bar baz" is valid filename in
> unix. This is kernel interface, it is not meant to be too user
> friendly...

v6 of this patchset carries your ack of the patch that uses this for 
/sys/debug/resume, so are you disagreeing we need this support at all or 
that it shouldn't be the generic sysfs write behavior?  If the latter, I 
agree, and the changelog could be improved to specify what writes we 
actually care about.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
