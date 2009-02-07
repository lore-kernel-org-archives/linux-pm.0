From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Acer Aspire 1690 Suspend/Hibernate Report with
	2.6.29-rc3
Date: Sun, 8 Feb 2009 00:41:49 +0100
Message-ID: <200902080041.49657.rjw@sisk.pl>
References: <449895.60011.qm@web36806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <449895.60011.qm@web36806.mail.mud.yahoo.com>
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
To: linux-pm@lists.linux-foundation.org, dqarras@yahoo.com
List-Id: linux-pm@vger.kernel.org

On Saturday 07 February 2009, Daniel Qarras wrote:
> Hi!
> 
> > > Just a FYI, with my Acer Aspire 1690 using 2.6.29-rc3
> > > suspend/hibernate behave in this manner:
> > > 
> > > Hibernation completes ok but resumes immediately as if
> > > I would have pressed the power button.
> 
> Thanks a lot for the tip, indeed it makes hibernation working again:
> 
> root@localhost:~# echo shutdown > /sys/power/disk
> root@localhost:~# pm-hibernate
> 
> Great! Is there a way to make this default on my system, e.g., with a quirk?

Well, put 'echo shutdown > /sys/power/disk' into your init scripts?

Rafael
