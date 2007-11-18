From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 23:27:59 +0100
Message-ID: <200711182328.00570.rjw__43807.4659243741$1195423895$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711181203220.5712-100000@netrider.rowland.org>
	<47408DFF.9070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47408DFF.9070701@gmail.com>
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
> On 11/18/2007 06:07 PM, Alan Stern wrote:
> > You'll get more useful results if you redo your changes to 
> > notifier_call_chain().  Have it print out the address of the routine 
> > _before_ making the call, and don't limit it to 20.  That way you'll 
> > know exactly which notifier routine ends up hanging.
> 
> The problem is, that notifier_call_chain is called again and again zillion times
> by somebody else...

You can use a global variable to switch the logging only before the CPU
hotunplug done by the suspend code.  You just need to hack
disable_nonboot_cpus() for that.
