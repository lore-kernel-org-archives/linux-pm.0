From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 00/48] kernel: Add support for power-off handler call
 chain
Date: Tue, 11 Nov 2014 10:20:23 -0800
Message-ID: <20141111182023.GA21970@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
 <20141110083347.GA29543@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141110083347.GA29543@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, LeeJon@roeck-us.net
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 10, 2014 at 09:33:48AM +0100, Pavel Machek wrote:
> Hi!
> 
> > Introduce a system power-off handler call chain to solve the described
> > problems.  This call chain is expected to be executed from the architecture
> > specific machine_power_off() function.  Drivers providing system power-off
> > functionality are expected to register with this call chain.  By using the
> > priority field in the notifier block, callers can control power-off
> > handler
> 
> Linus rather disliked the idea of notifier chains for this... And I
> don't see how it got addressed.
> 
Hi all,

After more thought, I concluded that it is technically impossible to support
multiple power-off handlers without some kind of list or call chain, no matter
how it is called. Given the opposition from Linus and the power maintainers
to the series, I decided to shelf it.

Thanks,
Guenter
