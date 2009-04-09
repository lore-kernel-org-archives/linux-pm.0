From: mark gross <mgross@linux.intel.com>
Subject: Re: Adding PM QoS parameters
Date: Thu, 9 Apr 2009 11:57:38 -0700
Message-ID: <20090409185738.GA26224@linux.intel.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301CC66C7DE@dbde02.ent.ti.com>
	<20090406211237.GA25173@linux.intel.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC7972A5@dbde02.ent.ti.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC7972A5@dbde02.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 07, 2009 at 02:30:40PM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: mark gross [mailto:mgross@linux.intel.com] 
> > Sent: Tuesday, April 07, 2009 2:43 AM
> > To: Premi, Sanjeev
> > Cc: linux-pm@lists.linux-foundation.org
> > Subject: Re: [linux-pm] Adding PM QoS parameters
> > 
> > On Fri, Apr 03, 2009 at 01:55:06AM +0530, Premi, Sanjeev wrote:
> > > I have just started looking at the PM QoS implementation; I 
> > came across this
> > > text in "pm_qos_interface.txt"
> > > 
> > > [quote]
> > > The infrastructure exposes multiple misc device nodes one 
> > per implemented
> > > parameter.  The set of parameters implement is defined by 
> > pm_qos_power_init()
> > > and pm_qos_params.h.  This is done because having the 
> > available parameters
> > > being runtime configurable or changeable from a driver was 
> > seen as too easy to
> > > abuse.
> > > [/quote]
> > > 
> > > Though I have understood the intent; i feel it may also be 
> > limiting the use
> > > where there is a genuine need - specific to an arch/ platform.
> > > 
> > > Can we allow number of these params to grow upto a 
> > reasonable limit (say 8)?
> > > If an arch/platform does not specifies more params, 
> > everything remains same.
> > > But we get an opportunity to add arch/platform specific 
> > requirements.
> > 
> > If you do this then user mode software using the interface will not be
> > portable across architectures.  Is that what you want?
> 
> [sp] Not really. I was more looking at extending the current set
>      to include params specific to the architectures so that the
>      apps running on these apps are able to make use of these
>      params without inventing custom tricks.
> 
> > 
> > What parameters are you looking to add?  I have gotten very little
> > feedback on what parameters are missing or wanted.
> 
> [sp] As an example, the OMAP processors support multiple
>      scalable voltage domains. Depending upon operating
>      conditions, target voltage can be a param.
>

I can see that more parameters would make sense.  Can you come up with
a set of abstractions that have a chance of being portable?
 
> > 
> > > 
> > > Not sure if this has already been discussed earlier, but 
> > would like to hear
> > > more thoughts.
> > 
> > This has not been discussed, but changing the data structures to use
> > handles instead of strings has brought up once without data 
> > showing the
> > strcmps where a measurable issue.
> > 
> > I'm very open to improvements, applications and further discussions.
> 
> [sp] Here is rough outline
> 
>      Initialize the QoS array (with room to extend) as:
> 
>     static struct pm_qos_object *pm_qos_array[] = {
>         &null_pm_qos,
>         &cpu_dma_pm_qos,
>         &network_lat_pm_qos,
>         &network_throughput_pm_qos
>         &null_pm_qos,
>         &null_pm_qos,
>         &null_pm_qos,
>         &null_pm_qos,
>         &null_pm_qos,
>     };
> 
>      Assuming there is an API to add objects to this array, one
>      could define additional param as:
>

nah, If this is where we need to go, then I would change the array to a
list and make it possible to add new parameters at runtime.

Note: this is how I originally implemented it but changed it to a
compile time array to force LKML review of new parameters.  The worry
was that driver writers would just add whatever qos param they wanted
and we would loose on a consistent or stable ABI the user mode clients
of the interface could expect.
 
>     static BLOCKING_NOTIFIER_HEAD(voltage_notifier);
>     static struct pm_qos_object voltage_pm_qos = {
>         .requirements = {LIST_HEAD_INIT(voltage_pm_qos.requirements.list)},
>         .notifiers = &voltage_notifier,
>         .name = "voltage_level",
>         .default_value = 1200,              /* in mVolts */
>         .target_value = ATOMIC_INIT(1200),  /* in mVolts */,
>         .comparitor = min_compare
>     };

Can we identify something that maps to voltage level that would have a
chance at being portable to non-omap?  Higher level abstractions are
more attractive.

I'm having conflicting feelings on voltage as a QoS quantity, but I
totally see the utility of using the PM-QOS infrastructure to provide a
constraint framework on power domains. We may need to investigate this
more.

I would like to get more input from the peanut gallery on this before
acting on it too much.

 
>      Now, this can be added to pm_qos_array replacing a
>      trailing null_pm_qos.
> 
>      Requirements for voltage levels across domains
>      can be added to voltage_pm_qos.requirements.list
>      in platform specific init.
> 
>      Applications for this platform can choose to use
>      this param - for better power savings or choose
>      to ignore for portability.
> 
> 
> 
>      As I mentioned, I just started on the QoS infra. So, do
>      correct me if any of this can be achieved via current
>      params.

Right now adding new parameters is easy (other than dealing with LKML
questioning your choices for names and meanings)  To me you bring up 2
issues:

1) adding a voltage pm-qos parameter for omap power domains

2) is it the right thing to keep pm-qos-params a compile time array and
control the growth of the ABI via these mailing lists or make it a list
and enable driver creation of new parameters as they wish.

Both are good things for us to discuss on the list.


--mgross
