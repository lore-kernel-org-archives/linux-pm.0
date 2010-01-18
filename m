From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM / Runtime: Add sysfs switch for
 disabling device run-time PM
Date: Mon, 18 Jan 2010 11:10:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001181102460.6554-100000__4306.73505547947$1263831094$gmane$org@netrider.rowland.org>
References: <201001180129.55219.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001180129.55219.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Jan 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Runtime: Add sysfs switch for disabling device run-time PM
> 
> Add new device sysfs attribute, power/runtime, allowing the user
> space to block the run-time power management of the device.  If this
> attribute is set to "disabled", the driver of the device won't be
> able to enable run-time power management for it (without breaking the
> rules).

Ouch.  This does nearly the same thing as the power/level attribute in
the USB subsystem, but in an incompatible and more complicated way.

The power/level attribute can contain either "on" or "auto", meaning
that the device is always on or that it is subject to automatic runtime
power management (autosuspend).  Changing the setting from "auto" to
"on" merely does sets a flag and does pm_runtime_get_sync(); changing
it from "on" to "auto" clears the flag and does pm_runtime_put_sync().

Is there any reason this same mechanism shouldn't be used for all
devices?

Alan Stern
