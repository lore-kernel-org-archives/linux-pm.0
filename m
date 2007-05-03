From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrinking memory for suspend?
Date: Thu, 3 May 2007 14:56:51 +0200
Message-ID: <200705031456.51546.rjw@sisk.pl>
References: <1177943076.5102.83.camel@johannes.berg>
	<200705031217.30979.rjw@sisk.pl>
	<1178192016.13233.94.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178192016.13233.94.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 May 2007 13:33, Johannes Berg wrote:
> On Thu, 2007-05-03 at 12:17 +0200, Rafael J. Wysocki wrote:
> 
> > I think that on a uniprocessor system it's quite safe, but on SMP it doesn't
> > seem so.  For example, imagine the situation in which one CPU is executing the
> > suspend code while another one is running userspace with system calls etc.
> 
> We can still hot-unplug all the other CPUs though, no?

We used to, but now we're "hot-unplugging" them after suspending devices.

Besides, preemptible kernels are not much different from SMP in that respect,
so ...

Greetings,
Rafael
