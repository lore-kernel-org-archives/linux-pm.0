From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: e978aa7d (cpuidle: Move dev->last_residency
	update...) broke suspend
Date: Sat, 12 Nov 2011 23:13:26 +0100
Message-ID: <201111122313.26968.rjw@sisk.pl>
References: <874nyadwef.fsf@tac.ki.iif.hu> <201111120218.17758.rjw@sisk.pl>
	<87obwhcy1e.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87obwhcy1e.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, November 12, 2011, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Saturday, November 12, 2011, Ferenc Wagner wrote:
> >> Hi,
> >> 
> >> Since e978aa7d (cpuidle: Move dev->last_residency update to driver
> >> enter routine; remove dev->last_state) my ThinkPad R50e can't suspend
> >> anymore, it just freezes instead.  I controlled git bisect by booting
> >> with break=top and issuing 'echo mem >/sys/power/state'.  My config is
> >> attached.
> >
> > What's the output of "cat /sys/devices/system/cpu/cpuidle/current_driver" ?
> 
> acpi_idle.
> 
> Your patch (ACPI / cpuidle: Remove acpi_idle_suspend) fixes the problem
> for me.  Amazing turnaround, really!

Well, I could reproduce the problem on one of my machines, so it wasn't
that difficult.

Thanks,
Rafael
