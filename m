From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/9] cpufreq: Introduce support for ST's cpufreq
 functionality
Date: Wed, 8 Jul 2015 16:20:54 +0530
Message-ID: <20150708105054.GB1805@linux>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435154348-28840-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 24-06-15, 14:58, Lee Jones wrote:
> This driver reads very platform specific information in from Device Tree
> and translates it into frequency tables.  The generic drivers then use the
> tables to conduct frequency and voltage scaling in the normal way.
> 
> There are 'ARM' patches in the set which are not necessarily related to CPUFreq,
> but are required to get it to work.  Anyone who is not interested in general STi
> DT changes can safely ignore these.
> 
> v1 => v2:
>  - CPUFreq is no longer it's own device in DT; instead:
>    - It is probed from the platform area
>    - Key properties have been moved into the CPU's node
>  - Driver is less generic [ST => STI]
>  - Documentation has been updated
>    - Point one (above) has been accounted for
>    - Example of bootloader supplied node has been provided
>  - GPL licensing has been updated to reflected the header
>  - Kconfig disparity has been rectified [bool => tristate]

Sorry for being so late to get back to this.. Was tooo busy :(

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
