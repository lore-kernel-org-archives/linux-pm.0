From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch update] PM: Introduce core framework for
 run-time PM of I/O devices
Date: Sun, 14 Jun 2009 16:18:50 -0700
Message-ID: <20090614161850.01435082__22177.2002558739$1245021566$gmane$org@infradead.org>
References: <200906140023.36147.rjw@sisk.pl> <200906141158.50171.rjw@sisk.pl>
	<200906150057.32424.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906150057.32424.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, 15 Jun 2009 00:57:31 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 14 June 2009, Rafael J. Wysocki wrote:
> > On Sunday 14 June 2009, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > Below is the current version of my "run-time PM for I/O devices"
> > > patch.
> > > 
> > > I've done my best to address the comments received during the
> > > recent discussions, but at the same time I've tried to make the
> > > patch only contain the most essential things.  For this reason,
> > > for example, the sysfs interface is not there and it's going to
> > > be added in a separate patch.
> > > 
> > > Please let me know if you want me to change anything in this
> > > patch or to add anything new to it.  [Magnus, I remember you
> > > wanted something like ->runtime_wakeup() along with
> > > ->runtime_idle(), but I'm not sure it's really necessary.  Please
> > > let me know if you have any particular usage scenario for it.]
> 
> Appended is an update of the patch addressing the today's comments
> from Magnus.

few comments from me

1) For the usecases for upcoming hw from Intel (where you really can't talk to the hw while it's in powersave mode); the locking needs to be
   IRQ safe. Think of it like this:
   Lets assume you get a (shared) interrupt from your device. In the handler you need to make 100% sure that 
    1) you're not suspended at this point .. basically do a forced wakeup right there and then
    2) assure that you're not about to suspend
2) You use jiffies in the API; I would suggest exposing milliseconds instead and internally convert to jiffies;
   milliseconds tends to be a much more natural unit for this sort of thing
