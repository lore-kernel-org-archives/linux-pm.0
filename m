From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] PM / docs: Drop confusing kernel-doc references from
 infrastructure.rst
Date: Mon, 2 Jan 2017 15:39:20 -0700
Message-ID: <20170102153920.56c48a83@lwn.net>
References: <1637935.8QKVTKQPm8@aspire.rjw.lan>
        <1866121.f9dSvTNiL5@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1866121.f9dSvTNiL5@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 02 Jan 2017 23:05:31 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The references to drivers/base/power/main.c and
> > drivers/acpi/scan.c from Documentation/driver-api/infrastructure.rst
> > are confusing.  They both cause descriptions of functions that are
> > not relevant to device drivers at all to be generated and none of
> > them is sufficient to cover the API in a meaningful way.
> > 
> > Drop them for now.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>  
> 
> I'd like this to go into 4.10.
> 
> Are there any objections here?

None here.  Sorry, somehow I failed to see this when I was putting
together the fixes to send a few days ago.  If you want to include it in
a batch of yours, feel free to do so with my ack; otherwise I can ship it
Linusward in a bit.

Thanks,

jon
