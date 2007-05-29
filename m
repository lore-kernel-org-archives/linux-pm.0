From: Rob Landley <rob@landley.net>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Tue, 29 May 2007 16:41:41 -0400
Message-ID: <200705291641.43476.rob@landley.net>
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

On Sunday 27 May 2007 4:45 pm, Michael-Luke Jones wrote:
> (Slightly OT: A particularly nasty race is when an initramfs  
> userspace is present, but firmware loading cannot occur because init  
> has not run, so proc hasn't been mounted, so a hotplug event handler  
> cannot be registered, despite the fact that the firmware is sitting  
> on the ramdisk mounted correctly...)

I believe that the current functionality is that /sbin/hotplug is the default.  
I think that if there is one in initramfs, it'll get called as a usermode 
helper, even before init has run.  (If it needs /proc /sys or /dev, setting 
it up properly is its problem, but not an insurmountable one.)

I remember discussion of this a while back, and that it was indeed 
intentional.  I dunno if anybody's actually tried it.

Rob
