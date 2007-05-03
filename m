From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: shrinking memory for suspend?
Date: Thu, 3 May 2007 12:17:30 +0200
Message-ID: <200705031217.30979.rjw@sisk.pl>
References: <1177943076.5102.83.camel@johannes.berg>
	<20070502112929.GD11316@elf.ucw.cz>
	<1178114521.13233.56.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178114521.13233.56.camel@johannes.berg>
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

On Wednesday, 2 May 2007 16:02, Johannes Berg wrote:
> On Wed, 2007-05-02 at 13:29 +0200, Pavel Machek wrote:
> 
> > It makes the device driver's job easier. But I guess we should stop
> > doing the freeze for suspend-to-RAM. Some auditing required, but OTOH
> > we'll be one step closer to runtime power management on such drivers.
> 
> *shrug*. We've never done it on powerbooks and it always seemed to work
> just fine...

I think that on a uniprocessor system it's quite safe, but on SMP it doesn't
seem so.  For example, imagine the situation in which one CPU is executing the
suspend code while another one is running userspace with system calls etc.
Pretty scary.

Greetings,
Rafael
