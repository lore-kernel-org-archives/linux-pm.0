From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: docs: sleep-states: Fix a typo ("includig")
Date: Sun, 13 May 2018 10:50:48 +0200
Message-ID: <4601374.GrrhKEzYAE@aspire.rjw.lan>
References: <20180425100715.17235-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425100715.17235-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 25, 2018 12:07:03 PM CEST Jonathan Neuschäfer wrote:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/admin-guide/pm/sleep-states.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
> index 1e5c0f00cb2f..dbf5acd49f35 100644
> --- a/Documentation/admin-guide/pm/sleep-states.rst
> +++ b/Documentation/admin-guide/pm/sleep-states.rst
> @@ -15,7 +15,7 @@ Sleep States That Can Be Supported
>  ==================================
>  
>  Depending on its configuration and the capabilities of the platform it runs on,
> -the Linux kernel can support up to four system sleep states, includig
> +the Linux kernel can support up to four system sleep states, including
>  hibernation and up to three variants of system suspend.  The sleep states that
>  can be supported by the kernel are listed below.
>  
> 

Applied and pushed for 4.17-rc5, thanks!
