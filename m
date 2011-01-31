From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Mon, 31 Jan 2011 15:43:41 -0800
Message-ID: <871v3s3ahe.fsf__47907.3349074044$1296517515$gmane$org@ti.com>
References: <201101300107.19389.rjw@sisk.pl>
	<20110131225902.GD27856@angua.secretlab.ca>
	<201102010010.46096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102010010.46096.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 1 Feb 2011 00:10:45 +0100")
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
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> Also, what is the use case for having 2 sets of power_domain ops?  My
>> gut tells me that you'd only want to do post ops on the
>> {freeze,suspend,poweroff} path and pre ops on the {resume,thaw,restore}
>> path.  It seems overly engineered to me, but I may be missing
>> something fundamental.
>
> Well, that's a part of the RFC, actually. :-)
>
> For the subsystems I've worked with (PCI, ACPI, PNP to some extent) one set
> would be sufficient, but I don't know of every possible use case.

For the on-chip SoC devices we're managing with OMAP, we're currently
only using one set: post ops on [runtime_]suspend and pre ops on
[runtime_]resume.

However, I could imagine (at least conceptually) using the pre ops on
suspend to do some constraints checking and/or possibly some
management/notification of dependent devices.  Another possiblity
(although possibly racy) would be using the pre ops on suspend to
initiate some high-latency operations.

I guess the main problem with two sets is wasted space.  e.g, if I move
OMAP to this (already hacking on it) there will be only 2 functions used
in post ops: [runtime_]suspend() and 2 used in pre ops [runtime_]_resume().

Kevin
