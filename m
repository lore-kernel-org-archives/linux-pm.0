From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][v5] tools/power turbostat: if --iterations, print for
 specific count of iterations
Date: Thu, 26 Apr 2018 08:08:48 +0800
Message-ID: <20180426000847.GA20079@sandybridge-desktop>
References: <20180414041055.10159-1-yu.c.chen@intel.com>
 <1840879.edVvmFFlsp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1840879.edVvmFFlsp@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>, Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 23, 2018 at 10:48:39AM +0200, Rafael J. Wysocki wrote:
> On Saturday, April 14, 2018 6:10:55 AM CEST Yu Chen wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> > 
> > There's a use case during test to only print specific round of iterations
> > if --iterations is specified, for example, with this patch applied:
> > 
> > turbostat -i 5 -r 4
> > will capture 4 samples with 5 seconds interval.
> > 
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Rafael J Wysocki <rjw@rjwysocki.net>
> > Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> > Cc: Doug Smythies <dsmythies@telus.net>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
[cut]...
> > +		if (iterations && (++done_iters >= iterations))
> 
> The inner parens are not needed here (and similarly below).
> 
> If you fix this little one, please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch (FWIW). 
> 
OK, will do, thanks!
Yu
