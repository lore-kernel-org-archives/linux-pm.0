From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] cpufreq: trace frequency limits change
Date: Thu, 26 Jul 2018 10:22:05 +0200
Message-ID: <CAJZ5v0hzdLpFaZuMVPP1oWOExsp5BBStpkg_C1ZekCEnDQjdgA@mail.gmail.com>
References: <20180724173544.18876-1-joel@joelfernandes.org> <20180725091802.74400a81@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725091802.74400a81@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 25, 2018 at 3:18 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 24 Jul 2018 10:35:44 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
>> From: Ruchi Kandoi <kandoiruchi@google.com>
>>
>> systrace used for tracing for Android systems has carried a patch for
>> many years in the Android tree that traces when the cpufreq limits
>> change.  With the help of this information, systrace can know when the
>> policy limits change and can visually display the data. Lets add
>> upstream support for the same.
>>
>> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Better ;-)
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Patch applied, thanks!
