From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/3] cpufreq-dt: Supply power coefficient when
 registering cooling devices
Date: Tue, 10 Nov 2015 12:28:23 +0000
Message-ID: <20151110122822.GC3551@e104805>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
 <1447090163-13700-3-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447090163-13700-3-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 09, 2015 at 05:29:22PM +0000, Punit Agrawal wrote:
> Support registering cooling devices with dynamic power coefficient
> where provided by the device tree. This allows OF registered cooling
> devices driver to be used with the power_allocator thermal governor.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

FWIW,

Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
