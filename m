From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] cpufreq: Add dummy cpufreq_cpu_get/put for
 CONFIG_CPU_FREQ=n
Date: Thu, 17 Oct 2013 09:08:00 +0200
Message-ID: <20131017070800.GS4830@phenom.ffwll.local>
References: <1381222571-20317-1-git-send-email-daniel.vetter@ffwll.ch>
 <3064536.Uv6oZedeVB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3064536.Uv6oZedeVB@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Chris Wilson <chris@chris-wilson.co.uk>, kbuild test robot <fengguang.wu@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 17, 2013 at 01:00:42AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 08, 2013 10:56:11 AM Daniel Vetter wrote:
> > The drm/i915 driver wants to adjust it's own power policies using the
> > cpu policies as a guideline (we can implicitly boost the cpus through
> > the gpus on some platforms). To avoid a dreaded select (since a
> > depends will leave users wondering where where their driver has gone
> > too) add dummy functions.
> > 
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > Cc: kbuild test robot <fengguang.wu@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: cpufreq@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> > A quick ack for merging this this through the drm-intel tree is
> > probably the simplest way forward.
> 
> Well, ACK, or please let me know if you want me to take this.

I've merged it, thanks for tacking a quick look.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
