From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH][v3] tools/power turbostat: if --max_loop, print for specific time of loops
Date: Thu, 12 Apr 2018 00:18:44 -0700
Message-ID: <003e01d3d22e$7faa6b80$7eff4280$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: 6Cz1fQrxBvxoZ6Cz3fxUbk
In-Reply-To: 6Cz1fQrxBvxoZ6Cz3fxUbk
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Yu Chen' <yu.c.chen@intel.com>, 'Len Brown' <lenb@kernel.org>
Cc: 'Rafael J Wysocki' <rjw@rjwysocki.net>, 'Artem Bityutskiy' <artem.bityutskiy@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.04.11 03:31 Yu Chen wrote: 

> From: Chen Yu <yu.c.chen@intel.com>
>
> There's a use case during test to only print specific round of loops
> if --iterations is specified, for example, with this patch applied:
>
> turbostat -i 5 -t 4
> will capture 4 samples with 5 seconds interval.

Hi Yu,

This would be a very useful addition to turbostat.
Please also update the man turbostat man page.

tools/power/x86/turbostat/turbostat.8

... Doug
