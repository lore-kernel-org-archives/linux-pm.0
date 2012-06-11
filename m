From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Re: [RFC PATCH 6/12] thermal: introduce active cooling
	algorithm
Date: Mon, 11 Jun 2012 11:48:46 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59134985@BGSMSX101.gar.corp.intel.com>
References: <1339384817.1492.160.camel@rui.sh.intel.com>
	<CAK44p227RorAEGcikmXSYHJizxVvwbQkZY9fSS0MvpsA4XyATQ@mail.gmail.com>
	<1339396704.1492.193.camel@rui.sh.intel.com>
	<20120611114450.GC3649@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120611114450.GC3649@besouro>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> > > Can we use the trend callback here even if the current temperature is
> > > less than the trip temperature. Basically according to trend it should
> > > deactivate the cooling devices as done for activating cooling devices.
> >
> > yes, this depends on the cooling algorithm we want to use.
> > When the temperature is lower than the trip point, if we want to stop
> > the fan immediately instead of spinning down step by step, we can do
> > this.
> >
> > Actually, what we are discussing right now should be some cooling
> > governor stuff. which I'm not sure if we should introduce to the generic
> > thermal manager or not, right now. :)
> 
> Rui, this is an interesting point. Do you have plans to have governor like approach
> in the generic thermal fw? Or are you sticking to the zone/cooling binding?

Yes We have. I am almost done.
Will submit patches by tomorrow.

Unfortunately, I cannot re-base my code now on top of Rui's patches.
So, I will submit an RFC version and we can work to resolve the conflicts.

Thanks,
Durga
