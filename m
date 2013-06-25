From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 25/32] cpufreq: delete __cpuinit usage from all cpufreq
 files
Date: Mon, 24 Jun 2013 23:59:45 -0700
Message-ID: <1372143585.1245.44.camel@joe-AO722>
References: <1372102237-8757-1-git-send-email-paul.gortmaker@windriver.com>
	 <1372102237-8757-26-git-send-email-paul.gortmaker@windriver.com>
	 <CAKohponpsJBqbj_8u8MUiu7sCEpeg5bcztWJAZdn9uxL5taVZQ@mail.gmail.com>
	 <1372133724.1245.38.camel@joe-AO722>
	 <CAKohpomOyV2zze1QCKArytXD=x7NXSPtsxped_j2ZKJ_aZOi3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomOyV2zze1QCKArytXD=x7NXSPtsxped_j2ZKJ_aZOi3w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-06-25 at 12:14 +0530, Viresh Kumar wrote:
> On 25 June 2013 09:45, Joe Perches <joe@perches.com> wrote:
> > Viresh, there's no absolute "right" way to do this.
> 
> Yeah Joe, but I thought its better to keep it consistent within a file.
> So, while writing new files, keep what you want but for existing ones
> follow what's in there.

Sure Viresh.

I could agree with that, but that's not what you
recommended though.  "Check this everywhere" isn't
the same as the advice you just gave above.

There are those that think it's better to convert
each instance whenever touched to what they think
of as "kernel" style.

Me, I'd just as soon convert to aligned indentation
and generic kernel style whenever touching any code,
even if it differs from the existing file style.

cheers, Joe

