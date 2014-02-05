From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v7 1/3] mm: add kstrdup_trimnl function
Date: Wed, 05 Feb 2014 14:55:52 -0800
Message-ID: <20140205225552.16730.1677@capellas-linux>
References: <1391546631-7715-1-git-send-email-sebastian.capella@linaro.org>
 <1391546631-7715-2-git-send-email-sebastian.capella@linaro.org>
 <20140205135052.4066b67689cbf47c551d30a9@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140205135052.4066b67689cbf47c551d30a9@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Joe Perches <joe@perches.com>, David Rientjes <rientjes@google.com>, Alexey Dobriyan <adobriyan@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Quoting Andrew Morton (2014-02-05 13:50:52)
> On Tue,  4 Feb 2014 12:43:49 -0800 Sebastian Capella <sebastian.capella@l=
inaro.org> wrote:
> =

> > kstrdup_trimnl creates a duplicate of the passed in
> > null-terminated string.  If a trailing newline is found, it
> > is removed before duplicating.  This is useful for strings
> > coming from sysfs that often include trailing whitespace due to
> > user input.
> =

> hm, why?  I doubt if any caller of this wants to retain leading and/or
> trailing spaces and/or tabs.

Hi Andrew,

I agree the common case doesn't usually need leading or trailing whitespace.

Pavel and others pointed out that a valid filename could contain
newlines/whitespace at any position.

If we allow for this, then it would be incorrect to strip whitespace
from the input.  Comments also went down the lines that it would be
better for the kernel not to second guess what is being passed in.

I find stripping the trailing newline to be very useful, and there are
many examples of kernel code doing this.  I think it would be a mistake
to remove this now, and would be confusing for users.  A compromise
is to strip the final newline only if it's present before the null.

This allows the common case of echoing a simple string onto
/sys/power/resume, and behaves as expected in that case.

A complex string without a trailing newline is also handled by quoting or
dding a file onto /sys/power/resume.

In the unlikely event a user has trailing newline as part of the input, then
adding an additional newline to the end will cover that case.  This
is not ideal, but it puts the additional burden onto the complex case
rather than the common case.

Thanks,

Sebastian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
