From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V2
Date: Fri, 5 Jun 2009 21:54:15 +0200
Message-ID: <200906052154.16563.rjw__11663.7078616352$1244231687$gmane$org@sisk.pl>
References: <20090601101614.10720.93804.sendpatchset@rx1.opensource.se>
	<200906031101.56577.rjw@sisk.pl>
	<aec7e5c30906042007t26915c05rd8ef375b8d4a353c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906042007t26915c05rd8ef375b8d4a353c@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 05 June 2009, Magnus Damm wrote:
> On Wed, Jun 3, 2009 at 6:01 PM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > On Tuesday 02 June 2009, Magnus Damm wrote:
> >> If you guys dislike adding arch specific data to struct platform
> >> device then for SuperH we can just (mis)use the arch specific data in
> >> struct device instead. I'm afraid that solution wastes memory since
> >> the data will only be used for platform devices anyway. So I prefer
> >> adding arch specific data to struct platform_device instead of struct
> >> device if possible.
> >
> > BTW, what is the difference really?  You can always put
> > dev.platform_data = NULL for devices that don't have any platform data,
> > can't you?
> 
> So the convention is that dev.platform_data points to driver-specific
> data. It may or may not be required by the driver. The format of this
> data is driver specific and should be the same across architectures.
> 
> What I'm trying to add with struct pdev_archdata is a place for
> architecture specific data. This data is needed by architecture
> specific code (for example runtime PM), and since it's architecture
> specific it should _never_ be touched by device driver code. Exactly
> like struct dev_archdata but for platform devices.
> 
> Like I said, we _could_ use struct device for this purpose, but it
> sounds like suboptimal software design to me. Using struct device
> means that we put data where it doesn't belong. I'd like to add
> _platform_ _device_ _specific_ data, not data that should be present
> in all struct devices in the system but only used in some cases.

OK, that explains the idea.  Perhaps it's woth putting into the changelog?

Best,
Rafael
