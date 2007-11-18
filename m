From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: broken suspend [Was: 2.6.24-rc2-mm1]
Date: Sun, 18 Nov 2007 23:42:18 +0100
Message-ID: <200711182342.18816.rjw__24797.7659259506$1195424752$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0711181203220.5712-100000@netrider.rowland.org>
	<200711182328.00570.rjw@sisk.pl> <4740B8E9.4030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4740B8E9.4030903@gmail.com>
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
> On 11/18/2007 11:27 PM, Rafael J. Wysocki wrote:
> > You can use a global variable to switch the logging only before the CPU
> > hotunplug done by the suspend code.  You just need to hack
> > disable_nonboot_cpus() for that.
> 
> If I understand you correctly, that's what BUBAK variable is there for.

Ah, yes.

-ETOOTIRED

> But it is still called again and again while the suspend code runs...

You can count the number of calls and then make it print the information for
the last, say, 20 of them.

Greetings,
Rafael
