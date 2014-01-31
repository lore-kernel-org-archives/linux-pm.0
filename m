From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v4 1/2] mm: add kstrimdup function
Date: Fri, 31 Jan 2014 12:00:29 -0800
Message-ID: <20140131200029.13265.72190@capellas-linux>
References: <1391039304-3172-1-git-send-email-sebastian.capella@linaro.org>
 <1391039304-3172-2-git-send-email-sebastian.capella@linaro.org>
 <20140131103232.GB1534@amd.pavel.ucw.cz>
 <alpine.DEB.2.02.1401310243090.7183@chino.kir.corp.google.com>
 <20140131122421.GA3305@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140131122421.GA3305@amd.pavel.ucw.cz>
Sender: owner-linux-mm@kvack.org
To: Pavel Machek <pavel@ucw.cz>, David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Shaohua Li <shli@kernel.org>, Jerome Marchand <jmarchan@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Quoting Pavel Machek (2014-01-31 04:24:21)
> Well, your /sys/power/resume patch would be nice cleanup, but it
> changs behaviour, too... which is unnice. Stripping trailing "\n" is
> probably neccessary, because we did it before. (It probably was a
> mistake). But kernel is not right place to second-guess what the user
> meant. Just return -EINVAL. This is kernel ABI, after all, not user
> facing shell.

Thanks guys!  I hadn't thought of these cases.

It sounds like we're really back to stripping one trailing \n to match
the sysfs behavior to which people have become accustomed, and leave
the rest of the string untouched in case the whitespace is intentional.

Should a user intentionally have input ending in a newline, then they
should add an additional newline, expecting it to be stripped, but
otherwise, their string is taken as entered.

Does this sound right?

Meanwhile, I'll try a test to see how name_to_dev_t handles files with
spaces in them.

Thanks,

Sebastian

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
