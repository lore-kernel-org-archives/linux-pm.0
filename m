From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Oops during hibernation under 2.6.28-rc6
Date: Wed, 3 Dec 2008 23:05:25 +0100
Message-ID: <200812032305.25766.rjw@sisk.pl>
References: <87hc5mijcc.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87hc5mijcc.fsf@tac.ki.iif.hu>
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
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 2 of December 2008, Ferenc Wagner wrote:
> Hi,

Hi,

> swsusp usually works on my ThinkPad R50e.  However sometimes it oopses
> instead of hibernating the machine.  I can't provide real statistics
> as I haven't been using it for long (just about a month), but it also
> happened under 2.6.27.  Last time in happened under 2.6.28-rc6.  After
> two unsuccessful attempts (not enough free swap), I closed Emacs and
> Firefox, retried, and got the oops.  I could scroll the console back,
> and did two screenshots, find them under http://apt.niif.hu/susp/.
> I'm not sure what other data may be useful for debugging, please ask.

Does it happen with 2.6.26(.y)?

Rafael
