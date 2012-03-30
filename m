From: Joe Perches <joe@perches.com>
Subject: Re: [linux-pm] [PATCH 17/76] thermal_sys: convert printks to
 pr_<level>
Date: Fri, 30 Mar 2012 12:08:50 -0700
Message-ID: <1333134530.27601.2.camel@joe2Laptop>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
	 <c5a01dd52dc4903772f464ea580895ccc36e911d.1333101989.git.len.brown@intel.com>
	 <20120330134119.GA13130@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120330134119.GA13130@besouro>
Sender: linux-acpi-owner@vger.kernel.org
To: eduardo.valentin@ti.com
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-03-30 at 16:41 +0300, Eduardo Valentin wrote:
> On Fri, Mar 30, 2012 at 06:13:20AM -0400, Len Brown wrote:
> > From: Joe Perches <joe@perches.com>
> > Use the current logging style.
[]
> We should get the struct dev in thermal_zone_device, I think it makes
> more sense to use the dev_* helper functions.
[]
> The orig argument could probably be changed to a thermal zone device
> and the we use it's id as orig for the message.
> What do you think?

dev_<level> should be used instead of pr_<level> when
an appropriate struct device * is available.

cheers, Joe

