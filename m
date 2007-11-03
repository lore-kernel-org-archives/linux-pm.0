From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 3/3] PM: Suspend/hibernation debug
	documentation update (rev. 2)
Date: Sat, 3 Nov 2007 21:54:48 +0100
Message-ID: <200711032154.49758.rjw__1597.66772198981$1194123592$gmane$org@sisk.pl>
References: <200711032054.40195.rjw@sisk.pl> <200711032058.23358.rjw@sisk.pl>
	<E1IoPIE-0005qK-9U@faramir.fjphome.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1IoPIE-0005qK-9U@faramir.fjphome.nl>
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
Cc: johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 3 November 2007 21:08, Frans Pop wrote:
> Rafael J. Wysocki wrote:
> > +core run in a test mode.  There are 5 test modes available:
> > +
> > +freezer - test the freezing of processes
> > +devices - test the freezing of processes and suspending of devices
> > +platform - test the freezing of processes, suspending of devices and platform
> > +           global control methods(*)
> > +processors - test the freezing of processes, suspending of devices, platform
> > +             global control methods(*) and the disabling of nonboot CPUs
> > +core - test the freezing of processes, suspending of devices, platform global
> > +       control methods(*), the disabling of nonboot CPUs and suspending of
> > +       platform/system devices
> 
> I'd suggest to indent this as follows:
> - freezer
>   Test the freezing of processes.
> - devices
>   Test the freezing of processes and suspending of devices.
> - platform
>   Test the freezing of processes, suspending of devices and platform global
>   control methods(*).
> - processors
>   Test the freezing of processes, suspending of devices, platform global
>   control methods(*) and the disabling of nonboot CPUs.
> - core
>   Test the freezing of processes, suspending of devices, platform global
>   control methods(*), the disabling of nonboot CPUs and suspending of
>   platform/system devices.

Yup, this way it looks better.

Thanks,
Rafael
