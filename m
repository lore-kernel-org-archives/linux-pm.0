From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 13865] New: Can only resume with HP_WMI
	selected on compaq nc6000 when
	4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Wed, 29 Jul 2009 22:57:40 +0200
Message-ID: <200907292257.41573.rjw__17265.7621712007$1248901202$gmane$org@sisk.pl>
References: <bug-13865-10028@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <bug-13865-10028@http.bugzilla.kernel.org/>
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
To: Frans Pop <elendil@planet.nl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 29 July 2009, you wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13865
> 
>            Summary: Can only resume with HP_WMI selected on compaq nc6000
>                     when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is
>                     reverted
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 2.6.30
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: cedric@belbone.be
>         Regression: No
> 
> 
> Just for testing I enabled HP_WMI. But from then, I could not resume anymore.
> I just reverted the last git commit on the 'drivers/platform/x86/hp-wmi.c' code
> (4c395bdd3f2ca8f7e8efad881e16071182c3b8ca) and now I can resume.
> The problem still persists on .31-rc serie

Frans, that's something for you to take care of.

Best,
Rafael
