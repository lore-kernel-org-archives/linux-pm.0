From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?=5BRFC_Disable_suspend_on_a_specific_de?=
 =?iso-8859-1?q?vice=5D_This_is_a_little=09change_in_linux_power_scheme?=
Date: Wed, 8 Apr 2009 10:13:24 +0200
Message-ID: <200904081013.25301.rjw@sisk.pl>
References: <200904072257.23756.rjw@sisk.pl>
	<1239143110.7183.56.camel@nigel-laptop>
	<49DC3D2A.1020405@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49DC3D2A.1020405@gandalf.sssup.it>
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
To: linux-pm@lists.linux-foundation.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wednesday 08 April 2009, Michael Trimarchi wrote:
> Hi,
> 
> Nigel Cunningham wrote:
> > Hi.
> >
> > On Tue, 2009-04-07 at 23:38 +0200, Pavel Machek wrote:
> >> Well.... userspace should not have to decide this. If userspace tells
> >> kernel not to suspend video card (on PC/ACPI), then we either honour
> >> the request, or violate ACPI spec (and probably break suspend).
> >
> > What about the cases where the ACPI spec is irrelevant? (As I understand
> > it, not all embedded boards use ACPI). Would this be a good approach in
> > those cases? If so, perhaps the trick would be to make the functionality
> > depend on !CONFIG_ACPI?
> It can be an option, or just add only in embedded configuration where is 
> not ACPI configured.
> The dependences is allready provided by the kernel. The default is to 
> have suspend enabled.
> The user level access it's needed because the kernel does't exacly know 
> when the device must remain on/off during suspend.

So, who exactly is going to have that information?  Does it depend on a user
decision on something else?  If something else, then what?

> This api change can't cover any possible scenario but
> introduce a flexbility scheame in suspend process. Avoid suspend in some 
> device can be obtain
> looking at dependece too? I don't know exacly if the acpi capapiblity 
> can be seen throw the
> link to a bus or a specific class, but we can limit it to the platform 
> device instead all device.

If I understand it correctly, the behavior you'd like to obtain is quite
similar to the one of wake-up devices that usually also need to remain
powered (at least to some extent) during suspend.  This, however, is handled
by the drivers of that devices, in their suspend callbacks.

How is your device different from the other wake-up devices?

Rafael
