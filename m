From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Driver Core: Add platform device arch data V3
Date: Wed, 24 Jun 2009 20:50:56 +0200
Message-ID: <200906242050.57312.rjw__4102.74520186267$1245869881$gmane$org@sisk.pl>
References: <20090610121659.27937.13560.sendpatchset@rx1.opensource.se>
	<87r5xhqzr4.fsf@deeprootsystems.com>
	<aec7e5c30906240450w2c204b1bo8e06cdc26eaad753@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30906240450w2c204b1bo8e06cdc26eaad753@mail.gmail.com>
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

On Wednesday 24 June 2009, Magnus Damm wrote:
> On Fri, Jun 19, 2009 at 1:21 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
> > Magnus Damm <magnus.damm@gmail.com> writes:
> >
> >> From: Magnus Damm <damm@igel.co.jp>
> >>
> >> Allow architecture specific data in struct platform_device V3.
> >>
> >> With this patch struct pdev_archdata is added to struct
> >> platform_device, similar to struct dev_archdata in found in
> >> struct device. Useful for architecture code that needs to
> >> keep extra data associated with each platform device.
> >>
> >> Struct pdev_archdata is different from dev.platform_data, the
> >> convention is that dev.platform_data points to driver-specific
> >> data. It may or may not be required by the driver. The format
> >> of this depends on driver but is the same across architectures.
> >>
> >> The structure pdev_archdata is a place for architecture specific
> >> data. This data is handled by architecture specific code (for
> >> example runtime PM), and since it is architecture specific it
> >> should _never_ be touched by device driver code. Exactly like
> >> struct dev_archdata but for platform devices.
> >>
> >> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> >
> > Since there is no 'Feature-desired-by:' tag, I'll addd
> >
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> >
> > For PM on ARM in general, and OMAP in particular we definitely need a
> > generic way to handle arch-specific data per platform_device.
> 
> Thanks, Kevin! So ARM in general or at least OMAP wants this, and so
> does SuperH.
> 
> Rafael, you kindly gave feedback on earlier versions, are you ok with
> this version?

Yes, I am.  I'm planning to include it into my linux-next branch for 2.6.32, if
no one objects.

Best,
Rafael
