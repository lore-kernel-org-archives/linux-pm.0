From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Improve ACPI handling during
	suspend and hibernation
Date: Mon, 27 Aug 2007 00:46:30 +0200
Message-ID: <200708270046.31214.rjw__48029.0906773464$1188167795$gmane$org@sisk.pl>
References: <200708261509.40118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708261509.40118.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 26 August 2007 15:09, Rafael J. Wysocki wrote:
> Hi,
> 
> The next three patches are intended to improve the handling of the ACPI
> platform during suspend and hibernation.
> 
> The do the following:
> * make hibernation_platform_enter() consistent with the sleep state entering
>   code in kernel/power/main.c
> * introduce global platform callbacks allowing us to handle ACPI in a more fine
>   grained way during suspend and hibernation
> * improve the handling of the system status indicator during suspend and
>   hibernation.
> Details are in the changelogs.

I the meantime, I have updated all of the patches in this series.  Please
consider them as obsolete and I'll send the updated patches in a while, in a
new thread.

Greetings,
Rafael
