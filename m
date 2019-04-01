From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/5] drivers/cpufreq: Convert some slow-path
 static_cpu_has() callers to boot_cpu_has()
Date: Mon, 1 Apr 2019 14:48:14 +0200
Message-ID: <20190401124814.GD28264@zn.tnic>
References: <20190330112022.28888-1-bp@alien8.de>
 <20190330112022.28888-6-bp@alien8.de>
 <CAJZ5v0hDyx6t8UXj=tO78YUTMBqmdnNWEjs4SVwBoJya9pHu4A@mail.gmail.com>
 <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gfqOB8r0dvTf3uRSkJCNOLYPe9qLaUV1BLGjTanmMbvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 01, 2019 at 11:32:59AM +0200, Rafael J. Wysocki wrote:
> Or I can queue it up if you prefer.

Doesn't matter to me - it doesn't have any dependencies to previous
patches so however you like.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
