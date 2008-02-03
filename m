From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to ram problem
Date: Sun, 3 Feb 2008 18:39:01 +0100
Message-ID: <200802031839.02397.rjw__11942.3214615837$1202060610$gmane$org@sisk.pl>
References: <47A5C399.7010405@free.fr> <47A5DE60.1080402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47A5DE60.1080402@free.fr>
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
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 of February 2008, matthieu castet wrote:
> matthieu castet wrote:
> > Hi,
> > 
> > I am trying to make work suspend to ram on a MSI MS-6380E with a 2.6.23 
> > kernel.
> > 
> > Standby mode works.
> > S2ram suspend seems to work : the computer turn off and I can wake up it 
> > with the keyboard.
> > 
> > But when the computer wakeup, I see the video card POST on the screen, 
> > but after that the computer hangs : black screen, no working numlock.
> > 
> > I tried to compile PM_TRACE, but it give no result. So this means the 
> > resume hang very early.
> > 
> > What can I do to debug this ?
> >
> I play with the s2_beep feature and :
> - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer beep
> - echo 4 > /proc/sys/kernel/acpi_video_flags make the computer not beep
> - adding a beep in bogus_real_magic, make the computer not beep
> 
> So the hang seems located in wakeup_start.

Hm.  Can you add unconditional BEEP after "jne bogus_real_magic" in
arch/x86/kernel/acpi/wakeup.S and see if it beeps?

Rafael
