From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Sun, 27 May 2007 23:55:19 +0200
Message-ID: <200705272355.20840.rjw@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<6BD5252F-96CD-49D9-86C7-18115294D913@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <6BD5252F-96CD-49D9-86C7-18115294D913@cam.ac.uk>
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
To: Michael-Luke Jones <mlj28@cam.ac.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 27 May 2007 22:45, Michael-Luke Jones wrote:
> On 27 May 2007, at 21:31, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Use a hibernation and suspend notifier to disable the firmware  
> > requesting
> > mechanism before a hibernation/suspend and enable it after the  
> > operation.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >
> >  drivers/base/firmware_class.c |   36 ++++++++++++++++++++++++++++++ 
> > ++++++
> >  1 file changed, 36 insertions(+)
> 
> I don't like this approach, as I feel that the firmware loading  
> interface should be able to detect if a firmware load request is not  
> being handled, due to absence of userspace / hotplug handler presence.

In principle, I agree.  In practice, though, I don't know how to make this
happen.

> Other circumstances in which this can be a problem is during bootup  
> when request_firmware() calls can be made before userspace is up and  
> init has run (even in the presence of an initramfs).
> 
> (Slightly OT: A particularly nasty race is when an initramfs  
> userspace is present, but firmware loading cannot occur because init  
> has not run, so proc hasn't been mounted, so a hotplug event handler  
> cannot be registered, despite the fact that the firmware is sitting  
> on the ramdisk mounted correctly...)
> 
> In short, a more general solution would be preferred, and preferably  
> one which allows firmware loading to *actually* occur once userspace  
> has actually turned up and registered a handler :)

I agree, but well ... ;-)

Greetings,
Rafael
