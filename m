From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
Date: Mon, 1 Apr 2019 11:32:59 +0200
Message-ID: <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
References: <20190330112022.28888-1-bp@alien8.de> <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 1, 2019 at 11:31 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Mar 30, 2019 at 12:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > From: Borislav Petkov <bp@suse.de>
> >
> > Using static_cpu_has() is pointless on those paths, convert them to the
> > boot_cpu_has() variant.
> >
> > No functional changes.
> >
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or I can queue it up if you prefer.
