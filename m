From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Allow wakeup events to abort
	freezing of tasks
Date: Fri, 1 Oct 2010 23:24:29 +0200
Message-ID: <201010012324.29283.rjw__8842.97768720916$1285968352$gmane$org@sisk.pl>
References: <201009300016.50128.rjw@sisk.pl> <20100930142903.GA1442@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100930142903.GA1442@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 30, 2010, Pavel Machek wrote:
> On Thu 2010-09-30 00:16:50, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > Subject: PM: Allow wakeup events to abort freezing of tasks
> > 
> > If there is a wakeup event during the freezing of tasks, suspend or
> > hibernation will fail anyway.  Since try_to_freeze_tasks() can take
> > up to 20 seconds to complete or fail, aborting it as soon as a wakeup
> > event is detected improves the worst case wakeup latency.
> > 
> > Based on a patch from Arve Hj??nnev??g.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Ack.

Thanks!
