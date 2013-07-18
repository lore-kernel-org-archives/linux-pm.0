From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4] power: new trace event to print device suspend and
 resume time
Date: Thu, 18 Jul 2013 12:42:40 -0700
Message-ID: <1374176560.1949.131.camel@joe-AO722>
References: <1374175349-3435-1-git-send-email-shuah.kh@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374175349-3435-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, rostedt@goodmis.org, fweisbec@gmail.com, mingo@redhat.com, paul.gortmaker@windriver.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2013-07-18 at 13:22 -0600, Shuah Khan wrote:
> A new trace event is added to pm events to print time it takes to suspend and
> resume a device. It generates trace message that includes device, driver,
> parent information in addition to the type of pm ops invoked as well as the
> pm event and error status from the pm ops. Example trace below:

Hi again Shuah.

Thanks, this looks good to me now.

Here's just one new trivial bit.

> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
[]
> @@ -56,6 +57,8 @@ static pm_message_t pm_transition;
[]
> +static char *pm_verb(int);

Instead of giving a prototype to a static, can
you move the static to this location instead?

It's a trivial function that just enumerates
the int and returns a descriptive char *

btw: it should be declared "const char *" too.

That could be a new patch if you're tired of
modifying this one.

cheers, Joe
