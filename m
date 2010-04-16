From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Fri, 16 Apr 2010 20:00:29 +0200
Message-ID: <201004162000.29861.rjw__48751.9621769481$1271440700$gmane$org@sisk.pl>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<201004132253.37432.rjw@sisk.pl>
	<20100414075808.GA4202@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100414075808.GA4202@tiehlicka.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Tony Vroon <tony@linx.net>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 April 2010, Michal Hocko wrote:
> On Tue 13-04-10 22:53:37, Rafael J. Wysocki wrote:
> > On Tuesday 13 April 2010, Michal Hocko wrote:
> > > On Tue 13-04-10 01:01:54, Rafael J. Wysocki wrote:
> > > > On Saturday 10 April 2010, Rafael J. Wysocki wrote:
> > > > > On Friday 09 April 2010, Tony Vroon wrote:
> > > > > > On Fri, 2010-04-09 at 22:42 +0200, Rafael J. Wysocki wrote:
> > > > > > > Please check if the patch below changes anything.
> > > > > > >  drivers/acpi/wakeup.c |    4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > That didn't change the behaviour for me, sorry.
> > > > > 
> > > > > Well, I would be sorry if it did, because the patch removed some useful code. :-)
> > > > > 
> > > > > > (I made sure to go through a full power down session before trying the
> > > > > > patched kernel)
> > > > > 
> > > > > Thanks for testing.  So it looks like we don't disable the GPE during power off.
> > > > > 
> > > > > I'll try to figure out what's going on, please stay tuned.
> > > > 
> > > > Can you please check if the patch below changes the behavior?
> > > 
> > > Unfortunately, it didn't help either (I have tried on top of the fresh
> > > rc4).
> > 
> > That gets really weird.
> > 
> > > > ---
> > > >  drivers/acpi/wakeup.c |    6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > Index: linux-2.6/drivers/acpi/wakeup.c
> > > > ===================================================================
> > > > --- linux-2.6.orig/drivers/acpi/wakeup.c
> > > > +++ linux-2.6/drivers/acpi/wakeup.c
> > > > @@ -63,17 +63,17 @@ void acpi_enable_wakeup_device(u8 sleep_
> > > >  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> > > >  		struct acpi_device *dev =
> > > >  			container_of(node, struct acpi_device, wakeup_list);
> > > > +		u8 action = ACPI_GPE_ENABLE;
> > 
> > Can you try to change the above to ACPI_GPE_DISABLE and retest, please?
> 
> Unfortunately didn't help as well...
> Just for reference:
> 
> diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
> index 248b473..f23c08f 100644
> --- a/drivers/acpi/wakeup.c
> +++ b/drivers/acpi/wakeup.c
> @@ -63,7 +63,7 @@ void acpi_enable_wakeup_device(u8 sleep_state)
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  		struct acpi_device *dev =
>  			container_of(node, struct acpi_device, wakeup_list);
> -		u8 action = ACPI_GPE_ENABLE;
> +		u8 action = ACPI_GPE_DISABLE;

That probably means the chipset enables the GPEs by itself _after_ we've
disabled them in acpi_enable_wakeup_device().

Unfortunately, I can't reproduce the issue on any of my test boxes and it's
hard to find the source of the problem staring at the code.

Rafael
