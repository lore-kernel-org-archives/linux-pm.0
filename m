From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic messages
Date: Sun, 13 May 2018 10:46:29 +0200
Message-ID: <2450217.aSupH1P1pj@aspire.rjw.lan>
References: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, April 26, 2018 11:36:20 PM CEST Bjorn Helgaas wrote:
> These are pretty minor cleanups to the suspend/resume diagnostic messages.
> 
> The first two are trivial.  The third may break scripts that parse dmesg
> output.  I looked at scripts/bootgraph.pl, and I don't think it is
> affected, but there may be others I don't know about.  Let me know if there
> are.
> 
> ---
> 
> Bjorn Helgaas (3):
>       PM / core: Remove unused initcall_debug_report() arguments
>       PM / core: Simplify initcall_debug_report() timing
>       PM / core: Use dev_printk() and symbols in suspend/resume diagnostics
> 
> 
>  drivers/base/power/main.c |   37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 

All [1-3/3] applied, thanks!
