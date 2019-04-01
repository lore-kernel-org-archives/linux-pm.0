From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
Date: Mon, 1 Apr 2019 23:34:24 +0200
Message-ID: <CAJZ5v0gCJSDFkmdf-Pi5fiZXTe2T5PK5iM3UxQeX_uk5yMPYyg@mail.gmail.com>
References: <20190330112022.28888-1-bp@alien8.de> <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
 <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com> <20190401124814.GD28264@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401124814.GD28264@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 1, 2019 at 2:48 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 01, 2019 at 11:32:59AM +0200, Rafael J. Wysocki wrote:
> > Or I can queue it up if you prefer.
>
> Doesn't matter to me - it doesn't have any dependencies to previous
> patches so however you like.

OK, I'll take it.
