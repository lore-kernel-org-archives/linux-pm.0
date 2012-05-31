From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: Re: [RFC] the generic thermal layer enhancement
Date: Thu, 31 May 2012 11:14:01 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB5912D03E@BGSMSX101.gar.corp.intel.com>
References: <1338367742.1472.128.camel@rui.sh.intel.com>
	<1338367860.1472.129.camel@rui.sh.intel.com>
	<20120530103006.GA3261@besouro>
	<4D68720C2E767A4AA6A8796D42C8EB5912C976@BGSMSX101.gar.corp.intel.com>
	<20120530111729.GC3261@besouro>
	<1338435161.1472.205.camel@rui.sh.intel.com>
	<20120531110607.GB3673@besouro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120531110607.GB3673@besouro>
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
Cc: Jean Delvare <jdelvare@suse.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

[A big cut]

> > >
> > > Maybe a better way would be to have sort of pm/thermal contraint
> framework, which
> > > would map these per device, at LDM level?
> > >
> > > I am copying Jean-Pihet, he has been working in this front. Jean, any
> thoughts?
> > >
> > Durga and I are investigating how to introduce some concepts like
> > "influence/weight" to generic thermal layer. :)
> 
> What do you mean here? Describing the cooling devices effectiveness on each
> zone and
> derive algorithms to act accordingly?

Yes. something like that..

Thanks,
Durga
