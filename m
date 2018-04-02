From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Documentation/thermal: Check links and convert to https
Date: Mon, 2 Apr 2018 12:42:46 +0530
Message-ID: <20180402071246.GF4714@vireshk-i7>
References: <20180328145913.14026-1-ghane0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328145913.14026-1-ghane0@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sanjeev Gupta <ghane0@gmail.com>
Cc: corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28-03-18, 22:59, Sanjeev Gupta wrote:
> All links working.

And why is it important to convert them to https ?

> Signed-off-by: Sanjeev Gupta <ghane0@gmail.com>
> ---
>  Documentation/thermal/cpu-cooling-api.txt | 2 +-
>  Documentation/thermal/nouveau_thermal     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
> index 7df567eaea1a..32917d178c51 100644
> --- a/Documentation/thermal/cpu-cooling-api.txt
> +++ b/Documentation/thermal/cpu-cooling-api.txt
> @@ -5,7 +5,7 @@ Written by Amit Daniel Kachhap <amit.kachhap@linaro.org>
>  
>  Updated: 6 Jan 2015
>  
> -Copyright (c)  2012 Samsung Electronics Co., Ltd(http://www.samsung.com)
> +Copyright (c)  2012 Samsung Electronics Co., Ltd (https://www.samsung.com)
>  
>  0. Introduction
>  
> diff --git a/Documentation/thermal/nouveau_thermal b/Documentation/thermal/nouveau_thermal
> index 6e17a11efcb0..502b0b95c2e2 100644
> --- a/Documentation/thermal/nouveau_thermal
> +++ b/Documentation/thermal/nouveau_thermal
> @@ -79,4 +79,4 @@ Thermal management on Nouveau is new and may not work on all cards. If you have
>  inquiries, please ping mupuf on IRC (#nouveau, freenode).
>  
>  Bug reports should be filled on Freedesktop's bug tracker. Please follow
> -http://nouveau.freedesktop.org/wiki/Bugs
> +https://nouveau.freedesktop.org/wiki/Bugs
> -- 
> 2.15.1

-- 
viresh
