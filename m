From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Wed, 25 Apr 2007 21:36:57 +0200
Message-ID: <200704252136.58470.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704152154.09212.rjw@sisk.pl>
	<20070425171409.GA9990@melchior.yamamaya.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070425171409.GA9990@melchior.yamamaya.is-a-geek.org>
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
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 April 2007 19:14, Tobias Diedrich wrote:
> Rafael J. Wysocki wrote:
> > On Sunday, 15 April 2007 21:40, Tobias Diedrich wrote:
> > > Rafael J. Wysocki wrote:
> > > > On Sunday, 15 April 2007 17:14, David Brownell wrote:
> > > > > On Sunday 15 April 2007 4:16 am, Rafael J. Wysocki wrote:
> > > > > > On Sunday, 15 April 2007 10:02, Tobias Diedrich wrote:
> > > > > > I think using the 'shutdown' mode of suspend would be better.  There's a little
> > > > > > point in using 'platform' on desktop systems anyway.
> > > > > > 
> > > > > > Frankly, I don't know what to do about it.  If we move platform_finish() after
> > > > > > device_resume(), some systems may be broken ...
> > > > > 
> > > > > What I'm curious about is exactly why the patch matters.  What ACPI
> > > > > magic is being invoked to confuse, or unconfuse, those controllers?
> > > > 
> > > > I think the patch helps, because it makes the ACPI magic be done while the
> > > > i8042's .resume() is being executed.
> > > > 
> > > > Which makes me think the following patch might help:
> > > 
> > > Unfortunately not, I tried this before disabling CONFIG_SERIO_I8042.
> > 
> > Well, this means i8042 can be ruled out, so the problem probably is related
> > to the ACPI resume which makes it _much_ more difficult to debug.
> > 
> > Can you compile the ACPI drivers: processor, thermal, fan, battery, etc. as
> > modules, boot the kernel with init=/bin/bash and see if the problem is still
> > present (please keep CONFIG_SERIO_I8042 unset just in case)?
> > 
> > Rafael
> 
> I first tried it with acpi+cpufreq completely disabled (works).
> Then I tried it with acpi enabled, but everything as modules and
> those not loaded (init=/bin/bash, hangs at second suspend).

Have you tried with ACPI and without cpufreq?

Rafael
