From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] MAINTAINERS: add maintainer for tools/power/cpupower
Date: Fri, 03 Nov 2017 19:42:17 +0100
Message-ID: <37746081.0qdYMxC6BJ@skinner>
References: <20171102191947.18486-1-shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102191947.18486-1-shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: rafael@kernel.org, davem@davemloft.net, rdunlap@infradead.org, mchehab@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Shuah,


On Thursday, November 02, 2017 01:19:47 PM Shuah Khan wrote:
> Based on discussions with Rafael J. Wysocki, cpupower is need of an
> active maintainer. I decided to on take the task of maintaining this
> tool.

Thanks. It is very much appreciated!
I had a motorcycle accident and had to stop typing at all for several 
weeks/months.

My plan is to be more active again on lists, do reviews again and submit some
patches I have lying around for a long time, etc.,...
Do not hesitate to contact me directly, I try to answer in time, may still 
take a while on more complex things...

Good luck and have fun...,

      Thomas

 
> Patches will flow through the pm sub-systems to the mainline.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>

Acked-by: Thomas Renninger <trenn@suse.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af0cb69f6a3e..9fd3ce23095a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3636,6 +3636,8 @@ F:	drivers/cpufreq/arm_big_little_dt.c
>  
>  CPU POWER MONITORING SUBSYSTEM
>  M:	Thomas Renninger <trenn@suse.com>
> +M:	Shuah Khan <shuahkh@osg.samsung.com>
> +M:	Shuah Khan <shuah@kernel.org>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	tools/power/cpupower/
> 
