From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Documentation/ABI: update cpuidle sysfs documentation
Date: Mon, 22 Jan 2018 16:30:35 +0000
Message-ID: <ad66263c-2116-63d0-1b80-c5357f731066@arm.com>
References: <20180122160922.GA13380@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20180122160922.GA13380@mordor.localdomain>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Sudeep Holla <sudeep.holla@arm.com>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org



On 22/01/18 16:09, Aishwarya Pant wrote:
> Update cpuidle documentation using git logs and existing documentation
> in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
> and tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index bfd29bc8d37a..f38e52d08be1 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -126,6 +126,85 @@ Description:	Discover cpuidle policy and mechanism
>  		See files in Documentation/cpuidle/ for more information.
>  
>  
> +What:		/sys/devices/system/cpu/cpuidle/current_driver
> +What:		/sys/devices/system/cpu/cpuidle/available_governors
> +What:		/sys/devices/system/cpu/cpuidle/current_governor
> +Date:		September 2007
> +KernelVersion:	v2.6.24
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +		With the cpuidle_sysfs_switch boot option enabled (meant for
> +		developer testing), the following three attributes are visible
> +		instead:
> +
> +		current_driver: (RO) Display the current idle mechanism.
> +
> +		available_governors: (RO) Display a space separated list of
> +		available governors
> +
> +		current_governor: (RW) Display the current idle policy. Users
> +		can switch the governor at runtime by writing to this file.
> +

May be you can merge above with the previous entry which already has
/sys/devices/system/cpu/cpuidle/current_driver
/sys/devices/system/cpu/cpuidle/current_governer_ro

Otherwise looks good.

-- 
Regards,
Sudeep
