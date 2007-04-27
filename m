From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:30:09 +0200
Message-ID: <200704271730.10217.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<200704271700.52678.rjw@sisk.pl>
	<20070427151649.GB22639@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427151649.GB22639@in.ibm.com>
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
To: ego@in.ibm.com, Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 17:16, Gautham R Shenoy wrote:
> On Fri, Apr 27, 2007 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> > 
> > This clashes with the recent freezer changes in -mm quite violently.
> >
> 
> Yes. But I anyway plan to have a system_freeze_event_mask. That can
> very well serve this purpose.
> 
> > We're moving the freezer to kernel/freezer.c and we're introducing a special
> > field in task_struct for the freezer flags.
> > 
> > Please have a look at the freezer changes queued up in -mm and the freezer
> > patches recently sent.
> 
> I am not sure if the recently sent freezer patches hit lkml.
> I cannot spot the address in the CC list.

Ohs...t,  I did it again.  Sorry for the confusion.

Sending in a while.  I'll add Pekka to the CC list this time. :-)

Greetings,
Rafael
