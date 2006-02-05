From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.15.2: kernel oops with swsusp
Date: Sun, 5 Feb 2006 14:30:44 +0100
Message-ID: <200602051430.45478.rjw@sisk.pl>
References: <1139145074.20895.253576886@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1139145074.20895.253576886@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Robert Freund <spinningteacup@ftml.net>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

Thanks a lot for the report.

On Sunday 05 February 2006 14:11, you wrote:
> Hi,
> 
> I'm emailing you because I believe you're one of the swsusp-maintainers.
> If this is not the case, please forward this mail.
> 
> I'm trying to swsusp my acer travelmate 800, which is a centrino machine
> using the hibernate script from the suspend2-project, which does an
> "echo disk > /sys/power/state" as far as I know. This is on a vanilla
> 2.6.15.2.
> 
> Unfortunately I get a kernel oops ("Unable to handle kernel paging
> request at address...") when doing so. This was the same with 2.6.15.1.
> Suspend used to work flawlessly with 2.6.14 and before. I exited X and
> removed all modules I could remove (see the screenshot for what was
> left), but it still doesn't work.
> 
> Here are links to (maybe) relevant information, and a screenshot from my
> digicam:
> 
> http://rffr.de/configs/dmesg-2006-02-05.txt
> http://rffr.de/configs/lspci-2006-02-05.txt
> http://rffr.de/configs/config-2.6.15.2.txt
> http://rffr.de/screens/oops-2006-02-05.jpg (135k)
> 
> What else can I do to help solving this?

Your oops trace suggests this happens while suspending one of devices.

Could you please do the following:

1) boot your box with the "init=/bin/bash" kernel command line parameter
2) do "mount /proc" and "mount /sys"
3) do "echo disk > /sys/power/state"

and see if the problem occurs?

Greetings,
Rafael
