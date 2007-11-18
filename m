From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 16:03:25 +0100
Message-ID: <200711181603.26522.rjw__35155.2102635198$1195397286$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711171649100.7748-100000@netrider.rowland.org>
	<200711181442.09917.rjw@sisk.pl> <474043EC.4000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <474043EC.4000700@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 18 of November 2007, Jiri Slaby wrote:
> On 11/18/2007 02:42 PM, Rafael J. Wysocki wrote:
> > On Sunday, 18 of November 2007, Jiri Slaby wrote:
> >> On 11/18/2007 01:42 PM, Jiri Slaby wrote:
> >>> See shot of prints here:
> >>> http://www.fi.muni.cz/~xslaby/sklad/susp_hang1.png
> >> BTW output from that tree minus the patch:
> > 
> > Hm, it looks like one of the CPU hotplug notifiers is doing something wrong.
> > 
> > Can you try to see what happens (with the patch applied) if
> > thermal_throttle_cpu_callback() is not registered?
> 
> After commenting out
> //device_initcall(thermal_throttle_init_device);
> it looks like this:
> http://www.fi.muni.cz/~xslaby/sklad/susp_hang2.png

Can you also make the new System-map available, please?
