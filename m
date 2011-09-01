From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/5] PM: Generic PM domains and device PM QoS
Date: Fri, 2 Sep 2011 00:14:38 +0200
Message-ID: <201109020014.39027.rjw__34887.3482239016$1314932968$gmane$org@sisk.pl>
References: <201108310017.03103.rjw@sisk.pl>
	<CAORVsuVJEbLRXLuQFUh3_rDf+DfNFpOhEuBr33SRKqxBos=6Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuVJEbLRXLuQFUh3_rDf+DfNFpOhEuBr33SRKqxBos=6Bw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, September 01, 2011, Jean Pihet wrote:
> Rafael,
> 
> On Wed, Aug 31, 2011 at 12:17 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > This patchset illustrates how device PM QoS may be used along with
> > PM domains in my view.
> >
> > Actually, it consists of two parts.  Namely, patches [1-3/5] seem to be
> > suitable for 3.2, unless somebody hates them,
> The patches [1-3/5] are ok (reviewed only) excepted some remarks I have.

OK, thanks for the comments.

> > but patches [4-5/5] are
> > total RFC.  They haven't been tested, only compiled, so the use of them
> > is not encouraged (they may kill your dog or make your cat go wild, or
> > do something equally nasty, so beware).
> That looks like a disclaimer ;p
> 
> > Their purpose is to illustrate
> > an idea that I'd like to discuss at the PM miniconference during the
> > LPC.
> There is some code for OMAP that dynamically updates the worst case
> values for devices activation and de-activation;
> cf._omap_device_activate and _omap_device_deactivate in
> arch/arm/plat-omap/omap_device.c. The idea is to start with reference
> figures (worst case measured on board) at boot and then update the
> worst case values at runtime.
> Based on the PM QoS values and the worst case latency values the next
> power domains states can be determined. Unfortunately this is not
> (yet) implemented.

I thought about that too, but I'd like to discuss the basic idea first.

> I am wondering if the patches [4-5/5] are meant to replace the OMAP
> code, which would be really nice.

I certainly hope they will be useful for multiple platforms.  Whether
or not OMAP turns out to be one of them I can't tell at the moment.

Thanks,
Rafael
