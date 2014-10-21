From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Tue, 21 Oct 2014 08:50:47 -0700
Message-ID: <20141021155047.GA3453@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-2-git-send-email-linux@roeck-us.net>
 <20141021093405.GA2113@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141021093405.GA2113@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 21, 2014 at 11:34:05AM +0200, Johan Hovold wrote:
> On Mon, Oct 20, 2014 at 09:12:17PM -0700, Guenter Roeck wrote:
> 
> > v2:
> > - poweroff -> power_off
> 
> Do you want to stick to power[-_ ]off consistently throughout?
> 

The string "poweroff" is used 819 times in today's upstream kernel.
"power_off" is used 1,496 times, presumably mostly in variable names.
"power-off" is used 145 times.

So, yes, I can change all newly introduced variable and function names
from poweroff to power_off, and all newly introduced descriptive text
from poweroff to power-off if that makes you happy. It won't improve
consistency, though, since many of the current poweroff functions
are named "something_poweroff". Hope you don't expect me to change
all those function names as well.

Guenter
