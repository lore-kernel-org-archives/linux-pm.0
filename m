From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend
	and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 17:33:13 +0100
Message-ID: <200803271733.14480.rjw__9224.66511042348$1206635789$gmane$org@sisk.pl>
References: <200803262353.30566.rjw@sisk.pl> <200803270223.06715.rjw@sisk.pl>
	<1206586358.6926.68.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1206586358.6926.68.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thursday, 27 of March 2008, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2008-03-27 at 02:23 +0100, Rafael J. Wysocki wrote:
> > On Thursday, 27 of March 2008, Benjamin Herrenschmidt wrote:
> > > 
> > > > > There is absolutely no point getting a second struct anymore.
> > > > 
> > > > I obviously disagree with that opinion, so please elaborate.
> > > 
> > > Well, what does it bring you ? Why can't it be one struct ? To save
> > > space in the data area ?
> > 
> > Mostly, but not only that.
> > 
> > There are users of 'struct pm_ops' that aren't even supposed to define the
> > _noirq callbacks (device types and device classes), so I thought it would be
> > better to introduce a separate _noirq struct after all.
> 
> Make sense... USB has no use of noirq for example.

Well, FWIW, we can also do something like this:

struct pm_ops {
	int (*prepare)(struct device *dev);
	void (*complete)(struct device *dev);
	int (*suspend)(struct device *dev);
	int (*resume)(struct device *dev);
	int (*freeze)(struct device *dev);
	int (*thaw)(struct device *dev);
	int (*poweroff)(struct device *dev);
	int (*restore)(struct device *dev);
};

struct pm_ext_ops {
	struct pm_ops base;
	int (*suspend_noirq)(struct device *dev);
	int (*resume_noirq)(struct device *dev);
	int (*freeze_noirq)(struct device *dev);
	int (*thaw_noirq)(struct device *dev);
	int (*poweroff_noirq)(struct device *dev);
	int (*restore_noirq)(struct device *dev);
};

and use 'struct pm_ext_ops' for the entities that may need to implement the
_noirq callbacks.  This way we'll avoid the duplication of "_noirq" in the code
pointed to by Alex and there will be one "pm" pointer per bus type, device
type, device class, etc.

Thoughts?

Thanks,
Rafael
