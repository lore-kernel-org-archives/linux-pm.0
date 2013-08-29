From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH v2] cpuidle: coupled: abort idle if pokes are pending
Date: Thu, 29 Aug 2013 22:28:28 +0200
Message-ID: <7272744.lhUaaLc3cm@vostro.rjw.lan>
References: <1377740508-22134-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377740508-22134-1-git-send-email-ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Neil Zhang <zhangwm-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Jon Medhurst <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sivaram Nair <sivaramn-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 28, 2013 06:41:47 PM Colin Cross wrote:
> Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> reported a lockup on Tegra20 caused
> by a race condition in coupled cpuidle.  When two or more cpus
> enter idle at the same time, the first cpus to arrive may go to the
> ready loop without processing pending pokes from the last cpu to
> arrive.
> 
> This patch adds a check for pending pokes once all cpus have been
> synchronized in the ready loop and resets the coupled state and
> retries if any cpus failed to handle their pending poke.
> 
> Retrying on all cpus may trigger the same issue again, so this patch
> also adds a check to ensure that each cpu has received at least one
> poke between when it enters the waiting loop and when it moves on to
> the ready loop.
> 
> Reported-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Tested-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>

Still stable material I suppose?

Queued up for 3.12, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
