From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH update 2x] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 16)
Date: Fri, 14 Aug 2009 06:03:08 +0900
Message-ID: <20090813210308.GA9570__10391.8646033437$1250197763$gmane$org@linux-sh.org>
References: <200908081625.57333.rjw@sisk.pl> <200908092313.05541.rjw@sisk.pl>
	<200908132256.42941.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908132256.42941.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 13, 2009 at 10:56:42PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Introduce core framework for run-time PM of I/O devices (rev. 16)
> 
> Introduce a core framework for run-time power management of I/O
> devices.  Add device run-time PM fields to 'struct dev_pm_info'
> and device run-time PM callbacks to 'struct dev_pm_ops'.  Introduce
> a run-time PM workqueue and define some device run-time PM helper
> functions at the core level.  Document all these things.
> 
> Special thanks to Alan Stern for his help with the design and
> multiple detailed reviews of the pereceding versions of this patch
> and to Magnus Damm for testing feedback.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

If there are no more outstanding issues with this, any chance of having
this rolled in to a topic branch along with Magnus's platform bus
support? It would be nice if these could spend some time in -next,
especially as it seems there are no longer any glaring issues with the
patch series.
