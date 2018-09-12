From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 5/5] PM / hibernate: An option to request that snapshot
 image must be authenticated
Date: Wed, 12 Sep 2018 09:24:38 -0700
Message-ID: <0ee402c0-bd0e-ea84-9def-f6355b83b4f5@infradead.org>
References: <20180912142337.21955-1-jlee@suse.com>
 <20180912142337.21955-6-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912142337.21955-6-jlee@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On 9/12/18 7:23 AM, Lee, Chun-Yi wrote:
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 7c5c30149dbc..3c998fd6dc4c 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -90,6 +90,17 @@ config HIBERNATION_ENC_AUTH
>  	  master key of hibernation. The TPM trusted key depends on TPM. The
>  	  security of user defined key relies on user space.
>  
> +config HIBERNATION_ENC_AUTH_FORCE
> +	bool "Require hibernate snapshot image to be validly signed"
> +	depends on HIBERNATION_ENC_AUTH
> +	help
> +	  This option will prevent that a snapshot image without (valid)
> +	  signature be restored. Without this option, a unauthenticated

	                                              an

> +	  snapshot image can be restored but the restored kernel will be
> +	  tainted. Which also means that the hibernation can be triggered

s/Which/This/

or like this:
	  tainted, which also

> +	  without snapshot key but kernel will be tainted without this
> +	  option.
> +


-- 
~Randy
