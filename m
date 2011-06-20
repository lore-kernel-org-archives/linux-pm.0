From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: System PM QoS patches
Date: Mon, 20 Jun 2011 21:28:21 +0200
Message-ID: <201106202128.21395.rjw@sisk.pl>
References: <alpine.DEB.2.00.1106021505090.26852@utopia.booyaka.com>
	<alpine.DEB.2.00.1106021614140.26852@utopia.booyaka.com>
	<BANLkTikPaUDQSYuUXO8-s5+gbBmM_0AuVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikPaUDQSYuUXO8-s5+gbBmM_0AuVA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pihet-XID, Jean" <j-pihet@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

[CCing linux-pm]

On Monday, June 20, 2011, Pihet-XID, Jean wrote:
> Hi,
> 
> On Fri, Jun 3, 2011 at 12:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 2 Jun 2011, Kevin Hilman wrote:
> >
> >> The main idea is to start from the PM QoS API, and just make all those
> >> APIs take a 'struct device *', and the constraints would be assoicated
> >> with a struct device.  The current system-wide constratints would then
> >> be a special case of the per-device constratints.  Maybe when the struct
> >> device pointer is NULL, that means set a system-wide constraint.  The
> >> existing users of PM QoS could then be easily converted to the new API
> >> by just passing in NULL.
> >
> > There are so few current in-tree users, I'm not sure if that's needed.
> >
> > Of the three system-wide PM QoS parameters, CPU_DMA_LATENCY is the only
> > one that is really set by in-kernel drivers.  And there are only five
> > drivers that use it (fgrep -r PM_QOS_CPU .).
> >
> > mac80211 uses network latency, but only as a way to get some requirements
> > from userspace.  And that's almost certainly the wrong way to do it, since
> > not all network devices have the same latency requirements.  Network
> > throughput isn't used at all.
> >
> >
> > - Paul
> >
> 
> I see 3 implementation options:
> 
> 1) Add an extra parameter to the PM QoS API to take an extra parameter
> for the device ptr, e.g. changing
>     void pm_qos_add_request(struct pm_qos_request_list *dep, int
> pm_qos_class, s32 value)
> to
>     void pm_qos_add_request(struct pm_qos_request_list *dep, struct
> device *dev, int pm_qos_class, s32 value)
> 
> 2) Use a constraints parameter instead of the current parameter list
> of the PM QoS API, e.g. changing
>     void pm_qos_add_request(struct pm_qos_request_list *dep, int
> pm_qos_class, s32 value)
> to
>     void pm_qos_add_request(struct pm_qos_request_list *dep, struct
> pm_qos_params *params), with:
>     struct pm_qos_params { device *dev; int pm_qos_class; s32 value };
> 
> 3) Keep the current API and add a new API for the device wake-up
> latency constraints.

I'm opting for 3, with a twist that the new implementation would use the
majority of the exsiting code (with some modifications).

> The options 1 & 2 have the advantage of keeping the code generic while
> option 3 means duplicating most of the code in kernel/pm_qos_params.c.

You don't need to duplicate it.  Just modify it so that it works with both
the existing API and the new one.

> Also the options 1 & 2 are impacting the current API users but as Paul
> reported it there are so few users so it is not an issue to do so.
> Option 3 has the advantage of being flexible when more parameters will
> be needed in the future.
> 
> What do you think?
> 
> I am currently trying to implement the option 2. More to come!

Good, looking forward to seeing the code. ;-)

Thanks,
Rafael
