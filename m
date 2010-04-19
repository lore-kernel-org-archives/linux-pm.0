From: Michal Hocko <mhocko@suse.cz>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Mon, 19 Apr 2010 13:59:42 +0200
Message-ID: <20100419115942.GC5160__25379.7614052475$1271678447$gmane$org@tiehlicka.suse.cz>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<201004132253.37432.rjw@sisk.pl>
	<20100414075808.GA4202@tiehlicka.suse.cz>
	<201004162000.29861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004162000.29861.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Tony Vroon <tony@linx.net>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri 16-04-10 20:00:29, Rafael J. Wysocki wrote:
> On Wednesday 14 April 2010, Michal Hocko wrote:
> > On Tue 13-04-10 22:53:37, Rafael J. Wysocki wrote:
> > > On Tuesday 13 April 2010, Michal Hocko wrote:
> > > > On Tue 13-04-10 01:01:54, Rafael J. Wysocki wrote:
> > > > > On Saturday 10 April 2010, Rafael J. Wysocki wrote:
> > > > > > On Friday 09 April 2010, Tony Vroon wrote:
> > > > > > > On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > > > > > > > Please check if the patch below changes anything.
> > > > > > > >  drivers/acpi/wakeup.c |    4 ++--
> > > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > That didn't change the behaviour for me, sorry.
> > > > > > 
> > > > > > Well, I would be sorry if it did, because the patch removed some useful code. :-)
> > > > > > 
> > > > > > > (I made sure to go through a full power down session before trying the
> > > > > > > patched kernel)
> > > > > > 
> > > > > > Thanks for testing.  So it looks like we don't disable the GPE during power off.
> > > > > > 
> > > > > > I'll try to figure out what's going on, please stay tuned.
> > > > > 
> > > > > Can you please check if the patch below changes the behavior?
> > > > 
> > > > Unfortunately, it didn't help either (I have tried on top of the fresh
> > > > rc4).
> > > 
> > > That gets really weird.
> > > 
> > > > > ---
> > > > >  drivers/acpi/wakeup.c |    6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > Index: linux-2.6/drivers/acpi/wakeup.c
> > > > > ===================================================================
> > > > > --- linux-2.6.orig/drivers/acpi/wakeup.c
> > > > > +++ linux-2.6/drivers/acpi/wakeup.c
> > > > > @@ -63,17 +63,17 @@ void acpi_enable_wakeup_device(u8 sleep_
> > > > >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> > > > >  		struct acpi_device *dev =
> > > > >  			container_of(node, struct acpi_device, wakeup_list);
> > > > > +		u8 action = ACPI_GPE_ENABLE;
> > > 
> > > Can you try to change the above to ACPI_GPE_DISABLE and retest, please?
> > 
> > Unfortunately didn't help as well...
> > Just for reference:
> > 
> > diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
> > index 248b473..f23c08f 100644
> > --- a/drivers/acpi/wakeup.c
> > +++ b/drivers/acpi/wakeup.c
> > @@ -63,7 +63,7 @@ void acpi_enable_wakeup_device(u8 sleep_state)
> >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> >  		struct acpi_device *dev =
> >  			container_of(node, struct acpi_device, wakeup_list);
> > -		u8 action = ACPI_GPE_ENABLE;
> > +		u8 action = ACPI_GPE_DISABLE;
> 
> That probably means the chipset enables the GPEs by itself _after_ we've
> disabled them in acpi_enable_wakeup_device().

Is this something BIOS specific?

> 
> Unfortunately, I can't reproduce the issue on any of my test boxes and it's
> hard to find the source of the problem staring at the code.

Are there any debug options I can turn on to provide some information?

Btw. what exactly does this mean? In what state is the laptop while it
is turned off and GPE is enabled?

Thanks!

> 
> Rafael

-- 
Michal Hocko
L3 team 
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
