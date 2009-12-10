From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 14730] sky2 won't work after suspend/resume
	cycle
Date: Thu, 10 Dec 2009 22:23:33 +0100
Message-ID: <200912102223.33184.rjw__31319.7863907137$1260480224$gmane$org@sisk.pl>
References: <bug-14730-10028@http.bugzilla.kernel.org/>
	<200912102140.26491.rjw@sisk.pl>
	<200912102200.29219.mat@esi.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912102200.29219.mat@esi.com.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Maciej J. Woloszyk" <mat@esi.com.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, akpm@linux-foundation.org, bugzilla-daemon@bugzilla.kernel.org, shemminger@linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 10 December 2009, Maciej J. Woloszyk wrote:
...
> > Can you please use 2.6.32 for further testing and do the following:
> > 
> 
> Ok.
> 
> > # echo code > /sys/power/pm_test
> 
> I hope you ment it to  be "echo core" because if it actualy supposed to be 
> "code" - it didn't worked ;)

Yes, that should have been 'core', sorry for the mistake.

> > # echo mem > /sys/power/state
> > 
> > wait until it gets back to the command prompt and see if your sky2 works
> > after that?
> > 
> 
> Yes - after the second echo it did kind of suspend/resume cycle and after that 
> sky2 still worked.

OK, thanks.

Please attach the full output of 'lspci -vv' (including all devices) before and
after a suspend-resume cycle failing to restore the sky2 functionality.
