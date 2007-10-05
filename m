From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Q] APM depends on PM_SLEEP?
Date: Fri, 5 Oct 2007 17:49:52 +0200
Message-ID: <200710051749.52685.rjw__39620.2512122274$1191598661$gmane$org@sisk.pl>
References: <Pine.LNX.4.60.0710051615350.10392@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0710051615350.10392@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, 5 October 2007 16:18, Guennadi Liakhovetski wrote:
> Why does APM depend on PM_SLEEP?

Because APM uses the suspend core functions in drivers/base/power .

> So without sleep support you cannot use "Make CPU Idle calls when idle ",
> "Use real mode APM BIOS call to power off" etc? Found in 23-rc9-git of
> yesterday. 

Selecting CONFIG_SUSPEND without ACPI only causes the suspend core (used
by APM) and kernel/power/main.c to be compiled in.

Greetings,
Rafael
