From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
Date: Thu, 04 Oct 2018 10:16:46 -0700
Message-ID: <dba47f670a8aab2ff68e664b3a138ca456fbfd74.camel@perches.com>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
         <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
         <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
         <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Colin Cross <ccross@android.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Shi <alex.shi@linaro.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-10-04 at 10:40 +0200, Daniel Lezcano wrote:
> On 04/10/2018 10:22, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > > The function get_loadavg() returns almost always zero. To be more
> > > precise, statistically speaking for a total of 1023379 times passing
> > > in the function, the load is equal to zero 1020728 times, greater than
> > > 100, 610 times, the remaining is between 0 and 5.
[]
> > > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
[]
> > > @@ -359,7 +346,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> > >                  * Use the performance multiplier and the user-configurable
> > >                  * latency_req to determine the maximum exit latency.
> > >                  */
> > > -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> > > +               interactivity_req = data->predicted_us /
> > > +                       performance_multiplier(nr_iowaiters);
> > 
> > I wouldn't break this line.
> 
> Ok, mind if I break the line in a separate patch before ? (my git
> pre-commit hook runs checkpatch and it complains and prevent to commit
> the patch because of the line length (94)).

A lot of this file uses > 80 column lines.
As well, the identifiers here are relatively long.

Long identifier lengths and 80 column lines are generally
incompatible.

I suggest you change your script to allow > 80 column lines
using the checkpatch command-line option --ignore==long_line
or perhaps add --max-line-length=<some higher value> or at
least allow some other senstible interactivity when the silly
script bleats some mindless warning or another.
