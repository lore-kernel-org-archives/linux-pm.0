From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH 3/3] PM: Suspend/hibernation debug
	documentation update (rev. 2)
Date: Sat, 03 Nov 2007 21:08:30 +0100
Message-ID: <E1IoPIE-0005qK-9U@faramir.fjphome.nl>
References: <200711032054.40195.rjw@sisk.pl> <200711032058.23358.rjw@sisk.pl>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-To: <200711032058.23358.rjw@sisk.pl>
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
Cc: johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> +core run in a test mode.  There are 5 test modes available:
> +
> +freezer - test the freezing of processes
> +devices - test the freezing of processes and suspending of devices
> +platform - test the freezing of processes, suspending of devices and platform
> +           global control methods(*)
> +processors - test the freezing of processes, suspending of devices, platform
> +             global control methods(*) and the disabling of nonboot CPUs
> +core - test the freezing of processes, suspending of devices, platform global
> +       control methods(*), the disabling of nonboot CPUs and suspending of
> +       platform/system devices

I'd suggest to indent this as follows:
- freezer
  Test the freezing of processes.
- devices
  Test the freezing of processes and suspending of devices.
- platform
  Test the freezing of processes, suspending of devices and platform global
  control methods(*).
- processors
  Test the freezing of processes, suspending of devices, platform global
  control methods(*) and the disabling of nonboot CPUs.
- core
  Test the freezing of processes, suspending of devices, platform global
  control methods(*), the disabling of nonboot CPUs and suspending of
  platform/system devices.

Cheers,
FJP
