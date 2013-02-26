From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] PM / OPP: improve introductory documentation
Date: Tue, 26 Feb 2013 14:43:40 -0800
Message-ID: <512D3A9C.5040801@infradead.org>
References: <1361900231-10478-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1361900231-10478-1-git-send-email-nm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/26/13 09:37, Nishanth Menon wrote:
> Make Operating Performance Points (OPP) library introductory chapter
> a little more reader-friendly. Split the chapter into two sections
> and highlight the definition with an example.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> based on v3.8 tag
>  Documentation/power/opp.txt |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/power/opp.txt b/Documentation/power/opp.txt
> index 3035d00..b4f1870 100644
> --- a/Documentation/power/opp.txt
> +++ b/Documentation/power/opp.txt
> @@ -1,6 +1,5 @@
> -*=============*
> -* OPP Library *
> -*=============*
> +Operating Performance Points (OPP) Library
> +==========================================
>  
>  (C) 2009-2010 Nishanth Menon <nm@ti.com>, Texas Instruments Incorporated
>  
> @@ -16,15 +15,31 @@ Contents
>  
>  1. Introduction
>  ===============
> +1.1 What is an Operating Performance Point (OPP)?
> +
>  Complex SoCs of today consists of a multiple sub-modules working in conjunction.
>  In an operational system executing varied use cases, not all modules in the SoC
>  need to function at their highest performing frequency all the time. To
>  facilitate this, sub-modules in a SoC are grouped into domains, allowing some
>  domains to run at lower voltage and frequency while other domains are loaded
> -more. The set of discrete tuples consisting of frequency and voltage pairs that
> +more.

huh???

> +
> +The set of discrete tuples consisting of frequency and voltage pairs that
>  the device will support per domain are called Operating Performance Points or
>  OPPs.
>  
> +As an example:
> +Let us consider an MPU device which supports the following:
> +{300MHz at minimum voltage of 1V}, {800MHz at minimum voltage of 1.2V},
> +{1GHz at minimum voltage of 1.3V}
> +
> +We can represent these as three OPPs as the following {Hz, uV} tuples:
> +{300000000, 1000000}
> +{600000000, 1200000}
    800000000

> +{100000000, 1300000}
    1000000000 ??

> +
> +1.2 Operating Performance Points Library
> +
>  OPP library provides a set of helper functions to organize and query the OPP
>  information. The library is located in drivers/base/power/opp.c and the header
>  is located in include/linux/opp.h. OPP library can be enabled by enabling
> 


-- 
~Randy
