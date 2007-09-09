From: Maciek Rutecki <maciej.rutecki@gmail.com>
Subject: Re: Suspend and hibernation status report
Date: Sun, 09 Sep 2007 11:10:51 +0200
Message-ID: <46E3B89B.2080600__12185.8773789883$1189467607$gmane$org@gmail.com>
References: <200707271057.05438.rjw@sisk.pl>
	<200709041932.21281.lenb@kernel.org>
	<200709082340.37018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709082340.37018.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki pisze:
> 
> Well, I am.
> 
> On HPC nx6325 the status of AC adapter after the restore is not reported
> correctly if hibernation is done without the ACPI hooks (eg. if you hibernate
> with the AC connected and then disconnect it and resume, it will still be
> reported as connected until you plug/unplug it).
> 
> There are more machines that behave similarly, AFAICT.

I notice similar issue on nx6310 when e.g. hibernation->remove
battery->resume doesn't refresh power status. But when I add:

echo platform > /sys/power/disk

Problem goes away


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
