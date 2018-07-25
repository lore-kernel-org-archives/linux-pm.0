From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: trace frequency limits change
Date: Wed, 25 Jul 2018 09:20:45 +0530
Message-ID: <CAKohponm0CbBNLY19B-9ccfe3d3jreSJLDePEROR+w1=1JZEWw@mail.gmail.com>
References: <20180724173544.18876-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724173544.18876-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Cc: Android Kernel" <kernel-team@android.com>, Ruchi Kandoi <kandoiruchi@google.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

On 24 July 2018 at 23:05, Joel Fernandes <joel@joelfernandes.org> wrote:
> From: Ruchi Kandoi <kandoiruchi@google.com>
>
> systrace used for tracing for Android systems has carried a patch for
> many years in the Android tree that traces when the cpufreq limits
> change.  With the help of this information, systrace can know when the
> policy limits change and can visually display the data. Lets add
> upstream support for the same.
>
> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Viresh since I changed the patch, could you Ack it again?
>
> v2->v3: reduce parameters to tracepoint call (Steve)
> v1->v2: correct ordering of min/max (Viresh)
>
>  Documentation/trace/events-power.rst |  1 +
>  drivers/cpufreq/cpufreq.c            |  1 +
>  include/trace/events/power.h         | 25 +++++++++++++++++++++++++
>  3 files changed, 27 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
