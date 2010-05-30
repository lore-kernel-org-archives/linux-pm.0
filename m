From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Pm-utils] cores offline after pm-suspend?
Date: Sun, 30 May 2010 21:48:48 +0200
Message-ID: <201005302148.48571.rjw__8599.12321107021$1275248930$gmane$org@sisk.pl>
References: <1275231359-sup-8543@nixos>
	<1275233020.4638.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275233020.4638.32.camel@localhost.localdomain>
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
Cc: pm-utils@lists.freedesktop.org
List-Id: linux-pm@vger.kernel.org

On Sunday 30 May 2010, Victor Lowther wrote:
> On Sun, 2010-05-30 at 17:04 +0200, Marc Weber wrote:
> > Hi,
> > 
> > Some weeks ago I got a new laptop running core -i5 processsor.
> > Everything seems to be working. However after resuming from suspend to
> > ram htop only shows one core having 100% utilization and I can't seem to
> > fix this putting cores off and online again using the sys cpuX/online
> > interface.
> 
> Weird.  pm-utils does not do anything special with the cpus across
> suspend/resume -- the kernel handles all that.
> 
> I have gone ahead and cc'ed the linux-pm mailing list.

This is a kernel issue.  Marc, what kernel did you use?

Rafael
